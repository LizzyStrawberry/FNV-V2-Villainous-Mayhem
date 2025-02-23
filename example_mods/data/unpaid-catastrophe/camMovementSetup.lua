local camVariables = {
	camOffsets = "960, 510, 400, 330, 0, 0",
	ofs = 35,
	noMove = "700, 350",
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onUpdate()
	if curBeat == 72 then
		setGlobalFromScript("scripts/Camera Movement", 'flipEnemyMovement', true)
	end
end