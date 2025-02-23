local camVariables = {
	camOffsets = "900, 440, 560, 330, 0, 0",
	ofs = 35,
	noMove = "700, 350",
	camZooms = nil
}

function onCreate()
	setProperty('gf.visible', false)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onUpdate()
	if curBeat == 67 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "560, 390"})
	end
	if curBeat == 76 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "560, 330"})
	end
	if curBeat == 136 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "470, 300"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "950, 400"})
	end
	if curBeat == 200 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "560, 330"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "950, 440"})
	end
	if curStep == 1776 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
	end
end