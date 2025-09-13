function onCreate()
	if mechanics then
		precacheImage('effects/static')
		for i = 1, 4 do
			precacheSound('Static Noises/Glitch-'..i)
		end
		
		makeAnimatedLuaSprite('static', 'effects/static', 0, 0)
		addAnimationByPrefix('static', 'stun', 'static stun0', 24 / playbackRate, true)
		setProperty('static.alpha', 0.0001) -- Avoid Lag
		scaleObject('static', 2, 2)
		objectPlayAnimation('static', 'stun', true)
		setObjectCamera('static', 'hud')
		addLuaSprite('static', true)
		
		--Iterate over all notes
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Static Notes' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/staticNotes'); --Change texture
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

local songDir = {"LEFT", "DOWN", "UP", "RIGHT"}
function noteMiss(id, dir, noteType, isSus)
	local buff3 = getPropertyFromClass('ClientPrefs', 'buff3Active')
	
	if mechanics and not buff3 and noteType == "Static Notes" then
		objectPlayAnimation('static', 'stun', true)
		playSound('Static Noises/Glitch-'..getRandomInt(1,4), 1)
		setProperty('static.alpha', 1)
		
		cancelTimer("StaticGoByeBye")
		doTweenAlpha('StaticGoByeBye', 'static', 0, 1.4, 'linear')

		setHealth(getHealth() - getHealthToDrain())
		
		playAnim('boyfriend', 'sing'..songDir[dir + 1]..'miss', true)
	end
end

function getHealthToDrain()
	local healthThing = 0.25 -- Casual Non Mayhem Mode Default
	
	if isMayhemMode then
		if difficulty == 0 then healthThing = 4 else healthThing = 10 end
	else
		if difficulty == 1 then healthThing = 0.5 elseif difficulty == 2 then healthThing = 0.75 end
	end

	local buff1 = (getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1)
	if buff1 then healthThing = healthThing / 2 end
	
	return healthThing
end