local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "Marcx",
	frame = 0,
    diff = nil
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "<PUR>POISON<PUR> ATTACK",
    tip1 = "Beware of AI's attack!\nPress <G>DODGE<G> once you hear the 3rd click on her attack sequence, or get hit by the needle!",
	tipIcon1 = "aiTail"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
	end
end