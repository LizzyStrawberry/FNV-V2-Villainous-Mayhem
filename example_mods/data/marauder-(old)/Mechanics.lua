local notePos = {}

function onCreate()
	if mechanics then
		makeLuaSprite('static', 'effects/glitch', 0, 0)
		setScrollFactor('static', 0, 0)
		setObjectCamera('static', 'hud')
		setProperty('static.alpha', 0)
		addLuaSprite('static', true)
	end
	
	setProperty("legacyPosition", true)
end

function onSongStart()
	if mechanics then
		for i = 0,7 do 
			x = getPropertyFromGroup('strumLineNotes', i, 'x')
			y = getPropertyFromGroup('strumLineNotes', i, 'y')
			table.insert(notePos, {mobileFix("X", x), y})
		end
	end
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and difficulty == 1 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getProperty('health') > 0.2 then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.0065);
				else
					setProperty('health', health- 0.013);
				end
			end
		end
end

function onUpdate()
	if mechanics then
		if curBeat == 134 then
			noteTweenX('noteTween1X', 0, 400, 0.8, 'cubeInOut')
			noteTweenX('noteTween2X', 1, 520, 0.8, 'cubeInOut')	
			noteTweenX('noteTween3X', 2, 640, 0.8, 'cubeInOut')
			noteTweenX('noteTween4X', 3, 760, 0.8, 'cubeInOut')
		
			noteTweenX('noteTween5X', 4, 400, 0.8, 'cubeInOut')
			noteTweenX('noteTween6X', 5, 520, 0.8, 'cubeInOut')	
			noteTweenX('noteTween7X', 6, 640, 0.8, 'cubeInOut')
			noteTweenX('noteTween8X', 7, 760, 0.8, 'cubeInOut')
		
			noteTweenY('noteTween5Y', 4, 760, 0.8, 'cubeInOut')
			noteTweenY('noteTween6Y', 5, 760, 0.8, 'cubeInOut')
			noteTweenY('noteTween7Y', 6, 760, 0.8, 'cubeInOut')
			noteTweenY('noteTween8Y', 7, 760, 0.8, 'cubeInOut')
		end
		if curBeat == 231 then
			for i = 0, 7 do
				noteTweenY('noteTweenY'..i, i, notePos[i + 1][2], 0.8, 'circOut')
			end
			for i = 0, 3 do
				noteTweenAlpha('noteAlpha'..i, i, 0.32, 0.8, 'circOut')
			end
		end
	end
end

function onBeatHit()
	if mechanics then
		if curBeat >= 136 and curBeat < 231 then
			if curBeat % 64 == 39 then
				for i = 0, 3 do
					noteTweenY('NoteSwap'..i, i, 760, 0.7, 'circOut')
				end
				for i = 4, 7 do
					noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7, 'circOut')
				end
			end
			if curBeat % 64 == 8 then
				for i = 0, 3 do
					noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7, 'circOut')
				end
				for i = 4, 7 do
					noteTweenY('NoteSwap'..i, i, 760, 0.7, 'circOut')
				end
			end
		end
		if curBeat >= 231 and curBeat <= 388 then
			if difficulty == 1 then
				if curBeat % 64 == 39 then
					noteTweenX('noteTween1X', 0, notePos[5][1], 0.8, 'circOut')
					noteTweenX('noteTween2X', 1, notePos[6][1], 0.8, 'circOut')
					noteTweenX('noteTween5X', 4, notePos[1][1], 0.8, 'circOut')
					noteTweenX('noteTween6X', 5, notePos[2][1], 0.8, 'circOut')
				
					noteTweenX('noteTween3X', 2, notePos[3][1], 0.8, 'circOut')
					noteTweenX('noteTween4X', 3, notePos[4][1], 0.8, 'circOut')
					noteTweenX('noteTween7X', 6, notePos[7][1], 0.8, 'circOut')
					noteTweenX('noteTween8X', 7, notePos[8][1], 0.8, 'circOut')
				end
				if curBeat % 64 == 8 then
					noteTweenX('noteTween1X', 0, notePos[1][1], 0.8, 'circOut')
					noteTweenX('noteTween2X', 1, notePos[2][1], 0.8, 'circOut')
					noteTweenX('noteTween5X', 4, notePos[5][1], 0.8, 'circOut')
					noteTweenX('noteTween6X', 5, notePos[6][1], 0.8, 'circOut')
			
					noteTweenX('noteTween3X', 2, notePos[7][1], 0.8, 'circOut')
					noteTweenX('noteTween4X', 3, notePos[8][1], 0.8, 'circOut')
					noteTweenX('noteTween7X', 6, notePos[3][1], 0.8, 'circOut')
					noteTweenX('noteTween8X', 7, notePos[4][1], 0.8, 'circOut')
				end
			elseif difficulty == 0 then
				if curBeat % 64 == 39 then
					noteTweenX('noteTween1X', 0, notePos[5][1], 0.8, 'circOut')
					noteTweenX('noteTween2X', 1, notePos[6][1], 0.8, 'circOut')
					noteTweenX('noteTween5X', 4, notePos[1][1], 0.8, 'circOut')
					noteTweenX('noteTween6X', 5, notePos[2][1], 0.8, 'circOut')
				
					noteTweenX('noteTween3X', 2, notePos[7][1], 0.8, 'circOut')
					noteTweenX('noteTween4X', 3, notePos[8][1], 0.8, 'circOut')
					noteTweenX('noteTween7X', 6, notePos[3][1], 0.8, 'circOut')
					noteTweenX('noteTween8X', 7, notePos[4][1], 0.8, 'circOut')
				end
				if curBeat % 64 == 8 then
					noteTweenX('noteTween1X', 0, notePos[1][1], 0.8, 'circOut')
					noteTweenX('noteTween2X', 1, notePos[2][1], 0.8, 'circOut')
					noteTweenX('noteTween5X', 4, notePos[5][1], 0.8, 'circOut')
					noteTweenX('noteTween6X', 5, notePos[6][1], 0.8, 'circOut')
			
					noteTweenX('noteTween3X', 2, notePos[3][1], 0.8, 'circOut')
					noteTweenX('noteTween4X', 3, notePos[4][1], 0.8, 'circOut')
					noteTweenX('noteTween7X', 6, notePos[7][1], 0.8, 'circOut')
					noteTweenX('noteTween8X', 7, notePos[8][1], 0.8, 'circOut')
				end
			end
		end
	end
end

function noteMiss()
	if mechanics then
		cancelTween('StaticGoByeBye')
		playSound('glitch', 1)
		setProperty('static.alpha', 1)
		runTimer('StaticByeBye', 0.06)
	end
end


function onTimerCompleted(tag)
	if tag == 'StaticByeBye' then
		doTweenAlpha('StaticGoByeBye', 'static', 0, 0.4, 'circOut')
	end
end
