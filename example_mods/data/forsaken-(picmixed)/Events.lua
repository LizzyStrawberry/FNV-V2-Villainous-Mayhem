local context = "During the Cassette Girl Banning, the team decided to scrap CG from this song, and Pico took her place instead. It was bound to happen until the ban ended up being lifted, meaning CG could return back, though the coder didn't want to let any stuff the team made go to waste, so he placed this song in this category. You're free to skip this honestly."

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
	
	makeLuaText('contextText', 'Context:\n'..context, 900, 185, 480)
	setTextAlignment('contextText', 'Center')
	setProperty('contextText.alpha', 0)
	setTextSize('contextText', 20)
	addLuaText('contextText')
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
	setProperty('iconP1.alpha', 0)
	setProperty('iconP2.alpha', 0)
	setProperty('scoreTxt.alpha', 0)
	setProperty('watermark.alpha', 0)
	setProperty('watermark2.alpha', 0)
end

function onSongStart()
	doTweenAlpha('contextAppear', 'contextText', 1, 1 / playbackRate, 'cubeInOut')
end

function onUpdatePost()
	if curStep == 0 then
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
	end
	if curBeat == 20 then
		doTweenAlpha('watermark', 'watermark', 1, 1.6, 'circOut')
	end
	if curBeat == 24 then
		doTweenAlpha('watermark2', 'watermark2', 1, 1.6, 'circOut')
	end
	if curBeat == 28 then
		doTweenAlpha('scoreTxt', 'scoreTxt', 1, 1.6, 'circOut')
	end
	if curBeat == 32 then
		noteTweenAlpha('noteTween1', 4, 1, 1.6, 'circOut')
	end
	if curBeat == 36 then
		noteTweenAlpha('noteTween2', 5, 1, 1.6, 'circOut')
	end
	if curBeat == 40 then
		noteTweenAlpha('noteTween3', 6, 1, 1.6, 'circOut')
	end
	if curBeat == 44 then
		noteTweenAlpha('noteTween1', 7, 1, 1.6, 'circOut')
	end
	if curBeat == 48 then
		cameraFlash('game', 'FFFFFF', 0.8, false)
	end
	if curStep == 455 and soundPlayed == false then
		runTimer('soundOn', 0.01)
		soundPlayed = true
	end
	if curBeat == 112 then
		setProperty("defaultCamZoom", 0.6)
	end
	if curBeat == 114 then
		doTweenZoom('gamegoWOOO', 'camGame', 1.1, 7 / playbackRate, 'cubeIn')
		triggerEvent('Play Animation', 'transform', 'dad')
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
	if curBeat == 115 then
		triggerEvent('Play Animation', 'react', 'boyfriend')
	end
	if curBeat == 126 then
		doTweenAlpha('fadeOut', 'blackBG', 1, 0.6 / playbackRate, 'circOut')
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
	if curBeat == 128 then
		setProperty('blackBG.alpha', 0)
		triggerEvent('Change Character', 'dad', 'DVTurn')
		triggerEvent('Change Character', 'bf', 'PicoFNVP2')
		cameraFlash('game', 'FFFFFF', 0.8, false)
	end
	if curBeat == 272 then
		setProperty("defaultCamZoom", 0.6)
		doTweenZoom('gamegoWOOO', 'camGame', 1.2, 20 / playbackRate, 'cubeIn')
	end
	if curStep == 1216 then
		addHaxeLibrary('flixel.FlxG')
        addHaxeLibrary('flixel.system.FlxSound')
		runHaxeCode([[
            FlxTween.tween(game, {songLength: FlxG.sound.music.length}, 5, {ease: FlxEase.expoInOut})
        ]])
		doTweenAlpha('fadeIn', 'blackBG', 1, 0.2, 'linear')
		
		doTweenAlpha('scoreTxt', 'scoreTxt', 0, 0.2, 'linear')
		doTweenAlpha('watermark', 'watermark', 0, 0.2, 'linear')
		doTweenAlpha('watermark2', 'watermark2', 0, 0.2, 'linear')
		if mechanics then
			doTweenAlpha('bar', 'bar', 0, 0.2, 'linear')
			doTweenAlpha('barBack', 'barBack', 0, 0.2, 'linear')
			doTweenAlpha('healthBar', 'healthBar', 0, 0.2, 'linear')
			doTweenAlpha('healthBarBG', 'healthBarBG', 0, 0.2, 'linear')
			doTweenAlpha('iconP1', 'iconP1', 0, 0.2, 'linear')
			doTweenAlpha('iconP2', 'iconP2', 0, 0.2, 'linear')
		else
			doTweenAlpha('healthBar', 'healthBar', 0, 0.2, 'linear')
			doTweenAlpha('healthBarBG', 'healthBarBG', 0, 0.2, 'linear')
			doTweenAlpha('iconP1', 'iconP1', 0, 0.2, 'linear')
			doTweenAlpha('iconP2', 'iconP2', 0, 0.2, 'linear')
		end
	end
	if curBeat == 307 then
		removeLuaSprite('bg', false)
		triggerEvent('Change Character', 'dad', 'DV Phase 2')
		
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
	if curBeat == 308 then
		cameraFlash('game', 'FFFFFF', 0.8, false)
		
		removeLuaSprite('blackBG', false)

		if getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
			removeLuaSprite('trampoline', false)
		end
	end
	if curBeat == 404 then
		cameraFlash('game', 'FFFFFF', 0.8, false)
		addLuaSprite('bg')
		
		addLuaSprite('blackBG')
		setProperty('blackBG.alpha', 0)
		
		if getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
			addLuaSprite('trampoline')
		end
		
		triggerEvent('Change Character', 'dad', 'DV')
		setProperty('boyfriend.visible', true)
	end
	if curBeat == 436 then
		cameraFade('hud', '000000', 1, false)
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