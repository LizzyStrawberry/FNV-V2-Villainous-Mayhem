local beefOriginScaleY
function onCreate()	
	makeLuaSprite('sabotage', '', -800, -600)
	makeGraphic('sabotage', 5000, 5000, 'FF0000')
	setScrollFactor('sabotage', 0, 0)
	setProperty('sabotage.alpha', 0)
	setObjectCamera('sabotage', 'game')
	addLuaSprite('sabotage', true)
	
	setObjectOrder('beef', getObjectOrder('beef') + 1)
	setProperty('beef.y', getProperty('beef.y') + 350)
	setProperty('beef.origin.y', 280)
	beefOriginScaleY = getProperty('beef.scale.y')
	
	setProperty('gf.x', getProperty('gf.x') - 120)
	setProperty('gf.y', getProperty('gf.y') - 60)
	doTweenX('bgMove', 'bg', -240, 139, 'linear')
end

function onBeatHit()
	if curBeat == 92 then
		doTweenAlpha('sabotage', 'sabotage', 0.8, 0.06 / playbackRate, 'circOut')
	end
	if curBeat == 94 then
		doTweenAlpha('sabotage', 'sabotage', 0.8, 0.06 / playbackRate, 'circOut')
	end
	if curBeat == 95 then
		cancelTween('sabotageEnd')
		doTweenAlpha('sabotage', 'sabotage', 0.8, 0.06 / playbackRate, 'circOut')
	end
	if curBeat % 4 == 2 and ((curBeat >= 96 and curBeat <= 160) or (curBeat >= 256 and curBeat <= 352)) then
		doTweenAlpha('sabotage', 'sabotage', 0.8, 0.06 / playbackRate, 'circOut')
	end
	if curBeat % 4 == 0 then
		setProperty('beef.scale.y', beefOriginScaleY - 0.05)
		doTweenY('beefY', 'beef.scale', beefOriginScaleY, 0.26 / playbackRate, 'sineOut')
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
		doTweenAlpha('sabotageEnd', 'sabotage', 0, 0.7 / playbackRate, 'easeOut')
	end
end