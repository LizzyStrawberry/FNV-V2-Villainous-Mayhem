local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "Kiana",
	frame = 0,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 2,
    title1 = "LUST NOTES - BAR",
    tip1 = "Beware of Kiana's lust notes! Pressing them will increase the Lust Bar bit by bit!",
	tipIcon1 = "lustNote",
	title2 = "TAIL LUNGE",
    tip2 = "Dropping on all 4's, Kiana won't hesitate to hit you with her tail! Press DODGE to avoid the attack!",
	tipIcon2 = "lustTimer"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1, tipShit.title2, tipShit.tip2, tipShit.tipIcon2})
	end
end