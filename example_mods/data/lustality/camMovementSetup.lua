local camVariables = {
	camOffsets = "1020, 600, 360, 580",
	ofs = 35,
	noMove = nil,
	camZooms = nil
}

function onCreate()
	setProperty('gf.visible', false)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
end

function onBeatHit()
	if curBeat == 560 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "570, 620"})
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "570, 620"})
		
		cameraFlash('game', 'ffffff', 0.4 / playbackRate, false)
		setProperty('boyfriend.alpha', 0)
		removeLuaSprite('BGP1', true)
		removeLuaSprite('CBack', true)
		removeLuaSprite('CFront', true)
		addLuaSprite('BGP2', false)
	end
end