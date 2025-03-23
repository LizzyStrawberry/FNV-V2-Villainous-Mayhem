local camVariables = {
	camOffsets = "450, 450, 1050, 460, 1000, 360",
	ofs = 35,
	noMove = "750, 450",
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onSongStart()
	setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
end

function onBeatHit()
	if curBeat == 32 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', true)
	end
	if curBeat == 299 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
	end
	if curBeat == 302 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', true)
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "1000, 360"})
	end
	if curBeat == 308 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "1000, 460"})
	end
end