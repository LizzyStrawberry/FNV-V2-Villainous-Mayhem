function onCreate()
	setProperty('gf.alpha', 0)
	setProperty('gf.x', getProperty('dad.x'))
	setProperty('gf.y', getProperty('dad.y'))
	setProperty('boyfriend.visible', false)

	setProperty('healthBar.alpha', 0)
	setProperty('healthBarBG.alpha', 0)
	setProperty('iconP1.alpha', 0)
	setProperty('iconP2.alpha', 0)
	setProperty('scoreTxt.alpha', 0)
	setProperty('watermark.alpha', 0)
	setProperty('watermark2.alpha', 0)
end

function onCreatePost()
	addCharacterToList('dad', 'MichaelPhase2')
	addCharacterToList('dad', 'MichaelPhase2_5')
	addCharacterToList('dad', 'MichaelPhase3')
	addCharacterToList('dad', 'MichaelPhase4')
	addCharacterToList('dad', 'MichaelPhase5')

	makeLuaSprite('blackBG', '', -300, -300)
	makeGraphic('blackBG', 2000, 2000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	setProperty('blackBG.alpha', 1)
	addLuaSprite('blackBG', true)
	
	makeLuaSprite('lineEffect', 'effects/lineEffect', 75, -200)
	setScrollFactor('lineEffect', 0, 0)
	setObjectCamera('lineEffect', 'game')
	setProperty('lineEffect.alpha', 0)
	scaleObject("lineEffect", 0.9, 0.9)
	addLuaSprite('lineEffect', true)
	
	makeLuaSprite('green', '', -300, -300)
	makeGraphic('green', 2000, 2000, '769469')
	setScrollFactor('green', 0, 0)
	setObjectCamera('green', 'game')
	setProperty('green.alpha', 0)
	addLuaSprite('green', true)
	
	if getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
		removeLuaSprite('trampoline', true)
	end
end

function onSongStart()
	doTweenAlpha('blackBGFadeOut', 'blackBG', 0, 10.4, 'cubeInOut')
	for i = 0, 3 do
		noteTweenAlpha('noteHide'..i, i, 0, 0.001, 'linear')
		setPropertyFromGroup('opponentStrums', i, 'y', 360);
	end
	
	setPropertyFromGroup('opponentStrums', 0, 'x', 120)
	setPropertyFromGroup('opponentStrums', 1, 'x', 120)
	setPropertyFromGroup('opponentStrums', 2, 'x', 1000)
	setPropertyFromGroup('opponentStrums', 3, 'x', 1000)
end

local heightCheck
function onUpdatePost()
	if curBeat == 0 then
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums',i,'alpha',0)
		end
	end
	
	setProperty('lineEffect.angle', getProperty("lineEffect.angle") + (7.5 * playbackRate))
	
	for i = 0, 3 do
		setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/MarcoNOTE_assets');
		setPropertyFromGroup('opponentStrums', i, 'scale.x', 2);
		setPropertyFromGroup('opponentStrums', i, 'scale.y', 2);
		if getPropertyFromGroup('notes', i, 'noteType') == 'Hurt Note' then
			setPropertyFromGroup('notes', i, 'visible', false);
		end
		if getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing' then
			setPropertyFromGroup('notes', i, 'scale.x', 2);
			setPropertyFromGroup('notes', i, 'scale.y', 2);
			--setPropertyFromGroup('notes', i, 'texture', 'notes/MarcoNOTE_assets');
			setPropertyFromGroup('notes', i, 'visible', false);
		end
	end
	
	if (curStep >= 0 and curStep < 383) then
		setProperty('camZooming', false)
	end
	
	if curStep >= 0 and curStep <= 32 then
		for i = 0, 3 do
			setPropertyFromGroup('playerStrums',i,'alpha',0)
		end
	end
	
	if curStep == 640 then
		doTweenAlpha('MichealFadeIn', 'gf', 0.5, 6 / playbackRate, 'cubeInOut')
	end
	if curStep == 700 then
		doTweenAlpha('MichealFadeIn', 'gf', 0.1, 4 / playbackRate, 'cubeInOut')
	end
	if curStep >= 896 and curStep <= 1024 then
		if curStep % 16 == 0 then
			doTweenAlpha('MichealFadeIn', 'gf', 0.5, 1 / playbackRate, 'linear')
			doTweenAlpha('lineThingFadeIn', 'lineEffect', 0.8, 1 / playbackRate, 'cubeInOut')
		end
		if curStep % 16 == 8 then
			doTweenAlpha('MichealFadeIn', 'gf', 0.1, 1 / playbackRate, 'linear')
			doTweenAlpha('lineThingFadeIn', 'lineEffect', 0.3, 1 / playbackRate, 'cubeInOut')
		end
	end
	if curStep == 1024 then
		cancelTween('lineThingFadeIn')
		cancelTween('MichealFadeIn')
		doTweenAlpha('MichealFadeOut', 'gf', 0, 1 / playbackRate, 'linear')
		doTweenAlpha('lineThingFadeOut', 'lineEffect', 0, 1 / playbackRate, 'easeInOut')
	end
	if curStep > 1024 then
		if curStep % 64 == 0 then
			doTweenAlpha('greenLmao', 'green', 0.4, 2 / playbackRate, 'linear')
		end
		if curStep % 64 == 32 then
			doTweenAlpha('greenLmao', 'green', 0, 2 / playbackRate, 'linear')
		end
	end
	
	if curBeat == 32 then
		doTweenAlpha('healthBar', 'healthBar', 1, 1 / playbackRate, 'linear')
		doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1 / playbackRate, 'linear')
		doTweenAlpha('iconP1', 'iconP1', 1, 1 / playbackRate, 'linear')
		doTweenAlpha('iconP2', 'iconP2', 1, 1 / playbackRate, 'linear')
		doTweenAlpha('watermark', 'watermark', 1, 1 / playbackRate, 'linear')
		doTweenAlpha('watermark2', 'watermark2', 1, 1 / playbackRate, 'linear')
		doTweenAlpha('scoreTxt', 'scoreTxt', 1, 1 / playbackRate, 'linear')
		
		for i = 4, 7 do
			noteTweenAlpha('noteAlpha'..i, i, 1, 1 / playbackRate, 'linear')
		end
	end
	if curStep == 376 then
		triggerEvent('Change Scroll Speed', '1.2', '0.7')
	end
	if curStep == 383 then
		runTimer('waityoudumbshit', 0.01)
		setProperty('camZooming', true)
	end
	if curStep == 1024 then
		cameraFlash('game', '769469', 7, false)
		triggerEvent('Change Scroll Speed', '1', '0.7')
	end
	if curStep == 1360 then
		cameraFade('hud', '000000', 4 / playbackRate, false)
	end
