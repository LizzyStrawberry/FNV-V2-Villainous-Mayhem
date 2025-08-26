local camVariables = {
	camOffsets = "1020, 520, 1020, 520",
	ofs = 15,
	noMove = "700, 300",
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end