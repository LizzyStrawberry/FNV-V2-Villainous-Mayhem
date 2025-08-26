local camVariables = {
	camOffsets = "800, 450, 350, 200, 500, 250",
	ofs = 35,
	noMove = "700, 350",
	camZooms = "0.9, 0.65, 0.9"
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'allowZoomShifts', true)
	setGlobalFromScript("scripts/Camera Movement", 'flipPlayerMovement', true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onCreatePost()
	setProperty("iconGF.visible", false)
end