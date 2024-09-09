local dead = false

function onTweenCompleted(tag)
	if tag == 'boyfriend' then
		dead = true
	end
end

function onTimerCompleted(tag)
	if tag == 'wait' then
		if inGameOver then
			doTweenAlpha('boyfriend', 'boyfriend', 1, 12, 'linear')
		end
	end
end

function onGameOverStart()
	if not dead then
		setProperty('boyfriend.alpha', 0)
		setScrollFactor('boyfriend', 0, 0)
		screenCenter('boyfriend', 'XY')
		
		setProperty('boyfriend.x', getProperty('boyfriend.x') + 150)
		setProperty('boyfriend.y', getProperty('boyfriend.y') + 105)
		
		cameraSetTarget('boyfriend')
		runTimer('wait', 3)
		dead = true
		return Function_Stop;
	end
	return Function_Continue;
end