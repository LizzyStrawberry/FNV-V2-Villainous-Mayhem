local camVariables = {
	camOffsets = "200, 380, 200, 380, 0, 0",
	ofs = 15,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
	setGlobalFromScript("scripts/Camera Movement", "allowGF", false)
end

function onStepHit()
	if curStep == 1024 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "200, 385"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "200, 385"})
	end
end