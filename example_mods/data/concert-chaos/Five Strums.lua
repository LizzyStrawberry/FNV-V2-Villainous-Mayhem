local Spacing = 100
local SPACING = 100
function onCreatePost()
    runHaxeCode([[
        for (i in 0...4)
        {
            var third = new StrumNote(0, 0, i + 8, 0);

            third.downScroll = ClientPrefs.downScroll;
            game.strumLineNotes.insert(i + 4, third);
            game.opponentStrums.add(third);
            third.postAddedToGroup();

            third.cameras = [game.camHUD];
            game.modchartSprites.set('third' + i, third);
        };
        for (i in 0...4)
        {
            var fourth = new StrumNote(0, 0, i + 12, 0);

            fourth.downScroll = ClientPrefs.downScroll;
            game.strumLineNotes.insert(i + 8, fourth);
            game.opponentStrums.add(fourth);
            fourth.postAddedToGroup();

            fourth.cameras = [game.camHUD];
            game.modchartSprites.set('fourth' + i, fourth);
        };
        for (i in 0...4)
        {
            var fifth = new StrumNote(0, 0, i + 16, 0);

            fifth.downScroll = ClientPrefs.downScroll;
            game.strumLineNotes.insert(i + 12, fifth);
            game.opponentStrums.add(fifth);
            fifth.postAddedToGroup();

            fifth.cameras = [game.camHUD];
            game.modchartSprites.set('fifth' + i, fifth);
        };

        game.singAnimations = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT', 'singLEFT', 'singDOWN', 'singUP', 'singRIGHT', 'singLEFT', 'singDOWN', 'singUP', 'singRIGHT', 'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];
    ]])
	
    DefaultSize = getPropertyFromGroup('strumLineNotes', 0, 'scale.x')
	
    for i=0,3 do
        setProperty('third'..i..'.scale.x', getPropertyFromGroup('strumLineNotes', 0, 'scale.x'))
        setProperty('third'..i..'.scale.y', getPropertyFromGroup('strumLineNotes', 0, 'scale.y'))
        setProperty('third'..i..'.y', defaultOpponentStrumY0)
        setProperty('fourth'..i..'.scale.x', getPropertyFromGroup('strumLineNotes', 0, 'scale.x'))
        setProperty('fourth'..i..'.scale.y', getPropertyFromGroup('strumLineNotes', 0, 'scale.y'))
        setProperty('fourth'..i..'.y', defaultOpponentStrumY0)
        setProperty('fifth'..i..'.scale.x', getPropertyFromGroup('strumLineNotes', 0, 'scale.x'))
        setProperty('fifth'..i..'.scale.y', getPropertyFromGroup('strumLineNotes', 0, 'scale.y'))
        setProperty('fifth'..i..'.y', defaultOpponentStrumY0)
    end
    setProperty('third0.x', getPropertyFromGroup('strumLineNotes', 3, 'x')+60)
    setProperty('third1.x', getProperty('third0.x')+Spacing)
    setProperty('third2.x', getProperty('third1.x')+Spacing)
    setProperty('third3.x', getProperty('third2.x')+Spacing)
    setProperty('fourth0.x', getProperty('third3.x')+60)
    setProperty('fourth1.x', getProperty('fourth0.x')+Spacing)
    setProperty('fourth2.x', getProperty('fourth1.x')+Spacing)
    setProperty('fourth3.x', getProperty('fourth2.x')+Spacing)
    setProperty('fifth0.x', getProperty('fourth3.x')+60)
    setProperty('fifth1.x', getProperty('fifth0.x')+Spacing)
    setProperty('fifth2.x', getProperty('fifth1.x')+Spacing)
    setProperty('fifth3.x', getProperty('fifth2.x')+Spacing)
	
    for i=0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'aileenSoloNotes' then
            setPropertyFromGroup('unspawnNotes', i, 'mustPress', false)
            setPropertyFromGroup('unspawnNotes', i, 'noteData', getPropertyFromGroup('unspawnNotes', i, 'noteData')+4)
        end
	end
	for i=0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' then
            setPropertyFromGroup('unspawnNotes', i, 'mustPress', false)
            setPropertyFromGroup('unspawnNotes', i, 'noteData', getPropertyFromGroup('unspawnNotes', i, 'noteData')+8)
        end
	end
	for i=0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'managerSoloNotes' then
            if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                setPropertyFromGroup('unspawnNotes', i, 'noteData', getPropertyFromGroup('unspawnNotes', i, 'noteData')+12)
            end
        end
    end
    for i=0,3 do
        setProperty('third'..i..'.alpha', 0)
        setProperty('fourth'..i..'.alpha', 0)
        setProperty('fifth'..i..'.alpha', 0)
    end
	if not getPropertyFromClass('ClientPrefs', 'optimizationMode') then
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums', i + 4, 'texture', 'notes/AileenNOTE_assets');
			setPropertyFromGroup('opponentStrums', i + 8, 'texture', 'notes/MarcoNOTE_assets');
			setPropertyFromGroup('opponentStrums', i + 12, 'texture', 'notes/LilyNOTE_assets');
			
			setPropertyFromGroup('strumLineNotes', i + 4, 'texture', 'notes/AileenNOTE_assets');
			setPropertyFromGroup('strumLineNotes', i + 12, 'texture', 'notes/LilyNOTE_assets');
		end
	end
