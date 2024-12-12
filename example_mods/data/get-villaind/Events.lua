local character = 0

local notePos = {}
local notePosX = {}

function onCreate()
	addCharacterToList('Justky', 'dad')
	addCharacterToList('Adamfriend', 'boyfriend')
	
	if boyfriendName == 'GFwav' then
		character = 1
	elseif boyfriendName == 'playablegf-old' then
		character = 2
	elseif boyfriendName == 'd-side gf' then
		character = 3
	elseif boyfriendName == 'debugGF' then
		character = 4
	end
	
	precacheSound('matpatRamble')
	
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', '')
end

function onCreatePost()
	removeLuaScript("custom_events/zCameraFix")
    addLuaScript("custom_events/zCameraFix")
	
	for i = 0,7 do
		x = getPropertyFromGroup('strumLineNotes', i, 'x')
		table.insert(notePosX, x)
	end
	
	makeLuaText('MorkyText', " ", 1000, 120, 520)
	setTextSize('MorkyText', 35)
	setObjectCamera('MorkyText', 'game')
	setScrollFactor('MorkyText', 0, 0)
	setProperty('MorkyText.alpha', 1)
	addLuaText('MorkyText')
	
	makeLuaSprite('morkyJumpscare', 'effects/morkyJumpscare', 0, 0)
	setProperty('morkyJumpscare.alpha', 0)
	setObjectCamera('morkyJumpscare', 'hud')
	addLuaSprite('morkyJumpscare', true)
	
	makeLuaSprite('mcdonnies', 'effects/mcdonnies', 350, 350)
	setProperty('mcdonnies.alpha', 0)
	addLuaSprite('mcdonnies', true)
	
	makeLuaSprite('gameTHEORY', 'effects/gaemTheoreh', 350, 0)
	setProperty('gameTHEORY.alpha', 0)
	setObjectCamera('gameTHEORY', 'hud')
	if mechanics then
		addLuaSprite('gameTHEORY', true)
	else
		addLuaSprite('gameTHEORY', false)
	end

	if shadersEnabled and mechanics then
		runHaxeCode([[
			game.initLuaShader('multi');
			shader0 = game.createRuntimeShader('multisplit');
			game.camGame.setFilters([new ShaderFilter(shader0)]);
			game.camHUD.setFilters([new ShaderFilter(shader0)]);

			shader0.setFloat('multi',1);
		]])
	end 
end

function onSongStart()
	for i = 0,7 do 
		y = getPropertyFromGroup('strumLineNotes', i, 'y')
		table.insert(notePos, y)
	end
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and difficulty == 1 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getProperty('health') > 0.2 then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.06);
				else
					setProperty('health', health- 0.012);
				end
			end
		end
end

function onUpdate()
	if curStep >= 512 and curStep < 768 and mechanics then
		setProperty('gameTHEORY.angle', getProperty('gameTHEORY.angle') + 10)
	end
end

