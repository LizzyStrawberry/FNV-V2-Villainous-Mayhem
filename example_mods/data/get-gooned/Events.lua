local shake = 8.5;
local ripMorkyY
local MorkyY

function onCreate()
	addCharacterToList('aizi', 'dad')
	setProperty('dad.x', 1620)
	setProperty('dad.y', 480)
	setProperty('boyfriend.x', 950)
	setProperty('boyfriend.y', 170)
	
	makeLuaSprite('seizureMorky', 'bgs/aizi/seizureMorky', getProperty('dad.x') - 150, getProperty('dad.y') - 300)
	scaleObject('seizureMorky', 0.9, 0.9)
	setProperty('seizureMorky.alpha', 0)
	addLuaSprite('seizureMorky', true)
	
	makeLuaSprite('ripMorky', 'bgs/aizi/ripMorky', getProperty('dad.x') - 150, getProperty('dad.y') - 300)
	scaleObject('ripMorky', 0.9, 0.9)
	setProperty('ripMorky.alpha', 0)
	addLuaSprite('ripMorky', true)
	ripMorkyY = getProperty('ripMorky.y')
	
	makeLuaSprite('shootMorky', 'bgs/aizi/ohGodHeBack', getProperty('dad.x') - 150, getProperty('dad.y') - 300)
	setProperty('shootMorky.alpha', 0)
	addLuaSprite('shootMorky', true)
	
	makeLuaSprite('morky!', 'bgs/aizi/Morky!', getProperty('dad.x') - 150, getProperty('dad.y') - 380)
	setProperty('morky!.alpha', 0)
	addLuaSprite('morky!', true)
	MorkyY = getProperty('dad.y') - 380
	
	if getPropertyFromClass('ClientPrefs', 'itsameDsidesUnlocked') == false then
		makeLuaText('unlockText', "MORKY IS SO TIRED OF YOU.\nGO TAP KIANA IN LUSTALITY REMIX IN FREEPLAY IF YOU'RE A BIG MUSCULAR BLACK MAN.\n- Morky", 1000, 130, 320)
		setTextSize('unlockText', 45)
		setObjectCamera('unlockText', 'other')
		setScrollFactor('unlockText', 0, 0)
		setProperty('unlockText.alpha', 0)
		addLuaText('unlockText')
	end
	
	makeLuaSprite('sabotage', '', -800, -600)
	makeGraphic('sabotage', 5000, 5000, 'FF0000')
	setScrollFactor('sabotage', 0, 0)
	setProperty('sabotage.alpha', 0)
	setObjectCamera('sabotage', 'game')
	addLuaSprite('sabotage', true)
end

