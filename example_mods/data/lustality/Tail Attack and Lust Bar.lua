local randNum = 0
local pressedKey = false --stealing some of my code lmaooaoaodjjkfhwojuvf
local missedKey = false
local canDodge = false
local timerCompleted = false
local turnedTimerOn = false
local warningOn = false
local gotHit = false
local songStarted = false
local gotAttacked = 0
local LustCount = 0

function onCreate()
	if mechanics then
		makeAnimatedLuaSprite('time2', 'effects/timer', 560 , 40)
		addAnimationByPrefix('time2', 'Stunned', 'timer rundown0', 24, false)
		setProperty('time2.alpha', 0)
		scaleObject('time2', 0.5, 0.5)
		setObjectCamera('time2', 'hud')
		setScrollFactor('time2', 1, 1)
		addLuaSprite('time2', true)
		
		makeLuaSprite('dodgeNow', 'effects/dodge', 370, 170)
		setProperty('dodgeNow.alpha', 0)
		scaleObject('dodgeNow', 0.6, 0.6)
		setObjectCamera('dodgeNow', 'hud')
		setScrollFactor('dodgeNow', 1, 1)
		addLuaSprite('dodgeNow', true)
		
		makeLuaSprite('barBack', 'effects/barBack', 1100, 170)
		setObjectCamera('barBack', 'hud')
		setProperty('barBack.origin.y', 365)
		addLuaSprite('barBack', true)
		
		makeLuaSprite('bar', 'effects/bar', 1100, 170)
		setObjectCamera('bar', 'hud')
		addLuaSprite('bar', true)
		
		for i = 1, 3 do
			makeLuaSprite('counterTime'..i, 'effects/counter-'..i, getProperty('bar.x'), 540)
			setObjectCamera('counterTime'..i, 'hud')
		end
		
		if difficulty == 0 then addLuaSprite('counterTime3', true) end
		if difficulty == 1 then addLuaSprite('counterTime1', true) end
		
		makeLuaText('warning', 'Get Ready!', 600, 345, 200)
		setTextSize('warning', 50)
		setProperty('warning.alpha', 0)
		addLuaText('warning')
		
		if downscroll then setProperty('warning.y', 400) end
	end
end

function onSongStart()
	if mechanics then
		if difficulty == 0 then randNum = getRandomInt(25, 30) end
		if difficulty == 1 then randNum = getRandomInt(15, 25) end
		songStarted = true
	end
end

function onCountdownTick(counter)
	if mechanics then
		if counter == 0 then
			doTweenY('barBackStart', 'barBack.scale', 0.001, 1.0, 'cubeInOut')
		end
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if mechanics then
		if noteType == 'Lust Notes' then
			LustCount = LustCount + 1
			if getProperty('barBack.scale.y') <= 1 then
				local barIncrease = (difficulty == 1 and 0.04 or 0.0286)
				setProperty('barBack.scale.y', bar + barIncrease)
			end
		end
	end
end

function onUpdate()
	if mechanics then
		bar = getProperty('barBack.scale.y')
		health = getProperty('health') --uwu
		--tail Attack Mechanic
		if not timerCompleted and songStarted == true and not turnedTimerOn then
			--debugPrint('Setting Timer Up! Random Number is: ' ..randNum)
			
			setProperty('dodgeNow.alpha', 0)
			setTextColor('warning', 'ffffff')
			setTextString('warning', 'Get Ready!')
			setProperty('warning.alpha', 0)
			setProperty('time2.alpha', 0)
			runTimer('TailAttack', randNum)
			
			turnedTimerOn = true
			warningOn = false
		end
		if canDodge then
			if keyJustPressed('dodge') then canDodge = false
			else canDodge = true end
		end
		
		if ((LustCount >= 30 and difficulty == 0) or (LustCount >= 20 and difficulty == 1)) and songStarted then
			if curStep % 8 == 0 then doTweenColor('WarningTime', 'barBack', 'FF0000', 0.4, 'cubeInOut') end
			if curStep % 8 == 4 then doTweenColor('WarningTime', 'barBack', 'ff9f9f', 0.4, 'cubeInOut') end
		end
		if (difficulty == 1 and LustCount == 26) or (difficulty == 0 and LustCount == 36) then	
			setProperty('health', 0)
		end
	end
end

function onTimerCompleted(tag)
	--once the timer is completed
	if tag == 'TailAttack' then
		runTimer('AnimatedTimerPlay', 3 / playbackRate)
		runTimer('spaceHit', 2.8 / playbackRate)
			
		if curBeat >= 0 and curBeat <= 559 then
			triggerEvent('Change Character', 'dad', 'kianaAttack')
			triggerEvent('Play Animation', 'tail attack', 'dad')
		end
		
		timerCompleted = true	
		warningOn = true
		
		doTweenAlpha('Timer2GoHello', 'time2', 1, 0.2, 'linear')
		objectPlayAnimation('time2','Stunned', true)
			
		--debugPrint('Timer Ended! Watch Out for her attack!')
		--debugPrint(timerCompleted)
	end
	if tag == 'spaceHit' then
		--debugPrint("Press Now!")
		setProperty('dodgeNow.alpha', 1)
		setProperty('warning.alpha', 0)
		
		warningOn = false
		canDodge = true
	end
	if tag == 'AnimatedTimerPlay' then
		if curBeat >= 0 and curBeat <= 287 then
			triggerEvent('Change Character', 'dad', 'kiana')
		end
		if curBeat >= 288 and curBeat <= 559 then
			triggerEvent('Change Character', 'dad', 'kianaPhase2')
		end
		if botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 then
			hit()
			doTweenAlpha('Timer2GoByeBye', 'time2', 0, 0.3, 'linear')
		elseif not botPlay then
			if not canDodge then 
				hit() doTweenAlpha('Timer2GoByeBye', 'time2', 0, 0.3, 'linear')
			else miss() end
		end
	end
end

function onStepHit()
	if warningOn then
		if curStep % 8 == 0 then setProperty('warning.alpha', 1) end
		if curStep % 8 == 4 then setProperty('warning.alpha', 0) end
	end
end

function miss()
	playSound('missnote1')
		
	cameraFlash('game', 'ff0000', 0.2, false)
	triggerEvent('Play Animation', 'singUPmiss', 'bf')
		
	if difficulty == 0 then
		randNum = getRandomInt(25, 30)
	end
	if difficulty == 1 then
		setProperty('health', 0) --here, if the difficulty is on villainous mode, you die.
	end
			
	gotHit = true
	timerCompleted = false
	turnedTimerOn = false
end

function onUpdatePost() --Go here after miss()
	if gotHit then
		gotAttacked = gotAttacked + 1
		if difficulty == 0 then
			if gotAttacked == 1 then
				addLuaSprite('counterTime2', true)
				removeLuaSprite('counterTime3', true)
			end
			if gotAttacked == 2 then
				addLuaSprite('counterTime1', true)
				removeLuaSprite('counterTime2', true)
			end
			if gotAttacked == 3 then
				setProperty('health', 0)
			end
		end
		gotHit = false
	end
end

function hit()
	playSound('clickText')
		
	cameraFlash('game', 'cd8b8b', 0.2, false)
	--characterPlayAnim('boyfriend', 'dodge', true)
	triggerEvent('Play Animation', 'dodge', 'bf') --this plays the whole animation lol
		
	if difficulty == 0 then
		randNum = getRandomInt(25, 30)
	end
	if difficulty == 1 then
		randNum = getRandomInt(15, 25)
	end
		
	timerCompleted = false
	turnedTimerOn = false
end