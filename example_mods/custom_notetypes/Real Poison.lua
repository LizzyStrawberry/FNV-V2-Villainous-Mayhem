local healthDraining = false
local healthMinus = false

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Bullet Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Real Poison' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/ActualPoisonNotes'); --Change texture
			if (songName == 'Toxic Mishap' or songName == 'Villainy') and difficulty == 2 then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/ActualPoisonNotesIniquitousMode'); --Change texture
			end
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
		end
	end
	--debugPrint('Script started!')
end

function onUpdate()
	if mechanics then
		health = getProperty('health')
		
		if songName == "Toxic Mishap" or songName == "Villainy" -- Main Week
		or songName == "Toxic Mishap (Legacy)" -- Week Legacy
		or songName == "Get Villain'd" or songName == "Get Villain'd (Old)" then -- Week Morky
			if difficulty == 1 and healthDraining == true and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then 
				if curStep % 1 == 0 then
					if framerate <= 240 and framerate >= 120 then
						if isMayhemMode then
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then		
								setProperty('health', health - 0.0275)
								healthMinus = false
							else
								setProperty('health', health - 0.0475)
								healthMinus = false
							end
						else
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
								setProperty('health', health - 0.00135)
								healthMinus = false
							else
								setProperty('health', health - 0.0027)
								healthMinus = false
							end
						end
					elseif framerate < 120 and framerate >= 60 then
						if isMayhemMode then
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then		
								setProperty('health', health - 0.0375)
								healthMinus = false
							else
								setProperty('health', health - 0.0575)
								healthMinus = false
							end
						else
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
								setProperty('health', health - 0.00350)
								healthMinus = false
							else
								setProperty('health', health - 0.0070)
								healthMinus = false
							end
						end
					elseif framerate <= 59 and framerate >= 30 then --For some reason in lower fps, the drain becomes slower :what the fuck:
						if isMayhemMode then
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then		
								setProperty('health', health - 0.0475)
								healthMinus = false
							else
								setProperty('health', health - 0.0675)
								healthMinus = false
							end
						else
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
								setProperty('health', health - 0.00465)
								healthMinus = false
							else
								setProperty('health', health - 0.0097)
								healthMinus = false
							end
						end
					end
				end
			end
			
			if songName == "Toxic Mishap" or songName == "Villainy" then
				if difficulty == 2 and healthDraining == true and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
					if healthMinus == true then
						if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then		
							setProperty('health', health - 0.499)
							healthMinus = false
						else
							setProperty('health', health - 0.999)
							healthMinus = false
						end
					end
				end
			end
		end
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Real Poison' and mechanics then
		--debugPrint('Timer Started!')
		cameraFlash('game', '4c9e64', 0.5, false)

		if difficulty == 1 and songName == "Get Villain'd" or songName == "Get Villain'd (Old)" then
			--debugPrint('Draining health...')
			healthDraining = true
			healthMinus = true
			runTimer('PoisonEnd', 2)
		end
		
		if songName == 'Toxic Mishap' or songName == 'Villainy' then	
			if difficulty == 0 or difficulty == 1 then
				--debugPrint('Draining health...')
				healthDraining = true
				healthMinus = true
				runTimer('PoisonEnd', 1.3) 
			end
			
			if difficulty == 2 then
				--debugPrint('fuck you, get 25% hit aswell')
				healthDraining = true
				healthMinus = true
				runTimer('PoisonEnd', 2)
			end
		end
		
		if songName == 'Toxic Mishap (Legacy)' then
			if difficulty == 1 then
				--debugPrint('Draining health...')
				healthDraining = true
				healthMinus = true
				runTimer('PoisonEnd', 1.3)
			end
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'PoisonEnd' then
		--debugPrint('Finished draining health!')
		healthDraining = false
	end
end