end
function TweenLinear(t, b, c, d)
    return c*t/d+b
end

function onUpdatePost()
    for i=0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', i, 'mustPress')==false then
            setPropertyFromGroup('notes', i, 'scale.x', getPropertyFromGroup('strumLineNotes', 0, 'scale.x'))
            if not getPropertyFromGroup('notes', i, 'isSustainNote') then
                setPropertyFromGroup('notes', i, 'scale.y', getPropertyFromGroup('strumLineNotes', 0, 'scale.y'))
            end
        else
            setPropertyFromGroup('notes', i, 'scale.x', getPropertyFromGroup('playerStrums', 0, 'scale.x'))
            if not getPropertyFromGroup('notes', i, 'isSustainNote') then
                setPropertyFromGroup('notes', i, 'scale.y', getPropertyFromGroup('playerStrums', 0, 'scale.y'))
            end
        end
    end
end

function onSongStart()
    ThirdTweening = true
end

local ThirdTweening=false
local FourthTweening=false
local FifthTweening=false
function onUpdate()
    if ThirdTweening then
        TimePassed=1-runHaxeCode('return game.modchartTimers.get("Third").timeLeft;')
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', TweenLinear(TimePassed, DefaultSize, (DefaultSize/1.1)-DefaultSize, 1))
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', TweenLinear(TimePassed, DefaultSize, (DefaultSize/1.1)-DefaultSize, 1))
            setPropertyFromGroup('strumLineNotes', i+16, 'scale.x', TweenLinear(TimePassed, DefaultSize, (DefaultSize/1.1)-DefaultSize, 1))
            setPropertyFromGroup('strumLineNotes', i+16, 'scale.y', TweenLinear(TimePassed, DefaultSize, (DefaultSize/1.1)-DefaultSize, 1))
        end
    end
    if FourthTweening then
        TimePassed=1-runHaxeCode('return game.modchartTimers.get("Fourth").timeLeft;')
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', TweenLinear(TimePassed, DefaultSize/1.1, (DefaultSize/1.6)-(DefaultSize/1.1), 1))
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', TweenLinear(TimePassed, DefaultSize/1.1, (DefaultSize/1.6)-(DefaultSize/1.1), 1))
            setProperty('fourth'..i..'.scale.x', TweenLinear(TimePassed, DefaultSize/1.1, (DefaultSize/1.6)-(DefaultSize/1.1), 1))
            setProperty('fourth'..i..'.scale.y', TweenLinear(TimePassed, DefaultSize/1.1, (DefaultSize/1.6)-(DefaultSize/1.1), 1))
        end
    end
    if FifthTweening then
        TimePassed=1-runHaxeCode('return game.modchartTimers.get("Fifth").timeLeft;')
        for i=0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'scale.x', TweenLinear(TimePassed, DefaultSize/1.6, (DefaultSize/2.2)-(DefaultSize/1.6), 1))
            setPropertyFromGroup('strumLineNotes', i, 'scale.y', TweenLinear(TimePassed, DefaultSize/1.6, (DefaultSize/2.2)-(DefaultSize/1.6), 1))
            setProperty('third'..i..'.scale.x', TweenLinear(TimePassed, DefaultSize/1.6, (DefaultSize/2.2)-(DefaultSize/1.6), 1))
            setProperty('third'..i..'.scale.y', TweenLinear(TimePassed, DefaultSize/1.6, (DefaultSize/2.2)-(DefaultSize/1.6), 1))
            setProperty('fourth'..i..'.scale.x', TweenLinear(TimePassed, DefaultSize/1.6, (DefaultSize/2.2)-(DefaultSize/1.6), 1))
            setProperty('fourth'..i..'.scale.y', TweenLinear(TimePassed, DefaultSize/1.6, (DefaultSize/2.2)-(DefaultSize/1.6), 1))
        end
    end
