local camVariables = {
	camOffsets = "900, 580, 400, 630",
	ofs = 35,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	setProperty('gf.visible', false)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onUpdate()
	if curBeat == 80 then
		setGlobalFromScript("scripts/Camera Movement", 'allowAngleShift', false)
	end
end