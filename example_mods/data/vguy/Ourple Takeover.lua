local shake = 6.5;

function onCreate()
	addCharacterToList('matpat', 'girlfriend')

	if shadersEnabled then
		makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
		runHaxeCode([[
			FlxG.game.setFilters([]);
		]])
	end
end

function onCreatePost()
	setObjectOrder('gf', getObjectOrder('extraCharBG') + 1)
	setObjectCamera('gf', 'hud')
	setTextFont('scoreTxt', 'ourpleFont.ttf')
	setTextFont('timeTxt', 'ourpleFont.ttf')
	setTextFont('watermark', 'ourpleFont.ttf')

	makeLuaSprite('extraCharBG', 'bgs/ourple/extraCharBG', mobileFix("X", 100), 60)
	setObjectCamera('extraCharBG', 'hud')
	scaleObject('extraCharBG', 0.95, 0.95)
	setScrollFactor('extraCharBG', 1, 1)
	addLuaSprite('extraCharBG', false)
	
	makeAnimatedLuaSprite('aileen', 'characters/aileenOurple', 280, 160)
	addAnimationByPrefix('aileen', 'idle', 'aileen idle0', 24, false)
	setScrollFactor('aileen', 1, 1)
	addLuaSprite('aileen', false)
	
	setProperty('extraCharBG.x', mobileFix("X", getProperty('extraCharBG.x') + 500))
	setProperty('gf.x', mobileFix("X", getProperty('boyfriend.x') + 500))
	
	mainY = getProperty('iconP1.y')
end

function onUpdatePost()	
    if curBeat == 0 then
		for i = 8, 11 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
        end
    end
	if curStep == 390 then
		for i = 8, 11 do
		    y = getPropertyFromGroup("strumLineNotes", i, "y")
			noteTweenAlpha('noteTweenAlpha'..i, i, 1, (0.5 + ((i - 7) * 0.2)) / playbackRate, 'cubeInOut')
		    noteTweenY('noteTweenY'..i, i, y + (downscroll and 20 or -20), (0.5 + ((i - 7) * 0.2)) / playbackRate, 'cubeInOut')
		end
		
	end
	
	setObjectOrder('gf', getObjectOrder('extraCharBG') + 1)
	setObjectCamera('gf', 'hud')
		
	for i = 0, getProperty('opponentStrums.length')-1 do
		if getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing' then
			setPropertyFromGroup('notes', i, 'texture', 'notes/ourpleNOTE_assets');
		end
	end
	
	for i = 0, getProperty('playerStrums.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/ourpleNOTE_assets');
			
			if getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Inwards' then
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Inwards/ourpleNoteSplashesInwards');
			elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Diamonds' then
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Diamonds/ourpleNoteSplashesDiamond');
			elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Sparkles' then
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Sparkles/ourpleNoteSplashesSparkle');
			elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Outwards' then
				setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Normal/ourpleNoteSplashes');
			end
		end
	end
	
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 300) * (bpm / 160)
	x = getProperty('iconP1.x')
	y = getProperty('iconP1.y')
	
	if (isMayhemMode and getProperty('health') <= 30) or (not isMayhemMode and getProperty('health') <= .399) then
		setProperty('iconP1.flipX', false)
		if curStep >= 0 then
			for i = 0,10 do
				setProperty('iconP1.x', x + getRandomFloat(-shake, shake) + math.sin((currentBeat + i*0.75) * math.pi))
				setProperty('iconP1.y', y + getRandomFloat(-shake, shake) + math.sin((currentBeat + i*0.75) * math.pi))
			end    	
		end
	else
		setProperty('iconP1.y', mainY)
		if curBeat % 2 == 0 then
			setProperty('iconP1.flipX', true)
		end
		if curBeat % 2 == 1 then
			setProperty('iconP1.flipX', false)
		end
	end
end

function onBeatHit()
	if (curBeat >= 16 and curBeat <= 64) or (curBeat >= 68 and curBeat <= 148) then
		triggerEvent('Add Camera Zoom', 0.07, 0.055)
	end
end

