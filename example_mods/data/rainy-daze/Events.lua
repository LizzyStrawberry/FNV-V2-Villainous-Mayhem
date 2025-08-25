function onCreatePost()
	setProperty('gf.visible', false)
end

function onUpdatePost()
	if curBeat == 0 then
		doTweenZoom('camGame', 'camGame', 0.9, 121, 'linear')
	end
	for i = 0, 3 do
		setPropertyFromGroup('opponentStrums',i,'alpha',0)
	end
end

function onGameOver()
	setProperty('camGame.zoom', 0.7)
	return Function_Continue
end