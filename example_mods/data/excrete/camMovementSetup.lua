local camVariables = {
	camOffsets = "980, 700, 540, 330, 330, 650",
	ofs = 35,
	noMove = nil,
	camZooms = "0.9, 1.1, 1.4"
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", "allowZoomShifts", true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onCreatePost()
	setProperty("iconGF.alpha", 0)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	-- Icon Change when the camera is on the player
	if gfSection or noteType == "GF Sing" then
		triggerEvent('Change Icon', 'P2, AmogleenExcrete, a3bb89')	
	else
		triggerEvent('Change Icon', 'P2, marcussyExcrete, 393939')
	end
	
	if noteType == '' and not (gfSection or noteType == "GF Sing") then
		triggerEvent('Screen Shake', '0.4, 0.003', '0.4, 0.003')
	end
end