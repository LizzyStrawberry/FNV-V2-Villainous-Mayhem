local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "Beatrice",
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
	if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
	end
end