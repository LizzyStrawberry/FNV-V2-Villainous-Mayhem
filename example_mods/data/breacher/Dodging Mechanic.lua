local beatsAllowed = {1, 3, 7, 15, 23, 31}
local beatSelected
local allow = false
local attack = false
local allowDodge = false
local dodged = false
local flash = false
local botPlayOn = false

function onCreate()
	if mechanics then
		makeLuaSprite('dodgeWarning', 'effects/dodgeWarning', 0, 0)
		setScrollFactor('dodgeWarning', 0, 0)
		setObjectCamera('dodgeWarning', 'hud')
		setProperty('dodgeWarning.alpha', 0)
		addLuaSprite('dodgeWarning', true)
		
		beatSelected = getRandomInt(1, #(beatsAllowed))
	end
end

function onUpdate()
	if mechanics then
		if curBeat >= 308 and curBeat <= 524 then
			if botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 then
				botPlayOn = true
			end
			if botPlayOn then
				if attack and allowDodge then
					allowDodge = false
					dodged = true
				end
			else
				if attack and allowDodge and keyJustPressed('dodge') then
					allowDodge = false
					dodged = true
				end
			end
		end
	end
end

local sing = {'LEFT', 'RIGHT', 'UP', 'DOWN'}
function onBeatHit()
	if mechanics then
		if curBeat >= 308 and curBeat <= 524 then
			if attack == true then
				if curBeat % 4 == 0 then
					setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.15)
					doTweenAlpha('dodgeWarning', 'dodgeWarning', 0.3, 0.5 / playbackRate, 'circOut')
					playSound('tick')
				end
				if curBeat % 4 == 1 then
					setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.15)
					doTweenAlpha('dodgeWarning', 'dodgeWarning', 0.6, 0.5 / playbackRate, 'circOut')
					playSound('tick')
				end
				if curBeat % 4 == 2 then
					setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.15)
					doTweenAlpha('dodgeWarning', 'dodgeWarning', 0.9, 0.5 / playbackRate, 'circOut')
					playSound('tick')
					allowDodge = true
				end
				if curBeat % 4 == 3 then
					doTweenAlpha('dodgeWarning', 'dodgeWarning', 0, 0.5 / playbackRate, 'circOut')
					setProperty('defaultCamZoom', 0.7)
					if dodged then
						playSound('gfDodge')
						playSound('ding')
						triggerEvent('Play Animation', 'dodge', 'bf')
						triggerEvent('Play Animation', 'attack', 'gf')
					else
						playSound('acid')
						cameraFlash('game', '51d431', 0.7 / playbackRate, false)
						triggerEvent('Play Animation', 'sing'..sing[getRandomInt(1, 4)]..'miss', 'bf')
						triggerEvent('Play Animation', 'attack', 'gf')
						
						if isMayhemMode then
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
								setProperty('health', getHealth() - 5)
							else
								setProperty('health', getHealth() - 10)
							end
						else
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
								if difficulty == 1 then
									setProperty('health', getHealth() - 0.475)
								else
									setProperty('health', getHealth() - 0.275)
								end
							else
								if difficulty == 1 then
									setProperty('health', getHealth() - 0.950)
								else
									setProperty('health', getHealth() - 0.550)
								end
							end
						end
						
						flash = true
						runTimer('flashing', 2)
					end
					
					allow = false
					attack = false
					allowDodge = false
					dodged = false
					
					beatSelected = getRandomInt(1, #(beatsAllowed))
				end
			end
			if curBeat >= 32 and curBeat % 32 == beatsAllowed[beatSelected] and attack == false and allow == false then
				allow = true
			end
		end
	end
end

function onStepHit()
	if mechanics then
		if curBeat >= 308 and curBeat <= 524 then
			if not attack and allow and curStep % 16 == 15 then
				attack = true
			end
			if flash then
				if curStep % 2 == 0 then
					setProperty('boyfriend.alpha', 0)
				end
				if curStep % 2 == 1 then
					setProperty('boyfriend.alpha', 1)
				end
			end
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'flashing' then
		setProperty('boyfriend.alpha', 1)
		flash = false
	end
end