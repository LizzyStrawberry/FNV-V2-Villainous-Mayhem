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
    graphName = "Yaku",
    diff = "Villainous"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if isStoryMode and not seenCutscene then -- To Apply only to story mode!
        addCharacterToList('beatricephase2', 'dad')
		triggerEvent('Change Character', 'dad', 'beatricephase2')
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end

    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.diff})
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