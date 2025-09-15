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

function onUpdatePost()
	if mechanics then
		-- First Section: Opponent Note Zoom in + switch
		if curBeat == 159 then
		    for i = 0, 3 do
		        noteTweenX("oppNoteSetX"..i,  i, notePos[i+1][1], 0.8 / playbackRate, "cubeInOut")
	        	noteTweenY("oppNoteSetY"..i,  i, notePos[i+1][2], 0.8 / playbackRate, "cubeInOut")
	            noteTweenScaleX("OppScaleX"..i, i, defaultNoteScaleX, 0.8 / playbackRate, "cubeInOut")
            	noteTweenScaleY("OppScaleY"..i, i, defaultNoteScaleY, 0.8 / playbackRate, "cubeInOut")
		    end
			for i = 4, 7 do noteTweenY('playerNoteTweenY'..i, i, downscroll and -360 or 760, 0.8 / playbackRate, 'cubeInOut') end
		end
		-- Second Section: Close up
		if curBeat == 224 then
			for i = 0, 7 do
				noteTweenY('setY'..i, i, notePos[i + 1][2], 0.8 / playbackRate, 'circOut')
				if i < 4 then noteTweenAlpha('noteAlpha'..i, i, 0.32, 0.8 / playbackRate, 'circOut') end
			end
		end
		-- Third Section: Switching
		if curBeat == 288 then
			for i = 0, 3 do
		        noteTweenX("oppNoteSetX"..i,  i, notePos[i+1][1], 0.8 / playbackRate, "circOut")
				noteTweenX("playerNoteSetX"..i, i + 4, notePos[i+1][1], 0.8 / playbackRate, "circOut")
		    end	
			doTweenAlpha('healthBar', 'healthBar', 0, 1.4 / playbackRate, 'circOut')
			doTweenAlpha('healthBarBG', 'healthBarBG', 0, 1.4 / playbackRate, 'circOut')
			for i = 1, 2 do
				doTweenAlpha('iconP'..i..'alpha', 'iconP'..i, 0, 1.4 / playbackRate, 'circOut')
			end
		end
		if curBeat >= 288 and curBeat < 480 then
			for i = 0, 3 do
				setPropertyFromGroup('opponentStrums',i,'angle', 0)
				setPropertyFromGroup('playerStrums',i,'angle', 0)
			end
			if curStep % 16 >= 8 and curStep % 16 <= 15 then
				if downscroll then
					for i = 0, 3 do
						setPropertyFromGroup('unspawnNotes',i,'angle', -360)
					end
					for i = 4, 7 do
						setPropertyFromGroup('notes',i,'angle', -180)
					end
				else
					for i = 0, 3 do
						setPropertyFromGroup('unspawnNotes',i,'copyAngle', false)
						setPropertyFromGroup('unspawnNotes',i,'angle', 360)
					end
					for i = 4, 7 do
						setPropertyFromGroup('notes',i,'angle', 180)
					end
				end
			end
			if curStep % 16 >= 0 and curStep % 16 <= 15 then
				if downscroll then
					for i = 0, 3 do
						setPropertyFromGroup('unspawnNotes',i,'angle', -180)
					end
					for i = 4, 7 do
						setPropertyFromGroup('notes',i,'angle', -360)
					end
				else
					for i = 0, 3 do
						setPropertyFromGroup('unspawnNotes',i,'angle', 180)
					end
					for i = 4, 7 do
						setPropertyFromGroup('notes',i,'angle', 360)
					end
				end
			end
		end
		if curBeat == 352 then
			for i = 0, 3 do
				noteTweenAlpha('noteAlpha'..i, i, 0.62, 0.8 / playbackRate, 'circOut')
			end
			doTweenAlpha('healthBar', 'healthBar', 1, 1.4 / playbackRate, 'circOut')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.4 / playbackRate, 'circOut')
			for i = 1, 2 do
				doTweenAlpha('iconP'..i..'alpha', 'iconP'..i, 1, 1.4 / playbackRate, 'circOut')
			end
		end
		-- Reset
		if curBeat == 480 then
			for i = 0, 3 do setPropertyFromGroup('notes',i,'copyAngle', true) end
			for i = 4, 7 do setPropertyFromGroup('unspawnNotes',i,'copyAngle', true) end

			for i = 0, 3 do
				noteTweenScaleX("OppScaleX"..i, i, oppNoteScaleX, 0.8 / playbackRate, "cubeInOut")
              	noteTweenScaleY("OppScaleY"..i, i, oppNoteScaleY, 0.8 / playbackRate, "cubeInOut")
			end

			for i = 0, 7 do
				noteTweenX('noteReset'..i, i, notePosDefault[i + 1][1], 0.8 / playbackRate, 'circOut')
				noteTweenY('NoteSwap'..i, i, notePosDefault[i + 1][2], 0.8 / playbackRate, 'circOut')
			end
			doTweenAlpha('healthBar', 'healthBar', 1, 1.4 / playbackRate, 'circOut')
			doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.4 / playbackRate, 'circOut')
			for i = 1, 2 do
				doTweenAlpha('iconP'..i..'alpha', 'iconP'..i, 1, 1.4 / playbackRate, 'circOut')
			end
		end
	end
