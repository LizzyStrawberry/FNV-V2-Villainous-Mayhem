local activated = false
local bulletCount = 5

local beatsAllowed = {1, 3, 7, 15, 23, 31}
local beatSelected
local dollOriginalPos = {{-900, 100}, {-900, 100}, {2100, 100}}
local canDodge, allow, pressedDodge, dodged, gotHit, setUp = false, false, false, false, false, false
local selectedDoll = 0
local allowDodge = true
local botAnim = false

local jammedGun, unjamming = false, false
local toUnjam = 0

local bulletsToKill = 4 --default

local botPlayOn, buff3On = false, false
secondsToKill = 30 --default

local healthLeft

function onCreate()
	setPropertyFromClass('PlayState', 'revivingNarrin', false)
	setPropertyFromClass('PlayState', 'reloadingGun', false)
	makeLuaSprite('barBack', 'effects/faithBarBack', 1100, 170) --Used to drain the health smoothly
end

function onCreatePost()
	if mechanics then
		makeLuaSprite('ammoBox', 'effects/unjammed', mobileFix("X", 930), 550)
		if downscroll then setProperty('ammoBox.y', 0) end
		setObjectOrder('ammoBox', getObjectOrder('scoreTxt') + 1)
		setObjectCamera('ammoBox', 'hud')
		setProperty('ammoBox.alpha', 0)
		addLuaSprite('ammoBox', true)
		
		for i = 1, #(dollOriginalPos) do
			makeAnimatedLuaSprite('Doll N'..i, 'characters/Narrin Mechanics', dollOriginalPos[i][1], dollOriginalPos[i][2])
			addAnimationByPrefix('Doll N'..i, 'spin', 'narrin spin', 24 / playbackRate, false)
			addAnimationByPrefix('Doll N'..i, 'dead', 'narrin dead', 24 / playbackRate, false)
			scaleObject('Doll N'..i, 0.7, 0.7)
			objectPlayAnimation('Doll N'..i, 'spin', true)
			addLuaSprite('Doll N'..i, true)
			
			if i ~= 1 then
				makeLuaSprite('dollHitbox'..i, nil, getProperty('Doll N'..i..'.x') - 25, getProperty('Doll N'..i..'.y') + 400)
				makeGraphic('dollHitbox'..i, 150, 100, "FFFFFF")
				setProperty('dollHitbox'..i..'.visible', false)
				addLuaSprite('dollHitbox'..i, true)
			end
		end
		
		makeLuaSprite('dollWarning', 'effects/dollWarning', 0, 0)
		setScrollFactor('dollWarning', 0, 0)
		setObjectCamera('dollWarning', 'hud')
		setProperty('dollWarning.alpha', 0)
		setGraphicSize("dollWarning", screenWidth, screenHeight)
		addLuaSprite('dollWarning', true)
		
		makeLuaSprite('picoHitbox', nil, getProperty("boyfriend.x") + 180, getProperty("boyfriend.y") + 75)
		makeGraphic("picoHitbox", 100, getProperty("boyfriend.height") - 50, "E0E0E0")
		setProperty('picoHitbox.visible', false)
		addLuaSprite('picoHitbox', true)
	
		beatSelected = beatsAllowed[getRandomInt(1, 6)]
		runTimer('continueSpin', 0.34 / playbackRate)
		
		if isMayhemMode then
			bulletsToKill = getRandomInt(2, 15)
			toUnjam = getRandomInt(3, 7)
		elseif difficulty == 0 then
			bulletsToKill = getRandomInt(2, 4)
			toUnjam = getRandomInt(1, 2)
		elseif difficulty == 1 then
			bulletsToKill = getRandomInt(3, 6)
			toUnjam = getRandomInt(2, 3)
		elseif difficulty == 2 then
			bulletsToKill = getRandomInt(4, 6)
			toUnjam = getRandomInt(3, 5)
		end
		
		if botPlayOn then bulletsToKill = getRandomInt(2, 3) end
	end
end

local resCharmOn = false

