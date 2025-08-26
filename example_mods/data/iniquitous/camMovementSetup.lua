local camVariables = {
	camOffsets = "700, 500, 700, 500",
	ofs = 35,
	noMove = "300, 100",
	camZooms = nil
}

function onCreate()
	setProperty('gf.visible', false)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onBeatHit()		
	if curBeat == 336 or curBeat == 544 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "800, 100"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "400, 500"})
	end
	
	if curBeat == 464 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "800, 100"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "800, 100"})
	end
end