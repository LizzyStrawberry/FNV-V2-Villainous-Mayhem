function onCreate()
	addCharacterToList('Narrin Side', 'dad')
	setProperty('dad.alpha', 0)
	setProperty('boyfriend.alpha', 0)
end

function onCreatePost()
	setProperty('iconP2.alpha', 0)
end

function onUpdate()
	if curBeat == 32 then
		setProperty('bg.alpha', 1)
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('boyfriend.alpha', 1)
	end
	if curStep == 248 then
		doTweenZoom('camGame', 'camGame', 2, 0.7 / playbackRate, 'cubeIn')
	end
	if curBeat == 64 then
		cancelTween('camGame')
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('camZooming', true)
		setProperty('defaultCamZoom', 1.1)
	end
	if curBeat == 96 then
		setProperty('bg.alpha', 0)
		setProperty('boyfriend.alpha', 0)
		setProperty('defaultCamZoom', 0.9)
	end
	if curBeat == 98 then
		doTweenAlpha('dad', 'dad', 1, 10 / playbackRate, 'cubeInOut')
		doTweenAlpha('iconP2', 'iconP2', 1, 10 / playbackRate, 'cubeInOut')
	end
	if curStep == 520 then
		triggerEvent('Play Animation', 'laugh', 'dad')
	end
	if curBeat == 136 then
		setProperty('bg.alpha', 1)
		setProperty('boyfriend.alpha', 1)
		setProperty('defaultCamZoom', 0.8)
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		triggerEvent('Change Character', 'dad', 'Narrin Side')
	end
	if curBeat == 391 then
		setProperty('defaultCamZoom', 1.5)
	end
	if curBeat == 392 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('defaultCamZoom', 0.8)
	end
	if curBeat == 456 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		doTweenAlpha('gameByeBye', 'camGame', 0, 3 / playbackRate, 'cubeInOut')
	end
end

function onBeatHit()
	if (curBeat >= 136 and curBeat <= 264) or (curBeat >= 328 and curBeat <= 392) then
		triggerEvent('Add Camera Zoom', 0.06, 0.04)
	end
	if curBeat >= 392 and curBeat <= 456 then
		triggerEvent('Add Camera Zoom', 0.08, 0.06)
	end
end