function onUpdate(elapsed)
	if mechanics then
		-- Checks
		if botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 and not botPlayOn then botPlayOn = true end
		buff3On = getPropertyFromClass('ClientPrefs', 'buff3Active') and true or false
		
		-- Set up hitbox positions
		for i = 2, 3 do setProperty("dollHitbox"..i..".x", getProperty("Doll N"..i..".x") + 100) end
		
		if activated then
		--Health Mechanic
			if not isMayhemMode then setProperty('health', getProperty('barBack.scale.y') * 2) healthLeft = getProperty('barBack.scale.y')
			else healthLeft = getHealth() end
			
			--Shooting
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 and not resCharmOn then
				cancelTween('backBarfill')
				cancelTimer('drainDelay')
				
				setUpTime()

				resCharmOn = true
			end
			
			--Dodging
			if curBeat % 32 == beatSelected and not allow and not canDodge and not jammedGun then
				allow = true
				
				selectedDoll = getRandomInt(2, 3)
				setProperty('dollWarning.flipX', selectedDoll == 3 and true or false)
			end
			if curBeat % 32 == 0 and allow then canDodge = true end
			
			if botPlayOn then pressedDodge = true
			else
				if keyJustPressed('dodge') and allowDodge then
					triggerEvent('Play Animation', 'dodge', 'boyfriend')
					allowDodge = false
				end
				
				pressedDodge = getProperty('boyfriend.animation.curAnim.name') == 'dodge' and true or false
			end
			if getProperty('boyfriend.animation.curAnim.finish') and getProperty('boyfriend.animation.curAnim.name') == 'dodge' then
				runTimer('fixDodge', 0.25 / playbackRate)
			end
			
			if canDodge then
				if not setUp then
					if curStep % 16 == 0 or curStep % 16 == 4 then
						playSound('CrystalAlarm', 0.1)
						setProperty('dollWarning.alpha', 1)
						doTweenAlpha('dollWarn', 'dollWarning', 0, 0.6 / playbackRate, 'circOut')
					end
					if curStep % 16 == 8 then
						doTweenX('dollMove'..selectedDoll, 'Doll N'..selectedDoll, dollOriginalPos[selectedDoll == 2 and 3 or 2][1], 2.6 / playbackRate, 'easeIn')
						setUp = true
					end
				end
				if objectsOverlap("picoHitbox", "dollHitbox2") or objectsOverlap("picoHitbox", "dollHitbox3") then
					if botPlayOn and not botAnim then triggerEvent('Play Animation', 'dodge', 'boyfriend') botAnim = true end
					
					if pressedDodge then dodged = true end
				end
			end

			--Jamming - Unjamming
			if jammedGun then
				if keyJustPressed('attack') and toUnjam > 0 and not unjamming then
					playSound('gunjam')
					unjamming = true
					setPropertyFromClass('PlayState', 'reloadingGun', true)
					triggerEvent('Play Animation', 'jammed', 'boyfriend')
					runTimer('reloadFix', 0.3 / playbackRate)
					runTimer('unjamSequence', 0.6 / playbackRate)
					toUnjam = toUnjam - 1
				end
				if toUnjam == 0 then
					jammedGun = false
					
					loadGraphic('ammoBox', 'effects/unjammed')
						
					playSound('reload')
					triggerEvent('Play Animation', 'unjammed', 'boyfriend')
							
					setPropertyFromClass('PlayState', 'reloadingGun', true)
					runTimer('reloadFix', 0.3 / playbackRate)
					
					if isMayhemMode then
						toUnjam = getRandomInt(1, 7)
					elseif difficulty == 0 then
						toUnjam = getRandomInt(1, 2)
					elseif difficulty == 1 then
						toUnjam = getRandomInt(2, 3)
					elseif difficulty == 2 then
						toUnjam = getRandomInt(3, 5)
					end			
				end	
			end
		end	
	end
end

function onUpdatePost(elapsed)
	if mechanics then
		if activated then
			--Dodging
			if canDodge then
				if objectsOverlap("picoHitbox", "dollHitbox2") or objectsOverlap("picoHitbox", "dollHitbox3") then
					if not gotHit and not dodged then
						jammedGun = true
						playSound('gunjam')
						triggerEvent('Play Animation', 'hit', 'boyfriend')
							
						setPropertyFromClass('PlayState', 'reloadingGun', true)
						runTimer('reloadFix', 0.3 / playbackRate)
							
						loadGraphic('ammoBox', 'effects/jammed')
						
						if buff3On then setProperty('health', healthLeft - 0)
						else
							local healthToDrain = 0.07 -- DEFAULT
							if isMayhemMode then
								if resCharmOn then healthToDrain = 7.5 else healthToDrain = 15 end
								setProperty('health', healthLeft - healthToDrain)
							else
								if resCharmOn then healthToDrain = 0.035 end
								setProperty('barBack.scale.y', healthLeft - healthToDrain)
							end
						end
							
						cancelTween('backBarfill')
						cancelTimer('drainDelay')
						setUpTime()
							
						gotHit = true
					end
				end
			end
		end	
	end
end

