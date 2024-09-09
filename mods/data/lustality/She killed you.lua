local dead = false

function onCreatePost()
	makeLuaSprite('blackout', ' ', 0, 0)
	makeGraphic('blackout', 2000, 2000, '000000')
	setObjectCamera('blackout', 'other')
end

function onTweenCompleted(tag)
	if tag == 'blackout' then
		dead = true
	end
end

function onTimerCompleted(tag)
	if tag == 'wait' then
		if inGameOver then
			doTweenAlpha('blackout', 'blackout', 0, 7, 'linear')
		end
	end
end

function onGameOverStart()
	if not dead then
		addLuaSprite('blackout', true)
		cameraSetTarget('boyfriend')
		runTimer('wait', 3)
		dead = true
		return Function_Stop;
	end
	return Function_Continue;
end