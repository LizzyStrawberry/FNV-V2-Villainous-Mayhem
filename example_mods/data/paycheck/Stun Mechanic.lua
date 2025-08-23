local randomBitchCount = 0
local LizKianaNaked = 0

local kill = false

local keyArray = {'Left','Right','Up','Down','Dodge', "Attack"}
local key = nil
local cheatsOn = false

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

local ended = false

function onCreatePost()
	if mechanics and not ended then
		if difficulty >= 0 then
			--setting the random numbers for the timer, images and secret counts lmao
			
			randomBitchCount = getRandomInt(1, 10) -- For Secret Text n.1
			LizKianaNaked = getRandomInt(1, 15) -- For Secret Text n.2
			
			--creating text and images
			makeLuaText('keyWarn', 'PRESS TO REMOVE POP UP!', 900, 0, 650)
			setTextAlignment('keyWarn', 'LEFT')
			setTextSize('keyWarn', 40)
			setObjectCamera('keyWarn', 'other')
			setProperty('keyWarn.visible', false)
		
			makeLuaSprite('colorChangingBG', 'effects/popups/New/colorChangingBG', 0, 0)
			setScrollFactor('colorChangingBG', 0, 0)
			setObjectCamera('colorChangingBG', 'hud')
			setProperty('colorChangingBG.visible', false)
			setObjectOrder('colorChangingBG', getObjectOrder('scoreTxt') + 1)
			addLuaSprite('colorChangingBG', true)
				
			makeLuaSprite('advert', 'effects/popups/New/popup-'..getRandomInt(1, 10), 0, 0)
			setScrollFactor('advert', 0, 0)
			setObjectCamera('advert', 'hud')
			setObjectOrder('advert', getObjectOrder('colorChangingBG') + 1)
			setProperty('advert.visible', false)
			addLuaSprite('advert', true)
			
			addLuaText('keyWarn', true)
		end
	end
end

function onSongStart()
	if mechanics and not ended then
		setUpContents()
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if mechanics and noteType == "" and kill then
		setProperty('health', getHealth() - 0)
	end
end

function onUpdate(elapsed)
	if mechanics and not ended then
		if difficulty >= 0 then
			if not cheatsOn and (botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1) then
				cheatsOn = true
			end
			
			if kill and keyJustPressed(key) then
				setUpContents()
				playSound('clickText')
			end
		end
	end
end

function onStepHit()
	if mechanics and not ended and kill then
		if curStep % 4 == 0 then
			setProperty('keyWarn.visible', true)
		elseif curStep % 4 == 2 then
			setProperty('keyWarn.visible', false)
		end
	end
end

function onTimerCompleted(tag)
	if mechanics and not ended then
		if difficulty >= 0 then
			if tag == 'popUpTimer' then
				kill = true
				playSound('ANGRY_TEXT_BOX')
				
				setProperty('colorChangingBG.visible', true)
				setProperty('advert.visible', true)
				setProperty('boyfriend.stunned', true)
				
				local timeToKill = 5
				if difficulty == 1 then timeToKill = 3 elseif difficulty == 2 then timeToKill = 1.5 end
				runTimer('killTimer', timeToKill)
				
				if cheatsOn then runTimer('botPlayOn', 0.15) end
			end
			
			if tag == 'botPlayOn' then
				setUpContents()
				playSound('clickText')
			end
			
			if tag == 'killTimer' and kill then
				setProperty('health', 0)
			end
		end
	end
end

function setUpContents()
	kill = false
	setProperty('colorChangingBG.visible', false)
	setProperty('keyWarn.visible', false)
	setProperty('advert.visible', false)
				
	-- Set Timer up
	local minTime, maxTime = 20, 25
	if difficulty == 1 then minTime = 10 maxTime = 15 
	elseif difficulty == 2 then minTime = 5 maxTime = 7 end
	
	local timeNum = getRandomInt(minTime, maxTime)
	runTimer('popUpTimer', timeNum)
	
	-- Set up key to press + Text
	key = keyArray[getRandomInt(1, #keyArray)]
	
	if randomBitchCount == 7 then setTextString('keyWarn', 'PRESS '..string.upper(key)..' IF YOU HAVE NO BITCHES')
	elseif LizKianaNaked == 2 then setTextString('keyWarn', 'PRESS '..string.upper(key)..' For Liz and Kiana Naked') 
	else setTextString('keyWarn', 'PRESS '..string.upper(key)..' TO REMOVE POP UP!')
	end
	
	-- Set up BG Color + PopUp
	local color = getColorFromHex(colors[getRandomInt(1, #colors)])
	setProperty('colorChangingBG.color', color)
	loadGraphic('advert', 'effects/popups/New/popup-'..getRandomInt(1, 10))
	
	-- De-stun Player
	setProperty('boyfriend.stunned', false)
end

function onEndSong()
	ended = true
	cancelTimer('popUpTimer')
	cancelTimer('killTimer')
	return Function_Continue
end