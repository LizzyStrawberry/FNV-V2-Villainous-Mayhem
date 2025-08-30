local bgY

local playerX
local playerY
local opponentX
local opponentY

local playerMoveX = 50
local playerMoveY = 140
local OpponentMoveX = 60
local OpponentMoveY = 170

function onCreate()
	setProperty('bg.alpha', 0)
	
	bgY = getProperty('bg.y')
	playerX = getProperty('boyfriend.x')
	playerY = getProperty('boyfriend.y')
	opponentX = getProperty('dad.x')
	opponentY = getProperty('dad.y')
end

function onSongStart()
	daSongLength = getProperty('songLength') / 1000 / playbackRate
end

function onUpdate()
	songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 130)
	if curBeat == 0 and getPropertyFromClass('ClientPrefs', 'shaders') == true then
		doTweenY('bgFall', 'bg', bgY - 50, 1.0 / playbackRate, 'linear')
	end
	
	if curBeat == 64 then
		cameraFlash('game', 'FFFFFF', 0.7, false)
		doTweenAlpha('bgAppear', 'bg', 1, 0.6 / playbackRate, 'circOut')
		if shadersEnabled == true then
			doTweenAngle('dadSpin', 'dad', getRandomInt(360, 3600), getRandomFloat(3, 10), 'cubeOut')
			doTweenAngle('playerSpin', 'boyfriend', getRandomInt(360, 3600), getRandomFloat(3, 10), 'cubeOut')
			triggerEvent('Toggle Trail', '1', '1')
		end
	end
	
	if curBeat >= 64 then
		if shadersEnabled == true then
			setProperty('boyfriend.x', playerX + playerMoveX * math.sin((currentBeat + 4*0.75) * math.pi))
			setProperty('boyfriend.y', playerY + playerMoveY * math.cos((currentBeat + 4*0.75) * math.pi))
			setProperty('dad.x', opponentX + OpponentMoveX * math.sin((currentBeat + 6*0.95) * math.pi))
			setProperty('dad.y', opponentY + OpponentMoveY * math.cos((currentBeat + 6*0.95) * math.pi))
		end
	end
	
	if curBeat == 224 then
		cameraFlash('hud', 'FFFFFF', 0.7 / playbackRate, false)
		setProperty('camGame.alpha', 0)
	end
end

function onTweenCompleted(tag)
	if tag == 'bgFall' then
		setProperty('bg.y', bgY)
		doTweenY('bgFall', 'bg', bgY - 500, 1.0 / playbackRate, 'linear')
	end
	if tag == 'bgAppear' then
		doTweenAlpha('bgFade', 'bg', 0, daSongLength - 20, 'circOut')
	end
	if tag == 'dadSpin' then
		doTweenAngle('dadSpin', 'dad', getRandomInt(360, 3600), getRandomFloat(3, 10) / playbackRate, 'cubeInOut')
		doTweenAngle('dadSpin', 'dad', getRandomInt(360, 3600), getRandomFloat(3, 10) / playbackRate, 'cubeInOut')
	end
	if tag == 'playerSpin' then
		doTweenAngle('playerSpin', 'boyfriend', getRandomInt(360, 3600), getRandomFloat(3, 10) / playbackRate, 'cubeInOut')
	end
end