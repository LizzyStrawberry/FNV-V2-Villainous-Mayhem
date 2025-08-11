local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "DV",
    diff = "Casual"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if mechanics then -- To only apply this if mechanics are enabled!
		if isMayhemMode then
			instructShit.graphName = "DVMayhem"
		end
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.diff})
    end
end