boyfriendColors =
{
	'a5004d', -- Intruder GF [OLD/NEW/SPENDTHRIFT]
	'fb7760', -- D-side GF
	'd83225', -- Crewmate GF
	'FFFFFF', -- GF.Wav
	'482b38' -- Debug GF
}
local shadersOn = false

function onCreate()
	makeLuaSprite('blackBG', '', -300, -300)
	makeGraphic('blackBG', 2000, 2000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	setProperty('blackBG.alpha', 0)
	addLuaSprite('blackBG', true)
	
	addCharacterToList('marcophase2', 'dad')
end

function onUpdate()
	if curBeat == 64 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.7 / playbackRate, 'circOut')
		doTweenAlpha('hudAppear', 'camHUD', 0, 0.8 / playbackRate, 'cubeInOut')
		for i = 0, 3 do
			noteTweenAlpha("goodbyeNote"..i, i, 0, 1 / playbackRate, "cubeInOut")
		end
	end
	if curBeat == 67 then
		triggerEvent('Change Character', 'dad', 'marcophase2')
		setProperty('defaultCamZoom', 1.3)
	end
	if curStep == 294 then
		doTweenAlpha('blackBg', 'blackBG', 0.7, 0.3 / playbackRate, 'cubeInOut')
		triggerEvent('Play Animation', 'laugh', 'dad')
		noteTweenX('NoteMove1', 0, 400, 1 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove2', 1, 520, 1 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove3', 2, 640, 1 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove4', 3, 760, 1 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove5', 4, 400, 1 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove6', 5, 520, 1 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove7', 6, 640, 1 / playbackRate, 'cubeInOut')
		noteTweenX('NoteMove8', 7, 760, 1 / playbackRate, 'cubeInOut')
	end
	if curStep == 312 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.3 / playbackRate, 'cubeInOut')
		doTweenAlpha('hud', 'camHUD', 1, 0.9 / playbackRate, 'linear')
	end
	if curStep == 320 then
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		
		setProperty('blackBG.alpha', 0)
	end
	if curStep == 700 then
		setProperty('defaultCamZoom', 1.3)
	end
	if curStep == 704 or curStep == 1472 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		setProperty('defaultCamZoom', 0.9)
		
		if shadersEnabled and shadersOn == false then
			addBloomEffect('game', 0.35, 1.0)
			shadersOn = true
		end
	end
	if curStep == 1216 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		setProperty('bg.alpha', 0)
		setProperty('fg.alpha', 0)
		setProperty('dad.color', getColorFromHex('00FF00'))
		if boyfriendName == 'playablegf' or boyfriendName == 'playablegf-old' or boyfriendName == 'Spendthrift GF' then
			color = getColorFromHex(boyfriendColors[1])
		elseif boyfriendName == 'd-side gf' then
			color = getColorFromHex(boyfriendColors[2])
		elseif boyfriendName == 'amongGF' then
			color = getColorFromHex(boyfriendColors[3])
		elseif boyfriendName == 'GFwav' then
			color = getColorFromHex(boyfriendColors[4])
		elseif boyfriendName == 'debugGF' then
			color = getColorFromHex(boyfriendColors[5])
		end
		setProperty('boyfriend.color', color)
		
		if shadersEnabled and shadersOn == true then
			clearEffects('game')
			shadersOn = false
		end
	end
	if curStep == 1464 then
		setProperty('defaultCamZoom', 1.3)
		doTweenAlpha('bg', 'bg', 1, 0.7 / playbackRate, 'circOut')
		doTweenAlpha('fg', 'fg', 1, 0.7 / playbackRate, 'circOut')
		doTweenColor('dad', 'dad', 'FFFFFF', 0.7 / playbackRate, 'circOut')
		doTweenColor('bf', 'boyfriend', 'FFFFFF', 0.7 / playbackRate, 'circOut')
	end
	if curStep == 1982 then
		setProperty('camGame.alpha', 0)
	end
	if curStep == 2000 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		setProperty('camGame.alpha', 1)
		
		if shadersEnabled and shadersOn == true then
			clearEffects('game')
			shadersOn = false
		end
	end
	if curStep == 2320 then
		doTweenZoom('gameWOOOOOOOO', 'camGame', 1.2, 4 / playbackRate, 'cubeInOut')
		doTweenAlpha('hudAppear', 'camHUD', 0, 3.8 / playbackRate, 'cubeInOut')
		setProperty('camZooming', false)
	end
	if curStep == 2384 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.7 / playbackRate, 'circOut')
	end
end

function onBeatHit()
	if curStep <= 704 or (curStep >= 1216 and curStep < 1472) then
		if curBeat % 8 == 0 and curBeat >= 76 then
			triggerEvent('Add Camera Zoom', '0.05', '0.055')
		end
		if curBeat % 8 == 2 and curBeat >= 76 then
			runTimer('woop', 0.01)
		end
		if curBeat % 8 == 4 and curBeat >= 76 then
			triggerEvent('Add Camera Zoom', '0.05', '0.055')
		end
		if curBeat % 8 == 6 and curBeat >= 76 then
			runTimer('woop', 0.01)
		end
	end
	if (curStep >= 704 and curStep < 1216) or (curStep >= 1472 and curStep <= 1984) then
		if curBeat % 4 == 0 then
			triggerEvent('Add Camera Zoom', '0.09', '0.095')
		end
		if curBeat % 4 == 1 then
			runTimer('woop2', 0.01)
		end
		if curBeat % 4 == 2 then
			triggerEvent('Add Camera Zoom', '0.09', '0.095')
		end
		if curBeat % 4 == 3 then
			runTimer('woop2', 0.01)
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'woop' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 25)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 25, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 20)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 20, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 20)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 20, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 25)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 25, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 25)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 25, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 20)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 20, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 20)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 20, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 25)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 25, 0.6 / playbackRate, 'sineOut')
	end	
	if tag == 'woop2' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 35)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 35, 0.6 / playbackRate, 'sineOut')
		
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