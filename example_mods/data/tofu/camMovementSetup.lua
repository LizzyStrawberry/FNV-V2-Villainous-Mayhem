local camVariables = {
	camOffsets = "860, 360, 560, 330",
	ofs = 35,
	noMove = nil,
	camZooms = "0.96, 1.25, 0"
}

function onCreate()
    setGlobalFromScript("scripts/Camera Movement", "allowZoomShifts", true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end