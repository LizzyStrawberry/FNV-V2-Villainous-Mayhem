function onCreate()
	setProperty('gf.visible', false)
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and difficulty == 1 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getProperty('health') > 0.2 then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.0075);
				else
					setProperty('health', health- 0.015);
				end
			end
		end
end

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
	if curBeat == 30 then
		for i = 4, 7 do
			noteTweenAlpha('noteAlpha'..i, i, 1, 0.6, 'cubeInOut')
		end
	end
	if curBeat == 46 then
		for i = 0, 3 do
			noteTweenAlpha('noteAlpha'..i, i, 1, 0.6, 'cubeInOut')
		end
	end
	if curBeat == 64 then
		cameraFlash('game', 'FFFFFF', 0.5, false)
		if difficulty == 0 then
			triggerEvent('Change Scroll Speed', '1.2', '0.4')
		elseif difficulty == 1 then
			triggerEvent('Change Scroll Speed', '1.1', '0.4')
		end
	end
	if curBeat == 224 then
		setProperty('defaultCamZoom', 1.3)
		if difficulty == 0 then
			triggerEvent('Change Scroll Speed', '0.9', '0.4')
		elseif difficulty == 1 then
			triggerEvent('Change Scroll Speed', '0.8', '0.4')
		end
	end
	if curStep == 1153 then
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'FFFFFF', 0.5, false)
	end
end

function onBeatHit()
	if curBeat % 4 == 1 and curBeat >= 64 and curBeat <= 224 then
		runTimer('woop', 0.01)
	end
	if curBeat % 4 == 3 and curBeat >= 64 and curBeat <= 224 then
		runTimer('woop', 0.01)
	end
	if curBeat % 2 == 0 and curBeat >= 64 and curBeat <= 224 then
		triggerEvent('Add Camera Zoom', '0.045', '0.045')
	end
end

function onTimerCompleted(tag)
	if tag == 'woop' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 30)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 30, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 25)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 25, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 25)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 25, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 30)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 30, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 30)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 30, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 25)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 25, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 25)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 25, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 30)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 30, 0.6, 'sineOut')
	end
end