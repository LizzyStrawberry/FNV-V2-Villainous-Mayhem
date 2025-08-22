local cutShit = 
{
    hasDial = false,
    hasStartVid = true, vidPath = 'Week3_Song3Cutscene',
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = true, endVidPath = 'Week3_NormalEnd'
}

local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "Kiana",
	frame = 1,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 3,
    title1 = "LUST NOTES - BAR",
    tip1 = "Beware of Kiana's lust notes! Pressing them will increase the Lust Bar bit by bit, and stun you for a few seconds!",
	tipIcon1 = "lustNote",
	title2 = "ATTACK",
    tip2 = "Looks like you finally learned how to attack back!\nOnce the cooldown is over, touch <B>ATTACK<B> to attack Kiana!\n<G>Remember your keybinds!<G>",
	tipIcon2 = "attackButton",
	title3 = "TAIL LUNGE",
    tip3 = "Dropping on all 4's, Kiana won't hesitate to hit you with her tail! Touch <PUR>DODGE<PUR> to avoid the attack!\n<G>Remember your keybinds!<G>",
	tipIcon3 = "lustTimer"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if difficulty >= 1 then
        cutShit.endVidPath = 'Week3_Song4Cutscene'
    end

    if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end

    if mechanics then -- To only apply this if mechanics are enabled!
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1, tipShit.title2, tipShit.tip2, tipShit.tipIcon2, tipShit.title3, tipShit.tip3, tipShit.tipIcon3})
		setGlobalFromScript("scripts/"..name, "backdropColor", "ff7af2")
	end
end