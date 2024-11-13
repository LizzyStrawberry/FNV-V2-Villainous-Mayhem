local hudThings = {'healthBar', 'healthBarBG', 'iconP1', 'iconP2', 'scoreTxt'}
local randomScrollSpeed = 0

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		addCharacterToList('marcophase3', 'dad')
		addCharacterToList('marcophase3_5', 'dad')
		addCharacterToList('marcoElectric', 'dad')
		addCharacterToList('gfElectric', 'boyfriend')
	
		makeLuaSprite('blackBG', '', -300, -300)
		makeGraphic('blackBG', 3000, 3000, '000000')
		setScrollFactor('blackBG', 0, 0)
		setObjectCamera('blackBG', 'game')
		setObjectOrder('blackBG', getObjectOrder('boyfriendGroup') - 1)
		setProperty('blackBG.alpha', 1)
		addLuaSprite('blackBG', true)
		
		makeLuaSprite('neonBG', 'bgs/marco/foreground-neon', -240, -100);
		setScrollFactor('neonBG', 0.9, 0.9);
		setProperty('neonBG.alpha', 0)
		addLuaSprite('neonBG', false)
		
		setProperty('gf.alpha', 0)
		setProperty('boyfriend.x', 560)
		setProperty('dad.x', 540)
		runHaxeCode([[
			game.dad.setColorTransform(0,0,0,0,255,255,255,0);
			game.boyfriend.setColorTransform(0,0,0,0,255,255,255,0);
		]])
	
		for i = 1, #(hudThings) do
			setProperty(hudThings[i]..'.alpha', 0)
		end
	end
end

function onUpdatePost()
	if curStep < 48 then
		for i = 0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end
	end
	
	if curStep == 32 or curStep == 40 then
		setProperty('boyfriend.alpha', 1)
		doTweenAlpha('boyfriendFix', 'boyfriend', 0, 0.2 / playbackRate, 'easeIn')
	end
	
	if curStep == 36 or curStep == 44 then
		setProperty('dad.alpha', 1)
		doTweenAlpha('dadFix', 'dad', 0, 0.2 / playbackRate, 'easeIn')
	end
	
	if curStep == 48 then
		for i = 0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
		end
		for i = 1, #(hudThings) do
			setProperty(hudThings[i]..'.alpha', 1)
		end
		cameraFlash('hud', 'FFFFFF', 0.7 / playbackRate, false)
		
		setProperty('gf.alpha', 1)
		setProperty('boyfriend.x', 870)
		setProperty('dad.x', 40)

		setProperty('blackBG.alpha', 0)
		setObjectOrder('blackBG', getObjectOrder('neonBG') + 5)
		
		runHaxeCode([[
			game.dad.setColorTransform(1,1,1,1,0,0,0,0);
			game.boyfriend.setColorTransform(1,1,1,1,0,0,0,0);
		]])
		
		if shadersEnabled then
			triggerEvent('Set RTX Data', '0,0.41297871757832,0,0.35555555555556,0,0.45555555555556,0.059470497661755,0.26391302850543,0.46624763596608,0.87627019248397,0.1519863862471,0.24647074621987,232.4386852381,29.542329077536', '')
		end
	end
	
	if curStep == 288 then
		setProperty('defaultCamZoom', 1.4)
	end
	
	if curStep == 304 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		triggerEvent('Change Character', 'dad', 'marcophase3')
		setProperty('defaultCamZoom', 0.9)
	end
	
	if curStep == 920 then
		setProperty('defaultCamZoom', 1.4)
		doTweenAlpha('bgBye', 'bg', 0, 0.4 / playbackRate, 'easeOut')
		doTweenAlpha('fgBye', 'fg', 0, 0.4 / playbackRate, 'easeOut')
		doTweenAlpha('neonBG', 'neonBG', 1, 0.4 / playbackRate, 'sineOut')
		doTweenAlpha('gfbye', 'boyfriend', 0, 0.4 / playbackRate, 'easeOut')
		doTweenAlpha('gf', 'gf', 0, 0.4 / playbackRate, 'easeOut')
	end
	
	if curStep == 926 then
		triggerEvent('Change Character', 'dad', 'marcoElectric')
	end
	
	if curStep == 927 then
		setProperty('defaultCamZoom', 1.0)
		triggerEvent('Play Animation', 'chuckletits', 'dad')
	end
	
	if curStep == 944 then
		triggerEvent('Change Character', 'bf', 'gfElectric')
		setProperty('boyfriend.alpha', 1)
		setProperty('neonBG.alpha', 1)
		cameraFlash('hud', 'FFFFFF', 0.7 / playbackRate, false)
		setProperty('defaultCamZoom', 0.9)
		
		if shadersEnabled then
			triggerEvent('Set RTX Data', '0,0,0,0,0,0,0,0,0,0,0,0,0,20', '')
		end
	end
	
	if curStep == 1200 then
		doTweenAlpha('blackBG', 'blackBG', 1, 0.4 / playbackRate, 'circOut')
	end
	
	if curStep == 1232 then
		triggerEvent('Change Character', 'dad', 'marcophase3')
		triggerEvent('Change Character', 'bf', 'playablegf')
		setProperty('defaultCamZoom', 0.9)
	end
	
	if curStep == 1248 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		setProperty('bg.alpha', 1)
		setProperty('fg.alpha', 1)
		setProperty('gf.alpha', 1)
		removeLuaSprite('neonBG', true)
		setProperty('blackBG.alpha', 0)
		
		if shadersEnabled then
			triggerEvent('Set RTX Data', '0,0.41297871757832,0,0.35555555555556,0,0.45555555555556,0.059470497661755,0.26391302850543,0.46624763596608,0.87627019248397,0.1519863862471,0.24647074621987,232.4386852381,29.542329077536', '')
		end
	end
	
	if curStep == 1632 then
		triggerEvent('Change Character', 'dad', 'marcophase3_5')
		doTweenAlpha('blackBG', 'blackBG', 1, 0.4 / playbackRate, 'circOut')
		doTweenAlpha('hud', 'camHUD', 0, 0.4 / playbackRate, 'circOut')
		setProperty('defaultCamZoom', 1.1)
	end
	
	if curStep == 1668 then
		doTweenAlpha('blackBG', 'blackBG', 0.7, 0.4 / playbackRate, 'circOut')
		triggerEvent('Play Animation', 'laugh', 'dad')
	end
	
	if curStep == 1684 then
		doTweenAlpha('hud', 'camHUD', 1, 0.4 / playbackRate, 'circOut')
	end
	
	if curStep == 1688 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		setProperty('blackBG.alpha', 0)
		setProperty('defaultCamZoom', 0.9)
	end
	
	if curStep == 1976 then
		setProperty('blackBG.alpha', 1)
	end
