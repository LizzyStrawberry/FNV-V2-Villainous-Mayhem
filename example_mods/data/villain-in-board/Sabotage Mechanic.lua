math.randomseed(os.time())

local randomTimerNumb = 0

local kill = false
local songStarted = false
local pressedKey = 0
local allowDodge = false
local timerCompleted = false
local turnedTimerOn = false
local autoEnabled = false

local ended = false

function onCreatePost()
	if mechanics and not ended then
		if difficulty >= 1 then
			--creating sprite
			makeLuaSprite('BlackBack', '', 0, 0)
			makeGraphic('BlackBack', screenWidth, screenHeight, '000000')
			setScrollFactor('BlackBack', 0, 0)
			setProperty('BlackBack.alpha', 0)
			setObjectCamera('BlackBack', 'hud')
			addLuaSprite('BlackBack', true)
			
			precacheSound('lightsOut')
		end
	end
end


function onSongStart()
	if mechanics and not ended then
		if difficulty >= 1 then
			sabotageTimer()
			songStarted = true
		end
	end
end

local drainRate = 0.3

function onUpdate(elapsed)
	if mechanics and not ended then
		-- For Botplay and AutoCharm:
		if botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 then
			autoEnabled = true
		end
		
		if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
			drainRate = 0.15
		end
		
		if difficulty >= 1 then
			-- Measuring the hp
			health = getProperty('health')
			-- Setting and running the timer
			if not mustHitSection then
				if not timerCompleted and songStarted and not turnedTimerOn then
					runTimer('blackoutStart', randomTimerNumb)
					
					turnedTimerOn = true
				end
			end
			
			if allowDodge then
				-- Press the key selected to increase the space counter to 10
				if pressedKey <= 9 and timerCompleted and not autoEnabled then
					setProperty("BlackBack.alpha", getProperty("BlackBack.alpha") + (elapsed * drainRate))
					if keyJustPressed('dodge') then
						setProperty("BlackBack.alpha", getProperty("BlackBack.alpha") - 0.05)
						pressedKey = pressedKey + 1
						playSound('clickText', 0.4)
					end
				end
				
				--Fix the lights
				if pressedKey == 10 then
					kill = false

					sabotageTimer()

					cancelTween('BlackBackReduceView')
					doTweenAlpha('BlackBackIncreaseView', 'BlackBack', 0, 1, 'circOut')
				
					allowDodge = false
					timerCompleted = false
					turnedTimerOn = false
					pressedKey = 0
				end
				
				if getProperty("BlackBack.alpha") >= 1 then
					if kill then
						setProperty('health', 0)
						setProperty('BlackBack.visible', false)
					end
				end
			end
		end
	end
end

function onTimerCompleted(tag)
	if mechanics and not ended then
		if difficulty >= 1 then
		--once the timer is completed
			if tag == 'blackoutStart' then
				kill = true
				timerCompleted = true
				drainHealth = true

				playSound('lightsOut')
				doTweenAlpha('BlackBackReduceView', 'BlackBack', 0.5, 1, 'cubeIn')
			end
			if tag == 'botPlayOn' then
				kill = false
		
				sabotageTimer()
				cancelTween('BlackBackReduceView')
				doTweenAlpha('BlackBackIncreaseView', 'BlackBack', 0, 1, 'circOut')
			
				timerCompleted = false
				turnedTimerOn = false
				pressedKey = 0
			end
			if tag == 'timerFix' then
				sabotageTimer()
			end
		end
	end
end

function sabotageTimer()
	if not mustHitSection then
		randomTimerNumb = math.random(15,25)
	else
		runTimer('timerFix', 1)
	end
end

function onTweenCompleted(tag)
	if tag == "BlackBackReduceView" then
		allowDodge = true
		if autoEnabled then
			runTimer('botPlayOn', 0.01)
		end
	end
end

function onGameOverStart()
	ended = true
	return Function_Continue
end

function onEndSong()
	ended = true
	return Function_Continue
end