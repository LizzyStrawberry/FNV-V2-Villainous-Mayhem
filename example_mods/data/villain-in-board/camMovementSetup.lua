local camVariables = {
	camOffsets = "980, 610, 560, 530",
	ofs = 35,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'flipOppMovement', true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end