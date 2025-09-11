function onCreate()
	setProperty('gf.visible', false)
	setProperty('gf.x', getProperty('gf.x') - 500)
	setProperty('gf.y', getProperty('gf.y') + 500)
	
	makeAnimatedLuaSprite('speaker', 'characters/Speaker', getProperty('boyfriend.x') - 250, getProperty('boyfriend.y') + 250)
	addAnimationByPrefix('speaker', 'idle', 'Speaker0', 24 / playbackRate, false);
	setScrollFactor('speaker', 0.95, 0.95)
	setObjectCamera('speaker', 'game')
	addLuaSprite('speaker', false)
	objectPlayAnimation('speaker', 'idle', true);
	
	makeLuaSprite('blackBG', '', -300, -300)
	makeGraphic('blackBG', 2000, 2000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	setProperty('blackBG.alpha', 0)
	addLuaSprite('blackBG', true)
end

function onSongStart()
	cameraHudY = getProperty('camHUD.y')
end

local hudThings = {'healthBar', 'healthBarBG', 'scoreTxt', 'timeTxt', 'timeBar', 'timeBarBG', 'iconP1', 'iconP2', 'charmSocket'}
function onUpdate()
	if curBeat == 16 then
		setProperty('defaultCamZoom', 0.9 * zoomMult)
	end
	if curBeat == 78 then
		setProperty('defaultCamZoom', 1.4 * zoomMult)
	end
	if curBeat == 79 then
		setProperty('defaultCamZoom', 1.7 * zoomMult)
	end
	if curBeat == 80 then
		cameraFlash('game', 'ffffff', 0.7 / playbackRate, false)
		setProperty('defaultCamZoom', 1.3 * zoomMult)
		setProperty('gf.visible', true)
	end
	if curBeat == 144 then
		setProperty('defaultCamZoom', 0.9 * zoomMult)
	end
	if curBeat == 207 then
		setProperty('defaultCamZoom', 1.4 * zoomMult)
	end
	if curBeat == 208 then
		cameraFlash('game', 'ffffff', 0.7 / playbackRate, false)
		setProperty('defaultCamZoom', 1.2 * zoomMult)
	end
	if curBeat == 272 then
		setProperty('defaultCamZoom', 0.9 * zoomMult)
		doTweenAngle('camHudAngle', 'camHUD', 0, 0.6 / playbackRate, 'circOut')
		doTweenAngle('camGameAngle', 'camGame', 0, 0.6 / playbackRate, 'circOut')
	end
	if curBeat == 336 then
		setProperty('defaultCamZoom', 1.3 * zoomMult)
	end
	if curBeat == 368 then
		doTweenAlpha('blackBg', 'blackBG', 1, 0.7 / playbackRate, 'circOut')
		for i = 0, 7 do
			noteTweenAlpha('noteBye'..i, i, 0, 1.7 / playbackRate, 'linear')
		end
		for i = 1, #(hudThings) do
			doTweenAlpha(hudThings[i], hudThings[i], 0, 1.7 / playbackRate, 'linear')
		end
	end
end

function onBeatHit()
	objectPlayAnimation('speaker', 'idle', true);
	if curBeat >= 80 and curBeat < 144 then
		if curBeat % 1 == 0 then
			setProperty('camHUD.y', cameraHudY + 10)
			doTweenY('canHud', 'camHUD', cameraHudY, 0.4 / playbackRate, 'circOut')
		end
	end
	if curBeat >= 208 and curBeat < 272 then
		if curBeat % 1 == 0 then
			setProperty('camHUD.y', cameraHudY + 10)
			doTweenY('canHud', 'camHUD', cameraHudY, 0.4 / playbackRate, 'circOut')
		end
		if curBeat % 4 == 0 then
			doTweenAngle('camHudAngle', 'camHUD', 5, 0.6 / playbackRate, 'circOut')
			doTweenAngle('camGameAngle', 'camGame', 5, 0.6 / playbackRate, 'circOut')
		end
		if curBeat % 4 == 2 then
			doTweenAngle('camHudAngle', 'camHUD', -5, 0.6 / playbackRate, 'circOut')
			doTweenAngle('camGameAngle', 'camGame', -5, 0.6 / playbackRate, 'circOut')
		end
	end
end