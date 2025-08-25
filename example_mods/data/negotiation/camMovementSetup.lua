local camVariables = {
	camOffsets = "800, 450, 370, 200, 500, 250",
	ofs = 35,
	noMove = "700, 350",
	camZooms = "1.0, 0.7, 0.9"
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'allowZoomShifts', true)
	setGlobalFromScript("scripts/Camera Movement", 'flipPlayerMovement', true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end