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
    graphName = "beatrice",
	frame = 1,
    diff = "Villainous"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "INTERFERE NOTES",
    tip1 = "If you've ever played that one hedgehog mod, you know what this is!\nMake sure you press the notes this time, or things might get static-y!",
	tipIcon1 = "interferenceNotes"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if difficulty == 0 then
        cutShit.hasEndVid = true
        cutShit.endVidPath = 'Week2_NormalEnd'
    end

    if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end

    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
	end
end