function onBeatHit()
	if mechanics then
		if curBeat == 136 then --Set up mechanics
			activated = true
			runTimer('delayedTimeFix', 0.05 / playbackRate)
			doTweenAlpha('ammoBox', 'ammoBox', 1, 1.6 / playbackRate, 'circOut')
			setProperty('barBack.scale.y', getHealth() / 2)
		end
		if curBeat == 456 then
			activated = false
			doTweenAlpha('ammoBox', 'ammoBox', 0, 1.6 / playbackRate, 'circOut')
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote, noteData)
	if mechanics and activated then
		if noteType == 'Bullet Notes' then
			if jammedGun then
				playSound('gunJam')
				triggerEvent('Play Animation', 'jammed', 'boyfriend')
			else
				playSound('gunshot')
				triggerEvent('Screen Shake', '0.06, 0.02', '0.08, 0.03')
				
				bulletCount = bulletCount - 1
				bulletsToKill = bulletsToKill - 1
			
				cancelTween('backBarfill')
				cancelTimer('drainDelay')
				
				if bulletsToKill == 0 then
					if isMayhemMode then
						if healthLeft < 150 then setProperty('health', healthLeft + 15) end
					else
						if healthLeft < 1 then
							setProperty('barBack.scale.y', healthLeft + 0.35)
							if getProperty('barBack.scale.y') > 1 then setProperty('barBack.scale.y', 1) end
						end
					end
					
					bulletsToKill = -1
					
					setPropertyFromClass('PlayState', 'revivingNarrin', true)
					triggerEvent('Play Animation', 'dead', 'dad')
					runTimer('reviveNarrin', 1 / playbackRate)
					runTimer('delayedTimeFix', 0.05 / playbackRate)
					
					setUpTime()
				end
				
				if bulletCount == 0 then
					bulletCount = 5
					
					setPropertyFromClass('PlayState', 'reloadingGun', true)
					runTimer('reload', 0.2 / playbackRate)
				end
				
				triggerEvent('Play Animation', 'shoot', 'boyfriend')
				
				setUpTime()
			end
		end
	end
end

function setUpTime()
	secondsToKill = 45 - (difficulty * 10) -- -0, -10, -20
				
	if resCharmOn then secondsToKill = (secondsToKill + 15) * (getHealth() / 2)
	else secondsToKill = secondsToKill * (getHealth() / 2) end

	if not isMayhemMode and not buff3On then cancelTimer('drainDelay') runTimer('drainDelay', 0.5) end
	
	setVar("secondsToKill", secondsToKill)
end

function onTweenCompleted(tag)
	if tag == 'dollMove1' then
		if isMayhemMode then bulletsToKill = getRandomInt(2, 15)
		elseif difficulty == 0 then bulletsToKill = getRandomInt(2, 4)
		elseif difficulty == 1 then bulletsToKill = getRandomInt(3, 6)
		elseif difficulty == 2 then bulletsToKill = getRandomInt(4, 8) end
		
		if botPlayOn then bulletsToKill = getRandomInt(2, 3) end
		
		setProperty('dad.alpha', 1)
		setPropertyFromClass('PlayState', 'revivingNarrin', false)
		setProperty('Doll N1.x', dollOriginalPos[1][1])
	end	
	for i = 2, 3 do
		if tag == 'dollMove'..i then
			canDodge = false
			setUp = false
			allow = false
			dodged = false
			gotHit = false
			setProperty('Doll N'..i..'.x', dollOriginalPos[i][1])
			
			beatSelected = beatsAllowed[getRandomInt(1, 6)]
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'drainDelay' then
		if not getPropertyFromClass('ClientPrefs', 'buff1Active') and not getPropertyFromClass('ClientPrefs', 'buff2Active')
		and not getPropertyFromClass('ClientPrefs', 'buff3Active') then
			doTweenY('backBarfill', 'barBack.scale', 0, secondsToKill, 'easeIn')
		end
	end
	if tag == 'reload' then
		playSound('reload')
		triggerEvent('Play Animation', 'unjammed', 'boyfriend')
		
		runTimer('reloadFix', 0.3 / playbackRate)
	end
	if tag == 'reloadFix' then setPropertyFromClass('PlayState', 'reloadingGun', false) end
	if tag == 'continueSpin' then
		for i = 1, 3 do playAnim('Doll N'..i, 'spin', true) end
		runTimer('continueSpin', 0.34 / playbackRate)
	end
	if tag == 'reviveNarrin' then
		doTweenX('dollMove1', 'Doll N1', 200, 1.9 / playbackRate, 'cubeInOut')
		doTweenAlpha('dad', 'dad', 0, 0.6 / playbackRate, 'cubeIn')
	end
	if tag == 'fixDodge' then 
		allowDodge = true 
		if botPlayOn then botAnim = false end
	end
	if tag == 'unjamSequence' then unjamming = false end
	if tag == "delayedTimeFix" then	setUpTime() end
end

function onDestroy()
	setPropertyFromClass('PlayState', 'revivingNarrin', false)
	setPropertyFromClass('PlayState', 'reloadingGun', false)
end