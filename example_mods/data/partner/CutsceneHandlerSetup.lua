local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "dv",
	frame = 0,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "FAITH",
    tip1 = "Your Health Bar has been replaced by the Faith Bar. Do not miss more than:",
	tipIcon1 = "faithBar"
}

local name = "Cutscene and Instructions Handler"

local missAmount = 45
function onCreate()
	if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end
	
    if mechanics then -- To only apply this if mechanics are enabled!
		if isMayhemMode then
			tipShit.tip1 = "Missing will deplete your <C>Faith Bar<C>. Keep hitting your notes to replenish it. Things only get worse once your <C>Faith Bar<C> is <R>low.<R>"
		else
			if difficulty == 1 then	missAmount = 25 elseif difficulty == 2 then missAmount = 12 end
			tipShit.tip1 = "Your <G>Health Bar<G> has been replaced by the <C>Faith Bar<C>. Do not miss more than "..missAmount.." times, otherwise <R>suffer.<R>"
		end
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
		setGlobalFromScript("scripts/"..name, "backdropColor", "11001f")

		makeLuaSprite('blackOverlay', 'instructions/blackOverlay', 0, 0)
		setObjectCamera('blackOverlay', 'other')
		setProperty('blackOverlay.alpha', 0)
		setGraphicSize('blackOverlay', screenWidth, screenHeight)
	end
end

function onCreatePost()
	addLuaSprite('blackOverlay')
end

function onUpdate()
	if mechanics and getProperty("blackOverlay.alpha") > 0 and not getVar("handlerComplete") then
		setProperty("blackOverlay.alpha", getProperty("backdrop.alpha"))
	end
	if mechanics and getProperty("blackOverlay.alpha") < 0 and not getVar("handlerComplete") then
		setProperty("blackOverlay.alpha", 0)
	end
end