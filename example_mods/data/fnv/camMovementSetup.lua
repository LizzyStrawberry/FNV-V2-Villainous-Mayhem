local camVariables = {
	camOffsets = "1020, 320, 420, 250",
	ofs = 35,
	noMove = "700, 300",
	camZooms = nil
}

function onCreate()
	setProperty('gf.visible', false)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end