--[[
    Lizzy's Cutscene and Instructions Handler
    ------------------------------------------

    With this, you can do the following:
    - Play Startup Video before dialogue
    - Play Dialogue
    - Play Video Mid-Dialogue
    - Play Ending Video
    - Show instructions (if mechanics apply)

    To use:
    Make a lua script in your song's data folder, and do this:
    -- VALUES ARE TO BE CHANGED TO YOUR LIKING ON BOTH STRUCTS!! --
    local cutShit = 
    {
        hasDial = true,
        hasStartVid = false, vidPath = nil,
        hasMidDialVid = false, midVidPath = nil, midPos = -1,
        hasEndVid = false, endVidPath = nil
    }

    -- ADD THIS IF YOU WANT INSTRUCTIONS FOR YOUR MECHANICS!!
    local instructShit = 
    {
        hasMech = false,
        isBoss = false,
        graphName = nil,
        diff = nil

    }

    local name = "Cutscene and Instructions Handler"
    function onCreate()
        if isStoryMode then -- To Apply only to story mode!
            callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit,hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
        end

        if mechanics then -- To only apply this if mechanics are enabled!
            callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.diff})
        end
    end
]]

local cutsceneData =
{
    hasDialogue = false,
    hasStartupVideo = false, videoPath = "",
    hasMidDialogueVideo = false, midVideoPath = "", midVideoPos = -1,
    hasEndVideo = false, endVideoPath = ""
}

local viewedVideo = false
local viewedDialogue = false

local instructionsData = 
{
    hasMechanic = false,
    isBossFight = false,
    instGraphic = "",
    diff = 0
}

local showMechanic = false
local confirmMechanic = false

function onStartCountdown()
	if not seenCutscene then
		if cutsceneData.hasStartupVideo and not viewedVideo then -- In Case of Start Up Video
			startVideo(cutsceneData.videoPath)
			viewedVideo = true
			return Function_Stop
		elseif cutsceneData.hasDialogue and not viewedDialogue then -- In case of Dialogue
			setProperty('inCutscene', true)
			runTimer('playDialogue', 0.8)
			viewedDialogue = true
			return Function_Stop
		elseif instructionsData.hasMechanic and not showMechanic then -- If there are mechanics
			showMechanic = true
			runTimer('warningAppear', 0.01)

			if not confirmMechanic then
				return Function_Stop
			end
		end
		setPropertyFromClass("PlayState", "seenCutscene", true)
	end

    return Function_Continue -- Allow Countdown
end

function onCreatePost()    
	if instructionsData.hasMechanic then
		makeLuaSprite('warn', 'instructions/Inst-'..instructionsData.instGraphic, 0, 0)
		setObjectCamera('warn', 'other')
		setProperty('warn.alpha', 0)
		scaleObject('warn', 0.67, 0.67)
		addLuaSprite('warn')

        if instructionsData.isBossFight then
            makeLuaSprite('bossFight', 'instructions/bossFightWarning', 0, 0)
            setObjectCamera('bossFight', 'other')
            setProperty('bossFight.alpha', 0)
            setGraphicSize("bossFight", screenWidth, screenHeight)
            addLuaSprite('bossFight')
        end
		
		makeLuaText('warnTxt', 'PRESS Y TO START!', 900, 0, 650)
		setTextAlignment('warnTxt', 'LEFT')
		setTextSize('warnTxt', 40)
		setProperty('warnTxt.alpha', 0)
		setObjectCamera('warnTxt', 'other')
		addLuaText('warnTxt')
	end
end

function onUpdate()
	if instructionsData.hasMechanic and difficulty >= instructionsData.diff and showMechanic and not confirmMechanic then
		if instructionsData.isBossFight then setProperty("bossFight.alpha", getProperty("warnTxt.alpha")) end
        
        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Y') then
            playSound('confirmMenu');

            if instructionsData.isBossFight then
                doTweenAlpha('disableBossFight', 'bossFight', 0, 0.75, 'sineOut')
            end
            doTweenAlpha('disableWarn', 'warn', 0, 0.75, 'sineOut')
			doTweenAlpha('disableWarnTxt', 'warnTxt', 0, 0.75, 'sineOut')

            runTimer('removeEverything', 0.75)
	
            confirmMechanic = true
			cancelAllTweens()
			startCountdown()
		end
	end
end

function cancelAllTweens()
	cancelTween('warnAppear')

    cancelTween('warningTXThi')
	cancelTween('warningTXTbye')
	
	cancelTimer('warningAppear')
	cancelTimer('warningDisappear')
end

function onNextDialogue(line)
	if cutsceneData.hasMidDialogueVideo and line == cutsceneData.midVideoPos then
		playDialogueVideo(cutsceneData.midVideoPath);
	end
end

local endingSong = false
function onEndSong()
	if cutsceneData.hasEndVideo and not endingSong then
		startVideo(cutsceneData.endVideoPath)
		endingSong = true
		return Function_Stop
	end
	return Function_Continue
end

function onTimerCompleted(tag)
    -- Dialogue Stuff
	if tag == 'playDialogue' then
		startDialogue("dialogue");
	end

    -- Mechanic Stuff
    if tag == 'warningAppear' then
		runTimer('warningDisappear', 1)
		if getProperty("warn.alpha") == 0 then doTweenAlpha('warnAppear', 'warn', 1, 1, 'cubeInOut') end
		doTweenAlpha('warningTXTbye', 'warnTxt', 0, 0.6, 'sineOut');
	end
	if tag == 'warningDisappear' then
		runTimer('warningAppear', 1)
		doTweenAlpha('warningTXThi', 'warnTxt', 1, 0.6, 'sineOut');
	end
	if tag == 'removeEverything' then
		removeLuaSprite('warn', true)
        if instructionsData.isBossFight then
            removeLuaSprite('bossFight', true)
        end
		removeLuaText('warnTxt', true)
	end
end

function setCutsceneData(hasDial, hasSVid, vidPath, hasMVid, midVidPath, midPos, endVid, endVidPath)
    cutsceneData.hasDialogue = hasDial
    cutsceneData.hasStartupVideo = hasSVid
    cutsceneData.videoPath = vidPath
    cutsceneData.hasMidDialogueVideo = hasMVid
    cutsceneData.midVideoPath = midVidPath
    cutsceneData.midVideoPos = midPos
    cutsceneData.hasEndVideo = endVid
    cutsceneData.endVideoPath = endVidPath
end

function setInstructionsData(mechOn, bFight, graph, diffString)
	if diffString == nil then diffString = "Casual" end -- Fail Safe
	
    instructionsData.hasMechanic = mechOn
    instructionsData.isBossFight = bFight
    instructionsData.instGraphic = graph
	instructionsData.diff = difficultyStringToNumber(diffString)
end