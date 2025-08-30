local context = "Our coder wanted to make a cover of this song with this Pico chromatic cuz he found the chromatic to be really good. That's all lmfao\n(There are minor differences worth checking out here tho!)"

function onCreate()
	makeLuaSprite('blackBG', '', -800, -600)
	makeGraphic('blackBG', 5000, 5000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	addLuaSprite('blackBG', true)
	
	makeLuaSprite('cutBG', 'bgs/DV/cutBG', screenWidth + 25, 350)
	setScrollFactor('cutBG', 0, 0)
	setObjectCamera('cutBG', 'hud')
	scaleObject("cutBG", 0.5, 0.5)
	addLuaSprite('cutBG', true)
	
	makeLuaText('contextText', 'Context:\n'..context, 900, mobileFix("X", 185), 480)
	setTextAlignment('contextText', 'Center')
	setProperty('contextText.alpha', 0)
	setTextSize('contextText', 20)
	addLuaText('contextText')
		
	precacheSound('cracking')	
	addCharacterToList('DVTurn', 'dad')
	addCharacterToList('DV', 'dad')
	addCharacterToList('DV Phase 2', 'dad')
	
	addCharacterToList('PicoFNVP2', 'boyfriend')
	addCharacterToList('PicoFNVP3', 'boyfriend')
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
	
	setObjectOrder("cutBG", getObjectOrder("iconP1") + 1)
end

function onSongStart()
	doTweenAlpha('contextAppear', 'contextText', 1, 1 / playbackRate, 'cubeInOut')
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
			doTweenAlpha('bar', 'bar', 1, 1.6 / playbackRate, 'circOut')
			doTweenAlpha('barBack', 'barBack', 1, 1.6 / playbackRate, 'circOut')
			doTweenAlpha('healthBar', 'healthBar', 1, 1.6 / playbackRate, 'circOut')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.6 / playbackRate, 'circOut')
			if not isMayhemMode then
				doTweenAlpha('mayhembackBar', 'mayhembackBar', 1, 1.6 / playbackRate, 'circOut')
			end
		else
			doTweenAlpha('healthBar', 'healthBar', 1, 1.6 / playbackRate, 'circOut')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.6 / playbackRate, 'circOut')
		end
		doTweenAlpha('iconP1', 'iconP1', 1, 1.6 / playbackRate, 'circOut')
		doTweenAlpha('iconP2', 'iconP2', 1, 1.6 / playbackRate, 'circOut')
		noteTweenAlpha('noteTween1', 4, 1, 1.6 / playbackRate, 'circOut')
	end
	if curBeat == 20 then
		doTweenAlpha('watermark', 'watermark', 1, 1.6 / playbackRate, 'circOut')
		noteTweenAlpha('noteTween2', 5, 1, 1.6 / playbackRate, 'circOut')
	end
	if curBeat == 24 then
		noteTweenAlpha('noteTween3', 6, 1, 1.6 / playbackRate, 'circOut')
	end
	if curBeat == 28 then
		doTweenAlpha('scoreTxt', 'scoreTxt', 1, 1.6 / playbackRate, 'circOut')
		noteTweenAlpha('noteTween4', 7, 1, 1.6 / playbackRate, 'circOut')
	end
	if curBeat == 32 then
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
	end
	if curStep == 641 and soundPlayed == false then
		setProperty('defaultCamZoom', 1.4 * zoomMult)
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
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
	end
	if curBeat == 382 then
		doTweenZoom('gamegoWOOO', 'camGame', 1.2, 0.8 / playbackRate, 'elasticIn')
		addHaxeLibrary('flixel.FlxG')
        addHaxeLibrary('flixel.sound.FlxSound')
		runHaxeCode([[
            FlxTween.tween(game, {songLength: FlxG.sound.music.length}, 5, {ease: FlxEase.expoInOut})
        ]])
	end
	if curBeat == 384 then
		removeLuaSprite('bg', false)
		triggerEvent('Change Character', 'dad', 'DV Phase 2')
		triggerEvent('Change Character', 'bf', 'PicoFNVP3')
		setObjectCamera("boyfriend", 'hud')
		setProperty("boyfriend.x", screenWidth)
		setObjectOrder("boyfriend", getObjectOrder("cutBG") + 1)
		
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
		removeLuaSprite('blackBG', false)
		
		doTweenAlpha('scoreTxt', 'scoreTxt', 1, 0.2 / playbackRate, 'linear')
		doTweenAlpha('watermark', 'watermark', 1, 0.2 / playbackRate, 'linear')
		doTweenAlpha('watermark2', 'watermark2', 1, 0.2 / playbackRate, 'linear')
		if mechanics then
			doTweenAlpha('bar', 'bar', 1, 0.2 / playbackRate, 'linear')
			doTweenAlpha('barBack', 'barBack', 1, 0.2 / playbackRate, 'linear')
			doTweenAlpha('healthBar', 'healthBar', 1, 0.2 / playbackRate, 'linear')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 0.2 / playbackRate, 'linear')
			doTweenAlpha('iconP1', 'iconP1', 1, 0.2 / playbackRate, 'linear')
			doTweenAlpha('iconP2', 'iconP2', 1, 0.2 / playbackRate, 'linear')
		else
			doTweenAlpha('healthBar', 'healthBar', 1, 0.2 / playbackRate, 'linear')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 0.2 / playbackRate, 'linear')
			doTweenAlpha('iconP1', 'iconP1', 1, 0.2 / playbackRate, 'linear')
			doTweenAlpha('iconP2', 'iconP2', 1, 0.2 / playbackRate, 'linear')
		end
	end
	if curBeat >= 384 and curBeat < 464 then -- Stop before duet
		if curBeat % 32 == 13 then
			doTweenX("boyfriendOnScreen", "boyfriend", screenWidth - 420, 0.75 / playbackRate, "cubeInOut")
			doTweenX("bgOnScreen", "cutBG", (screenWidth - 420) + 25, 0.75 / playbackRate, "cubeInOut")
		end
		if curBeat % 32 == 31 then
			doTweenX("boyfriendOffScreen", "boyfriend", screenWidth, 1.25 / playbackRate, "cubeInOut")
			doTweenX("bgOnScreen", "cutBG", screenWidth + 25, 1.25 / playbackRate, "cubeInOut")
		end
	end
	if curBeat == 512 then
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
		addLuaSprite('bg')
		
		addLuaSprite('blackBG')
		setProperty('blackBG.alpha', 0)
		
		triggerEvent('Change Character', 'dad', 'DV')
		triggerEvent('Change Character', 'bf', 'PicoFNVP2')
		setObjectCamera("boyfriend", 'game')
		setProperty("boyfriend.x", 890)
		setObjectOrder("boyfriend", -1)
		
		removeLuaSprite("cutBG", true)
	end
	if curBeat == 640 then
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
		triggerEvent('Change Character', 'bf', 'PicoFNVP3')
		setObjectCamera("boyfriend", 'game')
		setProperty("boyfriend.x", 850)
		setObjectOrder("boyfriend", -1)
	end
	if curBeat == 720 then
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
		cameraFade('hud', '000000', 3 / playbackRate, false)
	end
end

function onTimerCompleted(tag)
	if tag == 'soundOn' then
		playSound('cracking')
	end
	if tag == "showContext" then
		doTweenAlpha('contextBye', 'contextText', 0, 1 / playbackRate, 'cubeInOut')
	end
end

function onTweenCompleted(tag)
	if tag == "contextAppear" then
		runTimer("showContext", 7 / playbackRate)
	end
end