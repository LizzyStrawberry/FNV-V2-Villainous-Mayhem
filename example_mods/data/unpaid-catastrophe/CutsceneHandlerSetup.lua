local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "aizeenPhase2",
	frame = 2,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "<GR>TOXIC<GR>",
    tip1 = "Beware! Be sure to press these notes, they function the opposite way, unlike Marco's!\nOh, they come from the enemy side too!",
	tipIcon1 = "poisonNote"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
    end
end