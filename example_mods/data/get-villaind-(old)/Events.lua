local shadersUsed = false
local character = 0
function onCreate()
	addCharacterToList('lulababegf', 'boyfriend')
	addCharacterToList('MorkyHypnoAgain', 'dad')
	addCharacterToList('MorkyHypno', 'dad')
	addCharacterToList('MorkyEgg', 'dad')
	addCharacterToList('MorkyMoist', 'dad')
	addCharacterToList('MorkyHank', 'dad')
	if boyfriendName == 'GFwav' then
		character = 1
	elseif boyfriendName == 'playablegf-old' then
		character = 2
	elseif boyfriendName == 'd-side gf' then
		character = 3
	elseif boyfriendName == 'debugGF' then
		character = 4
	elseif boyfriendName == 'Spendthrift GF' then
		character = 5
	end
	
	precacheSound('hypnoGoBrrrrrr')
	precacheSound('goldJumpscare')
	
	hBarY = getProperty('healthBar')
	hBarBGY = getProperty('healthBarBG')
	
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', '')
end

function onCreatePost()
	makeLuaText('MorkyText', " ", 1000, mobileFix("X", 120), 520)
	setTextSize('MorkyText', 35)
	setObjectCamera('MorkyText', 'game')
	setScrollFactor('MorkyText', 0, 0)
	setProperty('MorkyText.alpha', 1)
	addLuaText('MorkyText')
	
	makeAnimatedLuaSprite('static', 'effects/StaticHypno', mobileFix("X", -96), -65)
	addAnimationByPrefix('static', 'fuck you', 'StaticHypno0', 24, false)
	setProperty('static.alpha', 0)
	scaleObject('static', 0.6, 0.6)
	setObjectCamera('static', 'other')
	setScrollFactor('static', 1, 1)
	addLuaSprite('static', true)
	
	makeAnimatedLuaSprite('fakespace', 'effects/Extras', mobileFix("X", 530), 390)
	addAnimationByPrefix('fakespace', 'troll', 'Spacebar0', 24, false)
	setProperty('fakespace.alpha', 0)
	setObjectCamera('fakespace', 'hud')
	setScrollFactor('fakespace', 1, 1)
	addLuaSprite('fakespace', true)
	
	makeAnimatedLuaSprite('Pendelum', 'effects/Pendelum_Phase2', mobileFix("X", 550), -500)
	addAnimationByPrefix('Pendelum', 'weeeeeeeee', 'Pendelum Phase 20', 24, false)
	setProperty('Pendelum.alpha', 1)
	scaleObject('Pendelum', 1.4, 1.4)
	setObjectCamera('Pendelum', 'hud')
	setScrollFactor('Pendelum', 1, 1)
	addLuaSprite('Pendelum', true)
	
	makeLuaSprite('trollchrome', 'effects/trollchrome', 0, 0)
	setProperty('trollchrome.alpha', 0)
	setObjectCamera('trollchrome', 'hud')
	setGraphicSize("trollchrome", screenWidth, screenHeight)
	addLuaSprite('trollchrome', true)
	
	makeLuaSprite('morkyJumpscare', 'effects/morkyJumpscare', 0, 0)
	setProperty('morkyJumpscare.alpha', 0)
	setObjectCamera('morkyJumpscare', 'hud')
	setGraphicSize("morkyJumpscare", screenWidth, screenHeight)
	addLuaSprite('morkyJumpscare', true)
	
	if not botPlay then
		makeLuaText('botPlayFake', "BOTPLAY", 1000, mobileFix("X", 140), 120)
		setTextSize('botPlayFake', 35)
		setObjectCamera('botPlayFake', 'hud')
		setScrollFactor('botPlayFake', 0, 0)
		setProperty('botPlayFake.alpha', 0)
		addLuaText('botPlayFake')
	end
end

function onSongStart() --set your time stuff ig
    runHaxeCode([[
        game.songLength = (184 * 1000);
    ]])
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and difficulty == 1 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getProperty('health') > 0.2 then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.004);
				else
					setProperty('health', health- 0.008);
				end
			end
		end
	if curBeat >= 576 and curBeat <= 608 then
		cameraShake('game', 0.02, 0.2)
		cameraShake('hud', 0.02, 0.2)
	end
end

