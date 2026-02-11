local instructShit = 
{
    hasMech = true,
    isBoss = true,
    graphName = "marcussy",
	frame = 2,
    diff = "Villainous"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "LIGHTS OUT",
    tip1 = "Marcussy keeps messing up the lights! Hit your <G>DODGE<G> button 10 times before it gets borderline dark to fix them!",
	tipIcon1 = "lightsOut"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
		setGlobalFromScript("scripts/"..name, "backdropColor", "00540a")
	end
end