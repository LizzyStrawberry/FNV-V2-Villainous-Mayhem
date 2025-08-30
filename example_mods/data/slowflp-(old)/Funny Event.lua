local notePos = {}
local notePosX = {}

local tailOriginScaleY

function onCreate()
	makeLuaSprite('NicJumpscare', 'effects/nicJumpscare', -150, -100)
	setProperty('NicJumpscare.alpha', 0)
	setObjectCamera('NicJumpscare', 'hud')
	addLuaSprite('NicJumpscare', true)
	
	tailOriginScaleY = getProperty('tail.scale.y')
	
	doTweenX('scaleX', 'NicJumpscare.scale', 0.01, 0.5, 'circOut')
	doTweenY('scaleY', 'NicJumpscare.scale', 0.01, 0.5, 'circOut')
end

function onCreatePost()
	if difficulty == 1 then
		for i = 4,7 do 
			x = getPropertyFromGroup('strumLineNotes', i, 'x')
			table.insert(notePosX, x)
		end
	end
	
	setObjectOrder('NicJumpscare', getObjectOrder('scoreTxt') + 1)
end

function onSongStart()
	for i = 4,7 do 
		y = getPropertyFromGroup('strumLineNotes', i, 'y')
		table.insert(notePos, y)
	end
end

function onBeatHit()	
	if curBeat % 4 == 0 then
		setProperty('tail.scale.y', tailOriginScaleY - 0.08)
		doTweenY('tail', 'tail.scale', tailOriginScaleY, 0.26 / playbackRate, 'sineOut')
	end
end

function onUpdatePost()
	if difficulty == 1 then
		setPropertyFromGroup('strumLineNotes', 4, 'x', notePosX[4])
		setPropertyFromGroup('strumLineNotes', 5, 'x', notePosX[3])
		setPropertyFromGroup('strumLineNotes', 6, 'x', notePosX[2])
		setPropertyFromGroup('strumLineNotes', 7, 'x', notePosX[1])
	end
	if curBeat >= 64 and curBeat < 80 then
		setTextString('timeTxt', 'Nic')
	end
	
	if curBeat >= 80 and curBeat < 96 then
		setTextString('timeTxt', 'Nic will fuck you up')
	end
	
	if curBeat >= 96 and curBeat < 112 then
		setTextString('timeTxt', 'Nic will destroy all .exes')
	end
	
	if curBeat >= 112 and curBeat < 128 then
		setTextString('timeTxt', 'Nic is your new god')
	end
	
	if curBeat >= 128 and curBeat < 144 then
		setTextString('timeTxt', 'Nic is coming for you')
	end
end

function onUpdate()
	if curBeat == 64 then
		noteTweenY('GFNote1', 4, notePos[1] + 900, 12 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote2', 6, notePos[2] + 900, 12.6 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote3', 7, notePos[3] + 900, 13.2 / playbackRate, 'cubeInOut')
		
		noteTweenAngle('GFNoteAngle1', 4, -10, 7 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFNoteAngle2', 6, 10, 7.6 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFNoteAngle3', 7, 15, 8.2 / playbackRate, 'cubeInOut')
	end
	
	if curBeat == 80 then
		doTweenAngle('camAngle', 'camGame', 15, 24 / playbackRate, 'cubeInOut')
		doTweenAngle('camAngleHUD', 'camHUD', 15, 24 / playbackRate, 'cubeInOut')
		
		doTweenZoom('camGame', 'camGame', 1.4 * zoomMult, 24 / playbackRate, 'cubeInOut')
		
		noteTweenDirection('GFDirectionChange', 5, 360 * 100, 24 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFAngleChange', 5, 360 * 100, 24 / playbackRate, 'cubeInOut')
		
		doTweenColor('whiteBG', 'whiteBG', '820101', 25 / playbackRate, 'cubeInOut')
	end
	
	if curBeat == 140 then
		doTweenAngle('camAngle', 'camGame', 0, 0.6 / playbackRate, 'cubeInOut')
		doTweenAngle('camAngleHUD', 'camHUD', 0, 0.6 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote1', 4, notePos[1], 1 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote2', 6, notePos[2], 1 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote3', 7, notePos[3], 1 / playbackRate, 'cubeInOut')
	end
	
	if curBeat == 144 then
		doTweenColor('whiteBG', 'whiteBG', 'FFFFFF', 0.01 / playbackRate, 'linear')
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
	end
	
	if curBeat == 172 then
		setProperty('NicJumpscare.alpha', 1)
		doTweenX('scaleX', 'NicJumpscare.scale', 1, 0.5 / playbackRate, 'circOut')
		doTweenY('scaleY', 'NicJumpscare.scale', 1, 0.5 / playbackRate, 'circOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'GFNoteAngle2' then
		noteTweenAngle('GFNoteAngleFix1', 4, 0, 1 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFNoteAngleFix2', 6, 0, 1 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFNoteAngleFix3', 7, 0, 1 / playbackRate, 'cubeInOut')
	end
end