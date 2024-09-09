local randomTimerNumb = 0
local randomImageNumb = 0
local randomBitchCount = 0
local LizKianaNaked = 0

local kill = false
local songStarted = false
local pressedKey = false
local timerCompleted = false
local turnedTimerOn = false

local Keys = {'A','B','C','D','SPACE'}
local numRand = Keys[math.random(#Keys)]

local ended = false

local cheatsOn = false

function onCreatePost()
	if mechanics and not ended then
		if difficulty >= 0 then		
			randomBitchCount = math.random(1,10)
			LizKianaNaked = math.random(1,15)
		
			--creating text and images
			makeLuaText('WarningText', 'PRESS '..numRand..' TO REMOVE POP UP!', 900, 0, 650)
			setTextAlignment('WarningText', 'LEFT')
			setTextSize('WarningText', 40)
			setObjectCamera('WarningText', 'other')
			
			makeLuaSprite('popup', 'effects/popups/Old/popup-'..math.random(1,10), 0, 0)
			setScrollFactor('popup', 0, 0)
			setObjectCamera('popup', 'hud')
			setObjectOrder('popup', getObjectOrder('scoreTxt') + 1)
			setProperty('popup.alpha', 0)
			addLuaSprite('popup', true)
		end
	end
end

function onSongStart()
	if mechanics and not ended then
		if difficulty == 1 then
			randomTimerNumb = math.random(10,20)
		end
		if difficulty == 0 then
			randomTimerNumb = math.random(20,25)
		end
		songStarted = true
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if timerCompleted and noteType == '' and mechanics then
		setProperty('health', health - 0)
	end
end

function onUpdate()
if mechanics and not ended then
	if difficulty >= 0 then
		--measuring the hp
		health = getProperty('health')
		
		if cheatsOn == false and (botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1) then
			cheatsOn = true;
		end
		
		--setting and running the timer
		if not timerCompleted and songStarted and not turnedTimerOn then
			--debugPrint('Setting Timer Up! Random Number is: ' ..randomTimerNumb)
		
			runTimer('blackoutStart', randomTimerNumb)
			
			pressedKey = false
			turnedTimerOn = true
		end
		--pressing the key selected to redo the mechanic
		if not cheatsOn and (not pressedKey and timerCompleted and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..numRand)) then
			kill = false
			
			setProperty('popup.alpha', 0)
			loadGraphic('popup', 'effects/popups/Old/popup-'..getRandomInt(1,10))

			setProperty('WarningText.alpha', 0)
			playSound('clickText')
		
			setProperty('boyfriend.stunned', false)

			if difficulty == 1 then
				randomTimerNumb = math.random(10,20)
			end
			if difficulty == 0 then
				randomTimerNumb = math.random(20,25)
			end
		
			
			numRand = Keys[math.random(#Keys)]
		
			timerCompleted = false
			pressedKey = true
			turnedTimerOn = false
			drainHealth = false
		end
	
		--setting text
		if randomBitchCount == 7 then
			setTextString('WarningText', 'PRESS '..numRand..' IF YOU HAVE NO BITCHES')
		elseif LizKianaNaked == 2 then
			setTextString('WarningText', 'PRESS '..numRand..' For Liz and Kiana Naked')
		else
			setTextString('WarningText', 'PRESS '..numRand..' TO REMOVE POP UP!')
		end
	end
end
end

function onStepHit()
	if mechanics and not ended then
		--text flash
		if curStep % 4 == 0 and timerCompleted then
			setProperty('WarningText.alpha', 1)
		end
		if curStep % 4 == 2 and timerCompleted then
			setProperty('WarningText.alpha', 0)
		end
	end
end

function onTimerCompleted(tag)
	if mechanics and not ended then
		if difficulty >= 0 then
		--once the timer is completed
		if tag == 'blackoutStart' then
			kill = true
			timerCompleted = true
			drainHealth = true
			
			setProperty('popup.alpha', 1)
			addLuaText('WarningText', true)
			
			runTimer('killTimer', 3)

			
			playSound('ANGRY_TEXT_BOX')
			
			if cheatsOn then
				runTimer('botPlayOn', 1)
			end
			
			setProperty('boyfriend.stunned', true)
			
			--debugPrint('Timer Works! Press Space to Reset the Timer!')
			--debugPrint(timerCompleted)
		end
		if tag == 'botPlayOn' then
			kill = false
			
			setProperty('popup.alpha', 0)
			loadGraphic('popup', 'effects/popups/Old/popup-'..getRandomInt(1,10))
			
			setProperty('WarningText.alpha', 0)
			playSound('clickText')
			
			setProperty('boyfriend.stunned', false)

			if difficulty == 1 then
				randomTimerNumb = math.random(10,20)
			end
			if difficulty == 0 then
				randomTimerNumb = math.random(20,25)
			end
			
			numRand = Keys[math.random(#Keys)]
			
			timerCompleted = false
			pressedKey = true
			turnedTimerOn = false
			drainHealth = false
		end
		if tag == 'killTimer' then
			if kill == true then
				setProperty('health', 0)
			end
		end
		end
	end
end

function onEndSong()
	ended = true
	cancelTimer('blackoutStart')
	return Function_Continue
end