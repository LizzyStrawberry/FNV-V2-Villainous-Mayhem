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
	if curBeat == 8 then
		for i = 0, 3 do
			noteTweenAlpha('noteAlpha'..i, i, 1, 0.9 / playbackRate, 'circOut')
		end
	end
	if curBeat == 12 then
		for i = 4, 7 do
			noteTweenAlpha('noteAlpha'..i, i, 1, 0.9 / playbackRate, 'circOut')
		end
	end
	if curBeat == 16 then
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
	end
	if curBeat == 112 then
		triggerEvent('Change Scroll Speed', '0.8', '0.4')
	end
	if curBeat == 143 then
		triggerEvent('Change Scroll Speed', '1', '0.4')
	end
	if curBeat == 144 then
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
		triggerEvent('Toggle Trail', '1', '1')
	end
	if curStep == 832 then
		setProperty('defaultCamZoom', 1.2 * zoomMult)
	end
	if curStep == 835 then
		setProperty('defaultCamZoom', 1.4 * zoomMult)
	end
	if curStep == 838 then
		setProperty('defaultCamZoom', 0.9 * zoomMult)
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
	end
	if curBeat == 212 then
		triggerEvent('Toggle Trail', '0', '0')
	end
end

function onStepHit()
	if curStep == 218 or curStep == 219 or curStep == 221 or curStep == 223 then
		triggerEvent('Add Camera Zoom', '0.040', '0.050')
	end
	if curStep == 282 or curStep == 283 or curStep == 285 or curStep == 287 then
		triggerEvent('Add Camera Zoom', '0.040', '0.050')
	end
end

function onBeatHit()
	if curBeat % 4 == 1 and curBeat >= 19 then
		runTimer('woop', 0.08)
	end
	if curBeat % 4 == 3 and curBeat >= 19 then
		runTimer('woop', 0.08)
	end
	if curBeat % 4 == 2 and curBeat >= 32 then
		triggerEvent('Add Camera Zoom', '0', '0.035')
	end
end

function onTimerCompleted(tag)
	if tag == 'woop' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 15)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 15, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 10)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 10, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 10)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 10, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 15)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 15, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 15)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 15, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 10)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 10, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 10)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 10, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 15)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 15, 0.6 / playbackRate, 'sineOut')
	end
end