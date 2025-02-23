local camVariables = {
	camOffsets = "1130, 510, 1130, 510, 1000, 490",
	ofs = 13,
	noMove = "750, 350",
	camZooms = "1, 1.5, 1.5"
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onBeatHit()
	if curBeat == 144 then
		setGlobalFromScript("scripts/Camera Movement", 'allowZoomShifts', true)
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "600, 300"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"camOffsets", "35"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"camZooms", "1, 1.3, 1.5"})
	end
	if curBeat == 440 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"camZooms", "1, 2, 1.5"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"camOffsets", "20"})
	end
	if curBeat == 504 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"camZooms", "1, 1.3, 1.5"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"camOffsets", "35"})
	end
	if curBeat == 984 then
		setGlobalFromScript("scripts/Camera Movement", 'allowZoomShifts', false)
		setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
		setProperty('defaultCamZoom', 0.8)
	end
end