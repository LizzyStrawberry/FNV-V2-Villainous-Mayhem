local numberX = 0
local numberY = 0

function onCreate()
	for i = 0, 15 do
		numberX = getRandomInt(-100, 700)
		numberY = getRandomInt(-100, 700)
		makeAnimatedLuaSprite('heart'..i, 'effects/heartPop', mobileFix("X", numberX), numberY)
		addAnimationByPrefix('heart'..i, 'pop', 'heart pop up0', 36, false)
		setProperty('heart'..i..'.alpha', 0)
		--scaleObject('heart'..i, 0.5, 0.5)
		setObjectCamera('heart'..i, 'hud')
		setScrollFactor('heart'..i, 1, 1)
		addLuaSprite('heart'..i, true)
	end
end

function onUpdate()
	if curBeat == 61 then
		for i = 0, 15 do
			setProperty('heart'..i..'.alpha', 1)
			objectPlayAnimation('heart'..i, 'pop', true)
		end
	end
	if curBeat == 64 then
		for i = 0, 15 do
			setProperty('heart'..i..'.alpha', 0)
		end
		cameraFlash('game', 'FFFFFF', 0.55, false)
		removeLuaSprite('BG', true);
	end
	if curBeat == 284 then
		for i = 0, 15 do
			numberX = getRandomInt(-100, 700)
			numberY = getRandomInt(-100, 700)
			setProperty('heart'..i..'.alpha', 1)
			objectPlayAnimation('heart'..i, 'pop', true)
		end
	end
	if curBeat == 288 then
		for i = 0, 15 do
			setProperty('heart'..i..'.alpha', 0)
		end
	end
	if curBeat == 332 then
		for i = 0, 15 do
			numberX = getRandomInt(-100, 700)
			numberY = getRandomInt(-100, 700)
			setProperty('heart'..i..'.alpha', 1)
			objectPlayAnimation('heart'..i, 'pop', true)
		end
	end
	if curBeat == 336 then
		for i = 0, 15 do
			setProperty('heart'..i..'.alpha', 0)
		end
	end
	if curBeat == 429 then
		for i = 0, 15 do
			numberX = getRandomInt(-100, 700)
			numberY = getRandomInt(-100, 700)
			setProperty('heart'..i..'.alpha', 1)
			objectPlayAnimation('heart'..i, 'pop', true)
		end
	end
	if curBeat == 432 then
		for i = 0, 15 do
			setProperty('heart'..i..'.alpha', 0)
		end
	end
end