function onStepHit()
	if curStep == 135 then
		doTweenAlpha('hudgobye', 'camHUD', 0, 0.5 / playbackRate, 'linear')
	end
	if curStep == 138 then
		doTweenAlpha('MorkyText', 'MorkyText', 1, 0.07 / playbackRate, 'cubeIn')
		setProperty('defaultCamZoom', 1.4)
		setTextString('MorkyText', "Ha!")
	end
	if curStep == 148 then
		setTextString('MorkyText', "Ha! Hah!")
	end
	if curStep == 157 then
		setTextString('MorkyText', "Ha! Hah! Hah!")
	end
	if curStep == 166 then
		setTextString('MorkyText', "Ha! Hah! Hah! Haaaaa!")
	end
	if curStep == 184 then
		setTextString('MorkyText', "I")
	end
	if curStep == 189 then
		setTextString('MorkyText', "I am")
	end
	if curStep == 192 then
		setTextString('MorkyText', "I am Mor")
	end
	if curStep == 196 then
		setTextString('MorkyText', "I am Morky!")
	end
	if curStep == 208 then
		setTextString('MorkyText', "And")
	end
	if curStep == 210 then
		setTextString('MorkyText', "And I")
	end
	if curStep == 214 then
		doTweenAlpha('MorkyText', 'MorkyText', 0, 0.6 / playbackRate, 'cubeInOut')
		triggerEvent('Play Animation', 'pomnify', 'dad')
		setProperty('defaultCamZoom', 1.1)
	end
	if curStep == 243 then
		doTweenAngle('camGameGoSpeen', 'camGame', 360 * 3, 1.7 / playbackRate, 'cubeInOut')
	end
	if curStep == 252 then
		doTweenZoom('camGameZoom', 'camGame', 1.6, 0.4 / playbackRate, 'elasticInOut')
	end
	if curStep == 256 then
		cancelTween('camGameGoSpeen')
		cancelTween('camGameZoom')
		
		setProperty('camGame.angle', 0)
		
		doTweenAlpha('hudgobye', 'camHUD', 1, 1.6 / playbackRate, 'circOut')
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'ffffff', 0.8 / playbackRate, false)
	end
	if curStep == 384 then
		setProperty('defaultCamZoom', 1.6)
	end
	if curStep == 388 then
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'ffffff', 0.8 / playbackRate, false)
	end
	if curStep == 512 then
		playSound('matpatRamble')
		doTweenAlpha('gaemTheoreh', 'gameTHEORY', 0.6, 17 / playbackRate, 'cubeInOut')
		if mechanics then
			doTweenX('gaemTheorehX', 'gameTHEORY.scale', 4.5, 21 / playbackRate, 'cubeInOut')
			doTweenY('gaemTheorehY', 'gameTHEORY.scale', 4.5, 21 / playbackRate, 'cubeInOut')
		end
	end
	if curStep == 752 then
		setProperty('defaultCamZoom', 1.3)
		doTweenAlpha('gaemTheoreh', 'gameTHEORY', 0, 0.5 / playbackRate, 'circOut')
	end
	if curStep == 768 then
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'ffffff', 0.8 / playbackRate, false)
	end
	if curStep == 1280 then
		triggerEvent("Change Character", 'dad', 'Justky')
		setProperty('defaultCamZoom', 1.3)
	end
	if curStep == 1296 then
		triggerEvent("Change Character", 'bf', 'adamfriend')
	end
	if curStep == 1408 then
		setProperty('defaultCamZoom', 1.1)
	end
	if curStep == 1414 then
		doTweenAlpha('mcdonnies', 'mcdonnies', 1, 1.5 / playbackRate, 'cubeInOut')
	end
	if curStep == 1520 then
		setProperty('defaultCamZoom', 0.7)
	end
	if curStep == 1528 then
		doTweenAngle('morkSpin', 'dad', 360 * 100, 2, 'circOut')
		doTweenX('morkX', 'dad.scale', 40, 2, 'bounceInOut')
		triggerEvent("Screen Shake", '0.8/'..playbackRate..', 0.035', '0.8/'..playbackRate..', 0.04')
		
		setProperty('morkyJumpscare.alpha', 1)
		doTweenAlpha('morkyJumpscare', 'morkyJumpscare', 0, 0.7 / playbackRate, 'circOut')
	end
	if curStep == 1536 then
		cancelTween('morkSpin')
		cancelTween('morkX')
		setProperty('dad.scale.x', 1)
		setProperty('dad.angle', 0)
		
		removeLuaSprite('mcdonnies', true)
		
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'ffffff', 0.8 / playbackRate, false)
		
		triggerEvent('Change Character', 'dad', 'Morky')
		
		if character == 1 then
			triggerEvent('Change Character', 'boyfriend', 'GFwav')
		elseif character == 2 then
			triggerEvent('Change Character', 'boyfriend', 'playablegf-old')
		elseif character == 3 then
			triggerEvent('Change Character', 'boyfriend', 'd-side gf')
		elseif character == 4 then
			triggerEvent('Change Character', 'boyfriend', 'debugGF')
		else
			triggerEvent('Change Character', 'boyfriend', 'playablegf')
		end
		
		addGlitchEffect('bg', 1.5, 0.6, 0.3)
	end
	if curStep == 1784 then
		setProperty('defaultCamZoom', 1.7)
	end
	if curStep == 1792 then
		setProperty('defaultCamZoom', 0.9)
		
		if mechanics then
			noteTweenX('noteTweenX0', 0, defaultPlayerStrumX0, 0.7 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX1', 1, defaultPlayerStrumX1, 0.72 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX2', 2, defaultPlayerStrumX2, 0.74 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX3', 3, defaultPlayerStrumX3, 0.76 / playbackRate, 'cubeInOut')
			
			noteTweenX('noteTweenX4', 4, defaultOpponentStrumX0, 0.7 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX5', 5, defaultOpponentStrumX1, 0.72 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX6', 6, defaultOpponentStrumX2, 0.74 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX7', 7, defaultOpponentStrumX3, 0.76 / playbackRate, 'cubeInOut')
		end
	end
	if curStep == 2032 then
		if mechanics then
			for i = 0, 7 do
				cancelTween("noteTweenX"..i)
				cancelTween("noteTweenX"..i.."FIX")
			end
			
			noteTweenX('noteTweenX0End', 0, defaultOpponentStrumX0, 0.7 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX1End', 1, defaultOpponentStrumX1, 0.72 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX2End', 2, defaultOpponentStrumX2, 0.74 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX3End', 3, defaultOpponentStrumX3, 0.76 / playbackRate, 'cubeInOut')
			
			noteTweenX('noteTweenX4End', 4, defaultPlayerStrumX0, 0.7 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX5End', 5, defaultPlayerStrumX1, 0.72 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX6End', 6, defaultPlayerStrumX2, 0.74 / playbackRate, 'cubeInOut')
			noteTweenX('noteTweenX7End', 7, defaultPlayerStrumX3, 0.76 / playbackRate, 'cubeInOut')
		end
		setProperty('defaultCamZoom', 1.7)
	end
	if curStep == 2048 then
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'ffffff', 0.8 / playbackRate, false)
	end
	if curStep == 2296 then
		callScript('scripts/VideoSpriteHandler', 'makeVideoSprite', {'theSilly', 'theBilly', -20, 275, 'camGame', 0})
		setProperty('theSilly.alpha', 0)
		scaleObject('theSilly', 2, 2)
	end
	if curStep == 2304 then
		doTweenX('backgroundZoomX', 'bg.scale', 3, 0.6 / playbackRate, 'circOut')
		doTweenY('backgroundZoomY', 'bg.scale', 3, 0.6 / playbackRate, 'circOut')
		
		doTweenAlpha('theSilly, please show up', 'theSilly', 0.5, 21 / playbackRate, 'cubeInOut')
		setProperty('defaultCamZoom', 0.5)
	end
	if curStep == 2560 then
		doTweenX('backgroundZoomX', 'bg.scale', 1.5, 0.6 / playbackRate, 'circOut')
		doTweenY('backgroundZoomY', 'bg.scale', 1.5, 0.6 / playbackRate, 'circOut')
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'ffffff', 0.8 / playbackRate, false)
		setProperty('theSilly.alpha', 0)
		
		for i = 0, 7 do
			noteTweenY('noteGoUp'..i, i, notePos[i + 1], 0.7 / playbackRate, 'elasticOut')
		end
			
		noteTweenX('noteTweenX0End', 0, defaultOpponentStrumX0, 0.7 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX1End', 1, defaultOpponentStrumX1, 0.72 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX2End', 2, defaultOpponentStrumX2, 0.74 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX3End', 3, defaultOpponentStrumX3, 0.76 / playbackRate, 'cubeInOut')
			
		noteTweenX('noteTweenX4End', 4, defaultPlayerStrumX0, 0.7 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX5End', 5, defaultPlayerStrumX1, 0.72 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX6End', 6, defaultPlayerStrumX2, 0.74 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX7End', 7, defaultPlayerStrumX3, 0.76 / playbackRate, 'cubeInOut')
			
		clearEffects('bg')
	end
end

local count = 1
function onBeatHit()
	if (curBeat >= 64 and curBeat < 128) or (curBeat >= 192 and curBeat < 320) then
		triggerEvent('Add Camera Zoom', '0.045', '0.048')
	end
	if (curBeat >= 128 and curBeat < 192) or (curBeat >= 320 and curBeat < 384) or (curBeat >= 448 and curBeat <= 508)
	or (curBeat > 656 and curBeat <= 672) then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom', '0.065', '0.069')
		end
	end
	if (curBeat >= 384 and curBeat < 448) or (curBeat >= 512 and curBeat <= 640) then
		triggerEvent('Add Camera Zoom', '0.055', '0.058')
		if curBeat % 2 == 0 then
			runTimer('woop', 0.001)
		end
	end
	
	-- Multiplier shader
	if shadersEnabled and mechanics then
		if curBeat >= 192 and curBeat < 256 and curBeat % 4 == 0 then
			if count > 4 then
				count = 1
			end
			runHaxeCode([[
				shader0.setFloat('multi',]]..count..[[);
			]])
			count = count + 1
		end
		if curBeat == 256 then
			runHaxeCode([[
				shader0.setFloat('multi', 1);
			]])
		end
	end
	
	-- Note Moving
	if (curBeat >= 512 and curBeat < 640) then
		if curBeat % 1 == 0 then
			for i = 0, 7 do
				setPropertyFromGroup('strumLineNotes', i, 'y', notePos[i + 1])
				setPropertyFromGroup('strumLineNotes', i, 'scale.x', 1.0)
				setPropertyFromGroup('strumLineNotes', i, 'scale.y', 0.35)
				
				noteTweenY('noteGoUp'..i, i, notePos[i + 1] - 20, 0.7 / playbackRate, 'elasticOut')
				noteTweenScaleX('noteXSCALE'..i, i, 0.7, 0.7 / playbackRate, 'circOut')
				noteTweenScaleY('noteYSCALE'..i, i, 0.7, 0.7 / playbackRate, 'circOut')
			end
		end
		if curBeat % 2 == 0 then
			for i = 0, 7 do
				cancelTween('noteGoRight'..i)
				noteTweenX('noteGoLeft'..i, i, notePosX[i + 1] - 80, 0.7 / playbackRate, 'expoOut')
			end
		end
		if curBeat % 2 == 1 then
			for i = 0, 7 do
				cancelTween('noteGoLeft'..i)
				noteTweenX('noteGoRight'..i, i, notePosX[i + 1] + 80, 0.7 / playbackRate, 'expoOut')
			end
		end
	end
end
function onGameOverStart()
	if not isMayhemMode then
		startVideo('oh my god you died NEW!');
		runTimer('timeToDie', 9)
		setPropertyFromClass("openfl.Lib", "application.window.title", "HAHA, I aM MorKy, and I wiLL nOw CloSe uR gAem!! YoU cAn't Do ShIt nOW HAHAAAAAAAAAAAAAAAAAAAAAAAAAAA");
	end
end

function onTweenCompleted(tag)
	if tag == 'noteTweenX3' then
		noteTweenX('noteTweenX0FIX', 0, defaultOpponentStrumX0, 0.7 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX1FIX', 1, defaultOpponentStrumX1, 0.72 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX2FIX', 2, defaultOpponentStrumX2, 0.74 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX3FIX', 3, defaultOpponentStrumX3, 0.76 / playbackRate, 'cubeInOut')
		
		noteTweenX('noteTweenX4FIX', 4, defaultPlayerStrumX0, 0.7 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX5FIX', 5, defaultPlayerStrumX1, 0.72 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX6FIX', 6, defaultPlayerStrumX2, 0.74 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX7FIX', 7, defaultPlayerStrumX3, 0.76 / playbackRate, 'cubeInOut')
	end
	if tag == 'noteTweenX3FIX' then
		noteTweenX('noteTweenX0', 0, defaultPlayerStrumX0, 0.7 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX1', 1, defaultPlayerStrumX1, 0.72 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX2', 2, defaultPlayerStrumX2, 0.74 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX3', 3, defaultPlayerStrumX3, 0.76 / playbackRate, 'cubeInOut')
		
		noteTweenX('noteTweenX4', 4, defaultOpponentStrumX0, 0.7 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX5', 5, defaultOpponentStrumX1, 0.72 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX6', 6, defaultOpponentStrumX2, 0.74 / playbackRate, 'cubeInOut')
		noteTweenX('noteTweenX7', 7, defaultOpponentStrumX3, 0.76 / playbackRate, 'cubeInOut')
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
	
	if tag == 'timeToDie' then
		os.exit(true);
	end
end