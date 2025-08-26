local camVariables = {
	camOffsets = "1100, 450, 300, 550",
	ofs = 35,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	setProperty('gf.visible', false)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onBeatHit()
	if curBeat == 96 then --Front Facing Narrin
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "300, 550"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "300, 550"})
	end
	if curBeat == 136 then --Narrin and Pico
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "500, 450"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1020, 450"})
	end
end