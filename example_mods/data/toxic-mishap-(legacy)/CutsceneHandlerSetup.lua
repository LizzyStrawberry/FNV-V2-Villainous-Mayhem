local cutShit = 
{
    hasDial = false,
    hasStartVid = true, vidPath = "WeekLegacy_Song2Cutscene",
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = false, endVidPath = nil
}

local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "marco-old",
	frame = 2,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 2,
    title1 = "<GR>POISON<GR>",
    tip1 = "Avoid pressing the <GR>Poison Notes<GR>, they've venomous for your health!\nLiterally lethal to you.",
	tipIcon1 = "poisonNote",
	title2 = "SCROLL SPEED",
    tip2 = "Speed is in his name! (Not.)\nWatch out for the scroll speed changes ahead!",
	tipIcon2 = "scrollSpeed"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end

    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1, tipShit.title2, tipShit.tip2, tipShit.tipIcon2})
		setGlobalFromScript("scripts/"..name, "backdropColor", "007002")
    end
end