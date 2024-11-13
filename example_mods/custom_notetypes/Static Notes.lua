function onCreate()
	if mechanics then
		makeAnimatedLuaSprite('Static', 'effects/static', 0, 0)
		addAnimationByPrefix('Static', 'Stun', 'static stun', 24, true)
		setProperty('Static.alpha', 0)
		scaleObject('Static', 2, 2)
		setScrollFactor('Static', 0, 0)
		setObjectCamera('Static', 'hud')
		addLuaSprite('Static', true)
		
		for i = 1, 4 do
			precacheSound('Static Noises/Glitch-'..i)
		end
		
		--Iterate over all notes
		for i = 0, getProperty('unspawnNotes.length')-1 do
			--Check if the note is a Bullet Note
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Static Notes' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/staticNotes'); --Change texture
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

function onUpdate()
	if mechanics then
		health = getProperty('health')
	end
end

function noteMiss(id, direction, noteType, isSustainNote, noteData)
	if mechanics then
		if noteType == 'Static Notes' then
			objectPlayAnimation('Static','Stun', true)
			playSound('Static Noises/Glitch-'..getRandomInt(1,4), 1)
			setProperty('Static.alpha', 1)
			runTimer('StaticByeBye', 0.06)
			
			if getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
				if difficulty == 0 then
					if isMayhemMode then
						if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
							setProperty('health', health - 2)
						else
							setProperty('health', health - 4)
						end
					else
						if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
							setProperty('health', health - 0.125)
						else
							setProperty('health', health - 0.25)
						end
					end
				end
				if difficulty == 1 then
					if isMayhemMode then
						if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
							setProperty('health', health - 5)
						else
							setProperty('health', health - 10)
						end
					else
						if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
							setProperty('health', health - 0.25)
						else
							setProperty('health', health - 0.50)
						end
					end
				end
				if difficulty == 2 then
					if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
						setProperty('health', health - 0.345)
					else
						setProperty('health', health - 0.75)
					end
				end
			end
			
			if direction == 0 then
				characterPlayAnim('boyfriend', 'singLEFTmiss', true)
			end
			if direction == 1 then
				characterPlayAnim('boyfriend', 'singDOWNmiss', true)
			end
			if direction == 2 then
				characterPlayAnim('boyfriend', 'singUPmiss', true)
			end
			if direction == 3 then
				characterPlayAnim('boyfriend', 'singRIGHTmiss', true)
			end
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'StaticByeBye' then
		doTweenAlpha('StaticGoByeBye', 'Static', 0, 1.4, 'linear')
	end
end