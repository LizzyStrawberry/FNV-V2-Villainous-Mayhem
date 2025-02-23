local camVariables = {
	camOffsets = "980, 510, 560, 330, 0, 0",
	ofs = 35,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	setProperty('gf.visible', false)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end