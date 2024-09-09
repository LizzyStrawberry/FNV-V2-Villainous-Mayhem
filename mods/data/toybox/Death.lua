local dead = false

function onTweenCompleted(tag)
	if tag == 'boyfriend' then
		dead = true
	end
end

function onTimerCompleted(tag)
	if tag == 'blackOut' then
		if inGameOver then
			setProperty('boyfriend.alpha', 0)
		end
	end
	if tag == 'wait' then
		if inGameOver then
			doTweenAlpha('boyfriend', 'boyfriend', 1, 24, 'linear')
		end
	end
end

function onGameOverStart()
	if not dead then
		--setProperty('boyfriend.alpha', 0)
		setScrollFactor('boyfriend', 0, 0)
		screenCenter('boyfriend', 'XY')
		
		setProperty('boyfriend.x', getProperty('boyfriend.x') + 140)
		--setProperty('boyfriend.y', getProperty('boyfriend.y') + 210)
		
		cameraSetTarget('boyfriend')
		runTimer('wait', 4.9)
		runTimer('blackOut', 3)
		dead = true
		return Function_Stop;
	end
	return Function_Continue;
end