function onUpdate()
	if curStep == 1024 then
		setProperty('morkyJumpscare.alpha', 1)
		playSound('goldJumpscare', 0.35)
	end
	if curStep >= 1406 and curStep < 1536 then
		if curStep % 2 == 0 then
			objectPlayAnimation('static', 'fuck you', true)	
		end
		if curBeat % 8 == 0 then
			doTweenX('bfw i d e', 'boyfriend.scale', 2.1, 1.4 / playbackRate / playbackRate, 'linear')
			doTweenX('dadw i d e', 'dad.scale', 1, 1.4 / playbackRate / playbackRate, 'linear')
			doTweenAngle('hudGoWeeee', 'camHUD', 5, 2.5 / playbackRate / playbackRate, 'cubeOut')
		end
		if curBeat % 8 == 4 then
			doTweenX('bfw i d e', 'boyfriend.scale', 1, 1.4 / playbackRate / playbackRate, 'linear')
			doTweenX('dadw i d e', 'dad.scale', 2.1, 1.4 / playbackRate / playbackRate, 'linear')
			doTweenAngle('hudGoWeeee', 'camHUD', -5, 2.5 / playbackRate / playbackRate, 'cubeOut')
		end
		if curBeat % 4 == 0 then
			doTweenAlpha('helloHypno', 'static', 1, 0.4 / playbackRate / playbackRate, 'cubeInOut')
		end
		if curBeat % 4 == 2 then
			doTweenAlpha('helloHypno', 'static', 0.3, 0.4 / playbackRate / playbackRate, 'cubeInOut')
		end
		if curStep % 6 == 0 then
			playSound('hypnoGoBrrrrrr', 0.25)
		end
	end
	if curStep >= 1536 and curStep < 1664 then
		if curStep % 2 == 0 then
			objectPlayAnimation('static', 'fuck you', true)	
		end
		if curBeat % 8 == 0 then
			doTweenX('bfw i d e', 'boyfriend.scale', 2.1, 1.4 / playbackRate / playbackRate, 'linear')
			doTweenX('dadw i d e', 'dad.scale', 1, 1.4 / playbackRate / playbackRate, 'linear')
			doTweenAngle('hudGoWeeee', 'camHUD', 45, 2.5 / playbackRate / playbackRate, 'cubeOut')
		end
		if curBeat % 8 == 4 then
			doTweenX('bfw i d e', 'boyfriend.scale', 1, 1.4 / playbackRate, 'linear')
			doTweenX('dadw i d e', 'dad.scale', 2.1, 1.4 / playbackRate, 'linear')
			doTweenAngle('hudGoWeeee', 'camHUD', -45, 2.5 / playbackRate, 'cubeOut')
		end
		if curBeat % 4 == 0 then
			doTweenAlpha('helloHypno', 'static', 1, 0.4 / playbackRate, 'cubeInOut')
		end
		if curBeat % 4 == 2 then
			doTweenAlpha('helloHypno', 'static', 0.3, 0.4 / playbackRate, 'cubeInOut')
		end
		if curStep % 6 == 0 then
			playSound('hypnoGoBrrrrrr', 0.25)
		end
	end
end

