function onCreate()
	addCharacterToList('MichaelFAalt', 'dad')
	addCharacterToList('KyuAlt', 'boyfriend')
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and difficulty == 1 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getProperty('health') > 0.2 then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.009);
				else
					setProperty('health', health- 0.018);
				end
			end
		end
end

function onUpdate()
	if curBeat == 25 then
		triggerEvent('Play Animation', 'switch', 'dad')
	end
	if curBeat == 28 then
		triggerEvent('Change Character', 'dad', 'MichaelFAalt')
	end
	if curBeat == 30 then
		triggerEvent('Play Animation', 'switch', 'bf')
	end
	if curBeat == 33 then
		triggerEvent('Change Character', 'bf', 'KyuAlt')
	end
	if curBeat == 92 then
		triggerEvent('Change Character', 'dad', 'MichaelFA')
	end
	if curBeat == 124 then
		triggerEvent('Change Character', 'bf', 'Kyu')
	end
	if curBeat == 156 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		triggerEvent('Change Character', 'dad', 'MichaelFAalt')
	end
	if curBeat == 157 then
		triggerEvent('Play Animation', 'switch', 'bf')
	end
	if curBeat == 160 then
		triggerEvent('Change Character', 'bf', 'KyuAlt')
	end
	if curBeat == 188 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
	end
end

function onBeatHit()
	if curBeat >= 156 and curBeat < 188 then
		if curBeat % 2 == 0 then
			triggerEvent('Add Camera Zoom', '0.035', '0.035')
		end
	end
	if curBeat >= 188 and curBeat <= 220 then
		if curBeat % 1 == 0 then
			triggerEvent('Add Camera Zoom', '0.055', '0.055')
		end
	end
end