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
		frame = 0,
        diff = nil
    }
	
	local tipShit = 
	{
		numOfTips = 1,
		-- Insert amount of tips (up to 3 total)
		title1 = "SCROLL SPEED",
		tip1 = "Marco loves to tamper around with the <GR>scroll speed<GR> every now and then.\nBe prepared for any <G>speed ups<G> or <R>slow downs!<R>",
		tipIcon1 = "scrollSpeed",
		title2 = "POISON NOTES",
		tip2 = "Poison has been thrown around!\nBe careful not to touch any of it!",
		tipIcon2 = "scrollSpeed",
		title3 = "Shit",
		tip3 = "New lmao",
		tipIcon3 = "scrollSpeed"
	}

    local name = "Cutscene and Instructions Handler"
    function onCreate()
        if isStoryMode then -- To Apply only to story mode!
            callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit,hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
        end

        if mechanics then -- To only apply this if mechanics are enabled!
            callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
			callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1, tipShit.title2, tipShit.tip2, tipShit.tipIcon2, tipShit.title3, tipShit.tip3, tipShit.tipIcon3})
		end
    end
]]

enabled = true

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
	iconFrame = 0,
	
    diff = 0
}

local tipData =
{
	numOfTips = 1,
	tipTitle1 = "",
	textForTip1 = "",
	icon1 = "",
	tipTitle2 = nil,
	textForTip2 = nil,
	icon2 = nil,
	tipTitle3 = nil,
	textForTip3 = nil,
	icon3 = nil
}
local tipTitleSize, tipSize = 75, 50
backdropColor = nil

local showMechanic = false
local confirmMechanic = false

function onCreate()
	setVar("handlerComplete", false)
end

function onStartCountdown()
	if not seenCutscene and enabled then
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

function onSongStart()
	setVar("handlerComplete", true)
end

function onCreatePost()    
	if instructionsData.hasMechanic then
		if backdropColor == nil then backdropColor = rgbToHex(getProperty('dad.healthColorArray')) end
		
		makeLuaSprite('backdrop', 'instructions/backDrop', 0, 0)
		setObjectCamera('backdrop', 'other')
		setProperty('backdrop.alpha', 0)
		if backdropColor ~= "NONE" then setProperty('backdrop.color', getColorFromHex(backdropColor)) end
		setGraphicSize('backdrop', screenWidth, screenHeight)
		addLuaSprite('backdrop')
		
		makeLuaSprite('gimmickTitle', 'instructions/opponentGimmick', 500, 50)
		scaleObject("gimmickTitle", 1.15, 1.2)
		setObjectCamera('gimmickTitle', 'other')
		setProperty('gimmickTitle.alpha', 0)
		if backdropColor ~= "NONE" then
			addLuaSprite('gimmickTitle')
		end
		
		createInstance('iconGimmick', 'HealthIcon', {instructionsData.instGraphic, false})
		setObjectCamera('iconGimmick', "other")
		scaleObject("iconGimmick", 2.25, 2.25)
		setProperty("iconGimmick.x", 150) setProperty("iconGimmick.y", 300)
		setProperty("iconGimmick.animation.curAnim.curFrame", instructionsData.iconFrame) setProperty("iconGimmick.alpha", 0)
		if backdropColor ~= "NONE" then
			addInstance('iconGimmick')
		end

		for i = 1, tipData.numOfTips do
			makeLuaSprite('tipIcon'..i, 'instructions/tipIcons/'..tipData["tipIcon"..i], 375 + (tipData.numOfTips * 50), 175)
			setObjectCamera('tipIcon'..i, 'other')
			scaleObject('tipIcon'..i, 0.5 - (tipData.numOfTips * 0.1), 0.5 - (tipData.numOfTips * 0.1))
			setProperty('tipIcon'..i..'.alpha', 0)
			if backdropColor ~= "NONE" then addLuaSprite('tipIcon'..i) end
		end
		
		setTipsPosition(tipData.numOfTips)
		
		for i = 1, tipData.numOfTips do
			makeLuaText('tipTitle'..i, tipData["tipTitle"..i], 700, getProperty("tipIcon"..i..".x") + (250 - (tipData.numOfTips * 50)), getProperty("tipIcon"..i..".y") + 10)
			setTextAlignment('tipTitle'..i, 'LEFT')
			setTextSize('tipTitle'..i, tipTitleSize)
			setTextFont('tipTitle'..i, "atarian-bold-italic.ttf")
			setProperty('tipTitle'..i..'.alpha', 0)
			setObjectCamera('tipTitle'..i, 'other')
			addMarkers('tipTitle'..i)
			if backdropColor ~= "NONE" then addLuaText('tipTitle'..i) end
			
			makeLuaText('tip'..i, tipData["textForTip"..i], 625, getProperty("tipTitle"..i..".x"), getProperty("tipTitle"..i..".y") + getProperty("tipTitle"..i..'.height') + 6)
			setTextAlignment('tip'..i, 'LEFT')
			setTextSize('tip'..i, tipSize)
			setTextFont('tip'..i, "atarian-regular.ttf")
			setProperty('tip'..i..'.alpha', 0)
			setObjectCamera('tip'..i, 'other')
			addMarkers('tip'..i)
			if backdropColor ~= "NONE" then addLuaText('tip'..i) end
		end

        if instructionsData.isBossFight then
            makeLuaSprite('bossFight', 'instructions/bossFightWarning', 0, 0)
            setObjectCamera('bossFight', 'other')
            setProperty('bossFight.alpha', 0)
            setGraphicSize("bossFight", screenWidth, screenHeight)
            addLuaSprite('bossFight')
        end
		
		makeLuaText('warnTxt', 'PRESS Y TO START!', 900, 10, 650)
		setTextAlignment('warnTxt', 'LEFT')
		setTextSize('warnTxt', 40)
		setProperty('warnTxt.alpha', 0)
		setObjectCamera('warnTxt', 'other')
		addLuaText('warnTxt')
	end