function onUpdate()
	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 160)
	if curBeat == 32 then
		cameraFlash('game', 'FFFFFF', 0.6, false)
	end
	if curBeat >= 160 and curBeat < 190 then
		setProperty('seizureMorky.x', getProperty('seizureMorky.x') + getRandomFloat(-shake, shake) + math.sin((currentBeat + 0.75) * math.pi))
        setProperty('seizureMorky.y', getProperty('seizureMorky.y') + getRandomFloat(-shake, shake) + math.sin((currentBeat + 0.75) * math.pi))
	end
	if curBeat == 160 then
		doTweenAngle('seizureMorkySpin', 'seizureMorky', 360 * 10000, 24 / playbackRate, 'cubeIn')
		doTweenZoom('camGameZoom', 'camGame', 1.6, 21 / playbackRate, 'cubeInOut')
		doTweenAlpha('camHud', 'camHUD', 0, 15 / playbackRate, 'cubeInOut')
		setProperty('dad.alpha', 0)
		setProperty('seizureMorky.alpha', 1)
	end
	if curBeat == 190 then
		triggerEvent('Change Character', 'dad', 'aizi')
		triggerEvent('Play Animation', 'shoot', 'boyfriend')
		
		setProperty('seizureMorky.alpha', 0)
		setProperty('ripMorky.alpha', 1)
		
		doTweenY('ripMorkyMove', 'ripMorky', ripMorkyY + 10, 0.7 / playbackRate, 'circOut')
	end
	if curBeat == 196 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('defaultCamZoom', 0.9 * zoomMult)
		setProperty('dad.alpha', 1)
		setProperty('dad.x', -550)
		setProperty('dad.y', 480)
		setProperty('boyfriend.x', 1050)
		
		cancelTween('camGameZoom')
		
		doTweenX('dadMove', 'dad', 50, 0.8 / playbackRate, 'circOut')
		doTweenZoom('camGameZoom', 'camGame', 1.2 * zoomMult, 18 / playbackRate, 'cubeInOut')
		triggerEvent('Change Character', 'bf', 'cassetteGoonFlipped')
	end
	if curStep == 955 then
		cameraFlash('hud', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('camHUD.alpha', 1)
		setProperty('defaultCamZoom', 0.9 * zoomMult)
	end
	if curStep == 1126 then
		removeLuaSprite('seizureMorky', true)
		removeLuaSprite('ripMorky', true)
	end
	if curBeat >= 276 and curStep < 1126 then
		if curStep % 2 == 0 then
			setProperty('ripMorky.alpha', 0)
		end
		if curStep % 2 == 1 then
			setProperty('ripMorky.alpha', 1)
		end
	end
	if curStep == 1137 or curStep == 1158 or curStep == 1180 -- I hate how offsync shit gets omfg
	or curStep == 1200 or curStep == 1222 or curStep == 1243 
	or curStep == 1264 or curStep == 1286 or curStep == 1307 
	or curStep == 1328 or curStep == 1350 or curStep == 1371 
	or curStep == 1392 or curStep == 1414 or curStep == 1435
	or curStep == 1457 or curStep == 1478 or curStep == 1499
	or curStep == 1520 or curStep == 1542 or curStep == 1564 
	or curStep == 1585 or curStep == 1606 or curStep == 1627 
	or curStep == 1648 or curStep == 1670 or curStep == 1692 or curStep == 1713 then
		doTweenAlpha('sabotage', 'sabotage', 0.8, 0.06 / playbackRate, 'circOut')
	end
	if curBeat == 409 then
		cameraFlash('hud', 'FFFFFF', 0.6 / playbackRate, false)
		doTweenAlpha('camHud', 'camHUD', 0, 15 / playbackRate, 'cubeIn')
	end
	if curBeat == 456 then
		setProperty('defaultCamZoom', 1.5 * zoomMult)
	end
	if curStep == 1831 then
		triggerEvent('Play Animation', 'singUPmiss', 'boyfriend')
		cameraShake('game', 0.02, 0.1)
		runTimer('goodByePlayer', 0.4)
		
		setProperty('shootMorky.alpha', 1)
	end
	if curStep == 1854 then
		removeLuaSprite('shootMorky', true)
		setProperty('morky!.alpha', 1)
		doTweenY('Morky!', 'morky!', MorkyY + 60, 0.7 / playbackRate,'circInOut')
	end
	if curBeat == 465 then
		doTweenX('morkZoomX', 'morky!.scale', 3, 0.4 / playbackRate, 'circOut')
		doTweenY('morkZoomY', 'morky!.scale', 3, 0.4 / playbackRate, 'circOut')
		doTweenAngle('morkSpin', 'morky!', 360 * 10000, 0.4 / playbackRate, 'circOut')
	end
	if curStep == 1862 and getPropertyFromClass('ClientPrefs', 'itsameDsidesUnlocked') == false then
		setProperty('unlockText.alpha', 1)
	end
end

function onBeatHit()
	if curBeat % 4 == 0 and (curBeat >= 64 and curBeat <= 188) then
		doTweenAlpha('sabotage', 'sabotage', 0.8, 0.06 / playbackRate, 'circOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'sabotage' then
		doTweenAlpha('sabotageEnd', 'sabotage', 0, 0.7 / playbackRate, 'easeOut')
	end
end

function onTimerCompleted(tag)
	if tag == 'goodByePlayer' then
		setProperty('boyfriend.visible', false)
	end
end