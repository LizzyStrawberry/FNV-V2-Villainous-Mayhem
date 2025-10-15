local camVariables = {
	camOffsets = "950, 510, 530, 430",
	ofs = 35,
	noMove = "700, 500",
	camZooms = nil
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'flipOppMovement', true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end