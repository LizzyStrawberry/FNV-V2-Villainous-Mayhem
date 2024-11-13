function onCreate()
	makeAnimatedLuaSprite('amogleen', 'characters/Amogleen', getProperty('dad.x') + 260, getProperty('dad.y') + 550)
	addAnimationByPrefix('amogleen', 'idle', 'amogleen idle0', 24, false)
	objectPlayAnimation('amogleen', 'idle', true)
	scaleObject('amogleen', 0.6, 0.6)
	setScrollFactor('amogleen', 1, 1)
	addLuaSprite('amogleen', true)
end

function onBeatHit()
	if curBeat % 2 == 0 then
		objectPlayAnimation('amogleen', 'idle', true)
	end
end