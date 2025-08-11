local cutShit = 
{
    hasDial = false,
    hasStartVid = true, vidPath = 'WeekLegacy_Song1Cutscene',
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = false, endVidPath = nil
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end
end