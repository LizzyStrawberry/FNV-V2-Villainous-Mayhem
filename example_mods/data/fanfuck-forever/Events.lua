local GFX;
function onCreate()
	addCharacterToList('FangirlP1', 'dad')
	addCharacterToList('FangirlP2', 'dad')
	addCharacterToList('marcoFFFP2', 'boyfriend')
	setProperty('gf.visible', false)
	GFX = getProperty('gf.x')
	setProperty('gf.x', GFX + 100)
	
	makeLuaSprite('BlackBack', '', -800, -600)
	makeGraphic('BlackBack', 5000, 5000, '000000')
	setScrollFactor('BlackBack', 0, 0)
	setProperty('BlackBack.alpha', 1)
	setObjectCamera('BlackBack', 'game')
	setObjectOrder('BlackBack', getObjectOrder('dadGroup') - 1)
	addLuaSprite('BlackBack', true)
	
	setObjectOrder('boyfriendGroup', getObjectOrder('BlackBack') + 1)
	setProperty('camHUD.alpha', 0)
	setProperty('dad.alpha', 0)
	setProperty('boyfriend.alpha', 0)
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and difficulty >= 1 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
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
	if curBeat == 4 then
		doTweenAlpha('marcoAppear', 'boyfriend', 1, 4, 'cubeInOut')
		doTweenZoom('gameZoom', 'camGame', 1, 11.4, 'cubeInOut')
	end
	
	if curBeat == 15 then
		doTweenAlpha('dadAppear', 'dad', 1, 6, 'cubeInOut')
	end
	if curBeat == 35 then
		removeLuaSprite('BlackBack', true)
		triggerEvent('Change Character', 'dad', 'FangirlP1')
		doTweenAlpha('hudHi', 'camHUD', 1, 0.4, 'circOut')
		setObjectOrder('boyfriendGroup', 6)
		setObjectOrder('gfGroup', 5)
	end
	if curBeat == 132 then
		triggerEvent('Play Animation', 'turn', 'dad')
		triggerEvent('Play Animation', 'turn', 'bf')
		doTweenAlpha('hudGoAway', 'camHUD', 0, 0.4, 'circOut')
	end
	
	if curBeat == 133 then
		setProperty('BGP2.alpha', 1)
		removeLuaSprite('BGP1', true)
		triggerEvent('Screen Shake', '0.1, 0.03', '')
		doTweenX('gfMove', 'gf', GFX, 0.5, 'circOut')
		setProperty('gf.visible', true)
	end
	
	if curStep == 534 then
		doTweenAlpha('hudComeBack', 'camHUD', 1, 0.4, 'circOut')
	end
	
	if curStep == 546 then
		triggerEvent('Change Character', 'dad', 'FangirlP2')
		triggerEvent('Change Character', 'bf', 'marcoFFFP2')
	end
end