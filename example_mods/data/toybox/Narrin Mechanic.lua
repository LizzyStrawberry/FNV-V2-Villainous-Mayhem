local activated = false
local bulletCount = 5

local beatsAllowed = {1, 3, 7, 15, 23, 31}
local beatSelected
local dollOriginalPos = {{-900, 100}, {-900, 100}, {2100, 100}}
local canDodge = false
local allow = false
local selectedDoll = 0
local dodged = false
local gotHit = false
local allowDodge = true
local setUp = false

local jammedGun = false
local unjamming = false
local toUnjam = 0

local bulletsToKill = 4 --default

local botPlayOn = false
local buff3On = false
secondsToKill = 30 --default
function onCreatePost()
	if mechanics then
		setPropertyFromClass('PlayState', 'revivingNarrin', false)
		setPropertyFromClass('PlayState', 'reloadingGun', false)
		makeLuaSprite('barBack', 'effects/faithBarBack', 1100, 170) --Used to drain the health smoothly
		
		makeLuaSprite('ammoBox', 'effects/unjammed', 930, 550);
		if downscroll then
			setProperty('ammoBox.y', 0)
		end
		setObjectOrder('ammoBox', getObjectOrder('scoreTxt') + 1)
		setObjectCamera('ammoBox', 'hud')
		setProperty('ammoBox.alpha', 0)
		addLuaSprite('ammoBox', true)
		
		for i = 1, #(dollOriginalPos) do
			makeAnimatedLuaSprite('Doll N'..i, 'characters/Narrin Mechanics', dollOriginalPos[i][1], dollOriginalPos[i][2]);
			addAnimationByPrefix('Doll N'..i, 'spin', 'narrin spin', 24 / playbackRate, false);
			addAnimationByPrefix('Doll N'..i, 'dead', 'narrin dead', 24 / playbackRate, false);
			scaleObject('Doll N'..i, 0.7, 0.7)
			objectPlayAnimation('Doll N'..i, 'spin', true);
			addLuaSprite('Doll N'..i, true)
		end
		
		makeLuaSprite('dollWarning', 'effects/dollWarning', 0, 0)
		setScrollFactor('dollWarning', 0, 0)
		setObjectCamera('dollWarning', 'hud')
		setProperty('dollWarning.alpha', 0)
		addLuaSprite('dollWarning', true)
	
		beatSelected = beatsAllowed[getRandomInt(1, 6)]
		runTimer('continueSpin', 0.34 / playbackRate)
		
		if difficulty == 0 then
			bulletsToKill = getRandomInt(2, 4)
			toUnjam = getRandomInt(1, 2)
		end
		if difficulty == 1 then
			bulletsToKill = getRandomInt(3, 6)
			toUnjam = getRandomInt(2, 3)
		end
		if difficulty == 2 then
			bulletsToKill = getRandomInt(4, 6)
			toUnjam = getRandomInt(3, 5)
		end
		if isMayhemMode then
			bulletsToKill = getRandomInt(2, 15)
			toUnjam = getRandomInt(3, 7)
		end
	end
end

