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

function onUpdate()
	if curBeat == 36 or curBeat == 131 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
		setProperty('defaultCamZoom', 1.4)
	end
	if curStep == 161 or curStep == 544 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', true)
		setProperty('defaultCamZoom', 0.9)
	end
	if curBeat == 268 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "360, 80"})
	end
end