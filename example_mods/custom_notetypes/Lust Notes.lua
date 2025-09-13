local indices = "24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47 ,48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62. 63, 64, 65, 66, 67, 68, 69, 70"
stunned = false
local curBF
function onCreate()
	if songName == 'Lustality' then
		if boyfriendName == 'playablegf' or boyfriendName == "playablegf-old" then
			addCharacterToList("playablegf-stun", "boyfriend")
		end
		
		curBF = boyfriendName
		
		makeAnimatedLuaSprite('time', 'effects/timer', getProperty('boyfriend.x') + 20 , getProperty('boyfriend.y') + 150)
		if difficulty == 0 then addAnimationByIndices('time', 'Stunned', 'timer rundown00', indices, 24)
		else addAnimationByPrefix('time', 'Stunned', 'timer rundown0', 24, false) end
		setProperty('time.alpha', 0.0001)
		scaleObject('time', 0.5, 0.5)
		setObjectCamera('time', 'game')
		setScrollFactor('time', 1, 1)
		addLuaSprite('time', true)	
	end
	
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Lust Notes' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/Love Notes'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true)
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
		end
	end
end

function onUpdate()
	healthBefore = getHealth()
end

function noteMiss(id, direction, noteType, isSus)
	if noteType == "" and stunned then setProperty("health", healthBefore) end
	
	if noteType == 'Lust Notes' and not isSus then
		cameraFlash('game', 'cd8b8b', 0.5 / playbackRate, false)
		
		if songName == 'Lustality' and not stunned then
			setProperty('time.alpha', 1)
			objectPlayAnimation('time', 'Stunned', true)
			
			if boyfriendName == 'playablegf' or boyfriendName == "playablegf-old" then triggerEvent('Change Character', 0, 'playablegf-stun') end
			
			setProperty('boyfriend.stunned', true)
			stunned = true

			runTimer('StunnedEnd', difficulty == 0 and 2 or 3)
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'StunnedEnd' then
		setProperty('boyfriend.stunned', false)
		stunned = false
		
		doTweenAlpha('TimerGoByeBye', 'time', 0, 0.3 / playbackRate, 'linear')
		
		triggerEvent('Change Character', 0, curBF)
	end
end