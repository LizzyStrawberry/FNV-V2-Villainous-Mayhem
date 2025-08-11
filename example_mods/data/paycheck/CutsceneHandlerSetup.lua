local cutShit = 
{
    hasDial = false,
    hasStartVid = true, vidPath = "WeekLegacy_Song3Cutscene",
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = false, endVidPath = nil
}


local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "Aileen",
    diff = "Casual"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if difficulty == 0 then
        cutShit.hasEndVid = true
        if getRandomInt(1, 25) == 12 then
            cutShit.endVidPath = 'Week1_SecretEnd'
        else
            cutShit.endVidPath = "Week1_NormalEnd"
        end
    end

    if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end
    
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.diff})
    end
end