local dollLocations = {{450, 210, 0.7}, {900, 210, 0.7}, {200, 210, 0.9}, {1050, 210, 0.9}}
local handLocations = {{200, -250, 0.4}, {700, -250, 0.4}, {-200, -450, 0.6}, {700, -450, 0.6}}
local dollsDeployed = 0

function onCreate()
	addCharacterToList('Narrin Side', 'dad')
	setProperty('dad.alpha', 0)
	setProperty('camGame.alpha', 0)
	
	for i = 1, 4 do
		makeAnimatedLuaSprite('dancer'..i, 'bgs/narrin/Dancers', dollLocations[i][1], dollLocations[i][2] - 1000);
		addAnimationByPrefix('dancer'..i, 'dance', 'dolls idle', 24 / playbackRate, false);
		scaleObject('dancer'..i, dollLocations[i][3], dollLocations[i][3])
		updateHitbox('dancer'..i)
		setProperty('dancer'..i..'.alpha', 1)
		addLuaSprite('dancer'..i, false)
		objectPlayAnimation('dancer'..i, 'dance', true);
	end
	
	makeLuaSprite('arm', 'bgs/narrin/hand', handLocations[1][1], handLocations[1][2] - 1000);
	setProperty('arm.alpha', 1)
	scaleObject('arm', handLocations[1][3], handLocations[1][3])
	addLuaSprite('arm', false)
	
	runTimer('dollsSpin', 0.33)
end

function onCreatePost()
	setProperty('iconP2.alpha', 0)
end

function onUpdate()
	if curStep == 128 then
		setProperty('camGame.alpha', 1)
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
	end
	if curStep == 248 then
		doTweenZoom('camGame', 'camGame', 2, 0.7 / playbackRate, 'cubeIn')
	end
	if curBeat == 64 then
		cancelTween('camGame')
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('camZooming', true)
		setProperty('defaultCamZoom', 1.1 * zoomMult)
	end
	if curBeat == 96 then
		setProperty('bg.alpha', 0)
		setProperty('boyfriend.alpha', 0)
		setProperty('defaultCamZoom', 0.9 * zoomMult)
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
		setProperty('defaultCamZoom', 0.95 * zoomMult)
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		triggerEvent('Change Character', 'dad', 'Narrin Side')
	end
	if curBeat == 391 then
		setProperty('defaultCamZoom', 1.5 * zoomMult)
	end
	if curBeat == 392 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('defaultCamZoom', 0.8 * zoomMult)
	end
	if curStep == 1584 then
		doTweenY('dollAppear', 'dancer1', dollLocations[1][2], 1.15 / playbackRate, 'cubeInOut')
		doTweenY('handAppear', 'arm', handLocations[1][2], 1.17 / playbackRate, 'cubeInOut')
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

function onTimerCompleted(tag)
	if tag == 'dollsSpin' then
		for i = 1, 4 do
			objectPlayAnimation('dancer'..i, 'dance', true);
		end
		runTimer('dollsSpin', 0.33)
	end
end

function onTweenCompleted(tag)
	if tag == 'handAppear' then
		dollsDeployed = dollsDeployed + 1
		if dollsDeployed == 1 then
			doTweenY('handDisappear', 'arm', handLocations[1][2] - 1000, 1.17 / playbackRate, 'cubeInOut')
		elseif dollsDeployed == 2 then
			doTweenY('handDisappear', 'arm', handLocations[2][2] - 1000, 1.17 / playbackRate, 'cubeInOut')
		elseif dollsDeployed == 3 then
			doTweenY('handDisappear', 'arm', handLocations[3][2] - 1000, 1.17 / playbackRate, 'cubeInOut')
		elseif dollsDeployed == 4 then
			doTweenY('handDisappear', 'arm', handLocations[4][2] - 1000, 1.17 / playbackRate, 'cubeInOut')
		end
	end
	
	if tag == 'handDisappear' then
		if dollsDeployed == 1 then
			setProperty('arm.x', handLocations[2][1])
			setProperty('arm.y', handLocations[2][2] - 1000)
			scaleObject('arm', handLocations[2][3], handLocations[2][3])
			doTweenY('dollAppear', 'dancer2', dollLocations[2][2], 1.15 / playbackRate, 'cubeInOut')
			doTweenY('handAppear', 'arm', handLocations[2][2], 1.17 / playbackRate, 'cubeInOut')
		elseif dollsDeployed == 2 then
			setProperty('arm.x', handLocations[3][1])
			setProperty('arm.y', handLocations[3][2] - 1000)
			scaleObject('arm', handLocations[3][3], handLocations[3][3])
			doTweenY('dollAppear', 'dancer3', dollLocations[3][2], 1.15 / playbackRate, 'cubeInOut')
			doTweenY('handAppear', 'arm', handLocations[3][2], 1.17 / playbackRate, 'cubeInOut')
		elseif dollsDeployed == 3 then
			setProperty('arm.x', handLocations[4][1])
			setProperty('arm.y', handLocations[4][2] - 1000)
			scaleObject('arm', handLocations[4][3], handLocations[4][3])
			doTweenY('dollAppear', 'dancer4', dollLocations[4][2], 1.15 / playbackRate, 'cubeInOut')
			doTweenY('handAppear', 'arm', handLocations[4][2], 1.17 / playbackRate, 'cubeInOut')
		end
	end
end