function onCreate()
	makeLuaSprite('sabotage', nil, 0, 0)
	makeGraphic('sabotage', screenWidth, screenHeight, 'FF0000')
	setProperty('sabotage.alpha', 0.0001) -- Avoid lag
	setObjectCamera('sabotage', 'hud')
	addLuaSprite('sabotage', true)
	
	runTimer('bfDiesTime', getRandomInt(24, 72))
	
	setProperty('beef.x', getProperty('beef.x') - 1540)
	
	setProperty('gf.x', getProperty('gf.x') + 100)
	setProperty('gf.y', getProperty('gf.y') - 60)
	doTweenX('bgMove', 'bg', -240, 161 / playbackRate, 'linear')
end

function onBeatHit()
	if curBeat % 4 == 0 and (curBeat >= 80 and curBeat <= 108) then
		sabotageFlash()
	end
	
	if curBeat % 4 == 2 and (curBeat >= 109 and curBeat <= 142) then
		sabotageFlash()
	end
end

function sabotageFlash()
	cancelTween("sabotageEnd")
	setProperty("sabotage.alpha", 0.8)
	doTweenAlpha('sabotageEnd', 'sabotage', 0, 0.7 / playbackRate, 'easeOut')
end

function onTimerCompleted(tag)
	if tag == 'bfDiesTime' then
		doTweenX('bfgoesweee', 'beef', 1840, 40 / playbackRate, 'linear')
		doTweenAngle('bfgoeswooo', 'beef', 360, 46 / playbackRate, 'linear')
	end
end