function onBeatHit()
	if curBeat >= 512 and curBeat <= 672 then
		if not botPlay then
			if curBeat % 8 == 0 then
				doTweenAlpha('FakeBotplay', 'botPlayFake', 1, 0.7 / playbackRate, 'easeIn')
			end
			if curBeat % 8 == 4 then
				doTweenAlpha('FakeBotplay', 'botPlayFake', 0, 0.7 / playbackRate, 'easeIn')
			end
		end
	end
	
	if curBeat == 498 then
		doTweenAlpha('hudgobye', 'camHUD', 0, 0.5, 'linear')
		addHaxeLibrary('flixel.FlxG')
        addHaxeLibrary('flixel.sound.FlxSound')
		runHaxeCode([[
            FlxTween.tween(game, {songLength: FlxG.sound.music.length}, 5, {ease: FlxEase.expoInOut})
        ]])
	end
	if curBeat == 500 then
		doTweenAlpha('MorkyText', 'MorkyText', 1, 0.07 / playbackRate, 'cubeIn')
		setProperty('defaultCamZoom', 1.4)
		setTextString('MorkyText', "Mor")
	end
	if curBeat == 501 then
		setTextString('MorkyText', "Morky!")
	end
	if curBeat == 502 then
		setTextString('MorkyText', "Mor")
	end
	if curBeat == 503 then
		setTextString('MorkyText', "Morky")
	end
	if curStep == 2015 then
		setTextString('MorkyText', "Morkyyyy")
	end
	if curStep == 2019 then
		setTextString('MorkyText', "roM")
	end
	if curBeat == 505 then
		setTextString('MorkyText', "roMkyyyyyyyy")
		runTimer('MorkyGlitching', 0.01)
	end
	if curBeat == 509 then
		setTextString('MorkyText', "eeeeeeeeeeee")
	end
	if curBeat == 510 then
		cameraShake('game', 0.05, 0.60)
		setTextString('MorkyText', "roMkyyyyyyyy")
		runTimer('MorkyGlitching', 0.01)
	end
	if curBeat == 512 then
		cameraFlash('game', 'FFFFFF', 1.7 / playbackRate, false)
		doTweenAlpha('hudgoHello', 'camHUD', 1, 0.5 / playbackRate, 'linear')
		doTweenAlpha('MorkyText', 'MorkyText', 0, 0.07 / playbackRate, 'cubeIn')
		
		setProperty('defaultCamZoom', 0.9)
	end
	if curBeat >= 512 and curBeat <= 672 then
		if not botPlay then
			if curBeat % 8 == 0 then
				doTweenAlpha('FakeBotplay', 'botPlayFake', 1, 0.7 / playbackRate, 'easeIn')
			end
			if curBeat % 8 == 4 then
				doTweenAlpha('FakeBotplay', 'botPlayFake', 0, 0.7 / playbackRate, 'easeIn')
			end
		end
	end
	if curBeat == 576 then
		triggerEvent('Change Character', 'dad', 'MorkyHank')
	end
	if curBeat == 608 then
		triggerEvent('Change Character', 'dad', 'Morky')
	end
	if curBeat == 672 then
		cameraFlash('game', 'FFFFFF', 1.7 / playbackRate, false)
		if not botPlay then
			doTweenAlpha('FakeBotplay', 'botPlayFake', 0, 0.7 / playbackRate, 'easeIn')
		end
		clearEffects('game')
		clearEffects('hud')
	end
end

