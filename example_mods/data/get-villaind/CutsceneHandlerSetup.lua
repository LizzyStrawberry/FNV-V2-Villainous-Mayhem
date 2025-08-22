local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "Morky",
	frame = 0,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "<R>M<R><G>O<G><GR>R<GR><PUR>K<PUR><P>Y<P>",
    tip1 = "MORKY SINGS!!1!\nMORKY WILL DROP BARS!!1!\nMORKY IS SO COOL!11!\nMORKY IS SO AWESOME!1!!\nHIS NAME IS MORKY!!1!!1\n<R>Obey him.<R>",
	tipIcon1 = "mork"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
	end
end