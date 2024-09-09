function onCreate()
	makeLuaSprite('blackBG', '', -800, -600)
	makeGraphic('blackBG', 5000, 5000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	addLuaSprite('blackBG', true)
		
	precacheSound('cracking')	
	addCharacterToList('DVTurn', 'dad')
	addCharacterToList('DV', 'dad')
	addCharacterToList('DV Phase 2', 'dad')
	addCharacterToList('PicoFNVP2', 'boyfriend')
end

function onCreatePost()
	if not isMayhemMode and mechanics then
		setProperty('bar.alpha', 0)
		setProperty('barBack.alpha', 0)
		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)
	elseif isMayhemMode then
		setProperty('bar.alpha', 0)
		setProperty('barBack.alpha', 0)
		setProperty('healthBar.alpha', 0)
		setProperty('healthBarBG.alpha', 0)
		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)
	else
		setProperty('healthBar.alpha', 0)
		setProperty('healthBarBG.alpha', 0)
		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)
	end
	setProperty('scoreTxt.alpha', 0)
	setProperty('watermark.alpha', 0)
	setProperty('watermark2.alpha', 0)
end

function onSongStart() --set your time stuff ig
    runHaxeCode([[
        game.songLength = (245 * 1000);
    ]])
end

function onUpdatePost()
	if curBeat <= 16 then
		for i = 0, 3 do
			setPropertyFromGroup('playerStrums', i, 'alpha', 0)
		end
	end
end

local hudThings = {'bar', 'barBack', 'iconP1', 'iconP2', 'watermark', 'watermark2', 'scoreTxt', 'healthBar', 'mayhembackBar', 'charmSocket'}
local soundPlayed = false
function onUpdate()
	if curBeat == 16 then
		doTweenAlpha('fadeOut', 'blackBG', 0, 10 / playbackRate, 'cubeInOut')
		if mechanics then
			doTweenAlpha('bar', 'bar', 1, 1.6, 'circOut')
			doTweenAlpha('barBack', 'barBack', 1, 1.6, 'circOut')
			doTweenAlpha('healthBar', 'healthBar', 1, 1.6, 'circOut')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.6, 'circOut')
			if not isMayhemMode then
				doTweenAlpha('mayhembackBar', 'mayhembackBar', 1, 1.6, 'circOut')
			end
		else
			doTweenAlpha('healthBar', 'healthBar', 1, 1.6, 'circOut')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.6, 'circOut')
		end
		doTweenAlpha('iconP1', 'iconP1', 1, 1.6, 'circOut')
		doTweenAlpha('iconP2', 'iconP2', 1, 1.6, 'circOut')
		noteTweenAlpha('noteTween1', 4, 1, 1.6, 'circOut')
	end
	if curBeat == 20 then
		doTweenAlpha('watermark', 'watermark', 1, 1.6, 'circOut')
		noteTweenAlpha('noteTween2', 5, 1, 1.6, 'circOut')
	end
	if curBeat == 24 then
		doTweenAlpha('watermark2', 'watermark2', 1, 1.6, 'circOut')
		noteTweenAlpha('noteTween3', 6, 1, 1.6, 'circOut')
	end
	if curBeat == 28 then
		doTweenAlpha('scoreTxt', 'scoreTxt', 1, 1.6, 'circOut')
		noteTweenAlpha('noteTween4', 7, 1, 1.6, 'circOut')
	end
	if curBeat == 32 then
		cameraFlash('game', 'FFFFFF', 0.8, false)
	end
	if curStep == 641 and soundPlayed == false then
		setProperty('defaultCamZoom', 1.4)
		runTimer('soundOn', 0.01)
		soundPlayed = true
		doTweenAlpha('fadeOut', 'blackBG', 1, 0.6 / playbackRate, 'circOut')
	end
	if curBeat == 164 then
		triggerEvent('Change Character', 'dad', 'DV')
		triggerEvent('Change Character', 'bf', 'PicoFNVP2')
		for i = 1, #(hudThings) do
			doTweenAlpha(hudThings[i], hudThings[i], 0, 1.1 / playbackRate, 'circOut')
		end
		if not mechanics then
			doTweenAlpha('healthBar', 'healthBar', 0, 1.1 / playbackRate, 'circOut')
			doTweenAlpha('healthBarBG', 'healthBarBG', 0, 1.1 / playbackRate, 'circOut')
		end
		for i = 4, 7 do
			noteTweenAlpha('noteTween'..i, i, 0, 1.1 / playbackRate, 'circOut')
		end
	end
	if curBeat == 172 then
		for i = 1, #(hudThings) do
			doTweenAlpha(hudThings[i], hudThings[i], 1, 1.1 / playbackRate, 'cubeInOut')
		end
		if not mechanics then
			doTweenAlpha('healthBar', 'healthBar', 1, 1.1 / playbackRate, 'circOut')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.1 / playbackRate, 'circOut')
		end
		for i = 4, 7 do
			noteTweenAlpha('noteTween'..i, i, 1, 1.1 / playbackRate, 'cubeInOut')
		end
	end
	if curBeat == 176 then
		setProperty('blackBG.alpha', 0)
		cameraFlash('game', 'FFFFFF', 0.8, false)
	end
	if curBeat == 382 then
		doTweenZoom('gamegoWOOO', 'camGame', 1.2, 0.8 / playbackRate, 'elasticIn')
		addHaxeLibrary('flixel.FlxG')
        addHaxeLibrary('flixel.system.FlxSound')
		runHaxeCode([[
            FlxTween.tween(game, {songLength: FlxG.sound.music.length}, 5, {ease: FlxEase.expoInOut})
        ]])
	end
	if curBeat == 384 then
		removeLuaSprite('bg', false)
		triggerEvent('Change Character', 'dad', 'DV Phase 2')
		
		cameraFlash('game', 'FFFFFF', 0.8, false)
		removeLuaSprite('blackBG', false)
		
		doTweenAlpha('scoreTxt', 'scoreTxt', 1, 0.2, 'linear')
		doTweenAlpha('watermark', 'watermark', 1, 0.2, 'linear')
		doTweenAlpha('watermark2', 'watermark2', 1, 0.2, 'linear')
		if mechanics then
			doTweenAlpha('bar', 'bar', 1, 0.2, 'linear')
			doTweenAlpha('barBack', 'barBack', 1, 0.2, 'linear')
			doTweenAlpha('healthBar', 'healthBar', 1, 0.2, 'linear')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 0.2, 'linear')
			doTweenAlpha('iconP1', 'iconP1', 1, 0.2, 'linear')
			doTweenAlpha('iconP2', 'iconP2', 1, 0.2, 'linear')
		else
			doTweenAlpha('healthBar', 'healthBar', 1, 0.2, 'linear')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 0.2, 'linear')
			doTweenAlpha('iconP1', 'iconP1', 1, 0.2, 'linear')
			doTweenAlpha('iconP2', 'iconP2', 1, 0.2, 'linear')
		end
		setProperty('boyfriend.visible', false)
	end
	if curBeat == 512 then
		cameraFlash('game', 'FFFFFF', 0.8, false)
		addLuaSprite('bg')
		
		addLuaSprite('blackBG')
		setProperty('blackBG.alpha', 0)
		
		triggerEvent('Change Character', 'dad', 'DV')
		setProperty('boyfriend.visible', true)
	end
	if curBeat == 720 then
		cameraFlash('game', 'FFFFFF', 0.8, false)
		cameraFade('hud', '000000', 3, false)
	end
end

function onTimerCompleted(tag)
	if tag == 'soundOn' then
		playSound('cracking')
	end
end