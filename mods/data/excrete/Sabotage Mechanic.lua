math.randomseed(os.time())

local randomTimerNumb = 0

local kill = false
local songStarted = false
local pressedKey = 0
local timerCompleted = false
local turnedTimerOn = false
local autoEnabled = false

local ended = false

function onCreatePost()
	if mechanics and not ended then
		if (isStoryMode and difficulty >= 1) or (not isStoryMode and difficulty >= 0) then
			--creating sprite
			makeLuaSprite('BlackBack', '', -800, -600)
			makeGraphic('BlackBack', 5000, 5000, '000000')
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
		if (isStoryMode and difficulty >= 1) or (not isStoryMode and difficulty >= 0) then
			sabotageTimer()
			songStarted = true
		end
	end
end

function onUpdate()
	if mechanics and not ended then
		-- For Botplay and AutoCharm:
		if botPlay then
			autoEnabled = true
		end
		
		if (isStoryMode and difficulty >= 1) or (not isStoryMode and difficulty >= 0) then
			--measuring the hp
			health = getProperty('health')
			--setting and running the timer
			if not mustHitSection then
				if not timerCompleted and songStarted and not turnedTimerOn then
					--debugPrint('Setting Timer Up! Random Number is: ' ..randomTimerNumb)
				
					runTimer('blackoutStart', randomTimerNumb)
					
					turnedTimerOn = true
				end
			end
			--pressing the key selected to increase the space counter to 10
			if pressedKey <= 9 and timerCompleted and keyJustPressed('dodge') and autoEnabled == false then
				pressedKey = pressedKey + 1
				playSound('clickText', 0.4)
			end
			--Fix the lights
			if pressedKey == 10 then
				kill = false

				sabotageTimer()

				cancelTween('BlackBackReduceView')
				doTweenAlpha('BlackBackIncreaseView', 'BlackBack', 0, 1.6, 'circOut')
			
				timerCompleted = false
				pressedKey = true
				turnedTimerOn = false
				pressedKey = 0
			end
		end
	end
end

function onTimerCompleted(tag)
	if mechanics and not ended then
		if (isStoryMode and difficulty >= 1) or (not isStoryMode and difficulty >= 0) then
		--once the timer is completed
			if tag == 'blackoutStart' then
				kill = true
				timerCompleted = true
				drainHealth = true
			
				setProperty('Warning.alpha', 1)
			
				runTimer('killTimer', 5)
			
				if botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 then
					runTimer('botPlayOn', 1)
				end
				
				playSound('lightsOut')
				doTweenAlpha('BlackBackReduceView', 'BlackBack', 0.85, 1.8, 'cubeInOut')
			
				--debugPrint('Timer Works! Press Space to Reset the Timer!')
				--debugPrint(pressedKey)
			end
			if tag == 'botPlayOn' then
				kill = false
		
				sabotageTimer()
				cancelTween('BlackBackReduceView')
				doTweenAlpha('BlackBackIncreaseView', 'BlackBack', 0, 1.8, 'cubeInOut')
			
				timerCompleted = false
				turnedTimerOn = false
				pressedKey = 0
			end
			if tag == 'killTimer' then
				if kill == true then
					setProperty('health', 0)
					setProperty('BlackBack.alpha', 0)
				end
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

function onGameOverStart()
	ended = true
	return Function_Continue
end

function onEndSong()
	ended = true
	return Function_Continue
end