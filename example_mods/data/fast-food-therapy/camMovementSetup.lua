local camVariables = {
	camOffsets = "660, 220, 1060, 200, 0, 0",
	ofs = 35,
	noMove = "700, 350",
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end