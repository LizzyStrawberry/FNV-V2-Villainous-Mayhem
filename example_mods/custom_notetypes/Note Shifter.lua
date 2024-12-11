--Idea by MoonScarf
--Created by Kevin Kuntz
local healthToDraining
local healthDrainRate = 0.3
local healthDraining = false
function onCreatePost()
	if mechanics then
		for i = 0, getProperty('unspawnNotes.length') - 1 do
			sus = getPropertyFromGroup('unspawnNotes', i, 'isSustainNote')
			mustPress = getPropertyFromGroup('unspawnNotes', i, 'mustPress')
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Note Shifter' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/ActualPoisonNotes'); --Change texture
				if not sus then
					oFX = getPropertyFromGroup('unspawnNotes', i, 'offsetX')
				else
					susFX = getPropertyFromGroup('unspawnNotes', i, 'offsetX')
				end
				if mustPress then
					setPropertyFromGroup('unspawnNotes', i, 'offsetX', getPropertyFromGroup('unspawnNotes', i, 'offsetX') - 640)
				else
					setPropertyFromGroup('unspawnNotes', i, 'offsetX', getPropertyFromGroup('unspawnNotes', i, 'offsetX') + 640)
				end
			end
		end
		
		if isMayhemMode then
			healthDrainRate = 3
		end
	end
end

function onUpdatePost(el)
	if mechanics then
		songPos = getSongPosition()
		local currentBeat = (getSongPosition() / 1000)*(bpm/60)
		for a = 0, getProperty('notes.length') - 1 do
			strumTime = getPropertyFromGroup('notes', a, 'strumTime')
			sus = getPropertyFromGroup('notes', a, 'isSustainNote')
			if getPropertyFromGroup('notes', a, 'noteType') == 'Note Shifter' then
				if sus then
					setPropertyFromGroup('notes', a, 'offsetX', getPropertyFromGroup('notes', a, 'offsetX') + 3 * math.cos((currentBeat + a * 0.15) * math.pi))
				end
				if (strumTime - songPos) < 1100 / scrollSpeed and not sus then
					if getPropertyFromGroup('notes', a, 'offsetX') ~= oFX then
						setPropertyFromGroup('notes', a, 'offsetX', lerp(getPropertyFromGroup('notes', a, 'offsetX'), oFX, boundTo(el * 10, 0, 1)))                     
					elseif getPropertyFromGroup('notes', a, 'offsetX') <= oFX then
						setPropertyFromGroup('notes', a, 'offsetX', oFX)
					end
				elseif (strumTime - songPos) < 1200 / scrollSpeed and sus then
					if getPropertyFromGroup('notes', a, 'offsetX') ~= susFX then
						setPropertyFromGroup('notes', a, 'offsetX', lerp(getPropertyFromGroup('notes', a, 'offsetX'), susFX, boundTo(el * 10, 0, 1)))
					elseif getPropertyFromGroup('notes', a, 'offsetX') <= susFX then
						setPropertyFromGroup('notes', a, 'offsetX', susFX)
					end
				end
			end
		end
	end
end

function lerp(a, b, ratio)
  return math.floor(a + ratio * (b - a))
end

function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end

function onUpdate(elapsed)
	if mechanics then
		health = getProperty('health')
		if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
			healthToDrain = (healthDrainRate * elapsed) / 2
		else
			healthToDrain = healthDrainRate * elapsed
		end
		
		if healthDraining == true and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then 
			setProperty('health', health - healthToDrain)
		end
	end
end

local drainingDur = 1.3
function noteMiss(id, noteData, noteType, isSustainNote)
	if mechanics then
		if noteType == 'Note Shifter' then
			--debugPrint('Timer Started!')
			cameraFlash('game', '4c9e64', 0.5, false)
			healthDraining = true
			
			if difficultyName == "Iniquitous" then
				drainingDur = 0.75
			else
				drainingDur = 1.3
			end

			runTimer('PoisonEnd', drainingDur)
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'PoisonEnd' then
		--debugPrint('Finished draining health!')
		healthDraining = false
	end
end