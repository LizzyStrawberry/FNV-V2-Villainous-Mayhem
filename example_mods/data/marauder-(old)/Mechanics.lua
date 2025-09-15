local notePosDefault = {} -- All note positions (Pre Mechanic)
local notePos = {} -- All note positions (During Mechanic)
local notePosXWide = {} -- 4 Values (for all notes)

function onCreate()
	if mechanics then
		makeLuaSprite('static', 'effects/glitch')
		setGraphicSize("static", screenWidth, screenHeight)
		setObjectCamera('static', 'hud')
		setProperty('static.alpha', 0)
		addLuaSprite('static', true)
	end
end

function onSongStart()
	if mechanics then
		for i = 0, 3 do 
			x = getPropertyFromGroup('opponentStrums', i, 'x')
			y = getPropertyFromGroup('opponentStrums', i, 'y')
			table.insert(notePosDefault, {x, y})
		end
		
		for i = 0, 7 do 
			x = getPropertyFromGroup('playerStrums', (i < 4 and i or i - 4), 'x')
			y = getPropertyFromGroup('playerStrums', (i < 4 and i or i - 4), 'y')
			table.insert(notePos, {x, y})
			if i >= 4 then table.insert(notePosDefault, {x, y}) end
		end
		
		for i = 1, 4 do 
			table.insert(notePosXWide, notePos[i][1] + (i <= 2 and -300 or 300))
		end
	end
end

function onUpdate()
	if mechanics then
		if curBeat == 134 then
			for i = 0, 3 do
		        noteTweenX("oppNoteSetX"..i,  i, notePos[i+1][1], 0.8 / playbackRate, "cubeInOut")
	        	noteTweenY("oppNoteSetY"..i,  i, notePos[i+1][2], 0.8 / playbackRate, "cubeInOut")
	            noteTweenScaleX("OppScaleX"..i, i, defaultNoteScaleX, 0.8 / playbackRate, "cubeInOut")
            	noteTweenScaleY("OppScaleY"..i, i, defaultNoteScaleY, 0.8 / playbackRate, "cubeInOut")
		    end
			for i = 4, 7 do noteTweenY('playerNoteTweenY'..i, i, downscroll and -360 or 760, 0.8 / playbackRate, 'cubeInOut') end
		end
		if curBeat == 231 then
			for i = 0, 7 do
				noteTweenY('noteTweenY'..i, i, notePos[i + 1][2], 0.8 / playbackRate, 'circOut')
			end
			for i = 0, 3 do
				noteTweenAlpha('noteAlpha'..i, i, 0.32, 0.8 / playbackRate, 'circOut')
			end
		end
	end
end

function onBeatHit()
	if mechanics then
		if curBeat >= 136 and curBeat < 231 then
			if curBeat % 64 == 39 then
				for i = 0, 3 do noteTweenY('NoteSwap'..i, i, downscroll and -360 or 760, 0.7 / playbackRate, 'circOut') end
				for i = 4, 7 do noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut') end
			end
			if curBeat % 64 == 8 then
				for i = 0, 3 do noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut') end
				for i = 4, 7 do noteTweenY('NoteSwap'..i, i, downscroll and -360 or 760, 0.7 / playbackRate, 'circOut') end
			end
		end
		if curBeat >= 231 and curBeat <= 388 then
			if curBeat % 64 == 39 then
				for i = 0, 3 do
					noteTweenX('oppNoteX'..i, i, notePosXWide[i + 1], 0.8 / playbackRate, 'circOut')
					noteTweenX('playerNoteX'..i, i + 4, notePos[i + 1][1], 0.8 / playbackRate, 'circOut')
				end
			end
			if curBeat % 64 == 8 then
				for i = 0, 3 do
					noteTweenX('oppNoteX'..i, i, notePos[i + 1][1], 0.8 / playbackRate, 'circOut')
					noteTweenX('playerNoteX'..i, i + 4, notePosXWide[i + 1], 0.8 / playbackRate, 'circOut')
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
		doTweenAlpha('StaticGoByeBye', 'static', 0, 0.4 / playbackRate, 'circOut')
	end
end
