local instructShit = 
{
    hasMech = true,
    isBoss = true,
    graphName = "",
	frame = 0,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "",
    tip1 = "",
	tipIcon1 = ""
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
		setGlobalFromScript("scripts/"..name, "backdropColor", "NONE")
	end
end

function onCreatePost()
	if mechanics then -- To only apply this if mechanics are enabled!
		loadGraphic("backdrop", "instructions/Inst-Debug")
		scaleObject("backdrop", 0.67, 0.67)
		screenCenter("backdrop", "XY")
	end
end