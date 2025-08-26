local camVariables = {
	camOffsets = "950, 410, 360, 230",
	ofs = 35,
	noMove = "600, 350",
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onSongStart()
	setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
end

function onBeatHit()
	if curBeat == 0 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
	end
	
	if curBeat == 64 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', true)
	end
	
	if curBeat == 480 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
	end
end