local camVariables = {
	camOffsets = "920, 510, 530, 430, 0, 0",
	ofs = 35,
	noMove = "700, 500",
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
end