function onUpdate(elapsed)
	if curBeat % 2 == 1 then
		objectPlayAnimation('aileen', 'idle', true)
	end
	if curBeat == 16 then
		cameraFlash('game', 'ffffff', 0.7 / playbackRate, false)
	end
	if curBeat == 64 then
		setProperty('camHUD.alpha', 0)
	end
	if curStep == 268 then
		doTweenAlpha('camHUD', 'camHUD', 1, 0.6 / playbackRate, 'cubeOut')
	end
	if curBeat >= 64 and curBeat < 68 then
		setShaderFloat('camShader', 'iTime', os.clock() * 2)
		setProperty('camZooming', false)
		if curStep >= 256 and curStep < 260 then
			if shadersEnabled then
				setSpriteShader('camShader', "ChromaticShift")
				
				runHaxeCode([[
					trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
					FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
				]])
			end
			triggerEvent('Play Animation', 'jumpscare', 'bf')
			setProperty('camGame.zoom', 1.2 * zoomMult)
		end
		if curStep == 261 then
			if shadersEnabled then
				runHaxeCode([[
					FlxG.game.setFilters([]);
				]])
			end
			triggerEvent('Play Animation', 'danceLeft', 'bf')
			setProperty('camGame.zoom', 0.9 * zoomMult)	
		end
		if curStep == 262 then
			if shadersEnabled then
				setSpriteShader('camShader', "ChromaticShift")
				
				runHaxeCode([[
					trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
					FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
				]])
			end
			triggerEvent('Play Animation', 'jumpscare', 'bf')
			setProperty('camGame.zoom', 1.2 * zoomMult)
		end
		if curDecBeat == 65.7 then
			if shadersEnabled then
				runHaxeCode([[
					FlxG.game.setFilters([]);
				]])
			end
			triggerEvent('Play Animation', 'danceLeft', 'bf')
			setProperty('camGame.zoom', 0.9 * zoomMult)	
		end
		if curStep == 263 then
			if shadersEnabled then
				setSpriteShader('camShader', "ChromaticShift")
				
				runHaxeCode([[
					trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
					FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
				]])
			end
			triggerEvent('Play Animation', 'jumpscare', 'bf')
			setProperty('camGame.zoom', 1.2 * zoomMult)
		end
		if curBeat == 66 then
			if shadersEnabled then
				runHaxeCode([[
					FlxG.game.setFilters([]);
				]])
			end
			triggerEvent('Play Animation', 'danceLeft', 'bf')
			setProperty('camGame.zoom', 0.9 * zoomMult)	
		end
		if curStep == 265 then
			if shadersEnabled then
				setSpriteShader('camShader', "ChromaticShift")
				
				runHaxeCode([[
					trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
					FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
				]])
			end
			triggerEvent('Play Animation', 'jumpscare', 'bf')
			setProperty('camGame.zoom', 1.2 * zoomMult)
		end
		if curDecBeat == 66.5 then
			if shadersEnabled then
				runHaxeCode([[
					FlxG.game.setFilters([]);
				]])
			end
			triggerEvent('Play Animation', 'danceLeft', 'bf')
			setProperty('camGame.zoom', 0.9 * zoomMult)	
		end
		if curStep == 267 then
			if shadersEnabled then
				setSpriteShader('camShader', "ChromaticShift")
				
				runHaxeCode([[
					trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
					FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
				]])
			end
			triggerEvent('Play Animation', 'jumpscare', 'bf')
			setProperty('camGame.zoom', 1.2 * zoomMult)
		end
		if curStep == 268 then
			runTimer('bye', 0.02)
		end
	end
	if curBeat == 68 then
		if shadersEnabled then
			runHaxeCode([[
				FlxG.game.setFilters([]);
			]])
		end
		removeLuaSprite('camShader', true)
		cancelTimer('hello')
		cancelTimer('bye')
		setProperty('camZooming', true)
		setProperty('camGame.zoom', 0.9 / playbackRate)
	end
	if curStep >= 390 and curStep < 400 then
		if curBeat % 2 == 0 then
			triggerEvent('Play Animation', 'call', 'bf')
		end
	end
	if curStep == 420 then
		doTweenX('extraCharBG', 'extraCharBG', screenWidth - 1180, 0.7 / playbackRate, 'circOut')
		doTweenX('gfMove', 'gf', screenWidth - 480, 0.7, 'circOut')
	end
	if curStep == 459 then
		doTweenX('gfMovePG', 'gf', screenWidth + 120, 0.7 / playbackRate, 'cubeInOut')
	end
	if curStep == 528 then
		doTweenX('gfMoveMP', 'gf', screenWidth + 120, 2.2 / playbackRate, 'cubeInOut')
	end
	if curStep == 557 then
		doTweenX('gfMovePG', 'gf', screenWidth + 120, 1.7 / playbackRate, 'cubeInOut')
	end
	if curStep == 592 then
		cameraFlash('hud', 'ffffff', 0.7 / playbackRate, false)
		doTweenX('gfMoveEnd', 'gf', screenWidth + 120, 2.5 / playbackRate, 'cubeInOut')
		doTweenX('extraCharBG', 'extraCharBG', screenWidth - 680, 2.5 / playbackRate, 'cubeInOut')
	end
end

function onTimerCompleted(tag)
	if tag == 'hello' then
		if shadersEnabled then
			setSpriteShader('camShader', "ChromaticShift")
				
			runHaxeCode([[
				trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
				FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
			]])
		end
		triggerEvent('Play Animation', 'jumpscare', 'bf')
		setProperty('camGame.zoom', 1.2 * zoomMult)
		runTimer('bye', 0.04)
	end
	if tag == 'bye' then
		if shadersEnabled then
			runHaxeCode([[
				FlxG.game.setFilters([]);
			]])
		end
		triggerEvent('Play Animation', 'danceLeft', 'bf')
		setProperty('camGame.zoom', 0.9 * zoomMult)
		runTimer('hello', 0.04)
	end
end

function onTweenCompleted(tag)
	if tag == 'gfMovePG' then
		triggerEvent('Change Character', 'gf', 'matpat')
		setProperty('gf.x', screenWidth + 120)
		doTweenX('gfMove', 'gf', screenWidth - 430, 0.7 / playbackRate, 'circOut')
	end
	if tag == 'gfMoveMP' then
		triggerEvent('Change Character', 'gf', 'phoneGuy')
		setProperty('gf.x', screenWidth + 120)
		doTweenX('gfMove', 'gf', screenWidth - 430, 0.7 / playbackRate, 'circOut')
	end
	if tag == 'ourpleEnd' then
		triggerEvent('Play Animation', 'idle', 'bf')
	end
end