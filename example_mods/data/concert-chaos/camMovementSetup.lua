local camVariables = {
	camOffsets = "920, 400, 920, 400, 850, 850",
	ofs = 25,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'flipOppMovement', true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})

	callScript("scripts/Camera Movement", "addExtraCamera", {"M-Chan", 560, 320, "managerSoloNotes", nil, true})
	callScript("scripts/Camera Movement", "addExtraCamera", {"Aileen", 1030, 320, "aileenSoloNotes", nil, false})
end

function onBeatHit()	
	if curBeat == 36 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "980, 450"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "980, 450"})
	end
	if curBeat == 68 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1160, 430"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "1160, 430"})
	end
	if curBeat == 84 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "960, 380"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "960, 380"})
	end
end

function onStepHit()
	if curStep == 1360 or curStep == 2896 or curStep == 3408 or curStep == 3728 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "1030, 350"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "560, 350"})
	end
	
	if curStep == 1872 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "920, 400"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "920, 400"})
	end
	
	if curStep == 2408 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "800, 400"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "800, 400"})
	end
	
	if curStep == 2640 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1060, 370"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "760, 370"})
	end
	
	if curStep == 3152 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "875, 200"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "875, 200"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"gfCamera", "875, 200"})
	end
	
	if curStep == 3280 then
		setGlobalFromScript("scripts/Camera Movement", "focusOnGF", true)
	end
	if curStep == 3408 or curStep == 3728 then
		setGlobalFromScript("scripts/Camera Movement", "focusOnGF", false)
	end
	
	if curStep == 3664 or curStep == 3856 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "875, 280"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "875, 280"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"gfCamera", "875, 280"})
		setGlobalFromScript("scripts/Camera Movement", "focusOnGF", true)
	end
end

function opponentNoteHit(id, dir, n, sus)
	local flipCheck = (dadName =='marcoCCP1' or dadName == 'marcoCCP2' or dadName == 'marcoCCP3') and n == ""
	setGlobalFromScript("scripts/Camera Movement", 'flipOppMovement', flipCheck)
end