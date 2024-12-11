local healthToDraining
local healthDrainRate = 0.3
local healthDraining = false
local healthMinus = false

function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Bullet Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Real Poison' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/ActualPoisonNotes'); --Change texture
			if (songName == 'Toxic Mishap' or songName == 'Villainy') and difficultyName == "Iniquitous" then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/ActualPoisonNotesIniquitousMode'); --Change texture
			end
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
		end
	end
	--debugPrint('Script started!')
	
	if isMayhemMode then
		healthDrainRate = 3
	end
end

function onUpdate(elapsed)
	if mechanics then
		health = getProperty('health')
		if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
			healthToDrain = (healthDrainRate * elapsed) / 2
		else
			healthToDrain = healthDrainRate * elapsed
		end
		
		if songName == "Toxic Mishap" or songName == "Villainy" -- Main Week
		or songName == "Toxic Mishap (Legacy)" -- Week Legacy
		or songName == "Get Villain'd" or songName == "Get Villain'd (Old)" then -- Week Morky
			if healthDraining == true and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then 
				setProperty('health', health - healthToDrain)
			end
			if songName == "Toxic Mishap" or songName == "Villainy" then
				if healthMinus == true and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
					if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then		
						setProperty('health', health - 0.0125)
						healthMinus = false
					else
						setProperty('health', health - 0.025)
						healthMinus = false
					end
				end
			end
		end
	end
end

local drainingDur = 1.3
function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Real Poison' and mechanics then
		--debugPrint('Timer Started!')
		cameraFlash('game', '4c9e64', 0.5, false)
		healthDraining = true
		
		if difficultyName == "Iniquitous" then
			drainingDur = 0.75
			healthMinus = true
		else
			drainingDur = 1.3
			healthMinus = false
		end

		runTimer('PoisonEnd', drainingDur)
	end
end

function onTimerCompleted(tag)
	if tag == 'PoisonEnd' then
		--debugPrint('Finished draining health!')
		healthDraining = false
	end
end