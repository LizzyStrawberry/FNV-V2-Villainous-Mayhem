local hudThings = {'watermark', 'watermark2', 'healthBar', 'healthBarBG', 'iconP1', 'iconP2', 'scoreTxt'}
local scrollSpeed = 1.2
local dur = 1
local videoPlayed = false

local context = "After GF humiliated Marco in the 4th rap battle, Marco went coo coo crazy, and straight up murdered GF. He wasn't satisfied enough though, as he enhanced the teleporter to practically bond with GF more and revive her so he can murder her again and again. Not only that, but he brought a special someone for her \"hanging\" there."

function onCreate()
	scrollSpeed = 1.2 / playbackRate
	dur = 1 / playbackRate
	
	makeAnimatedLuaSprite('bf', 'characters/FNV Shucks', 600, -195)
	addAnimationByPrefix('bf', 'ohnohelp', 'bf idle0', 24, false)
	setProperty('bf.alpha', 0)
	setObjectCamera('bf', 'game')
	setObjectOrder('bf', getObjectOrder('bg') + 1)
	setScrollFactor('bf', 0.9, 0.9)
	
	setProperty('bf.origin.y', -100)
	setProperty('bf.angle', -20)
	addLuaSprite('bf', true)
	
	doTweenAngle('bfnormal1', 'bf', 20, 1.4 / playbackRate, 'cubeInOut')
	
	makeLuaSprite('blackBG', '', 0, 0)
	makeGraphic('blackBG', screenWidth * 1.25, screenHeight * 1.25, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	screenCenter('blackBG', 'XY')
	addLuaSprite('blackBG', true)
	
	setProperty('gf.x', getProperty('gf.x') + 150)
	setProperty('gf.y', getProperty('gf.y') - 180)
	
	for i = 1, #(hudThings) do
		setProperty(hudThings[i]..'.alpha', 0)
	end
	
	makeLuaText('Lyrics', 'Hi', 1250, 0, 480)
	setTextAlignment('Lyrics', 'Center')
	setTextColor('Lyrics', 'FF0000')
	setProperty('Lyrics.alpha', 0)
	setTextSize('Lyrics', 28)
	addLuaText('Lyrics')
	
	makeLuaText('contextText', 'Context:\n'..context, 900, 185, 480)
	setTextAlignment('contextText', 'Center')
	setProperty('contextText.alpha', 0)
	setTextSize('contextText', 20)
	addLuaText('contextText')
end

function onCreatePost()
	runHaxeCode([[
		game.dad.setColorTransform(1,1,1,1,255,255,255,0);
		game.boyfriend.setColorTransform(1,1,1,1,255,10,30,0);
		game.gf.setColorTransform(1,1,1,1,67,255,10,0);
    ]])
	setProperty('bf.color', getColorFromHex('#00eeff'))
	setProperty('dad.alpha', 0)
	setProperty('bg.alpha', 0)
	setProperty('fg.alpha', 0)
	setProperty('ded.alpha', 0)
end

function onSongStart()
	doTweenZoom('camGame', 'camGame', 1.4, 9.5 / playbackRate, 'easeOut')
	doTweenAlpha('blackBG', 'blackBG', 0, 7.2 / playbackRate, 'cubeInOut')
	doTweenAlpha(hudThings[5], hudThings[5], 1, 14 / playbackRate, 'cubeInOut')
	
	doTweenAlpha('contextAppear', 'contextText', 1, 1 / playbackRate, 'cubeInOut')
end

function onUpdatePost(elapsed)
	if curBeat == 142 or curBeat == 503 then
		triggerEvent('Change Scroll Speed', scrollSpeed, '0.5')
	end
	if curBeat == 432 then
		triggerEvent('Change Scroll Speed', '1', '1')
	end
	if curBeat == 502 then
		triggerEvent('Change Scroll Speed', scrollSpeed, '1.5')
	end
end

function onUpdate()
	if curBeat == 32 or curBeat == 856 then
		cameraFlash('game', 'FFFFFF', 1.3 / playbackRate, false)
	end
	if curBeat == 144 then
		setProperty('dad.alpha', 1)
		setProperty(hudThings[4]..'.alpha', 1)
		doTweenAlpha('bf', 'bf', 1, 10 / playbackRate, 'cubeInOut')
		doTweenAlpha(hudThings[1], hudThings[1], 1, 10 / playbackRate, 'cubeInOut')
		doTweenAlpha(hudThings[2], hudThings[2], 1, 10 / playbackRate, 'cubeInOut')
		doTweenAlpha(hudThings[7], hudThings[7], 1, 10 / playbackRate, 'cubeInOut')
		doTweenAlpha(hudThings[8], hudThings[8], 1, 10 / playbackRate, 'cubeInOut')
	end
	if curStep == 704 then
		cameraFlash('hud', 'FFFFFF', 7.5 / playbackRate, false)
		triggerEvent('Add Camera Zoom', '0.115', '0.115')
		runHaxeCode([[
			game.dad.setColorTransform(1,1,1,1,0,0,0,0);
			game.boyfriend.setColorTransform(1,1,1,1,0,0,0,0);
			game.gf.setColorTransform(1,1,1,1,0,0,0,0);
		]])
		doTweenColor('bfcolor', 'bf', 'FFFFFF', 0.001, 'linear')
		setProperty('bg.alpha', 1)
		setProperty('fg.alpha', 1)
		setProperty('ded.alpha', 1)
		
		for i = 1, #(hudThings) do
			setProperty(hudThings[i]..'.alpha', 1)
		end
	end
	if curBeat == 366 then
		setProperty('defaultCamZoom', 2)
	end
	if curBeat == 432 then
		setProperty('camGame.alpha', 0)
		for i = 1, #(hudThings) do
			setProperty(hudThings[i]..'.alpha', 0)
		end
	end
	if curBeat == 440 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('camGame.alpha', 1)
	end
	if curBeat == 504 then
		setProperty('bg.alpha', 1)
		setProperty('fg.alpha', 1)
		setProperty('ded.alpha', 1)
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		runHaxeCode([[
			game.dad.setColorTransform(1,1,1,1,0,0,0,0);
			game.boyfriend.setColorTransform(1,1,1,1,0,0,0,0);
			game.gf.setColorTransform(1,1,1,1,0,0,0,0);
		]])
		doTweenColor('bfcolor', 'bf', 'FFFFFF', 0.001, 'linear')
		cancelTween('bfnormal1')
		cancelTween('bfnormal2')
		doTweenAngle('bfhi', 'bf', 90, getRandomFloat(0.4, 1) / playbackRate, 'cubeOut')
		
		for i = 1, #(hudThings) do
			setProperty(hudThings[i]..'.alpha', 1)
		end
	end
		
	if curStep == 2372 and not videoPlayed then
		startVideo("Shucks Cutscene noVol", false, true, false, true) -- Umskippable, for Mid Song, not loopable, play on load
		setProperty('videoCutscene.alpha', 0)
		setObjectCamera("videoCutscene", "hud")
		setObjectOrder("videoCutscene", 0)
		videoPlayed = true
	end
	if curStep == 2380 then
		hudThings = {'watermark', 'watermark2', 'healthBar', 'healthBarBG', 'iconP1', 'iconP2', 'scoreTxt', 'timeBar', 'timeBarBG', 'timeTxt'}
		for i = 1, #(hudThings) do
			doTweenAlpha(hudThings[i], hudThings[i], 0, 0.8 / playbackRate, 'cubeInOut')
		end
		doTweenAlpha('blackBG', 'blackBG', 0, 0.8 / playbackRate, 'cubeInOut')
	end
	if curStep == 2388 then
		for i = 0, 7 do
			noteTweenAlpha('fuckYouNote'..i, i, 0, 0.8 / playbackRate, 'circOut')
		end
		doTweenAlpha('goneCrazy', 'videoCutscene', 1, 0.8 / playbackRate, 'cubeInOut')
	end
	if curStep == 2640 then
		for i = 0, 7 do
			noteTweenAlpha('fuckYouNote'..i, i, 1, 0.8 / playbackRate, 'cubeInOut')
		end
		for i = 1, #(hudThings) do
			doTweenAlpha(hudThings[i], hudThings[i], 1, 0.8 / playbackRate, 'cubeInOut')
		end
	end
	if curStep == 2656 then
		cameraFlash('game', 'FFFFFF', 1.3 / playbackRate, false)
		setProperty('videoCutscene.alpha', 0)
	end
	
	--Lyrics!
	if curStep == 2023 then
		setProperty('Lyrics.alpha', 1)
		setTextString('Lyrics', "I");
	end
	if curStep == 2026 then
		setTextString('Lyrics', "I SE");
	end
	if curStep == 2027 then
		setTextString('Lyrics', "I SERI");
	end
	if curStep == 2028 then
		setTextString('Lyrics', "I SERIOU");
	end
	if curStep == 2030 then
		setTextString('Lyrics', "I SERIOUSLY");
	end
	if curStep == 2032 then
		setTextString('Lyrics', "I SERIOUSLY RE");
	end
	if curStep == 2034 then
		setTextString('Lyrics', "I SERIOUSLY RECO");
	end
	if curStep == 2035 then
		setTextString('Lyrics', "I SERIOUSLY RECOMMEND");
	end
	if curStep == 2037 then
		setTextString('Lyrics', "I SERIOUSLY RECOMMEND YOU");
	end
	if curStep == 2039 then
		setTextString('Lyrics', "I SERIOUSLY RECOMMEND YOU BOTH");
	end
	if curStep == 2042 then
		setTextString('Lyrics', "I SERIOUSLY RECOMMEND YOU BOTH SHUT");
	end
	if curStep == 2044 then
		setTextString('Lyrics', "I SERIOUSLY RECOMMEND YOU BOTH SHUT THE");
	end
	if curStep == 2045 then
		setTextString('Lyrics', "I SERIOUSLY RECOMMEND YOU BOTH SHUT THE FUCK");
	end
	if curStep == 2047 then
		setTextString('Lyrics', "I SERIOUSLY RECOMMEND YOU BOTH SHUT THE FUCK UP,");
	end
	if curStep == 2052 then
		setTextString('Lyrics', "OR");
	end
	if curStep == 2054 then
		setTextString('Lyrics', "OR ELSE");
	end
	if curStep == 2061 then
		setTextString('Lyrics', "OR ELSE YOU'LL");
	end
	if curStep == 2063 then
		setTextString('Lyrics', "OR ELSE YOU'LL END UP");
	end
	if curStep == 2065 then
		setTextString('Lyrics', "OR ELSE YOU'LL END UP LIKE");
	end
	if curStep == 2070 then
		setTextString('Lyrics', "OR ELSE YOU'LL END UP LIKE THE OTHER CLONES");
	end
	if curStep == 2080 then
		setTextString('Lyrics', "OR ELSE YOU'LL END UP LIKE THE OTHER CLONES OVER");
	end
	if curStep == 2083 then
		setTextString('Lyrics', "OR ELSE YOU'LL END UP LIKE THE OTHER CLONES OVER THERE.");
	end
	if curStep == 2091 then
		setTextString('Lyrics', "Y");
	end
	if curStep == 2092 then
		setTextString('Lyrics', "Y-YOU");
	end
	if curStep == 2096 then
		setTextString('Lyrics', "Y-YOU KNOW");
	end
	if curStep == 2102 then
		setTextString('Lyrics', "Y-YOU KNOW, YOU");
	end
	if curStep == 2105 then
		setTextString('Lyrics', "Y-YOU KNOW, YOU SEEMED");
	end
	if curStep == 2112 then
		setTextString('Lyrics', "Y-YOU KNOW, YOU SEEMED EASY");
	end
	if curStep == 2114 then
		setTextString('Lyrics', "Y-YOU KNOW, YOU SEEMED EASY TO");
	end
	if curStep == 2116 then
		setTextString('Lyrics', "Y-YOU KNOW, YOU SEEMED EASY TO BEAT,");
	end
	if curStep == 2126 then
		setTextString('Lyrics', "BUT NOW");
	end
	if curStep == 2134 then
		setTextString('Lyrics', "BUT NOW YOU HAD");
	end
	if curStep == 2138 then
		setTextString('Lyrics', "BUT NOW YOU HAD TO");
	end
	if curStep == 2140 then
		setTextString('Lyrics', "BUT NOW YOU HAD TO HUMILIATE");
	end
	if curStep == 2144 then
		setTextString('Lyrics', "BUT NOW YOU HAD TO HUMILIATE ME!");
	end
	if curStep == 2154 then
		setTextString('Lyrics', "But I");
	end
	if curStep == 2156 then
		setTextString('Lyrics', "But I know");
	end
	if curStep == 2160 then
		setTextString('Lyrics', "But I know what to do now..");
	end
	if curStep == 2170 then
		setTextString('Lyrics', "SEE,");
	end
	if curStep == 2176 then
		setTextString('Lyrics', "SEE, I");
	end
	if curStep == 2179 then
		setTextString('Lyrics', "SEE, I TOLD YOU");
	end
	if curStep == 2185 then
		setTextString('Lyrics', "SEE, I TOLD YOU NOT");
	end
	if curStep == 2187 then
		setTextString('Lyrics', "SEE, I TOLD YOU NOT TO MESS");
	end
	if curStep == 2190 then
		setTextString('Lyrics', "SEE, I TOLD YOU NOT TO MESS WITH THE TELEPORTER,");
	end
	if curStep == 2204 then
		setTextString('Lyrics', "SEE, I TOLD YOU NOT TO MESS WITH THE TELEPORTER, DIDN'T I?!");
	end
	if curStep == 2215 then
		setTextString('Lyrics', "BUT NOW");
	end
	if curStep == 2223 then
		setTextString('Lyrics', "BUT NOW THAT YOU");
	end
	if curStep == 2228 then
		setTextString('Lyrics', "BUT NOW THAT YOU DID");
	end
	if curStep == 2230 then
		setTextString('Lyrics', "BUT NOW THAT YOU DID IT-");
	end
	if curStep == 2236 then
		setTextString('Lyrics', "I");
	end
	if curStep == 2238 then
		setTextString('Lyrics', "I GOTTA");
	end
	if curStep == 2241 then
		setTextString('Lyrics', "I GOTTA SMASH!");
	end
	if curStep == 2247 then
		setTextString('Lyrics', "[Villainous Laugh]");
	end
	if curStep == 2276 then
		doTweenAlpha('Lyrics', 'Lyrics', 0, 1.7 / playbackRate, 'cubeInOut')
	end
end

function onStepHit()
	if curBeat >= 144 and curBeat < 174 then
		if curStep % 32 == 0 or curStep % 32 == 8 or curStep % 32 == 16 or curStep % 32 == 22 or curStep % 32 == 28 then
			cameraFlash('game', 'FFFFFF', 0.3 / playbackRate, false)
			triggerEvent('Add Camera Zoom', '0.085', '0.085')
		end
	end
	if curBeat >= 792 and curBeat <= 853 then
		if curStep % 32 == 0 or curStep % 32 == 8 or curStep % 32 == 16 or curStep % 32 == 22 or curStep % 32 == 28 then
			if curBeat < 824 then
				cameraFlash('game', 'FFFFFF', 0.3 / playbackRate, false)
			else
				cameraFlash('game', 'FF0000', 0.3 / playbackRate, false)
			end
			triggerEvent('Add Camera Zoom', '0.085', '0.085')
		end
	end
end

function onBeatHit()
	if curBeat == 400 then
		cameraFlash('game', 'FFFFFF', 1.3 / playbackRate, false)
		triggerEvent('Add Camera Zoom', '0.115', '0.115')
		runHaxeCode([[
			game.dad.setColorTransform(1,1,1,1,255,255,255,0);
			game.boyfriend.setColorTransform(1,1,1,1,255,10,30,0);
			game.gf.setColorTransform(1,1,1,1,67,255,10,0);
		]])
		setProperty('bf.color', getColorFromHex('#00eeff'))
		setProperty('bg.alpha', 0)
		setProperty('fg.alpha', 0)
		setProperty('ded.alpha', 0)
	end
	if curBeat == 984 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		triggerEvent('Add Camera Zoom', '0.145', '0.145')
		setProperty('defaultCamZoom', 0.8)
		doTweenAlpha('blackBG', 'blackBG', 1, 1.6 / playbackRate, 'cubeInOut')
		doTweenAlpha('camHUD', 'camHUD', 0, 1.6 / playbackRate, 'cubeInOut')
	end
	
	if (curBeat >= 176 and curBeat <= 366) or (curBeat >= 368 and curBeat <= 400) or (curBeat >= 504 and curStep <= 2393)
	or (curBeat >= 664 and curBeat < 728) or (curBeat >= 729 and curBeat <= 792) or (curBeat >= 856 and curBeat < 984) then
		triggerEvent('Add Camera Zoom', '0.105', '0.105')
	end
	if curBeat % 2 == 0 then
		objectPlayAnimation('bf', 'ohnohelp')
	end
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
	if not isMayhemMode  then
		if getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.0075);
			else
				setProperty('health', health- 0.013);
			end
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'swingAgain' then
		doTweenAngle('bfbye', 'bf', -90, getRandomFloat(1.4, 2) / playbackRate, 'cubeInOut')
	end
	if tag == 'swingFix' then
		doTweenAngle('bfhi', 'bf', 90, getRandomFloat(1.4, 2) / playbackRate, 'cubeInOut')
	end
	if tag == "showContext" then
		doTweenAlpha('contextBye', 'contextText', 0, 1 / playbackRate, 'cubeInOut')
	end
