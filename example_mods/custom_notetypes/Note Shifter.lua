--Idea by MoonScarf
--Created by Kevin Kuntz

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

function onUpdate()
	if mechanics then
		health = getProperty('health')
		
		if healthDraining == true and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then 
			if curStep % 1 == 0 then
				if framerate <= 240 and framerate >= 120 then
					if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
						if isMayhemMode then
							setProperty('health', health - 0.0135)
						else
							setProperty('health', health - 0.00135)
						end
					else
						if isMayhemMode then
							setProperty('health', health - 0.037)
						else
							setProperty('health', health - 0.0037)
						end
					end
				elseif framerate < 120 and framerate >= 60 then
					if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
						if isMayhemMode then
							setProperty('health', health - 0.025)
						else
							setProperty('health', health - 0.0025)
						end
					else
						if isMayhemMode then
							setProperty('health', health - 0.05)
						else
							setProperty('health', health - 0.0005)
						end
					end
				elseif framerate <= 59 and framerate >= 30 then
					if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
						if isMayhemMode then
							setProperty('health', health - 0.0365)
						else
							setProperty('health', health - 0.00365)
						end
					else
						if isMayhemMode then
							setProperty('health', health - 0.07)
						else
							setProperty('health', health - 0.007)
						end
					end
				end
			end
		end
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if mechanics then
		if noteType == 'Note Shifter' then
			--debugPrint('Timer Started!')
			cameraFlash('game', '4c9e64', 0.5, false)
		
			--debugPrint('Draining health...')
			healthDraining = true
			runTimer('PoisonEnd', 1.3)
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'PoisonEnd' then
		--debugPrint('Finished draining health!')
		healthDraining = false
	end
end