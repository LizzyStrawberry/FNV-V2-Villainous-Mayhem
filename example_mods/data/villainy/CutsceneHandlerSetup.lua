local cutShit = 
{
    hasDial = true,
    hasStartVid = true, vidPath = "Week1_Song4Cutscene",
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = false, endVidPath = nil
}

local instructShit = 
{
    hasMech = true,
    isBoss = true,
    graphName = "marcoPhase3",
	frame = 0,
    diff = "Villainous"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "SCROLL SPEED",
    tip1 = "Marco loves to tamper around with the <GR>scroll speed<GR> every now and then.\nBe prepared for any <G>speed ups<G> or <R>slow downs!<R>",
	tipIcon1 = "scrollSpeed"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if isStoryMode then -- To Apply only to story mode!
        precacheSound('Week1_TrueEnd')
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end

    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
        callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
    end
end

function onCreatePost()
    if isStoryMode then
        makeLuaText('endingTXT', 'After their final send-off, Girlfriend did a cute peace sign and Marco almost had a mental breakdown.\nBut wait, what is this?\nThe Teleporter suddenly turned on and teleported GF away!\nMarco gets relieved, and lets his assistant Aileen know that this experience was like having a constipation whilst having an acid reflux at the same time.\nJust as he is about to leave, the portal glows again, and in drops a new intruder!\nShe looks like GF but with gold hair and an indigo dress. She seems determined to rap battle Marco, but he is very tired, so he shoots that motherfucker and asks Aileen to clean this mess, in which she obeys.', 1050, 0, 0)
        setTextAlignment('endingTXT', 'CENTER')
        setTextSize('endingTXT', 30)
        screenCenter('endingTXT', 'XY')
        setProperty('endingTXT.alpha', 0)
        setObjectCamera('endingTXT', 'other')
        addLuaText('endingTXT')
		
		makeLuaText('progressThing', 'Press ENTER to Continue.', 900, 0, 650)
		setTextAlignment('progressThing', 'LEFT')
		setTextSize('progressThing', 40)
		setProperty('progressThing.alpha', 0)
		setObjectCamera('progressThing', 'other')
		addLuaText('progressThing')
    end
end

local endingSequence = 0
local ending = false
function onUpdate()
	if endingSequence == 1 and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') then
		endingSequence = 2;
		setProperty('progressThing.alpha', 0)
		setProperty('camHUD.visible', false)
		playSound('Week1_TrueEnd', 1, 'aileenRant')
	end
end

function onEndSong()
	if not ending and isStoryMode then
		ending = true
		doTweenAlpha('goodbyeHud', 'camHUD', 0, 0.6, 'sineOut')
		doTweenAlpha('goodbyeGame', 'camGame', 0, 0.6, 'sineOut')
		doTweenAlpha('helloEnding', 'endingTXT', 1, 1, 'sineOut')
		runTimer('allowEnter', 7)
		return Function_Stop
	end
	return Function_Continue
end

function onSoundFinished(tag)
	if tag == 'aileenRant' then
		endSong()
	end
end

function onTweenCompleted(tag)
	if tag == 'endingTXT' then
		endingSequence = 1
	end
end

function onTimerCompleted(tag)
	if tag == 'allowEnter' then
		setProperty("camGame.visible", false)
		setProperty("camHUD.visible", false)
	 	doTweenAlpha('endingTXT', 'progressThing', 1, 0.6, 'sineOut');
	end
end