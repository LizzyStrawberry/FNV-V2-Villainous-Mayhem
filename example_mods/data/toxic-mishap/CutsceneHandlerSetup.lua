local cutShit = 
{
    hasDial = true,
    hasStartVid = false, vidPath = nil,
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = false, endVidPath = nil
}

local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "Marco",
	frame = 2,
    diff = "Villainous"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "<GR>POISON<GR>",
    tip1 = "Avoid pressing the <GR>Poison Notes<GR>, they've venomous for your health!\nLiterally lethal to you.",
	tipIcon1 = "poisonNote"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end

    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
		setGlobalFromScript("scripts/"..name, "backdropColor", "11ff00")
    end
end