function onUpdate()
	if curStep == 0 then
		setPropertyFromGroup('opponentStrums',0,'alpha',0)
		setPropertyFromGroup('opponentStrums',1,'alpha',0)
		setPropertyFromGroup('opponentStrums',2,'alpha',0)
		setPropertyFromGroup('opponentStrums',3,'alpha',0)
		setPropertyFromGroup('playerStrums',0,'alpha',0)
		setPropertyFromGroup('playerStrums',1,'alpha',0)
		setPropertyFromGroup('playerStrums',2,'alpha',0)
		setPropertyFromGroup('playerStrums',3,'alpha',0)
	end
	if curStep == 13 then
		noteTweenAlpha('noteAlpha0', 0, 1, 0.6, 'cubeInOut')
	end
	if curStep == 25 then
		noteTweenAlpha('noteAlpha2', 2, 1, 0.3, 'cubeInOut')
		noteTweenAlpha('noteAlpha1', 1, 1, 0.3, 'cubeInOut')
	end
	if curStep == 29 then
		noteTweenAlpha('noteAlpha3', 3, 1, 0.6, 'cubeInOut')
	end
	if curStep == 45 then
		noteTweenAlpha('noteAlpha4', 4, 1, 0.6, 'cubeInOut')
	end
	if curStep == 57 then
		noteTweenAlpha('noteAlpha6', 6, 1, 0.3, 'cubeInOut')
		noteTweenAlpha('noteAlpha5', 5, 1, 0.3, 'cubeInOut')
	end
	if curStep == 61 then
		noteTweenAlpha('noteAlpha7', 7, 1, 0.6, 'cubeInOut')
	end
	if curStep == 77 then
		cameraFlash('game', 'FFFFFF', 0.5, false)
	end
end

function onBeatHit()
	if curBeat % 4 == 1 and curBeat >= 19 then
		runTimer('woop', 0.08)
	end
	if curBeat % 4 == 3 and curBeat >= 19 then
		runTimer('woop', 0.08)
	end
	if curBeat % 4 == 2 and curBeat >= 35 then
		triggerEvent('Add Camera Zoom', '0', '0.025')
	end
end

function onTimerCompleted(tag)
	if tag == 'woop' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 10)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 5)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 5, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 5)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 5, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 10)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 10)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 5)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 5, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 5)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 5, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 10)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 10, 0.6, 'sineOut')
	end
end