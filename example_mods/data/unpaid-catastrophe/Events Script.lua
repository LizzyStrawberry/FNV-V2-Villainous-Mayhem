function onCreate()
	makeLuaSprite('blackBG', '', -300, -300)
	makeGraphic('blackBG', 2000, 2000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	setProperty('blackBG.alpha', 0)
	addLuaSprite('blackBG', true)
	
	setProperty('gf.y', getProperty('gf.y') - 100)
	addCharacterToList('aizeenPhase2', 'dad')
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
	if curStep >= 288 and not isMayhemMode and getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
		if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
			setProperty('health', health- 0.006);
		else
			setProperty('health', health- 0.012);
		end
	end
	
	if (curBeat >= 192 and curBeat <= 199) or (curBeat >= 280 and curBeat <= 311) or (curBeat >= 452 and curBeat <= 456) or (curBeat >= 468 and curBeat <= 472) then
		triggerEvent('Add Camera Zoom', '0.02', '0.025')
	end
end

function onUpdate()
	if curBeat == 64 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.7 / playbackRate, 'circOut')
		doTweenAlpha('hudAppear', 'camHUD', 0, 0.8 / playbackRate, 'cubeInOut')
	end
	if curBeat == 67 then
		triggerEvent('Change Character', 'dad', 'aizeenPhase2')
	end
	if curStep == 280 then
		doTweenAlpha('hud', 'camHUD', 1, 0.9 / playbackRate, 'linear')
	end
	if curStep == 288 then
		setProperty('blackBG.alpha', 0)
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		setProperty('defaultCamZoom', 1.4 * zoomMult)
	end
	if curStep == 408 then
		setProperty('defaultCamZoom', 1.2 * zoomMult)
	end
	if curBeat == 96 then
		setProperty('defaultCamZoom', 0.8 * zoomMult)
	end
	if curStep == 408 then
		setProperty('defaultCamZoom', 1.2 * zoomMult)
	end
	if curStep == 410 then
		setProperty('defaultCamZoom', 1.4 * zoomMult)
	end
	if curStep == 412 then
		setProperty('defaultCamZoom', 1.6 * zoomMult)
	end
	if curStep == 414 then
		setProperty('defaultCamZoom', 1.8 * zoomMult)
	end
	if curStep == 416 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		setProperty('defaultCamZoom', 0.8 * zoomMult)
	end
	if curBeat == 248 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
	end
	if curBeat == 312 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
	end
	if curBeat == 376 then
		setProperty('defaultCamZoom', 1.4 * zoomMult)
	end
	if curBeat == 392 then
		setProperty('defaultCamZoom', 1.4 * zoomMult)
	end
	if curBeat == 400 then
		setProperty('defaultCamZoom', 0.8 * zoomMult)
	end
	if curBeat == 408 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
	end
	if curStep == 2000 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		cameraFade('game', '000000', 0.8 / playbackRate, false)
	end
end

function onBeatHit()
	if (curStep >= 416 and curBeat <= 200) or (curBeat >= 208 and curBeat <= 247) or (curBeat >= 440 and curBeat <= 372) then
		if curBeat % 4 == 0 then
			triggerEvent('Add Camera Zoom', '0.03', '0.035')
		end
		if curBeat % 4 == 1 then
			runTimer('woop', 0.01)
		end
		if curBeat % 4 == 2 then
			triggerEvent('Add Camera Zoom', '0.03', '0.035')
		end
		if curBeat % 4 == 3 then
			runTimer('woop', 0.01)
		end
	end
	if (curBeat >= 312 and curBeat <= 407) then
		if curBeat % 4 == 0 then
			triggerEvent('Add Camera Zoom', '0.07', '0.055')
		end
		if curBeat % 4 == 1 then
			runTimer('woop2', 0.01)
		end
		if curBeat % 4 == 2 then
			triggerEvent('Add Camera Zoom', '0.07', '0.055')
		end
		if curBeat % 4 == 3 then
			runTimer('woop2', 0.01)
		end
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
	if tag == 'woop2' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 35)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 35, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 30)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 30, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 30)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 30, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 35)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 35, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 35)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 35, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 30)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 30, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 30)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 30, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 35)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 35, 0.6 / playbackRate, 'sineOut')
	end
end