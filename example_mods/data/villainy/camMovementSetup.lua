local camVariables = {
	camOffsets = "950, 510, 760, 430",
	ofs = 35,
	noMove = "700, 350",
	camZooms = nil
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'flipOppMovement', true)
	setGlobalFromScript("scripts/Camera Movement", "specialAnims", {"chuckletits"})
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onUpdate()
	if curStep == 48 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "560, 330"})
	end
	
	if curStep == 927 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "560, 530"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "660, 500"})
	end
	
	if curStep == 944 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "560, 330"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "950, 510"})
	end
end