function onCreatePost()
    runHaxeCode([[
        for (i in 0...4)
        {
			var x = 10 + (i * 65);
			var y = ClientPrefs.downScroll ? 70 : (FlxG.height - 50);
			
            var third = new StrumNote(x, y + (ClientPrefs.downScroll ? 80 : -80), i + 8, 0);
            third.downScroll = ClientPrefs.downScroll;
			third.scale.x /= 1.75;
			third.scale.y /= 1.75;
            game.strumLineNotes.insert(i + 4, third);
            game.opponentStrums.add(third);
            third.postAddedToGroup(false);

            third.cameras = [game.camHUD];
            game.modchartSprites.set('third' + i, third);
         };
         
         for (i in 0...4)
         {
         	var x = (FlxG.width * 0.775) + (i * 65);
			var y = ClientPrefs.downScroll ? 70 : (FlxG.height - 50);
			
            var fourth = new StrumNote(x, y + (ClientPrefs.downScroll ? -20 : 20), i + 12, 0);
            fourth.downScroll = ClientPrefs.downScroll;
			fourth.scale.x /= 1.75;
			fourth.scale.y /= 1.75;
            game.strumLineNotes.insert(i + 8, fourth);
            game.opponentStrums.add(fourth);
            fourth.postAddedToGroup(false);

            fourth.cameras = [game.camHUD];
            game.modchartSprites.set('fourth' + i, fourth);
          };
          
         for (i in 0...4)
         {  
         	var x = (FlxG.width * 0.775) + (i * 65);
			var y = ClientPrefs.downScroll ? 70 : (FlxG.height - 50);
			
            var fifth = new StrumNote(x, y + (ClientPrefs.downScroll ? 80 : -80), i + 16, 0);
            fifth.downScroll = ClientPrefs.downScroll;
			fifth.scale.x /= 1.75;
			fifth.scale.y /= 1.75;
            game.strumLineNotes.insert(i + 12, fifth);
            game.opponentStrums.add(fifth);
            fifth.postAddedToGroup(false);

            fifth.cameras = [game.camHUD];
            game.modchartSprites.set('fifth' + i, fifth);
        };

        game.singAnimations = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT', 'singLEFT', 'singDOWN', 'singUP', 'singRIGHT', 'singLEFT', 'singDOWN', 'singUP', 'singRIGHT', 'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];
    ]])

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
		
		for i = 0, 11 do
		    setPropertyFromGroup('opponentStrums', i + 4, 'scale.x', oppNoteScaleX)
			setPropertyFromGroup('opponentStrums', i + 4, 'scale.y', oppNoteScaleY)
		end
	end
end

function onStepHit()
    if curStep == 3150 then
        for i = 0, 3 do
             noteTweenY("noteY"..i, i + 8, getPropertyFromGroup("strumLineNotes", i + 8, "y") + (downscroll and 20 or -20), (1 + (i * 0.25)) / playbackRate, "circOut")
             noteTweenAlpha('noteAlpha'..i, i + 8, 1, 1 / playbackRate, 'circOut')
        end
    end
    if curStep == 3406 then
         for i = 0, 3 do
             noteTweenY("noteY"..i, i + 4, getPropertyFromGroup("strumLineNotes", i + 4, "y") + (downscroll and 20 or -20), (1 + (i * 0.25)) / playbackRate, "circOut")
             noteTweenAlpha('noteAlpha'..i, i + 4, 1, 1 / playbackRate, 'circOut')
        end
    end
    if curStep == 3662 then   
         for i = 0, 3 do
             noteTweenY("noteY"..i, i + 12, getPropertyFromGroup("strumLineNotes", i + 12, "y") + (downscroll and 20 or -20), (1 + (i * 0.25)) / playbackRate, "circOut")
             noteTweenAlpha('noteAlpha'..i, i + 12, 1, 1 / playbackRate, 'circOut')
        end
    end
