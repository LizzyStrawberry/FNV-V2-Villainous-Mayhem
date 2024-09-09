local dead = false

function onGameOverStart()
	if not dead then
		setScrollFactor('boyfriend', 0, 0)
		screenCenter('boyfriend', 'XY')
		
		setProperty('boyfriend.x', getProperty('boyfriend.x'))
		cameraFlash('game', 'FFFFFF', 0.1, false)
		dead = true
		return Function_Stop;
	end
	return Function_Continue;
end