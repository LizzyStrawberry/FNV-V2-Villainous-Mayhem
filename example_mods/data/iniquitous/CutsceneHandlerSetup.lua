local cutShit =
{
    hasDial = false,
    hasStartVid = true, vidPath = "Finale_Intro",
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = true, endVidPath = "Game_Over"
}


local instructShit = 
{
    hasMech = true,
    isBoss = true,
    graphName = "iniquitous",
	frame = 0,
    diff = "Iniquitous"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "<R>RESPONSE<R>",
    tip1 = "<R>As soon as the circles collide, press DODGE.\nFailure results in tremendous damage.<R>",
	tipIcon1 = "iniquitousRings"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
	if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end
	
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
		
		makeLuaSprite('blackOverlay', 'instructions/blackOverlay', 0, 0)
		setObjectCamera('blackOverlay', 'other')
		setProperty('blackOverlay.alpha', 0)
		setGraphicSize('blackOverlay', screenWidth, screenHeight)
	end
end

function onCreatePost()
	if mechanics then
		setProperty("gimmickTitle.color", getColorFromHex("FF0000"))
		addLuaSprite('blackOverlay', true)
	end
end

function onUpdate()
	if mechanics and getProperty("blackOverlay.alpha") > 0 and not getVar("handlerComplete") then
		setProperty("blackOverlay.alpha", getProperty("backdrop.alpha") - 0.25)
	end
	if mechanics and getProperty("blackOverlay.alpha") < 0 and not getVar("handlerComplete") then
		setProperty("blackOverlay.alpha", 0)
	end
end