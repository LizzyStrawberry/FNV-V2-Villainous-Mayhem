local camVariables = {
	camOffsets = "1420, 410, 1820, 510, 0, 0",
	ofs = 35,
	noMove = "630, 350",
	camZooms = nil
}

function onCreate()
	setProperty('gf.visible', false)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onBeatHit()
	if curBeat == 196 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "550, 510"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1220, 410"})
	end
	if curBeat == 456 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "1820, 570"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1220, 310"})
	end
end