local cutShit = 
{
    hasDial = true,
    hasStartVid = true, vidPath = "WeekLegacy_Song3Cutscene",
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = false, endVidPath = nil
}


local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "Aileen",
	frame = 0,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "PROPAGANDA",
    tip1 = "While Aileen is distracting you, Marco's decided that it's <G>AD TIME!<G>\nPress the respective extra hitbox once the ad appears!\nDelaying will only cause death!",
	tipIcon1 = "ads"
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

    if not isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end
    
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
	end
end