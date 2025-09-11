function onCreate()
	setProperty('gf.x', getProperty('gf.x') - 50)
	setProperty('gf.y', getProperty('gf.y') + 50)
	setPropertyFromClass('PlayState', 'gfSpeed', 2)
	
	setProperty('boyfriend.y', getProperty('boyfriend.y') + 50)
	
	makeLuaSprite('leftBGEffect', 'effects/bgEffect')
	setScrollFactor('leftBGEffect', 0, 0)
	setObjectCamera('leftBGEffect', 'hud')
	setGraphicSize("leftBGEffect", screenWidth, screenHeight)
	setProperty('leftBGEffect.alpha', 0)
	addLuaSprite('leftBGEffect', true)
	
	makeLuaSprite('rightBGEffect', 'effects/bgEffect')
	setScrollFactor('rightBGEffect', 0, 0)
	setObjectCamera('rightBGEffect', 'hud')
	setProperty('rightBGEffect.alpha', 0)
	setGraphicSize("rightBGEffect", screenWidth, screenHeight)
	setProperty('rightBGEffect.flipX', true)
	addLuaSprite('rightBGEffect', true)
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if (curBeat >= 160 and curBeat <= 224) then
		if direction == 0 then
			setProperty('rightBGEffect.color', getColorFromHex('9700FF'))
			setProperty('rightBGEffect.alpha', 1)
			cancelTween('rightBGEffect')
			doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 1 then
			setProperty('rightBGEffect.color', getColorFromHex('00FFFF'))
			setProperty('rightBGEffect.alpha', 1)
			cancelTween('rightBGEffect')
			doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 2 then
			setProperty('rightBGEffect.color', getColorFromHex('00FF00'))
			setProperty('rightBGEffect.alpha', 1)
			cancelTween('rightBGEffect')
			doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 3 then
			setProperty('rightBGEffect.color', getColorFromHex('FF0000'))
			setProperty('rightBGEffect.alpha', 1)
			cancelTween('rightBGEffect')
			doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
	end
end

function onBeatHit()
	if (curBeat >= 160 and curBeat <= 224) then
		triggerEvent('Add Camera Zoom', 0.04, 0.035)
	end
	
	if curBeat == 32 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false) 
	end
	if curBeat == 96 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		setProperty('defaultCamZoom', 1.3)
	end
	if curBeat == 160 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		setProperty('defaultCamZoom', 0.9)
	end
	if curBeat == 224 then
		setProperty('defaultCamZoom', 1.3)
	end
	if curBeat == 256 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		setProperty('defaultCamZoom', 0.9)
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote) -- health draining mechanic
	if (curBeat >= 160 and curBeat <= 224) then
		if direction == 0 then
			setProperty('leftBGEffect.color', getColorFromHex('9700FF'))
			setProperty('leftBGEffect.alpha', 1)
			cancelTween('leftBGEffect')
			doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 1 then
			setProperty('leftBGEffect.color', getColorFromHex('00FFFF'))
			setProperty('leftBGEffect.alpha', 1)
			cancelTween('leftBGEffect')
			doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 2 then
			setProperty('leftBGEffect.color', getColorFromHex('00FF00'))
			setProperty('leftBGEffect.alpha', 1)
			cancelTween('leftBGEffect')
			doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 3 then
			setProperty('leftBGEffect.color', getColorFromHex('FF0000'))
			setProperty('leftBGEffect.alpha', 1)
			cancelTween('leftBGEffect')
			doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
	end
end