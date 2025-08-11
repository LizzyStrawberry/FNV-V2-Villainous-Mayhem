local instructShit = 
{
    hasMech = true,
    isBoss = true,
    graphName = "Marcussy",
    diff = "Villainous"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.diff})
    end
end