local randomTimerNumb = 0
local randomImageNumb = 0
local randomBitchCount = 0
local LizKianaNaked = 0

local kill = false
local songStarted = false
local pressedKey = false
local timerCompleted = false
local turnedTimerOn = false

local Keys = {'Dodge','Attack'}
local numRand = Keys[math.random(#Keys)]

local ended = false

local cheatsOn = false;

local colors = {
	'03fc20',
    '03fcc2',
    '0318fc',
    '9003fc',
    'fc03d2',
    'fc0303',
    'fc7303',
    'fcf403'
}

function onCreatePost()
	if mechanics and not ended then
		if difficulty >= 0 then
			--setting the random numbers for the timer, images and secret counts lmao
			
			randomBitchCount = math.random(1,10) -- For Secret Text n.1
			LizKianaNaked = math.random(1,15) -- For Secret Text n.2
			
			--creating text and images
			makeLuaText('WarningText', 'PRESS '..numRand..' TO REMOVE POP UP!', 900, 0, 650)
			setTextAlignment('WarningText', 'LEFT')
			setTextSize('WarningText', 40)
			setObjectCamera('WarningText', 'other')
		
			makeLuaSprite('colorChangingBG', 'effects/popups/New/colorChangingBG', 0, 0)
			setScrollFactor('colorChangingBG', 0, 0)
			setObjectCamera('colorChangingBG', 'hud')
			setProperty('colorChangingBG.alpha', 0)
			setObjectOrder('colorChangingBG', getObjectOrder('scoreTxt') + 1)
			addLuaSprite('colorChangingBG', true)
				
			makeLuaSprite('popup', 'effects/popups/New/popup-'..getRandomInt(1,10), 0, 0)
			setScrollFactor('popup', 0, 0)
			setObjectCamera('popup', 'hud')
			setObjectOrder('popup', getObjectOrder('colorChangingBG') + 1)
			setProperty('popup.alpha', 0)
			addLuaSprite('popup', true)
		end
	end
end

function onSongStart()
	if mechanics and not ended then
		if difficulty == 2 then
			randomTimerNumb = math.random(5,7)
		end
		
		if difficulty == 1 then
			randomTimerNumb = math.random(10,15)
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
			health = getProperty('health')
			
			if cheatsOn == false and (botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1) then
				cheatsOn = true;
			end
		
			--setting and running the timer
			if not timerCompleted and songStarted and not turnedTimerOn then
				--debugPrint('Setting Timer Up! Random Number is: ' ..randomTimerNumb)
				
				setProperty('colorChangingBG.color', getColorFromHex(colors[math.random(1, #(colors))]))
				
				runTimer('blackoutStart', randomTimerNumb)
				
				pressedKey = false
				turnedTimerOn = true
			end
			
			--pressing the key selected to redo the mechanic
			if not pressedKey and timerCompleted and keyJustPressed(numRand) then
				kill = false
				
				setProperty('popup.alpha', 0)
				loadGraphic('popup', 'effects/popups/New/popup-'..getRandomInt(1,10))
				
				setProperty('colorChangingBG.alpha', 0)
				setProperty('WarningText.alpha', 0)
				playSound('clickText')
			
				setProperty('boyfriend.stunned', false)
			
				if difficulty == 2 then
					randomTimerNumb = math.random(5,7)
				end
				if difficulty == 1 then
					randomTimerNumb = math.random(10,15)
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
				setTextString('WarningText', 'TOUCH '..numRand..' IF YOU HAVE NO BITCHES')
			elseif LizKianaNaked == 2 then
				setTextString('WarningText', 'TOUCH '..numRand..' For Liz and Kiana Naked')
			else
				setTextString('WarningText', 'TOUCH '..numRand..' TO REMOVE POP UP!')
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
				
				setProperty('colorChangingBG.alpha', 1)
				setProperty('popup.alpha', 1)
				addLuaText('WarningText', true)
				
				if difficulty == 2 then
					runTimer('killTimer', 2)
				else
					runTimer('killTimer', 3)
				end
				
				playSound('ANGRY_TEXT_BOX')
				
				if cheatsOn then
					runTimer('botPlayOn', 0.3)
				end
				
				setProperty('boyfriend.stunned', true)
				
				--debugPrint('Timer Works! Press Space to Reset the Timer!')
				--debugPrint(timerCompleted)
			end
			if tag == 'botPlayOn' then
				kill = false
				
				setProperty('popup.alpha', 0)
				loadGraphic('popup', 'effects/popups/New/popup-'..getRandomInt(1,10))
				
				setProperty('colorChangingBG.alpha', 0)
				setProperty('WarningText.alpha', 0)
				playSound('clickText')
			
				setProperty('boyfriend.stunned', false)
			
				if difficulty == 2 then
					randomTimerNumb = math.random(5,7)
				end
				if difficulty == 1 then
					randomTimerNumb = math.random(10,15)
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