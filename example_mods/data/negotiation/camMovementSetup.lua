local camVariables = {
	camOffsets = "900, 650, 300, 400, 0, 0",
	ofs = 35,
	noMove = "700, 350",
	camZooms = "0.9, 0.55, 0.9"
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'allowZoomShifts', true)
	setGlobalFromScript("scripts/Camera Movement", 'flipPlayerMovement', true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end