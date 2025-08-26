local manager = require("mods/scripts/ExtraCharModule")
local aileen = require("mods/scripts/ExtraCharModule")

function onCreatePost()
	-- Already hard positioned from before
	local aileenX, aileenY = 1100, 50
	local managerX, managerY = 380, 120

	manager.makeCharacter("M-Chan", "managerChanP2", "managerSoloNotes", true, true, {managerX, managerY}, "", false)
	setObjectOrder("M-Chan", getObjectOrder("boyfriendGroup") - 1)
	updateHitbox("M-Chan")
	setProperty("M-Chan.alpha", 0)

	aileen.makeCharacter("Aileen", "aileenCCP2", "aileenSoloNotes", false, false, {aileenX, aileenY}, "", false)
	updateHitbox("Aileen")
	setObjectOrder("Aileen", getObjectOrder("dadGroup") - 1)
	setProperty("Aileen.alpha", 0)

	setProperty("iconGF.alpha", 0)
	setObjectOrder("iconGF", getObjectOrder("iconP2") + 1)
	setProperty("iconM-Chan.alpha", 0)
	setProperty("iconAileen.alpha", 0)
end

function onUpdatePost(elapsed)
	if getHealth() >= 1.625 then
		if curBeat % 2 == 0 then
			setProperty("iconGF.animation.curAnim.curFrame", 0)
		end
	end
end

function onStepHit()
	-- On Phase 3
	if curStep == 1360 then
		setProperty("M-Chan.alpha", 1)
		setProperty("Aileen.alpha", 1)

		doTweenAlpha("showMChanIcon", "iconM-Chan", 1, 1.25 / playbackRate, "cubeInOut")
		doTweenAlpha("showAileenIcon", "iconAileen", 1, 1.25 / playbackRate, "cubeInOut")
	end
	
	-- Debug Phase
	if curStep == 1872 then
		for _, name in pairs({"M-Chan", "Aileen"}) do
			setProperty("icon"..name..".alpha", 0)
			setProperty(name..".alpha", 0)
		end
	end
	
	-- On Final Phase
	if curStep == 2896 then
		for _, name in pairs({"M-Chan", "Aileen"}) do
			setProperty("icon"..name..".alpha", 1)
			setProperty(name..".alpha", 1)
			setScrollFactor(name, 0.9, 0.9)
		end
	end
	if curStep == 3152 then
		doTweenAlpha("showDebugIcon", "iconGF", 1, 3 / playbackRate, "cubeInOut")
	end
end