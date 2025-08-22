local cutShit = 
{
    hasDial = false,
    hasStartVid = false, vidPath = nil,
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = true, endVidPath = 'Week3_TrueEnd'
}

local instructShit = 
{
    hasMech = true,
    isBoss = true,
    graphName = "KianaFinalPhase",
	frame = 1,
    diff = "Villainous"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "<R>SPIKE<R> ATTACK",
    tip1 = "Kiana's gone BERSERK!\nPress LEFT or RIGHT to move away from the rising spikes!\nKeep track of the beat, it helps!",
	tipIcon1 = "spikes"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
	if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end
	
    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
		--setGlobalFromScript("scripts/"..name, "backdropColor", "00540a")
	end
end