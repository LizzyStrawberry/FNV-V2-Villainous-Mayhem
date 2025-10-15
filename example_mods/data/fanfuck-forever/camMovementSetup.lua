local camVariables = {
	camOffsets = "860, 360, 400, 400, 660, 350",
	ofs = 35,
	noMove = "600, 350",
	camZooms = "1.0, 0.9, 1.4"
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", "allowZoomShifts", true)
	setGlobalFromScript("scripts/Camera Movement", "gfSide", "player")
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onCreatePost()
	setProperty("iconGF.alpha", 0)
	setObjectOrder("iconGF", getObjectOrder("iconP1") + 1)
end

function onSongStart()
	setGlobalFromScript("scripts/Camera Movement", "followChars", false)
end

function onBeatHit()
	if curBeat == 36 then
		setGlobalFromScript("scripts/Camera Movement", "followChars", true)
	end
	if curBeat == 132 then
		setGlobalFromScript("scripts/Camera Movement", "followChars", false)
	end
	if curBeat == 135 then
		setGlobalFromScript("scripts/Camera Movement", "followChars", true)
	end
	if curBeat == 262 then
		setGlobalFromScript("scripts/Camera Movement", "followChars", false)
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'FFFFFF', 0.5, false)
	end
end

function goodNoteHit(id, dir, n, sus)
	setGlobalFromScript("scripts/Camera Movement", 'flipPlayerMovement', (n == "GF Sing" or gfSection))
end