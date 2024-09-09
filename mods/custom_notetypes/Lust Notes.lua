local LustHit = false

function onCreate()
	if songName == 'Lustality V1' then
		makeAnimatedLuaSprite('time', 'effects/timer', getProperty('boyfriend.x') + 20 , getProperty('boyfriend.y') + 150)
		if difficulty == 0 then
			addAnimationByIndices('time', 'Stunned', 'timer rundown00', '24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47 ,48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62. 63, 64, 65, 66, 67, 68, 69, 70', 24)
		end
		if difficulty == 1 then
			addAnimationByPrefix('time', 'Stunned', 'timer rundown0', 24, false)
		end
		setProperty('time.alpha', 0)
		scaleObject('time', 0.5, 0.5)
		setObjectCamera('time', 'game')
		setScrollFactor('time', 1, 1)
		addLuaSprite('time', true)	
	end
	
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Bullet Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Lust Notes' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/Love Notes'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
		end
	end
	--debugPrint('Script started!')
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == 'Lust Notes' then
		--debugPrint('Timer Started!')
		if songName == 'Lustality' then
			health = getProperty('health')
			cameraFlash('game', 'cd8b8b', 0.5, false)
			LustHit = true;
		end
		
		if songName == 'Lustality V1' then
			health = getProperty('health')
			setProperty('time.alpha', 1)
			objectPlayAnimation('time','Stunned', true)
			
			cameraFlash('game', 'cd8b8b', 0.5, false)
			
			if boyfriendName == 'playablegf' then
				triggerEvent('Change Character', 0, 'playablegf-stun');
			end
			
			setProperty('boyfriend.stunned', true)
		
			LustHit = true;
		
			if difficulty == 0 then
				runTimer('StunnedEnd', 2)
			end
		
			if difficulty == 1 then
				runTimer('StunnedEnd', 3)
			end	
		end
		
		if songName == 'Lustality Remix' then
			health = getProperty('health')
			cameraFlash('game', 'cd8b8b', 0.5, false)
			LustHit = true;
		end
	end
	
	if noteType == '' and LustHit and songName == 'Lustality' then
		setProperty('health', health - 0)
		LustHit = false
	end
	
	if noteType == '' and LustHit and songName == 'Lustality V1' then
		setProperty('health', health - 0)
	end
	
	if noteType == '' and LustHit and songName == 'Lustality Remix' then
		setProperty('health', health - 0)
		LustHit = false
	end
end

function onTimerCompleted(tag)
	if tag == 'StunnedEnd' and songName == 'Lustality V1' then
		--debugPrint('Timer Ended!')
		setProperty('boyfriend.stunned', false)
		
		doTweenAlpha('TimerGoByeBye', 'time', 0, 0.3, 'linear')
		
		if boyfriendName == 'playablegf-stun' then
			triggerEvent('Change Character', 0, 'playablegf');
		end
		
		LustHit = false
	end
end