end
function onTimerCompleted(tag)
    if tag=='Third' then
        ThirdTweening=false
    end
    if tag=='Fourth' then
        FourthTweening=false
    end
    if tag=='Fifth' then
        FifthTweening=false
    end
end
function onStepHit()
    if curStep==3150 then
        runTimer('Third', 1)
        noteTweenX('Move0', 0, defaultOpponentStrumX0-90, 1, 'circOut')
        noteTweenX('Move1', 1, defaultOpponentStrumX0-90+Spacing, 1, 'circOut')
        noteTweenX('Move2', 2, defaultOpponentStrumX0-90+Spacing*2, 1, 'circOut')
        noteTweenX('Move3', 3, defaultOpponentStrumX0-90+Spacing*3, 1, 'circOut')
        noteTweenX('Move16', 16, defaultPlayerStrumX3+90-Spacing*3, 1, 'circOut')
        noteTweenX('Move17', 17, defaultPlayerStrumX3+90-Spacing*2, 1, 'circOut')
        noteTweenX('Move18', 18, defaultPlayerStrumX3+90-Spacing, 1, 'circOut')
        noteTweenX('Move19', 19, defaultPlayerStrumX3+90, 1, 'circOut')
        setProperty('fourth0.x', defaultOpponentStrumX0-90+Spacing*3+130)
        setProperty('fourth1.x', getProperty('fourth0.x')+Spacing)
        setProperty('fourth2.x', getProperty('fourth1.x')+Spacing)
        setProperty('fourth3.x', getProperty('fourth2.x')+Spacing)
        for i=0,3 do
            setProperty('fourth'..i..'.scale.x', DefaultSize/1.1)
            setProperty('fourth'..i..'.scale.y', DefaultSize/1.1)
            setProperty('fourth'..i..'.y', defaultOpponentStrumY0)
        end
        doTweenAlpha('Fourth0', 'fourth0', 1, 1, 'circOut')
        doTweenAlpha('Fourth1', 'fourth1', 1, 1, 'circOut')
        doTweenAlpha('Fourth2', 'fourth2', 1, 1, 'circOut')
        doTweenAlpha('Fourth3', 'fourth3', 1, 1, 'circOut')
    end
    if curStep==3406 then
        FourthTweening=true
        Spacing=(100/(1.6/1.1))
        SPACING=(100/(1.1/1.1))
        runTimer('Fourth', 1)
        noteTweenX('Move0', 0, defaultOpponentStrumX0-90, 1, 'circOut')
        noteTweenX('Move1', 1, defaultOpponentStrumX0-90+Spacing, 1, 'circOut')
        noteTweenX('Move2', 2, defaultOpponentStrumX0-90+Spacing*2, 1, 'circOut')
        noteTweenX('Move3', 3, defaultOpponentStrumX0-90+Spacing*3, 1, 'circOut')
        noteTweenX('Move16', 16, defaultPlayerStrumX3+90-SPACING*3, 1, 'circOut')
        noteTweenX('Move17', 17, defaultPlayerStrumX3+90-SPACING*2, 1, 'circOut')
        noteTweenX('Move18', 18, defaultPlayerStrumX3+90-SPACING, 1, 'circOut')
        noteTweenX('Move19', 19, defaultPlayerStrumX3+90, 1, 'circOut')
        for i=0,3 do
            setProperty('third'..i..'.scale.x', DefaultSize/1.6)
            setProperty('third'..i..'.scale.y', DefaultSize/1.6)
            setProperty('third'..i..'.y', defaultOpponentStrumY0)
        end
        doTweenX('FourthMove0', 'fourth0', defaultOpponentStrumX0-90+(Spacing*3)+75+Spacing+Spacing+Spacing+75, 1, 'circOut')
        doTweenX('FourthMove1', 'fourth1', defaultOpponentStrumX0-90+(Spacing*3)+75+Spacing+Spacing+Spacing+75+Spacing, 1, 'circOut')
        doTweenX('FourthMove2', 'fourth2', defaultOpponentStrumX0-90+(Spacing*3)+75+Spacing+Spacing+Spacing+75+Spacing+Spacing, 1, 'circOut')
        doTweenX('FourthMove3', 'fourth3', defaultOpponentStrumX0-90+(Spacing*3)+75+Spacing+Spacing+Spacing+75+Spacing+Spacing+Spacing, 1, 'circOut')
        setProperty('third0.x', defaultOpponentStrumX0-90+(Spacing*3)+75)
        setProperty('third1.x', getProperty('third0.x')+Spacing)
        setProperty('third2.x', getProperty('third1.x')+Spacing)
        setProperty('third3.x', getProperty('third2.x')+Spacing)
        doTweenAlpha('Third0', 'third0', 1, 1, 'circOut')
        doTweenAlpha('Third1', 'third1', 1, 1, 'circOut')
        doTweenAlpha('Third2', 'third2', 1, 1, 'circOut')
        doTweenAlpha('Third3', 'third3', 1, 1, 'circOut')
    end
    if curStep==3662 then
        FifthTweening=true
        Spacing=(100/(2.2/1.1))
        SPACING=(100/(1.1/1.1))
        runTimer('Fifth', 1)
        noteTweenX('Move0', 0, defaultOpponentStrumX0-90, 1, 'circOut')
        noteTweenX('Move1', 1, defaultOpponentStrumX0-90+Spacing, 1, 'circOut')
        noteTweenX('Move2', 2, defaultOpponentStrumX0-90+Spacing*2, 1, 'circOut')
        noteTweenX('Move3', 3, defaultOpponentStrumX0-90+Spacing*3, 1, 'circOut')
        noteTweenX('Move16', 16, defaultPlayerStrumX3+90-SPACING*3, 1, 'circOut')
        noteTweenX('Move17', 17, defaultPlayerStrumX3+90-SPACING*2, 1, 'circOut')
        noteTweenX('Move18', 18, defaultPlayerStrumX3+90-SPACING, 1, 'circOut')
        noteTweenX('Move19', 19, defaultPlayerStrumX3+90, 1, 'circOut')
        for i=0,3 do
            setProperty('fifth'..i..'.scale.x', DefaultSize/2.2)
            setProperty('fifth'..i..'.scale.y', DefaultSize/2.2)
            setProperty('fifth'..i..'.y', defaultOpponentStrumY0)
        end
        doTweenX('ThirdMove0', 'third0', defaultOpponentStrumX0-90+(Spacing*3)+60, 1, 'circOut')
        doTweenX('ThirdMove1', 'third1', defaultOpponentStrumX0-90+(Spacing*3)+60+Spacing, 1, 'circOut')
        doTweenX('ThirdMove2', 'third2', defaultOpponentStrumX0-90+(Spacing*3)+60+Spacing+Spacing, 1, 'circOut')
        doTweenX('ThirdMove3', 'third3', defaultOpponentStrumX0-90+(Spacing*3)+60+Spacing+Spacing+Spacing, 1, 'circOut')
        doTweenX('FourthMove0', 'fourth0', defaultOpponentStrumX0-90+(Spacing*3)+60+Spacing+Spacing+Spacing+60, 1, 'circOut')
        doTweenX('FourthMove1', 'fourth1', defaultOpponentStrumX0-90+(Spacing*3)+60+Spacing+Spacing+Spacing+60+Spacing, 1, 'circOut')
        doTweenX('FourthMove2', 'fourth2', defaultOpponentStrumX0-90+(Spacing*3)+60+Spacing+Spacing+Spacing+60+Spacing+Spacing, 1, 'circOut')
        doTweenX('FourthMove3', 'fourth3', defaultOpponentStrumX0-90+(Spacing*3)+60+Spacing+Spacing+Spacing+60+Spacing+Spacing+Spacing, 1, 'circOut')
        setProperty('fifth0.x', defaultOpponentStrumX0-90+(Spacing*3)+60+Spacing+Spacing+Spacing+60+Spacing+Spacing+Spacing+60)
        setProperty('fifth1.x', getProperty('fifth0.x')+Spacing)
        setProperty('fifth2.x', getProperty('fifth1.x')+Spacing)
        setProperty('fifth3.x', getProperty('fifth2.x')+Spacing)
        doTweenAlpha('Fifth0', 'fifth0', 1, 1, 'circOut')
        doTweenAlpha('Fifth1', 'fifth1', 1, 1, 'circOut')
        doTweenAlpha('Fifth2', 'fifth2', 1, 1, 'circOut')
        doTweenAlpha('Fifth3', 'fifth3', 1, 1, 'circOut')
    end
end