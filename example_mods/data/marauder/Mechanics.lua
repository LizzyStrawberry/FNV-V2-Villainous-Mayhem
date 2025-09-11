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

function onUpdatePost()
	if mechanics then
		if curBeat == 159 then
			noteTweenX('noteTween1X', 0, mobileFix("X", 400), 0.8 / playbackRate, 'cubeInOut')
			noteTweenX('noteTween2X', 1, mobileFix("X", 520), 0.8 / playbackRate, 'cubeInOut')	
			noteTweenX('noteTween3X', 2, mobileFix("X", 640), 0.8 / playbackRate, 'cubeInOut')
			noteTweenX('noteTween4X', 3, mobileFix("X", 760), 0.8 / playbackRate, 'cubeInOut')
		
			noteTweenX('noteTween5X', 4, mobileFix("X", 400), 0.8 / playbackRate, 'cubeInOut')
			noteTweenX('noteTween6X', 5, mobileFix("X", 520), 0.8 / playbackRate, 'cubeInOut')	
			noteTweenX('noteTween7X', 6, mobileFix("X", 640), 0.8 / playbackRate, 'cubeInOut')
			noteTweenX('noteTween8X', 7, mobileFix("X", 760), 0.8 / playbackRate, 'cubeInOut')
		
			noteTweenY('noteTween5Y', 4, 760, 0.8 / playbackRate, 'cubeInOut')
			noteTweenY('noteTween6Y', 5, 760, 0.8 / playbackRate, 'cubeInOut')
			noteTweenY('noteTween7Y', 6, 760, 0.8 / playbackRate, 'cubeInOut')
			noteTweenY('noteTween8Y', 7, 760, 0.8 / playbackRate, 'cubeInOut')
		end
		if curBeat == 224 then
			for i = 0, 7 do
				noteTweenY('noteTweenY'..i, i, notePos[i + 1][2], 0.8 / playbackRate, 'circOut')
			end
			for i = 0, 3 do
				noteTweenAlpha('noteAlpha'..i, i, 0.32, 0.8 / playbackRate, 'circOut')
			end
		end
		if curBeat == 288 then
			noteTweenX('noteTween1X', 0, mobileFix("X", 400), 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween2X', 1, mobileFix("X", 520), 0.8 / playbackRate, 'circOut')	
			noteTweenX('noteTween3X', 2, mobileFix("X", 640), 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween4X', 3, mobileFix("X", 760), 0.8 / playbackRate, 'circOut')
		
			noteTweenX('noteTween5X', 4, mobileFix("X", 400), 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween6X', 5, mobileFix("X", 520), 0.8 / playbackRate, 'circOut')	
			noteTweenX('noteTween7X', 6, mobileFix("X", 640), 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween8X', 7, mobileFix("X", 760), 0.8 / playbackRate, 'circOut')
			
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
						setPropertyFromGroup('unspawnNotes',i,'copyAngle', false)
						setPropertyFromGroup('unspawnNotes',i,'angle', -360)
					end
					for i = 4, 7 do
						setPropertyFromGroup('notes',i,'copyAngle', false)
						setPropertyFromGroup('notes',i,'angle', -180)
					end
				else
					for i = 0, 3 do
						setPropertyFromGroup('unspawnNotes',i,'copyAngle', false)
						setPropertyFromGroup('unspawnNotes',i,'angle', 360)
					end
					for i = 4, 7 do
						setPropertyFromGroup('notes',i,'copyAngle', false)
						setPropertyFromGroup('notes',i,'angle', 180)
					end
				end
			end
			if curStep % 16 >= 0 and curStep % 16 <= 15 then
				if downscroll then
					for i = 0, 3 do
						setPropertyFromGroup('unspawnNotes',i,'copyAngle', false)
						setPropertyFromGroup('unspawnNotes',i,'angle', -180)
					end
					for i = 4, 7 do
						setPropertyFromGroup('notes',i,'copyAngle', false)
						setPropertyFromGroup('notes',i,'angle', -360)
					end
				else
					for i = 0, 3 do
						setPropertyFromGroup('unspawnNotes',i,'copyAngle', false)
						setPropertyFromGroup('unspawnNotes',i,'angle', 180)
					end
					for i = 4, 7 do
						setPropertyFromGroup('notes',i,'copyAngle', false)
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
		if curBeat == 480 then
			for i = 0, 3 do
				setPropertyFromGroup('notes',i,'copyAngle', true)
			end
			for i = 4, 7 do
				setPropertyFromGroup('unspawnNotes',i,'copyAngle', true)
			end
			noteTweenX('noteTween1X', 0, notePos[1][1], 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween2X', 1, notePos[2][1], 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween3X', 2, notePos[3][1], 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween4X', 3, notePos[4][1], 0.8 / playbackRate, 'circOut')
			
			noteTweenX('noteTween5X', 4, notePos[5][1], 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween6X', 5, notePos[6][1], 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween7X', 6, notePos[7][1], 0.8 / playbackRate, 'circOut')
			noteTweenX('noteTween8X', 7, notePos[8][1], 0.8 / playbackRate, 'circOut')
			for i = 0, 7 do
				noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.8 / playbackRate, 'circOut')
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
		if curBeat >= 160 and curBeat < 224 then
			if curBeat % 32 == 15 then
				for i = 0, 3 do
					if downscroll then
						noteTweenY('NoteSwap'..i, i, -360, 0.7 / playbackRate, 'circOut')
					else
						noteTweenY('NoteSwap'..i, i, 760, 0.7 / playbackRate, 'circOut')
					end
				end
				for i = 4, 7 do
					noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut')
				end
			end
			if curBeat % 32 == 0 then
				for i = 0, 3 do
					noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut')
				end
				for i = 4, 7 do
					if downscroll then
						noteTweenY('NoteSwap'..i, i, -360, 0.7 / playbackRate, 'circOut')
					else
						noteTweenY('NoteSwap'..i, i, 760, 0.7 / playbackRate, 'circOut')
					end
				end
			end
		end
		if curBeat >= 224 and curBeat < 288 then
			if curBeat % 64 == 32 then
				noteTweenX('noteTween1X', 0, notePos[3][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween2X', 1, notePos[4][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween5X', 4, notePos[1][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween6X', 5, notePos[2][1], 0.8 / playbackRate, 'circOut')
			
				noteTweenX('noteTween3X', 2, notePos[5][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween4X', 3, notePos[6][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween7X', 6, notePos[7][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween8X', 7, notePos[8][1], 0.8 / playbackRate, 'circOut')
			end
			if curBeat % 64 == 0 then
				noteTweenX('noteTween1X', 0, notePos[1][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween2X', 1, notePos[2][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween5X', 4, notePos[3][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween6X', 5, notePos[4][1], 0.8 / playbackRate, 'circOut')
			
				noteTweenX('noteTween3X', 2, notePos[7][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween4X', 3, notePos[8][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween7X', 6, notePos[5][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween8X', 7, notePos[6][1], 0.8 / playbackRate, 'circOut')
			end
		end
		if curBeat >= 352 and curBeat < 480 then
			if curBeat % 64 == 32 then
				noteTweenX('noteTween1X', 0, notePos[3][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween2X', 1, notePos[4][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween5X', 4, notePos[1][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween6X', 5, notePos[2][1], 0.8 / playbackRate, 'circOut')
			
				noteTweenX('noteTween3X', 2, notePos[5][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween4X', 3, notePos[6][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween7X', 6, notePos[7][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween8X', 7, notePos[8][1], 0.8 / playbackRate, 'circOut')
				doTweenAlpha('healthBar', 'healthBar', 1, 1.4 / playbackRate, 'circOut')
				doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.4 / playbackRate, 'circOut')
				for i = 1, 2 do
					doTweenAlpha('iconP'..i..'alpha', 'iconP'..i, 1, 1.4 / playbackRate, 'circOut')
				end
			end
			if curBeat % 64 == 0 then
				noteTweenX('noteTween1X', 0, notePos[1][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween2X', 1, notePos[2][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween5X', 4, notePos[3][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween6X', 5, notePos[4][1], 0.8 / playbackRate, 'circOut')
			
				noteTweenX('noteTween3X', 2, notePos[7][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween4X', 3, notePos[8][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween7X', 6, notePos[5][1], 0.8 / playbackRate, 'circOut')
				noteTweenX('noteTween8X', 7, notePos[6][1], 0.8 / playbackRate, 'circOut')
				doTweenAlpha('healthBar', 'healthBar', 0.3, 1.4 / playbackRate, 'circOut')
				doTweenAlpha('healthBarBG', 'healthBarBG', 0.3, 1.4 / playbackRate, 'circOut')
				for i = 1, 2 do
					doTweenAlpha('iconP'..i..'alpha', 'iconP'..i, 0.3, 1.4 / playbackRate, 'circOut')
				end
			end
		end
		if curBeat >= 288 and curBeat < 480 then
			if curBeat % 8 == 4 then
				for i = 0, 3 do
					if downscroll then
						noteTweenDirection('NoteDir'..i, i, -90, 0.7 / playbackRate, 'circOut')
						noteTweenAngle('NoteAngle'..i, i, -180, 0.7 / playbackRate, 'circOut')
						noteTweenY('NoteSwap'..i, i, 80, 0.7 / playbackRate, 'circOut')
					else
						noteTweenDirection('NoteDir'..i, i, 630, 0.7 / playbackRate, 'circOut')
						noteTweenAngle('NoteAngle'..i, i, 180, 0.7 / playbackRate, 'circOut')
						noteTweenY('NoteSwap'..i, i, 560, 0.7 / playbackRate, 'circOut')
					end
				end
				for i = 4, 7 do
					if downscroll then
						noteTweenDirection('NoteDir'..i, i, -630, 0.7 / playbackRate, 'circOut')
						noteTweenAngle('NoteAngle'..i, i, 0, 0.7 / playbackRate, 'circOut')
						noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut')
					else
						noteTweenDirection('NoteDir'..i, i, 90, 0.7 / playbackRate, 'circOut')
						noteTweenAngle('NoteAngle'..i, i, 0, 0.7 / playbackRate, 'circOut')
						noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut')
					end
				end
			end
			if curBeat % 8 == 0 then
				for i = 0, 3 do
					if downscroll then
						noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut')
						noteTweenDirection('NoteDir'..i, i, -630, 0.7 / playbackRate, 'circOut')
						noteTweenAngle('NoteAngle'..i, i, 0, 0.7 / playbackRate, 'circOut')
					else
						noteTweenY('NoteSwap'..i, i, notePos[i + 1][2], 0.7 / playbackRate, 'circOut')
						noteTweenDirection('NoteDir'..i, i, 90, 0.7 / playbackRate, 'circOut')
						noteTweenAngle('NoteAngle'..i, i, 0, 0.7 / playbackRate, 'circOut')
					end
				end
				for i = 4, 7 do
					if downscroll then
						noteTweenY('NoteSwap'..i, i, 80, 0.7 / playbackRate, 'circOut')
						noteTweenDirection('NoteDir'..i, i, -90, 0.7 / playbackRate, 'circOut')
						noteTweenAngle('NoteAngle'..i, i, -180, 0.7 / playbackRate, 'circOut')
					else
						noteTweenY('NoteSwap'..i, i, 560, 0.7 / playbackRate, 'circOut')
						noteTweenDirection('NoteDir'..i, i, 630, 0.7 / playbackRate, 'circOut')
						noteTweenAngle('NoteAngle'..i, i, 180, 0.7 / playbackRate, 'circOut')
					end
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
