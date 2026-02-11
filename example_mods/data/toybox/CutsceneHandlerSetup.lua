local cutShit = 
{
    hasDial = false,
    hasStartVid = true, vidPath = "Week3_Song2Cutscene",
    hasMidDialVid = false, midVidPath = nil, midPos = -1,
    hasEndVid = false, endVidPath = nil
}

local instructShit = 
{
    hasMech = true,
    isBoss = false,
    graphName = "narrin",
	frame = 0,
    diff = "Casual"
}

local tipShit = 
{
	numOfTips = 3,
    title1 = "SHOOT",
    tip1 = "Your health isn't gonna regenerate normally, but deplete periodically instead!\nShoot Narrin with the bullet notes to regain your health!\nMissing won't cause any penalties, but keep your eyes open!",
	tipIcon1 = "gun",
	title2 = "DODGE",
    tip2 = "Narrin will send her dolls after you, so make sure you touch your <PUR>DODGE<PUR> Hitbox before the doll hits you, jamming your gun in the process!\nRemember, dodging has a cooldown!",
	tipIcon2 = "dodgePico",
	title3 = "UNJAM",
    tip3 = "Getting hit will jam your gun!\nMake sure you touch <B>ATTACK<B> a few times to unjam the gun!\nUnjamming also has a bit of a cooldown, don't spam!",
	tipIcon3 = "jammed"
}

local name = "Cutscene and Instructions Handler"

function onCreate()
    if isStoryMode then -- To Apply only to story mode!
        callScript("scripts/"..name, "setCutsceneData", {cutShit.hasDial, cutShit.hasStartVid, cutShit.vidPath, cutShit.hasMidDialVid, cutShit.midVidPath, cutShit.midPos, cutShit.hasEndVid, cutShit.endVidPath})
    end

    if mechanics then -- To only apply this if mechanics are enabled!
        if isMayhemMode then
			tipShit.tip1 = "Shoot Narrin to earn health back!\nYou won't regenerate via note presses, so beware of your health!" 
		end
        callScript("scripts/"..name, "setInstructionsData", {instructShit.hasMech, instructShit.isBoss, instructShit.graphName, instructShit.frame, instructShit.diff})
		callScript("scripts/"..name, "setTipData", {tipShit.numOfTips, tipShit.title1, tipShit.tip1, tipShit.tipIcon1, tipShit.title2, tipShit.tip2, tipShit.tipIcon2, tipShit.title3, tipShit.tip3, tipShit.tipIcon3})
    end
end