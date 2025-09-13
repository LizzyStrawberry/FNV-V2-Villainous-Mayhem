local beefOriginScaleY
function onCreate()	
	makeLuaSprite('sabotage', nil, 0, 0)
	makeGraphic('sabotage', screenWidth, screenHeight, 'FF0000')
	setProperty('sabotage.alpha', 0.0001) -- Avoid Lag
	setObjectCamera('sabotage', 'hud')
	addLuaSprite('sabotage', true)
	
	setObjectOrder('beef', getObjectOrder('beef') + 1)
	setProperty('beef.y', getProperty('beef.y') + 350)
	setProperty('beef.origin.y', 280)
	beefOriginScaleY = getProperty('beef.scale.y')
	
	setProperty('gf.x', getProperty('gf.x') - 120)
	setProperty('gf.y', getProperty('gf.y') - 60)
	doTweenX('bgMove', 'bg', -240, 139 / playbackRate, 'linear')
end

function onBeatHit()
	if curBeat == 92 then
		sabotageFlash()
	end
	if curBeat == 94 then
		sabotageFlash()
	end
	if curBeat == 95 then
		sabotageFlash()
	end
	if curBeat % 4 == 2 and ((curBeat >= 96 and curBeat <= 160) or (curBeat >= 256 and curBeat <= 352)) then
		sabotageFlash()
	end
	if curBeat % 4 == 0 then
		setProperty('beef.scale.y', beefOriginScaleY - 0.05)
		doTweenY('beefY', 'beef.scale', beefOriginScaleY, 0.26 / playbackRate, 'sineOut')
	end
end

function sabotageFlash()
	cancelTween("sabotageEnd")
	setProperty("sabotage.alpha", 0.8)
	doTweenAlpha('sabotageEnd', 'sabotage', 0, 0.7 / playbackRate, 'easeOut')
end