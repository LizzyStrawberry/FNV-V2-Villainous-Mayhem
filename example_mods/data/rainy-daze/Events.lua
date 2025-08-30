function onCreatePost()
	setProperty('gf.visible', false)
end

function onUpdatePost()
	if curBeat == 0 then
		doTweenZoom('camGame', 'camGame', 0.9 * zoomMult, 121 * zoomMult, 'linear')
	end
	for i = 0, 3 do
		setPropertyFromGroup('opponentStrums',i,'alpha',0)
	end
end

function onGameOver()
	setProperty('camGame.zoom', 0.7 * zoomMult)
	return Function_Continue
end