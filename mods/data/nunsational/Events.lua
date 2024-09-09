function onCreate()
	makeLuaSprite('blackbg','', -200, -200)
	makeGraphic('blackbg',3000,3000,'000000')
	setScrollFactor('blackbg',0,0)
	setObjectCamera('blackbg','game')
	addLuaSprite('blackbg',true)
	
	setProperty('gf.alpha', 0)
end

function onUpdate()
	health = getProperty('health')

	if curStep == 28 then
		doTweenAlpha('blackbg', 'blackbg', 0, 0.2, 'cubeInOut')
	end
	if curStep == 33 then
		removeLuaSprite('blackbg', true)
		setProperty('defaultCamZoom', 0.9)
	end
	if curBeat == 100 then
		doTweenZoom('gamegoBRRRR', 'camGame', 3, 1.5, 'sineIn')
	end
	if curBeat == 104 then
		setProperty('gf.alpha', 1)
	end
end

function opponentNoteHit()
	if mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
		if not isMayhemMode and difficulty == 1 and getProperty('health') > 0.2 then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.0115);
			else
				setProperty('health', health - 0.023)
			end
		end
		if not isMayhemMode and difficulty >= 2 and getProperty('health') > 0.2 then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.014);
			else
				setProperty('health', health - 0.028)
			end
		end
	end
end