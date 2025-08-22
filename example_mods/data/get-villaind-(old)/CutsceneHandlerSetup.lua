local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "Morky",
	frame = 2,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "<R>M<R><G>O<G><GR>R<GR><PUR>K<PUR><P>Y<P>",
    tip1 = "MORKY IS OLD!!1!\nMORKY WILL STILL DROP BARS!!1!\nMORKY IS STILL SO COOL!11!\nMORKY IS STILL SO AWESOME!1!!\nHIS NAME IS STILL MORKY!!1!!1",
	tipIcon1 = "mork"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
	end
end