end

function onTweenCompleted(tag)
	if tag == "contextAppear" then
		runTimer("showContext", 7 / playbackRate)
	end
	if tag == 'bfnormal1' then
		doTweenAngle('bfnormal2', 'bf', -20, 1.4 / playbackRate, 'cubeInOut')
	end
	if tag == 'bfnormal2' then
		doTweenAngle('bfnormal1', 'bf', 20, 1.4 / playbackRate, 'cubeInOut')
	end
	if tag == 'bfhi' then
		setObjectOrder('bf', getObjectOrder('boyfriendGroup') + 1)
		scaleObject('bf', 2, 2)
		updateHitbox('bf')
		setProperty('bf.origin.y', -100)
		setProperty('bf.y', -1095)
		runTimer('swingAgain', getRandomFloat(0.01, 0.6))
	end
	if tag == 'bfbye' then
		setObjectOrder('bf', getObjectOrder('bg') + 1)
		scaleObject('bf', 1, 1)
		updateHitbox('bf')
		setProperty('bf.origin.y', -100)
		setProperty('bf.y', -195)
		runTimer('swingFix', getRandomFloat(0.01, 0.6))
	end
	if tag == 'camGame' then
		doTweenZoom('camGameAgain', 'camGame', 1.9, 1.2 / playbackRate, 'elasticInOut')
	end
end