end

function onStepHit()
	if curStep >= 384 and curStep < 896 then
		if curStep % 8 == 0 then
			triggerEvent('Add Camera Zoom', '0.02', '0.02')
		end
	end
	if curStep >= 896 and curStep <= 1024 then
		if curStep % 4 == 0 then
			triggerEvent('Add Camera Zoom', '0.05', '0.05')
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote, noteData)
	if curStep >= 640 and curStep <= 704 then
		if noteType == 'GF Sing' then
			if direction == 0 then
				setPropertyFromGroup('opponentStrums', 0, 'alpha', 1)
				setPropertyFromGroup('opponentStrums', 0, 'x', 20)
				noteTweenAlpha('noteAlpha0', 0, 0, 0.6 / playbackRate, 'circOut')
				noteTweenX('noteY0', 0, 120, 0.6 / playbackRate, 'circOut')
			end
			if direction == 1 then
				setPropertyFromGroup('opponentStrums', 1, 'alpha', 1)
				setPropertyFromGroup('opponentStrums', 1, 'y', 460)
				noteTweenAlpha('noteAlpha1', 1, 0, 0.6 / playbackRate, 'circOut')
				noteTweenY('noteY1', 1, 360, 0.6 / playbackRate, 'circOut')
			end
			if direction == 2 then
				setPropertyFromGroup('opponentStrums', 2, 'alpha', 1)
				setPropertyFromGroup('opponentStrums', 2, 'y', 260)
				noteTweenAlpha('noteAlpha2', 2, 0, 0.6 / playbackRate, 'circOut')
				noteTweenY('noteY2', 2, 360, 0.6 / playbackRate, 'circOut')
			end
			if direction == 3 then
				setPropertyFromGroup('opponentStrums', 3, 'alpha', 1)
				setPropertyFromGroup('opponentStrums', 3, 'x', 1100)
				noteTweenAlpha('noteAlpha3', 3, 0, 0.6 / playbackRate, 'circOut')
				noteTweenX('noteX3', 3, 1000, 0.6 / playbackRate, 'circOut')
			end
		end
	end
	
	if curStep >= 896 and curStep <= 1024 then
		if direction == 0 then
			triggerEvent('Play Animation', 'singRIGHT', 'gf')
		end
		if direction == 1 then
			triggerEvent('Play Animation', 'singUP', 'gf')
		end
		if direction == 2 then
			triggerEvent('Play Animation', 'singDOWN', 'gf')	
		end
		if direction == 3 then
			triggerEvent('Play Animation', 'singLEFT', 'gf')
		end
	end
	
	health = getProperty('health')
	if not isMayhemMode and difficulty == 1 then
		if getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.007);
			else
				setProperty('health', health- 0.014);
			end
		end
	end
end

function onUpdate()
	if curStep == 532 then
		setProperty('dad.x', getProperty('dad.x'))
		triggerEvent('Change Character', 'dad', 'MichaelPhase3')
	end	
	if curStep == 536 then
		setProperty('dad.x', getProperty('dad.x'))
		triggerEvent('Change Character', 'dad', 'MichaelPhase2_5')
	end
	if curStep == 544 then
		setProperty('dad.x', getProperty('dad.x'))
		triggerEvent('Change Character', 'dad', 'MichaelPhase3')
	end
	if curStep == 896 then
		setProperty('gf.x', getProperty('dad.x'))
		setProperty('gf.y', getProperty('dad.y'))
		triggerEvent('Change Character', 'gf', 'MichaelPhase3')
		triggerEvent('Change Character', 'dad', 'MichaelPhase4')
		cameraFlash('game', '769469', 1, false)
		
		triggerEvent('Change Scroll Speed', '1.4', '0.01')
	end
	if curStep == 1029 then
		setProperty('dad.x', getProperty('dad.x'))
		triggerEvent('Change Character', 'dad', 'MichaelPhase5')
	end
end

function onTweenCompleted(tag)
	if tag == 'blackBGFadeOut' then
		removeLuaSprite('blackBG', true)
	end
end

function onTimerCompleted(tag)
	if tag == 'waityoudumbshit' then
		triggerEvent('Change Character', 'dad', 'MichaelPhase2')
		cameraFlash('game', '769469', 1, false)
	end
end