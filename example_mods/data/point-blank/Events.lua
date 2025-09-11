function onCreate()
	makeAnimatedLuaSprite('speaker', 'characters/Speaker', 700, 350)
	addAnimationByPrefix('speaker', 'idle', 'Speaker0', 24 / playbackRate, false);
	setScrollFactor('speaker', 0.95, 0.95)
	setObjectCamera('speaker', 'game')
	addLuaSprite('speaker', false)
	objectPlayAnimation('speaker', 'idle', true);
end

function onUpdate()
	if curBeat == 64 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		triggerEvent('Toggle Trail', '1', '1')
	end
	if curBeat == 336 or curBeat == 448 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
	end
	if curBeat == 608 then
		setProperty('camGame.alpha', 0)
	end
end

function onBeatHit()
	objectPlayAnimation('speaker', 'idle', true);
	if ((curBeat >= 64 and curBeat < 128) or (curBeat >= 192 and curBeat < 256) or (curBeat >= 336 and curBeat < 384)
	or (curBeat >= 448 and curBeat < 608)) and curBeat % 1 == 0 then
		triggerEvent('Add Camera Zoom', '0.05', '0.05')
	end
	if curBeat >= 384 and curBeat < 448 and curBeat % 2 == 0 then
		triggerEvent('Add Camera Zoom', '0.065', '0.065')
	end
	if ((curBeat >= 128 and curBeat < 192) or (curBeat >= 256 and curBeat < 320)) and curBeat % 4 == 0 then
		triggerEvent('Add Camera Zoom', '0.065', '0.065')
	end
end