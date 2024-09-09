local numberX = 0
local numberY = 0
local maxHearts = 7

function onCreate()
	addCharacterToList('kianaPhase2', 'dad')
	addCharacterToList('kianaPhase3', 'dad')
	for i = 0, maxHearts do
		numberX = getRandomInt(-100, 700)
		numberY = getRandomInt(-100, 700)
		makeAnimatedLuaSprite('heart'..i, 'effects/heartPop', numberX, numberY)
		addAnimationByPrefix('heart'..i, 'pop', 'heart pop up0', 36, false)
		setProperty('heart'..i..'.alpha', 0)
		setObjectCamera('heart'..i, 'hud')
		setScrollFactor('heart'..i, 1, 1)
		addLuaSprite('heart'..i, true)
	end
end


function onUpdate()
	if curBeat == 31 then
		if difficulty == 0 then
			triggerEvent('Change Scroll Speed', '1.1', '2')
		end
		if difficulty == 1 then
			triggerEvent('Change Scroll Speed', '1.2', '2')
		end
		if difficulty == 2 then
			triggerEvent('Change Scroll Speed', '1.35', '2')
		end
	end
	if curBeat == 30 then
		for i = 0, maxHearts do
			setProperty('heart'..i..'.alpha', 1)
			objectPlayAnimation('heart'..i, 'pop', true)
		end
	end
	if curBeat == 32 then
		for i = 0, maxHearts do
			setProperty('heart'..i..'.alpha', 0)
		end
		cameraFlash('game', 'FFFFFF', 0.55, false)
		removeLuaSprite('BG', true);
		setProperty('CFront.visible', true)
	end
	if curBeat == 110 then
		for i = 0, maxHearts do
			numberX = getRandomInt(-100, 700)
			numberY = getRandomInt(-100, 700)
			setProperty('heart'..i..'.x', numberX)
			setProperty('heart'..i..'.y', numberY)
			
			setProperty('heart'..i..'.alpha', 1)
			objectPlayAnimation('heart'..i, 'pop', true)
		end
	end
	if curBeat == 112 then
		for i = 0, maxHearts do
			setProperty('heart'..i..'.alpha', 0)
		end
	end
	if curBeat == 142 then
		for i = 0, maxHearts do
			numberX = getRandomInt(-100, 700)
			numberY = getRandomInt(-100, 700)
			setProperty('heart'..i..'.x', numberX)
			setProperty('heart'..i..'.y', numberY)
			
			setProperty('heart'..i..'.alpha', 1)
			objectPlayAnimation('heart'..i, 'pop', true)
		end
	end
	if curBeat == 144 then
		for i = 0, maxHearts do
			setProperty('heart'..i..'.alpha', 0)
		end
		triggerEvent('Change Character', 'dad', 'kianaPhase2')
	end
	if curBeat == 166 then
		for i = 0, maxHearts do
			numberX = getRandomInt(-100, 700)
			numberY = getRandomInt(-100, 700)
			setProperty('heart'..i..'.x', numberX)
			setProperty('heart'..i..'.y', numberY)
			
			setProperty('heart'..i..'.alpha', 1)
			objectPlayAnimation('heart'..i, 'pop', true)
		end
	end
	if curBeat == 168 then
		for i = 0, maxHearts do
			setProperty('heart'..i..'.alpha', 0)
		end
	end
	if curBeat == 215 then
		for i = 0, maxHearts do
			numberX = getRandomInt(-100, 700)
			numberY = getRandomInt(-100, 700)
			setProperty('heart'..i..'.x', numberX)
			setProperty('heart'..i..'.y', numberY)
			
			setProperty('heart'..i..'.alpha', 1)
			objectPlayAnimation('heart'..i, 'pop', true)
		end
	end
	if curBeat == 216 then
		for i = 0, maxHearts do
			setProperty('heart'..i..'.alpha', 0)
		end
	end
	if curBeat == 296 then
		triggerEvent('Change Character', 'dad', 'kianaPhase3')
	end
end