end

function onBeatHit()
	if mechanics then
		-- First Section: Opponent Note Zoom in + switch
		if curBeat >= 160 and curBeat < 224 then
			if curBeat % 32 == 15 then
				for i = 0, 3 do noteTweenY('NoteSwap'..i, i, downscroll and -360 or 760, 0.7 / playbackRate, 'circOut') end
				for i = 4, 7 do noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut') end
			end
			if curBeat % 32 == 0 then
				for i = 0, 3 do noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut') end
				for i = 4, 7 do noteTweenY('NoteSwap'..i, i, downscroll and -360 or 760, 0.7 / playbackRate, 'circOut') end
			end
		end
		-- Second Section: Close up
		if curBeat >= 224 and curBeat < 288 then
			if curBeat % 64 == 0 then
				for i = 0, 3 do
					noteTweenX('oppNoteX'..i, i, notePosXWide[i + 1], 0.8 / playbackRate, 'circOut')
					noteTweenX('playerNoteX'..i, i + 4, notePos[i + 1][1], 0.8 / playbackRate, 'circOut')
				end
			end
			if curBeat % 64 == 32 then
				for i = 0, 3 do
					noteTweenX('oppNoteX'..i, i, notePos[i + 1][1], 0.8 / playbackRate, 'circOut')
					noteTweenX('playerNoteX'..i, i + 4, notePosXWide[i + 1], 0.8 / playbackRate, 'circOut')
				end
			end
		end
		-- Fourth Section: All at once
		if curBeat >= 352 and curBeat < 480 then
			if curBeat % 64 == 32 then
				for i = 0, 3 do
					noteTweenX('oppNoteX'..i, i, notePosXWide[i + 1], 0.8 / playbackRate, 'circOut')
					noteTweenX('playerNoteX'..i, i + 4, notePos[i + 1][1], 0.8 / playbackRate, 'circOut')
				end
				
				doTweenAlpha('healthBar', 'healthBar', 1, 1.4 / playbackRate, 'circOut')
				doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.4 / playbackRate, 'circOut')
				for i = 1, 2 do doTweenAlpha('iconP'..i..'alpha', 'iconP'..i, 1, 1.4 / playbackRate, 'circOut') end
			end
			if curBeat % 64 == 0 then
			    for i = 0, 3 do
					noteTweenX('oppNoteX'..i, i, notePos[i + 1][1], 0.8 / playbackRate, 'circOut')
					noteTweenX('playerNoteX'..i, i + 4, notePosXWide[i + 1], 0.8 / playbackRate, 'circOut')
				end
				doTweenAlpha('healthBar', 'healthBar', 0.3, 1.4 / playbackRate, 'circOut')
				doTweenAlpha('healthBarBG', 'healthBarBG', 0.3, 1.4 / playbackRate, 'circOut')
				for i = 1, 2 do doTweenAlpha('iconP'..i..'alpha', 'iconP'..i, 0.3, 1.4 / playbackRate, 'circOut') end
			end
		end
		if curBeat >= 288 and curBeat < 480 then
			if curBeat % 8 == 4 then
				for i = 0, 3 do
					noteTweenDirection('NoteDir'..i, i, downscroll and -90 or 630, 0.7 / playbackRate, 'circOut')
					noteTweenAngle('NoteAngle'..i, i, downscroll and -180 or 180, 0.7 / playbackRate, 'circOut')
					noteTweenY('NoteSwap'..i, i, downscroll and 80 or 560, 0.7 / playbackRate, 'circOut')
				end
				for i = 4, 7 do
					noteTweenDirection('NoteDir'..i, i, downscroll and -630 or 90, 0.7 / playbackRate, 'circOut')
					noteTweenAngle('NoteAngle'..i, i, 0, 0.7 / playbackRate, 'circOut')
					noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut')
				end
			end
			if curBeat % 8 == 0 then
				for i = 0, 3 do
					noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut')
					noteTweenDirection('NoteDir'..i, i, downscroll and -630 or 90, 0.7 / playbackRate, 'circOut')
					noteTweenAngle('NoteAngle'..i, i, 0, 0.7 / playbackRate, 'circOut')
				end
				for i = 4, 7 do
					noteTweenY('NoteSwap'..i, i, downscroll and 80 or 560, 0.7 / playbackRate, 'circOut')
					noteTweenDirection('NoteDir'..i, i, downscroll and -90 or 630, 0.7 / playbackRate, 'circOut')
					noteTweenAngle('NoteAngle'..i, i, downscroll and -180 or 180, 0.7 / playbackRate, 'circOut')
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
