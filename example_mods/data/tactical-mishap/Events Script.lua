function onCreate()
	addCharacterToList('TCAlt', 'boyfriend')
	makeLuaSprite('blackBG', '', -300, -300)
	makeGraphic('blackBG', 2000, 2000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	setProperty('blackBG.alpha', 0)
	addLuaSprite('blackBG', true)
	
	addCharacterToList('marcophase2', 'dad')
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
	if not isMayhemMode and difficulty == 1 and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
		if getProperty('health') > 0.2 and mechanics then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.007);
			else
				setProperty('health', health- 0.014);
			end
		end
	end
end

function onUpdate()
	if curBeat == 64 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.7 / playbackRate, 'circOut')
		doTweenAlpha('hudAppear', 'camHUD', 0, 0.8 / playbackRate, 'cubeInOut')
	end
	if curBeat == 66 then
		triggerEvent('Change Character', 'dad', 'marcophase2')
		setProperty('defaultCamZoom', 1.5)
	end
	if curStep == 272 then
		doTweenAlpha('blackBg', 'blackBG', 0.7, 0.3 / playbackRate, 'cubeInOut')
		triggerEvent('Play Animation', 'laugh', 'dad')
	end
	if curStep == 280 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.3 / playbackRate, 'cubeInOut')
		doTweenAlpha('hud', 'camHUD', 1, 0.9 / playbackRate, 'linear')
	end
	if curStep == 288 then
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		
		setProperty('blackBG.alpha', 0)
	end
	if curStep == 544 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.3 / playbackRate, 'circOut')
		setProperty('defaultCamZoom', 1.5)
	end
	if curStep == 552 then
		doTweenAlpha('blackBg', 'blackBG', 0.6, 0.9 / playbackRate, 'cubeInOut')
	end
	if curStep == 800 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		setProperty('defaultCamZoom', 0.9)
		setProperty('blackBG.alpha', 0)
	end

	if curStep == 1296 then
		triggerEvent('Play Animation', 'bitch', 'dad')
		setProperty('defaultCamZoom', 1.5)
	end

	if curStep == 1311 then
		triggerEvent('Change Character', 'bf', 'TCAlt')
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		noteTweenX('NoteMove5', 4, 400, 0.25 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove6', 5, 520, 0.25 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove7', 6, 640, 0.25 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove8', 7, 760, 0.25 / playbackRate, 'cubeInOut')
		for i = 0, 3 do
			noteTweenAlpha('dadnotes'..i, i, 0, 0.25 / playbackRate, 'cubeInOut')
		end

		triggerEvent('Toggle Trail', '0', '1')
	end
	
	if curBeat == 359 then
		triggerEvent('Toggle Trail', '0', '0')
	end

	if curStep == 1440 then
		triggerEvent('Silhouette', 'a', '6')
	end

	if curStep == 1536 then
		triggerEvent('Screen Shake', '1.5, 0.01', '1.5, 0.01')
	end

	if curStep == 1556 then
		noteTweenAlpha('NoteAlpha8', 7, 0, 0.75 / playbackRate, 'circOut')
	end
	if curStep == 1560 then
		noteTweenAlpha('NoteAlpha5', 4, 0, 0.75 / playbackRate, 'circOut')
	end
	if curStep == 1564 then
		noteTweenAlpha('NoteAlpha6', 5, 0, 0.75 / playbackRate, 'circOut')
	end
	
	if curStep == 1568 then
		triggerEvent('Silhouette', 'b', '0.5')
		cameraFlash('game', 'FFFFFF', 0.5, false)
		noteTweenAlpha('NoteAlpha8', 6, 0, 2.75 / playbackRate, 'circOut')
		noteTweenY('NoteMoveFinal', 6, getPropertyFromGroup('strumLineNotes', 6, 'y') - 30, 2.25 / playbackRate, 'circOut')
	end
	
end

function noteMiss(id, direction, noteType, isSustainNote) --Kinn's request lmao
	if curBeat >= 328 and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
		setProperty('health', 0)
	end
end

function onBeatHit()
	if curStep >= 800 and curStep < 992 then
		if curBeat % 8 == 0 and curBeat >= 76 then
			triggerEvent('Add Camera Zoom', '0.015', '0.020')
		end
		if curBeat % 8 == 2 then
			runTimer('woop2', 0.01)
		end
		if curBeat % 8 == 4 and curBeat >= 76 then
			triggerEvent('Add Camera Zoom', '0.015', '0.020')
		end
		if curBeat % 8 == 6 then
			runTimer('woop2', 0.01)
		end
	end
	if curStep >= 992 and curStep <= 1311 then
		if curBeat % 8 == 0 and curBeat >= 76 then
			triggerEvent('Add Camera Zoom', '0.021', '0.025')
		end
		if curBeat % 8 == 4 and curBeat >= 76 then
			triggerEvent('Add Camera Zoom', '0.021', '0.025')
		end
	end
	if (curStep >= 288 and curStep <= 544) or (curStep >= 1312 and curStep <= 1568) then
		if curBeat % 4 == 0 then
			triggerEvent('Add Camera Zoom', '0.027', '0.035')
		end
		if curBeat % 4 == 1 then
			runTimer('woop2', 0.01)
		end
		if curBeat % 4 == 2 then
			triggerEvent('Add Camera Zoom', '0.027', '0.035')
		end
		if curBeat % 4 == 3 then
			runTimer('woop2', 0.01)
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'woop' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 15)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 10)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 10)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 15)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 15)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 10)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 10)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 15)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 15, 0.6, 'sineOut')
	end	
	if tag == 'woop2' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 25)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 25, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 20)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 20, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 20)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 20, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 25)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 25, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 25)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 25, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 20)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 20, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 20)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 20, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 25)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 25, 0.6, 'sineOut')
	end
end