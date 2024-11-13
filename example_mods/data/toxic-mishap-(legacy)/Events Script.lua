local randomScrollSpeed = 0

function onCreate()
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
	if not isMayhemMode and difficulty == 1 then
		if getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.004);
			else
				setProperty('health', health- 0.008);
			end
		end
	end
	if not isMayhemMode and difficulty == 2 then
		if getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.014);
			else
				setProperty('health', health- 0.028);
			end
		end
	end
end

function onUpdate()
	if curBeat == 64 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.7, 'circOut')
		doTweenAlpha('hudAppear', 'camHUD', 0, 0.8, 'cubeInOut')
		for i = 0, 3 do
			noteTweenAlpha('dadnotes'..i, i, 0.3, 1, 'cubeInOut')
		end
	end
	if curBeat == 67 then
		triggerEvent('Change Character', 'dad', 'marcophase2')
		setProperty('defaultCamZoom', 1.5)
	end
	if curStep == 275 then
		doTweenAlpha('blackBg', 'blackBG', 0.7, 0.3, 'cubeInOut')
		triggerEvent('Play Animation', 'laugh', 'dad')
		noteTweenX('NoteMove1', 0, 400, 1, 'cubeInOut')
		noteTweenX('NoteMove2', 1, 520, 1, 'cubeInOut')
		noteTweenX('NoteMove3', 2, 640, 1, 'cubeInOut')
		noteTweenX('NoteMove4', 3, 760, 1, 'cubeInOut')
		noteTweenX('NoteMove5', 4, 400, 1, 'cubeInOut')
		noteTweenX('NoteMove6', 5, 520, 1, 'cubeInOut')
		noteTweenX('NoteMove7', 6, 640, 1, 'cubeInOut')
		noteTweenX('NoteMove8', 7, 760, 1, 'cubeInOut')
	end
	if curStep == 295 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.3, 'cubeInOut')
		doTweenAlpha('hud', 'camHUD', 1, 0.9, 'linear')
	end
	if curStep == 305 then
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'FFFFFF', 0.5, false)
		
		setProperty('blackBG.alpha', 0)
	end
	if curStep == 622 then
		setProperty('defaultCamZoom', 1.5)
	end
	if curStep == 625 then
		cameraFlash('game', 'FFFFFF', 0.5, false)
		setProperty('defaultCamZoom', 0.9)
	end
	if curStep == 1713 then
		cameraFlash('game', 'FFFFFF', 0.5, false)
	end
	if curStep == 1776 then
		doTweenZoom('gameWOOOOOOOO', 'camGame', 1.2, 26 / playbackRate, 'cubeInOut')
	end
	if curStep == 1840 then
		doTweenAlpha('hudAppear', 'camHUD', 0, 0.8, 'cubeInOut')
	end
	if curStep == 2080 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.7, 'circOut')
	end
end

function onBeatHit()
	if curStep <= 624 or (curStep >= 1073 and curStep <= 1136) then
		if curBeat % 8 == 0 and curBeat >= 76 then
			triggerEvent('Add Camera Zoom', '0.02', '0.025')
		end
		if curBeat % 8 == 2 and curBeat >= 76 then
			runTimer('woop', 0.01)
		end
		if curBeat % 8 == 4 and curBeat >= 76 then
			triggerEvent('Add Camera Zoom', '0.02', '0.025')
		end
		if curBeat % 8 == 6 and curBeat >= 76 then
			runTimer('woop', 0.01)
		end
	end
	if (curStep >= 625 and curStep <= 1072) or (curStep >= 1136 and curStep <= 1584) then
		if curBeat % 4 == 0 then
			triggerEvent('Add Camera Zoom', '0.02', '0.025')
		end
		if curBeat % 4 == 1 then
			runTimer('woop2', 0.01)
		end
		if curBeat % 4 == 2 then
			triggerEvent('Add Camera Zoom', '0.02', '0.025')
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