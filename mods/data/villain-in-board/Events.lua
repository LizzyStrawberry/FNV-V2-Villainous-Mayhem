function onCreate()
	setProperty('gf.visible', false)
	
	makeLuaSprite('sabotage', '', -800, -600)
	makeGraphic('sabotage', 5000, 5000, 'FF0000')
	setScrollFactor('sabotage', 0, 0)
	setProperty('sabotage.alpha', 0)
	setObjectCamera('sabotage', 'game')
	addLuaSprite('sabotage', true)
	
	runTimer('bfDiesTime', getRandomInt(24, 72))
	
	setProperty('beef.x', getProperty('beef.x') - 1540)
	
	doTweenX('bgMove', 'bg', -240, 161, 'linear')
end

function onBeatHit()
	if curBeat % 4 == 0 and (curBeat >= 80 and curBeat <= 108) then
		doTweenAlpha('sabotage', 'sabotage', 0.8, 0.06, 'circOut')
	end
	
	if curBeat % 4 == 2 and (curBeat >= 109 and curBeat <= 142) then
		doTweenAlpha('sabotage', 'sabotage', 0.8, 0.06, 'circOut')
	end
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and difficulty == 1 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getProperty('health') > 0.2 then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.0085);
				else
					setProperty('health', health- 0.019);
				end
			end
		end
end

function onTweenCompleted(tag)
	if tag == 'sabotage' then
		doTweenAlpha('sabotageEnd', 'sabotage', 0, 0.7, 'easeOut')
	end
end

function onTimerCompleted(tag)
	if tag == 'bfDiesTime' then
		doTweenX('bfgoesweee', 'beef', 1840, 40, 'linear')
		doTweenAngle('bfgoeswooo', 'beef', 360, 46, 'linear')
	end
end