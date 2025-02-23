local camVariables = {
	camOffsets = "1020, 600, 360, 580, 0, 0",
	ofs = 35,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	setProperty('gf.visible', false)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onStepHit()
	if curStep == 376 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "360, 580"})
	end
	
	if curBeat == 100 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1020, 600"})
	end
	if curBeat == 308 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "270, 560"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "270, 560"})
	end
end