function onCreate()
	setProperty('iconP2.alpha', 0)
	setProperty('dad.alpha', 0)
	setProperty('boyfriend.alpha', 0)
	setProperty('BG.alpha', 0)
	setProperty('CFront.alpha', 0)
	
	if performanceWarn then
		setProperty('dad.visible', false)
		setProperty('boyfriend.visible', false)
		
		setProperty('gfOptimized.alpha', 0)
		setProperty('bgIntro.alpha', 0)
	end
end

function onUpdatePost()
	if performanceWarn then
		setProperty('gfOptimized.angle', getProperty('boyfriend.angle'))
	end
	if curBeat < 92 then
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
		end
	end
end

function onBeatHit()
	if (curBeat >= 96 and curBeat < 256) or (curBeat >= 288 and curBeat < 384) or (curBeat >= 465 and curBeat < 593)
	or (curBeat >= 625 and curBeat < 754) then
		triggerEvent('Add Camera Zoom', '0.03', '0.03')
	end
	if (curBeat >= 256 and curBeat < 288) or (curBeat >= 593 and curBeat < 625) then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom', '0.05', '0.05')
		end
	end
	if curBeat >= 448 and curBeat < 465 then
		if curBeat % 4 == 0 then
			triggerEvent('Add Camera Zoom', '0.05', '0.05')
		end
	end

	if not performanceWarn then
		if curBeat == 16 then
			doTweenAlpha('boyfriend', 'boyfriend', 1, 0.9 / playbackRate, 'circOut')
		end
		if curBeat == 92 then
			for i = 0, 3 do
				noteTweenAlpha('dadNOTE'..i, i, 1, 0.6 / playbackRate, 'circOut')
			end
			doTweenAlpha('dad', 'dad', 1, 0.9 / playbackRate, 'cubeInOut')
			doTweenAlpha('BG', 'BG', 1, 0.9 / playbackRate, 'cubeInOut')
			doTweenAlpha('CFront', 'CFront', 1, 0.9 / playbackRate, 'cubeInOut')
			doTweenAlpha('iconP2', 'iconP2', 1, 0.9 / playbackRate, 'cubeInOut')
		end
		if curBeat == 96 then
			cameraFlash('game', 'ffffff', 0.6 / playbackRate, false)
		end
		if curBeat == 384 then
			doTweenZoom('camGame', 'camGame', 1.4, 24 / playbackRate, 'cubeInOut')
		end
		if curBeat == 448 then
			cancelTween('camGame')
		end
		if curBeat == 465 then
			cameraFlash('game', 'ffffff', 0.6 / playbackRate, false)
		end
		if curStep == 3016 then
			triggerEvent('Add Camera Zoom', '0.08', '0.08')
			cameraFlash('game', 'ffffff', 0.6 / playbackRate, false)
		end
		if curBeat == 761 then
			doTweenAlpha('camGame', 'camGame', 0, 0.3 / playbackRate, 'circOut')
		end
	else
		if curBeat == 16 then
			doTweenAlpha('gfOptimized', 'gfOptimized', 1, 0.9 / playbackRate, 'circOut')
		end
		if curBeat == 48 then
			doTweenAlpha('bgIntro', 'bgIntro', 1, 1.9 / playbackRate, 'circOut')
		end
		if curBeat == 92 then
			for i = 0, 3 do
				noteTweenAlpha('dadNOTE'..i, i, 1, 0.6 / playbackRate, 'circOut')
			end
			doTweenAlpha('kianaOptimized', 'kianaOptimized', 1, 0.9 / playbackRate, 'cubeInOut')
			doTweenAlpha('iconP2', 'iconP2', 1, 0.9 / playbackRate, 'cubeInOut')
		end
		if curBeat == 96 then
			cameraFlash('game', 'ffffff', 0.6 / playbackRate, false)
			removeLuaSprite('bgIntro', true)
		end
		if curBeat == 384 then
			doTweenZoom('camGame', 'camGame', 1.4 * zoomMult, 24 / playbackRate, 'cubeInOut')
		end
		if curBeat == 448 then
			cancelTween('camGame')
			setProperty("mainCamZoom", true)
		end
		if curBeat == 465 then
			cameraFlash('game', 'ffffff', 0.6 / playbackRate, false)
		end
		if curStep == 3016 then
			triggerEvent('Add Camera Zoom', '0.08', '0.08')
			cameraFlash('game', 'ffffff', 0.6 / playbackRate, false)
		end
		if curBeat == 761 then
			doTweenAlpha('camGame', 'camGame', 0, 0.3 / playbackRate, 'circOut')
		end
	end
end