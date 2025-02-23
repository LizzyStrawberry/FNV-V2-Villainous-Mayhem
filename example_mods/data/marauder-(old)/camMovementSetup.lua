local camVariables = {
	camOffsets = "700, 400, 700, 400, 0, 0",
	ofs = 35,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onBeatHit()
	if curBeat == 32 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "700, 480"})
	end
	if curBeat == 136 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "460, 430"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "950, 480"})
	end
end