local resCharmOn = false
function onUpdate()
	if mechanics then
		if botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 then
			botPlayOn = true
		end
		if activated then
			--Health Mechanic
			if not isMayhemMode then
				setProperty('health', getProperty('barBack.scale.y') * 2)
				health = getProperty('barBack.scale.y')
			elseif isMayhemMode then
				health = getHealth();
			end
			
			--Shooting
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 and not resCharmOn then
				cancelTween('backBarfill')
				cancelTimer('drainDelay')
				
				setUpTime()

				resCharmOn = true
			end
			if getPropertyFromClass('ClientPrefs', 'buff3Active') == true and not buff3On then
				buff3On = true
			else
				buff3On = false
			end
			
			--Dodging
			if curBeat % 32 == beatSelected and not allow and not canDodge and not jammedGun then
				allow = true
				
				selectedDoll = getRandomInt(2,3)
				if selectedDoll == 3 then
					setProperty('dollWarning.flipX', true)
				else
					setProperty('dollWarning.flipX', false)
				end
			end
			if curBeat % 32 == 0 and allow then
				canDodge = true
			end
			
			if botPlayOn then
				dodged = true
			else
				if keyJustPressed('dodge') and allowDodge then
					triggerEvent('Play Animation', 'dodge', 'boyfriend')
					allowDodge = false
				end
				if getProperty('boyfriend.animation.curAnim.finish') and getProperty('boyfriend.animation.curAnim.name') == 'dodge' then --Cooldown of 1 second
					runTimer('fixDodge', 0.6 / playbackRate)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'dodge' then
					dodged = true
				else
					dodged = false
				end
			end
			
			if canDodge then
				if not setUp then
					if curStep % 16 == 0 then
						playSound('CrystalAlarm', 0.1)
						setProperty('dollWarning.alpha', 1)
						doTweenAlpha('dollWarn', 'dollWarning', 0, 0.6 / playbackRate, 'circOut')
					end
					if curStep % 16 == 4 then
						playSound('CrystalAlarm', 0.1)
						setProperty('dollWarning.alpha', 1)
						doTweenAlpha('dollWarn', 'dollWarning', 0, 0.6 / playbackRate, 'circOut')
					end
					if curStep % 16 == 8 then
						if selectedDoll == 2 then
							doTweenX('dollMove2', 'Doll N2', dollOriginalPos[3][1], 2.6 / playbackRate, 'easeIn')
						elseif selectedDoll == 3 then
							doTweenX('dollMove3', 'Doll N3', dollOriginalPos[2][1], 2.6 / playbackRate, 'easeIn')
						end
						setUp = true
					end
				end
				if getProperty('Doll N2.x') >= 850.00 and getProperty('Doll N2.x') <= 910.00 then
					if botPlayOn then
						triggerEvent('Play Animation', 'dodge', 'boyfriend')
					end
					if not dodged and not gotHit then
						jammedGun = true
						playSound('gunjam')
						triggerEvent('Play Animation', 'hit', 'boyfriend')
						
						setPropertyFromClass('PlayState', 'reloadingGun', true)
						runTimer('reloadFix', 0.3 / playbackRate)
						
						loadGraphic('ammoBox', 'effects/jammed')
						
						if buff3On then
							setProperty('health', health - 0)
						elseif resCharmOn then
							if isMayhemMode then
								setProperty('health', health - 7.5)
							else
								setProperty('barBack.scale.y', health - 0.035)
							end
						else
							if isMayhemMode then
								setProperty('health', health - 15)
							else
								setProperty('barBack.scale.y', health - 0.07)
							end
						end
						
						cancelTween('backBarfill')
						cancelTimer('drainDelay')
						setUpTime()
						
						gotHit = true
					end
				end
				if getProperty('Doll N3.x') >= 870.00 and getProperty('Doll N3.x') <= 950.00 then
					if botPlayOn then
						triggerEvent('Play Animation', 'dodge', 'boyfriend')
					end
					if not dodged and not gotHit then
						jammedGun = true
						playSound('gunjam')
						triggerEvent('Play Animation', 'hit', 'boyfriend')
						
						setPropertyFromClass('PlayState', 'reloadingGun', true)
						runTimer('reloadFix', 0.3 / playbackRate)
						
						loadGraphic('ammoBox', 'effects/jammed')

						if buff3On then
							setProperty('health', health - 0)
						elseif resCharmOn == true then
							if isMayhemMode then
								setProperty('health', health - 7.5)
							else
								setProperty('barBack.scale.y', health - 0.035)
							end
						else
							if isMayhemMode then
								setProperty('health', health - 15)
							else
								setProperty('barBack.scale.y', health - 0.07)
							end
						end
						
						cancelTween('backBarfill')
						cancelTimer('drainDelay')
						setUpTime()
						
						gotHit = true
					end
				end
			end
			
			--Jamming - Unjamming
			if jammedGun == true then
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
					
					if difficulty == 0 then
						toUnjam = getRandomInt(1, 2)
					end
					if difficulty == 1 then
						toUnjam = getRandomInt(2, 3)
					end
					if difficulty == 2 then
						toUnjam = getRandomInt(3, 5)
					end
					if isMayhemMode then
						toUnjam = getRandomInt(3, 7)
					end
				end	
			end
		end

		if curBeat == 136 then --Set up mechanics
			activated = true
			doTweenAlpha('ammoBox', 'ammoBox', 1, 1.6 / playbackRate, 'circOut')
			setProperty('barBack.scale.y', getHealth() / 2)
			setUpTime()
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
				
				if bulletsToKill > 0 then
					triggerEvent('Play Animation', 'dodge', 'dad')
				end
				if bulletsToKill == 0 then
					if not isMayhemMode then
						if health < 1 then
							setProperty('barBack.scale.y', health + 0.35)
							if getProperty('barBack.scale.y') > 1 then
								setProperty('barBack.scale.y', 1)
							end
							setProperty('health', getProperty('barBack.scale.y') * 2)
						end
					elseif isMayhemMode then
						if health < 150 then
							setProperty('health', health + 15)
						end
					end
					
					bulletsToKill = -1
					
					setPropertyFromClass('PlayState', 'revivingNarrin', true)
					triggerEvent('Play Animation', 'dead', 'dad')
					runTimer('reviveNarrin', 1 / playbackRate)
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
	if difficulty == 0 then
		secondsToKill = 45
	elseif difficulty == 1 then
		secondsToKill = 35
	elseif difficulty == 2 then
		secondsToKill = 25
	end
				
	if resCharmOn then
		secondsToKill = (secondsToKill + 15) * (getHealth() / 2)
	else
		secondsToKill = secondsToKill * (getHealth() / 2)
	end
	
	if not isMayhemMode and not buff3On then
		runTimer('drainDelay', 0.3 / playbackRate)
	end
	
	setVar("secondsToKill", secondsToKill)
