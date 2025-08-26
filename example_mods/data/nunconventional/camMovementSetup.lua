local camVariables = {
	camOffsets = "1020, 320, 360, 200",
	ofs = 35,
	noMove = "700, 300",
	camZooms = nil
}

function onCreate()
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
	if boyfriendName == 'amongGF' then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "1020, 420"})
	end
end

function onBeatHit()
	if curBeat == 207 then
		setGlobalFromScript("scripts/Camera Movement", 'allowAngleShift', false)
	end
	if curBeat == 272 then
		setGlobalFromScript("scripts/Camera Movement", 'allowAngleShift', true)
	end
	if curBeat == 352 then
		doTweenZoom('camGameZoom', 'camGame', 0.7, 10 / playbackRate, 'linear')
		setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
	end
end