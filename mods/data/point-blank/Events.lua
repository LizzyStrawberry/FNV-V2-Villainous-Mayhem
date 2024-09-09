function onCreate()
	setProperty('gf.visible', false)
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

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and difficulty >= 1 then
			if getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.0075);
				else
					setProperty('health', health- 0.015);
				end
			end
		end
end