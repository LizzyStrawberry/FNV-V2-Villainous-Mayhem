local dead = false

function onTimerCompleted(tag)
	if tag == 'flash1' then
		if inGameOver then
			cameraFlash('game', 'ffffff', 0.2, false)
		end
	end
	if tag == 'flash2' then
		if inGameOver then
			cameraFlash('game', 'ff00ff', 0.9, false)
		end
	end
end

function onGameOverStart()
	if not dead then
		setScrollFactor('boyfriend', 0, 0)
		screenCenter('boyfriend', 'XY')
		
		setProperty('boyfriend.y', getProperty('boyfriend.y') + 150)
		setProperty('boyfriend.x', getProperty('boyfriend.x') + 200)
		
		cameraSetTarget('boyfriend')
		runTimer('flash1', 2.67)
		runTimer('flash2', 10.6)
		dead = true
		return Function_Stop;
	end
	return Function_Continue;
end