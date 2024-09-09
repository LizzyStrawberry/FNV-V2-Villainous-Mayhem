function onCreate()
	setProperty('gf.visible', false)
	setProperty('gf.x', getProperty('gf.x') - 500)
	setProperty('gf.y', getProperty('gf.y') + 500)
	
	
	makeLuaSprite('blackBG', '', -300, -300)
	makeGraphic('blackBG', 2000, 2000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	setProperty('blackBG.alpha', 0)
	addLuaSprite('blackBG', true)
	
	setPropertyFromClass('GameOverSubstate', 'characterName', 'zuyu')
end

function onSongStart()
	cameraHudY = getProperty('camHUD.y')
end

function onUpdate()
	if getProperty('songMisses') == 1 then
		setProperty('health', 0)
	end
	if curBeat == 16 then
		setProperty('defaultCamZoom', 0.9)
	end
	if curBeat == 78 then
		setProperty('defaultCamZoom', 1.4)
	end
	if curBeat == 79 then
		setProperty('defaultCamZoom', 1.7)
	end
	if curBeat == 80 then
		cameraFlash('game', 'ffffff', 0.7, false)
		setProperty('defaultCamZoom', 1.3)
		setProperty('gf.visible', true)
	end
	if curBeat == 144 then
		setProperty('defaultCamZoom', 0.9)
	end
	if curBeat == 207 then
		setProperty('defaultCamZoom', 1.4)
	end
	if curBeat == 208 then
		cameraFlash('game', 'ffffff', 0.7, false)
		setProperty('defaultCamZoom', 1.2)
	end
	if curBeat == 272 then
		setProperty('defaultCamZoom', 0.9)
		doTweenAngle('camHudAngle', 'camHUD', 0, 0.6, 'circOut')
	end
	if curBeat == 336 then
		setProperty('defaultCamZoom', 1.3)
	end
	if curBeat == 368 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.7, 'circOut')
		doTweenAlpha('camHudBye', 'camHUD', 0, 1.7, 'linear')
	end
end

function onBeatHit()
	if curBeat >= 80 and curBeat < 144 then
		if curBeat % 1 == 0 then
			setProperty('camHUD.y', cameraHudY + 10)
			doTweenY('canHud', 'camHUD', cameraHudY, 0.4, 'circOut')
		end
	end
	if curBeat >= 208 and curBeat < 272 then
		if curBeat % 1 == 0 then
			setProperty('camHUD.y', cameraHudY + 10)
			doTweenY('canHud', 'camHUD', cameraHudY, 0.4, 'circOut')
		end
		if curBeat % 4 == 0 then
			doTweenAngle('camHudAngle', 'camHUD', 5, 0.6, 'circOut')
		end
		if curBeat % 4 == 2 then
			doTweenAngle('camHudAngle', 'camHUD', -5, 0.6, 'circOut')
		end
	end
end