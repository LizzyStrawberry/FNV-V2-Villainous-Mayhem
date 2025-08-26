local camVariables = {
	camOffsets = "950, 510, 560, 330",
	ofs = 35,
	noMove = "700, 350",
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onUpdate()
	if curBeat == 67 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "560, 390"})
	end
	if curBeat == 76 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "560, 330"})
	end
	if curStep == 704 or curStep == 1472 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', true)
	end
	if curStep == 700 or curStep == 1464 or curStep == 2320 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
	end
end