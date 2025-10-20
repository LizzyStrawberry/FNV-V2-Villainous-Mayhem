local randomTimer = 0
local randomScrollSpeed = 0
local timerStarted = false
local timerEnded = false

function onCreate()
	if mechanics then
		if difficulty == 0 then
			randomTimer = getRandomInt(20, 25)
			randomScrollSpeed = string.format("%.2f",getRandomFloat(0.7, 1.1))
		end
		if difficulty == 1 then
			randomTimer = getRandomInt(12, 20)
			randomScrollSpeed = string.format("%.2f",getRandomFloat(0.7, 1.2))
		end
		if difficulty == 2 then
			randomTimer = getRandomInt(5, 10)
			randomScrollSpeed = string.format("%.2f",getRandomFloat(0.4, 1.3))
		end
	end
end

function onUpdate()
	if mechanics then
		if difficulty >= 0 then
			if not timerStarted and not timerEnded then
				--debugPrint('Timer Started! : '..randomTimer)
				runTimer('changeSpeed', randomTimer)
				timerStarted = true
			end
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'changeSpeed' then
		--debugPrint('Scroll Speed changed to: '.. randomScrollSpeed.. 'x!')
		triggerEvent('Change Scroll Speed', randomScrollSpeed, '0.4')
		setTextString('ShowSpeed', 'Current Speed: '..randomScrollSpeed..'x!')
			
		timerStarted = false
		timerEnded = true
		
		runTimer('changeSeconds', 0.2)
	end
	
	if tag == 'changeSeconds' then
		if difficulty == 0 then
			randomTimer = getRandomInt(20, 25)
			randomScrollSpeed = string.format("%.2f",getRandomFloat(0.7, 1.1))
		end
		if difficulty == 1 then
			randomTimer = getRandomInt(12, 20)
			randomScrollSpeed = string.format("%.2f",getRandomFloat(0.7, 1.2))
		end
		if difficulty == 2 then
			randomTimer = getRandomInt(5, 10)
			randomScrollSpeed = string.format("%.2f",getRandomFloat(0.4, 1.3))
		end
	
		timerEnded = false
	end
end