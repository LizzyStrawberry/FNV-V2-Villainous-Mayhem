local camVariables = {
	camOffsets = "800, 960, 385, 410",
	ofs = 35,
	noMove = "430, 550",
	camZooms = "0.4, 0.7"
}

function onCreate()
	setProperty('gf.visible', false)
	
	if not performanceWarn then
		setGlobalFromScript("scripts/Camera Movement", 'allowZoomShifts', true)
		callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
	end
end

function onUpdate()
	if not performanceWarn then
		if curBeat == 96 then
			callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "620, 900"})
			setGlobalFromScript("scripts/Camera Movement", 'followChars', true)
		end
		if curBeat == 92 or curBeat == 272 or curBeat == 448 or curStep == 3016 then
			setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
			setProperty("defaultCamZoom", 0.4)
		end
		if curBeat == 287 or curBeat == 465 then
			setGlobalFromScript("scripts/Camera Movement", 'followChars', true)
		end
	end
end