end

function onBeatHit()
	if ((curStep >= 48 and curStep < 304) or (curStep >= 560 and curStep < 944)) and curBeat % 4 == 0 then
		triggerEvent('Add Camera Zoom', '0.08', '0.08')
		runTimer('woop', 0.01)
	end
	
	if (curStep >= 304 and curStep < 560) or (curStep >= 1688 and curStep <= 1976) then
		triggerEvent('Add Camera Zoom', '0.06', '0.06')
		runTimer('woop2', 0.01)
	end
	
	if (curStep >= 944 and curStep <= 1200) then
		triggerEvent('Add Camera Zoom', '0.1', '0.1')
		runTimer('woop2', 0.01)
		setProperty('neonBG.alpha', 1)
		doTweenAlpha('neonBG', 'neonBG', 0.3, 0.5, 'sineOut')
	end
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
	if not isMayhemMode and ((isStoryMode and difficulty == 1) or (not isStoryMode and difficulty == 0)) then
		if getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.006);
			else
				setProperty('health', health- 0.012);
			end
		end
	end
	if not isMayhemMode and ((isStoryMode and difficulty == 2) or (not isStoryMode and difficulty == 1)) then
		if getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.009);
			else
				setProperty('health', health- 0.018);
			end
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'woop' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 20)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 20, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 15)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 15)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 20)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 20, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 20)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 20, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 15)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 15)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 20)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 20, 0.6, 'sineOut')
	end
	
	if tag == 'woop2' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 20)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 20, 0.3, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 15)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 15, 0.3, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 15)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 15, 0.3, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 20)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 20, 0.3, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 20)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 20, 0.3, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 15)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 15, 0.3, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 15)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 15, 0.3, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 20)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 20, 0.3, 'sineOut')
	end
end