function onStepHit()
	if curStep % 8 == 0 then
		objectPlayAnimation('Pendelum', 'weeeeeeeee', true)
		objectPlayAnimation('fakespace', 'troll', true)
	end
	
	if curStep == 160 then
		doTweenAlpha('hudgobye', 'camHUD', 0, 0.5 / playbackRate, 'linear')
	end
	if curStep == 163 then
		doTweenAlpha('MorkyText', 'MorkyText', 1, 0.07 / playbackRate, 'cubeIn')
		setProperty('defaultCamZoom', 1.4)
		setTextString('MorkyText', "Ha!")
	end
	if curStep == 170 then
		setTextString('MorkyText', "Ha! Hah!")
	end
	if curStep == 178 then
		setTextString('MorkyText', "Ha! Hah! Hah!")
	end
	if curStep == 186 then
		setTextString('MorkyText', "Ha! Hah! Hah! Haaaaa!")
	end
	if curStep == 200 then
		setTextString('MorkyText', "I")
	end
	if curStep == 204 then
		setTextString('MorkyText', "I am")
	end
	if curStep == 208 then
		setTextString('MorkyText', "I am Mor")
	end
	if curStep == 213 then
		setTextString('MorkyText', "I am Morky!")
	end
	if curStep == 222 then
		setTextString('MorkyText', "And")
	end
	if curStep == 224 then
		setTextString('MorkyText', "And I")
	end
	if curStep == 228 then
		setTextString('MorkyText', "And I am")
	end
	if curStep == 230 then
		setTextString('MorkyText', "And I am a")
	end
	if curStep == 234 then
		setTextString('MorkyText', "And I am a Vi")
	end
	if curStep == 237 then
		setTextString('MorkyText', "And I am a Villain!")
	end
	if curStep == 240 then
		doTweenAlpha('MorkyText', 'MorkyText', 0, 1.6 / playbackRate, 'cubeInOut')
	end
	if curStep == 248 then
		doTweenAlpha('hudgobye', 'camHUD', 1, 1.6 / playbackRate, 'cubeInOut')
	end
	if curStep == 256 then
		setProperty('defaultCamZoom', 0.9 * zoomMult)
		cameraFlash('game', 'ffffff', 0.8 / playbackRate, false)
	end
	
	if curStep == 640 then
		triggerEvent('Change Character', 'dad', 'MorkyEgg')
	end
	if curStep == 640 then
		triggerEvent('Change Character', 'dad', 'MorkyEgg')
	end
	if curStep == 720 then
		triggerEvent('Change Character', 'dad', 'Morky')
	end
	if curStep == 896 then
		setProperty('trollchrome.alpha', 1)
	end
	if curStep == 960 then
		setProperty('trollchrome.alpha', 0)
	end
	if curStep == 1032 then
		doTweenAlpha('morkyJumpscare', 'morkyJumpscare', 0, 1.3 / playbackRate, 'cubeInOut')
	end
	if curStep == 1126 then
		triggerEvent('Change Character', 'dad', 'MorkyMoist')
	end
	if curStep == 1344 then
		triggerEvent('Change Character', 'dad', 'MorkyHypno')
	end
	if curStep == 1401 then
		doTweenY('Pendelum', 'Pendelum', 0, 0.3 / playbackRate, 'cubeInOut')
	end
	if curStep == 1406 then
		cameraFlash('game', 'FFFFFF', 1.7 / playbackRate, false)
		doTweenAngle('PendelumSpin', 'Pendelum', 360 * 1000, 24.5 / playbackRate, 'circOut')
		doTweenAngle('gameGoWeeee', 'camGame', 720, 24.5 / playbackRate, 'cubeInOut')
		doTweenAlpha('helloHypno', 'static', 1, 2.3 / playbackRate, 'cubeInOut')
		doTweenAlpha('hellofakeBar', 'fakespace', 1, 2.3 / playbackRate, 'cubeInOut')
		doTweenZoom('gamegobye', 'camGame', 0.2, 22.5 / playbackRate, 'cubeInOut')
		doTweenZoom('hudgobye', 'camHUD', 0.2, 22.5 / playbackRate, 'cubeInOut')
		addGlitchEffect('bg', 1.5, 0.6, 0.3)
	end
	if curStep == 1408 then
		triggerEvent('Change Character', 'dad', 'MorkyHypnoAgain')
		triggerEvent('Change Character', 'boyfriend', 'lulababegf')
	end
	if curStep == 1664 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		doTweenAlpha('hellofakeBar', 'fakespace', 0, 5.3 / playbackRate / playbackRate, 'linear')
		doTweenAngle('hudGoWeeee', 'camHUD', 0, 0.6 / playbackRate / playbackRate, 'circOut')
		doTweenY('Pendelum', 'Pendelum', -600, 0.3 / playbackRate / playbackRate, 'cubeInOut')
		doTweenAlpha('helloHypno', 'static', 0, 0.13 / playbackRate / playbackRate, 'circOut')
		triggerEvent('Change Character', 'dad', 'Morky')
		if character == 1 then
			triggerEvent('Change Character', 'bf', 'GFwav')
		elseif character == 2 then
			triggerEvent('Change Character', 'bf', 'playablegf-old')
		elseif character == 3 then
			triggerEvent('Change Character', 'bf', 'd-side gf')
		elseif character == 4 then
			triggerEvent('Change Character', 'bf', 'debugGF')
		elseif character == 5 then
			triggerEvent('Change Character', 'bf', 'Spendthrift GF')
		else
			triggerEvent('Change Character', 'bf', 'playablegf')
		end
		clearEffects('bg')
	end
	if curStep == 2048 then
		if shadersEnabled and shadersUsed == false then
			addPulseEffect('game', 1.5, 0.2, 0.25, 0.22)
			addPulseEffect('hud', 1.5, 0.2, 0.25, 0.22)
			shadersUsed = true
		end
	end
	if curStep == 3239 then
		doTweenAngle('morkSpin', 'dad', 360 * 100, 2 / playbackRate, 'circOut')
		doTweenX('morkX', 'dad.scale', 3, 2 / playbackRate, 'bounceInOut')
	end
	if curStep == 3247 then
		setProperty('camGame.alpha', 0)
		startVideo("morky farded", false, true, false, true) -- Umskippable, for Mid Song, not loopable, play on load
		setObjectCamera("videoCutscene", "hud")
		setObjectOrder("videoCutscene", 0)
	end
end

local glitchText = {'romKYYYYYYYYYYYYYYYYYY', 'y', 'MORKYYYYYYYYYROMYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYWNGWRPONIBVWO',
					'rom', 'moRKEEEEEEEEEEEEEEEEEEEE', 'M', 'Morkyyyyyyyyyyyyyyiewjhyoisrhnyoyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy',
					'REEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE', 'Sans', 'FORTNITE',
					'myyyyrKOOOOOOOOOOOOOOOOOOOOOOoooOOoOoOoOoOoOoOoOoO'}
function onTimerCompleted(tag)
	if tag == 'MorkyGlitching' and (curBeat <= 508 or (curBeat >= 510 and curBeat <= 512)) then
		setTextString('MorkyText', glitchText[getRandomInt(1, 11)])
		runTimer('MorkyGlitching', 0.01)
	end
end