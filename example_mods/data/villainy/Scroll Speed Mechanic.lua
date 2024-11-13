local beatsAllowed = {3, 7, 15, 23, 31}
local beatSelected
local randomScrollSpeed = 0
local allow = false

function onCreate()
	if mechanics then
		beatSelected = getRandomInt(1, #(beatsAllowed))
		if difficulty == 0 or (isStoryMode and difficulty == 1) then
			randomScrollSpeed = string.format("%.2f",getRandomFloat(1, 1.20))
		end
		if difficulty == 1 or ((isStoryMode or isInjectionMode) and difficulty == 1) then
			randomScrollSpeed = string.format("%.2f",getRandomFloat(1, 1.15))
		end
	end
end

function onUpdate()
	if mechanics then
		if difficulty >= 1 then
			if curBeat >= 80 and curBeat % 32 == beatsAllowed[beatSelected] and allow == false then
				allow = true
			end
		end
	end
end

function onStepHit()
	if allow and curStep % 8 == 0 then
		allow = false
		triggerChange()
	end
end

function triggerChange()
	triggerEvent('Change Scroll Speed', randomScrollSpeed, '0.4')
			
	if difficulty == 0 or (isStoryMode and difficulty == 1) then
		randomScrollSpeed = string.format("%.2f",getRandomFloat(1, 1.25))
	end
	if difficulty == 1 or ((isStoryMode or isInjectionMode) and difficulty == 2) then
		randomScrollSpeed = string.format("%.2f",getRandomFloat(1, 1.35))
	end
end