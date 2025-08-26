local camVariables = {
	camOffsets = "860, 360, 560, 330",
	ofs = 35,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end