local notePos = {}

function onCreatePost()
	setProperty('gf.visible', false)
	setProperty('dad.x', getProperty('boyfriend.x') - 200)
	for i = 0,7 do 
		x = getPropertyFromGroup('strumLineNotes', i, 'x')
		table.insert(notePos, x)
	end
end

function onUpdatePost()
	if curBeat == 0 then
		doTweenZoom('camGame', 'camGame', 0.7, 121, 'linear')
	end
	for i = 0, 3 do
		setPropertyFromGroup('opponentStrums',i,'alpha',0)
	end
	for i = 5, 7 do
		setPropertyFromGroup('strumLineNotes', i, 'x', notePos[i] - 200)
	end
		setPropertyFromGroup('strumLineNotes', 4, 'x', notePos[4] - 10)
end

function onGameOver()
	setProperty('camGame.zoom', 0.7)
	return Function_Continue
end