end

function setTipsPosition(numOfTips)
	if numOfTips == 1 then
		setProperty("tipIcon1.y", 250)
	elseif numOfTips == 2 then
		setProperty("tipIcon1.y", 175)
		setProperty("tipIcon2.y", 400)
		tipTitleSize = 50
		tipSize = 35
	elseif numOfTips == 3 then
		setProperty("tipIcon1.y", 175)
		setProperty("tipIcon2.y", 350)
		setProperty("tipIcon3.y", 525)
		tipTitleSize = 40
		tipSize = 25
	end
end

function onUpdate(elapsed)
	-- Mechanic check
	if instructionsData.hasMechanic and difficulty >= instructionsData.diff and showMechanic then
		if instructionsData.isBossFight then setProperty("bossFight.alpha", getProperty("warnTxt.alpha")) end
		setProperty("gimmickTitle.alpha", getProperty("backdrop.alpha"))
		setProperty("iconGimmick.alpha", getProperty("backdrop.alpha"))
		
		for i = 1, tipData.numOfTips do
			setProperty("tipTitle"..i..".alpha", getProperty("backdrop.alpha"))
			setProperty("tip"..i..".alpha", getProperty("backdrop.alpha"))
			setProperty("tipIcon"..i..".alpha", getProperty("backdrop.alpha"))
		end
        
        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Y') then
            playSound('confirmMenu')

            if instructionsData.isBossFight then
                doTweenAlpha('disableBossFight', 'bossFight', 0, 0.75, 'sineOut')
            end
            doTweenAlpha('disableBackdrop', 'backdrop', 0, 0.75, 'sineOut')
			doTweenAlpha('disableWarnTxt', 'warnTxt', 0, 0.75, 'sineOut')

            confirmMechanic = true
			cancelAllTweens()
			startCountdown()
		end
	end
end

function cancelAllTweens()
	cancelTween('backdropAppear')

    cancelTween('warningTXThi')
	cancelTween('warningTXTbye')
	
	cancelTimer('warningAppear')
	cancelTimer('warningDisappear')
end

-- Cutscene stuff
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
		if getProperty("backdrop.alpha") == 0 then doTweenAlpha('backdropAppear', 'backdrop', 1, 1, 'cubeInOut') end
		doTweenAlpha('warningTXTbye', 'warnTxt', 0, 0.6, 'sineOut')
	end
	if tag == 'warningDisappear' then
		runTimer('warningAppear', 1)
		doTweenAlpha('warningTXThi', 'warnTxt', 1, 0.6, 'sineOut')
	end
end

function onTweenCompleted(tag)
	if tag == "disableBackdrop" then
		showMechanic = false
		removeLuaSprite('backdrop', true)
		removeLuaSprite('gimmickTitle', true)
		for i = 1, tipData.numOfTips do
			removeLuaSprite('tipTitle'..i, true)
			removeLuaText('tip'..i, true)
			removeLuaSprite('tipIcon'..i, true)
		end
		
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

function setInstructionsData(mechOn, bFight, graph, iconFrame, diffString, tipNum, tip1, tip2, tip3)
	if diffString == nil then diffString = "Casual" end -- Fail Safe
	if iconFrame == nil then iconFrame = 0 end -- Fail Safe
	if tipNum == nil then tipNum = 1 end -- Fail Safe
	if tip1 == nil then tip1 = "This is a test tip." end -- Fail Safe
	
    instructionsData.hasMechanic = mechOn
    instructionsData.isBossFight = bFight
	
    instructionsData.instGraphic = graph
	instructionsData.iconFrame = iconFrame
	
	instructionsData.diff = difficultyStringToNumber(diffString)
	
	instructionsData.numOfTips = tipNum
	instructionsData.textForTip1 = tip1
	instructionsData.textForTip2 = tip2
	instructionsData.textForTip3 = tip3
end

function setTipData(tipNum, title1, tip1, icon1, title2, tip2, icon2, title3, tip3, icon3)
	tipData.numOfTips = tipNum
	
	tipData.tipTitle1 = title1
	tipData.textForTip1 = tip1
	tipData.tipIcon1 = icon1
	
	tipData.tipTitle2 = title2
	tipData.textForTip2 = tip2
	tipData.tipIcon2 = icon2
	
	tipData.tipTitle3 = title3
	tipData.textForTip3 = tip3
	tipData.tipIcon3 = icon3
end

function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
    return string.format('%02x%02x%02x', math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end