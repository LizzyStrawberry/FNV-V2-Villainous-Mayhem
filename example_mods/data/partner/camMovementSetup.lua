local camVariables = {
	camOffsets = "1060, 510, 80, 300, 0, 0",
	ofs = 35,
	noMove = "700, 350",
	camZooms = "1.1, 1.1, 0.9"
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'allowZoomShifts', true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onBeatHit()
	if curBeat == 176 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "260, 180"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"camZooms", "0.6, 1.1, 0.9"})
	end
	if curBeat == 384 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "80, 330"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "80, 330"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"camOffsets", "55"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"camZooms", "0.6, 0.6, 0.9"})
	end
	if curBeat == 512 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "260, 180"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1060, 510"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"camOffsets", "35"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"camZooms", "0.6, 1.1, 0.9"})
	end
end