end

function onTweenCompleted(tag)
	if tag == 'dollMove1' then
		if difficulty == 0 then
			bulletsToKill = getRandomInt(2, 4)
		end
		if difficulty == 1 then
			bulletsToKill = getRandomInt(3, 6)
		end
		if difficulty == 2 then
			bulletsToKill = getRandomInt(4, 6)
		end
		if isMayhemMode then
			bulletsToKill = getRandomInt(2, 15)
		end
		setProperty('dad.alpha', 1)
		setPropertyFromClass('PlayState', 'revivingNarrin', false)
		setProperty('Doll N1.x', dollOriginalPos[1][1])
	end	
	if tag == 'dollMove2' then
		canDodge = false
		setUp = false
		allow = false
		gotHit = false
		setProperty('Doll N2.x', dollOriginalPos[2][1])
		
		beatSelected = beatsAllowed[getRandomInt(1, 6)]
	end
	if tag == 'dollMove3' then
		canDodge = false
		setUp = false
		allow = false
		gotHit = false
		setProperty('Doll N3.x', dollOriginalPos[3][1])
		
		beatSelected = beatsAllowed[getRandomInt(1, 6)]
	end
end

function onTimerCompleted(tag)
	if tag == 'drainDelay' then
		if getPropertyFromClass('ClientPrefs', 'buff1Active') == false and getPropertyFromClass('ClientPrefs', 'buff2Active') == false
		and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			doTweenY('backBarfill', 'barBack.scale', 0, math.floor(secondsToKill / playbackRate), 'easeIn')
		end
	end
	if tag == 'reload' then
		playSound('reload')
		triggerEvent('Play Animation', 'unjammed', 'boyfriend')
		
		runTimer('reloadFix', 0.3 / playbackRate)
	end
	if tag == 'reloadFix' then
		setPropertyFromClass('PlayState', 'reloadingGun', false)
	end
	if tag == 'continueSpin' then
		for i = 1, 3 do
			objectPlayAnimation('Doll N'..i, 'spin', true);
		end
		runTimer('continueSpin', 0.34 / playbackRate)
	end
	if tag == 'reviveNarrin' then
		doTweenX('dollMove1', 'Doll N1', 200, 1.9 / playbackRate, 'cubeInOut')
		doTweenAlpha('dad', 'dad', 0, 0.6 / playbackRate, 'cubeIn')
	end
	if tag == 'fixDodge' then
		allowDodge = true
	end
	if tag == 'unjamSequence' then
		unjamming = false
	end
end

function onDestroy()
	setPropertyFromClass('PlayState', 'revivingNarrin', false)
	setPropertyFromClass('PlayState', 'reloadingGun', false)
end