local camVariables = {
	camOffsets = "1020, 320, 360, 200, 0, 0",
	ofs = 35,
	noMove = "700, 300",
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
	if boyfriendName == 'amongGF' then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1020, 420"})
	end
end

function onBeatHit()
	if curBeat == 96 or curBeat == 256 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "700, 300"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "700, 300"})
	end
	if curBeat == 128 or curBeat == 288 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "360, 200"})
		if boyfriendName == 'amongGF' then
			callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1020, 420"})
		end
	end
end