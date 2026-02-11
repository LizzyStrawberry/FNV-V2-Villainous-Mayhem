local cutShit = 
{
    hasDial = true,
    hasStartVid = false, vidPath = nil,
    hasMidDialVid = true, midVidPath = 'Week2_Song4Cutscene', midPos = 11,
    hasEndVid = true, endVidPath = 'Week2_TrueEnd'
}

local instructShit = 
{
    hasMech = true,
    isBoss = true,
    graphName = "yaku",
	frame = 0,
    diff = "Villainous"
}

local tipShit = 
{
	numOfTips = 1,
    title1 = "<G>DOUBLE<G> ATTACK",
    tip1 = "Watch out for Yaku's Double Attack!\nIt can hurt badly!\nAs soon as the 3rd beat commences in his attack sequence, press DODGE!",
	tipIcon1 = "yakuRings"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if isStoryMode and not seenCutscene then -- To Apply only to story mode!
        addCharacterToList('beatricephase2', 'dad')
		triggerEvent('Change Character', 'dad', 'beatricephase2')
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end

    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1})
	end
end

function onEndDialogue()
	if isStoryMode then
		triggerEvent('Change Character', 'dad', 'Yaku')
	end
end

function onNextDialogue(line)
	if line == cutShit.midPos then
		triggerEvent('Change Character', 'dad', 'Yaku')
	end
end