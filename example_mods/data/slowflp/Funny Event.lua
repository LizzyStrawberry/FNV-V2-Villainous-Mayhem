local notePos = {}
local notePosX = {}

local tailOriginScaleY

function onCreate()
	makeLuaSprite('NicJumpscare', 'effects/nicJumpscare', -150, -100)
	setProperty('NicJumpscare.alpha', 0)
	setObjectCamera('NicJumpscare', 'Hud')
	addLuaSprite('NicJumpscare', true)
	
	tailOriginScaleY = getProperty('tail.scale.y')
	
	doTweenX('scaleX', 'NicJumpscare.scale', 0.01, 0.5, 'circOut')
	doTweenY('scaleY', 'NicJumpscare.scale', 0.01, 0.5, 'circOut')
	
	setProperty("legacyPosition", true)
end

function onCreatePost()	
	if difficulty == 1 then
		setPropertyFromGroup('strumLineNotes', 0, 'x', mobileFix("X", 732))
		setPropertyFromGroup('strumLineNotes', 1, 'x', mobileFix("X", 844))
		setPropertyFromGroup('strumLineNotes', 4, 'x', 92)
		setPropertyFromGroup('strumLineNotes', 5, 'x', 204)
	end
	for i = 0,7 do
		x = getPropertyFromGroup('strumLineNotes', i, 'x')
		table.insert(notePosX, x)
	end
	
	setObjectOrder('NicJumpscare', getObjectOrder('scoreTxt') + 1)
end

function onSongStart()
	for i = 0,7 do 
		y = getPropertyFromGroup('strumLineNotes', i, 'y')
		table.insert(notePos, y)
	end
end

function onBeatHit()	
	if curBeat % 2 == 0 then
		setProperty('tail.scale.y', tailOriginScaleY - 0.08)
		doTweenY('tail', 'tail.scale', tailOriginScaleY, 0.26 / playbackRate, 'sineOut')
	end
	
	if (curBeat >= 32 and curBeat < 96) or (curBeat >= 98 and curBeat < 128) or (curBeat >= 136 and curBeat < 144) or (curBeat >= 152 and curBeat < 288) then
		triggerEvent('Add Camera Zoom', '0.04', '0.06')
		
		scaleObject('iconP1', 0.8, 0.8)
		doTweenX('iconP1scaleX', 'iconP1.scale', 0.7, 0.7 / playbackRate, 'sineOut')
		doTweenY('iconP1scaleY', 'iconP1.scale', 0.7, 0.7 / playbackRate, 'sineOut')
			
		scaleObject('iconP2', 0.8, 0.8)
		doTweenX('iconP2scaleX', 'iconP2.scale', 0.7, 0.7 / playbackRate, 'sineOut')
		doTweenY('iconP2scaleY', 'iconP2.scale', 0.7, 0.7 / playbackRate, 'sineOut')
		
		if curBeat % 2 == 0 then
			setProperty('iconP1.angle', -35)
			doTweenAngle('iconP1Angle', 'iconP1', 0, 0.7 / playbackRate, 'sineOut')
			
			setProperty('iconP2.angle', 35)
			doTweenAngle('iconP2Angle', 'iconP2', 0, 0.7 / playbackRate, 'sineOut')
		end
		if curBeat % 2 == 1 then
			setProperty('iconP1.angle', 35)
			doTweenAngle('iconP1Angle', 'iconP1', 0, 0.7 / playbackRate, 'sineOut')
			
			setProperty('iconP2.angle', -35)
			doTweenAngle('iconP2Angle', 'iconP2', 0, 0.7 / playbackRate, 'sineOut')
		end
	end

	if (curBeat >= 32 and curBeat < 128) or (curBeat >= 136 and curBeat < 144) or (curBeat >= 152 and curBeat < 200) then
		if curBeat % 1 == 0 then
			for i = 0, 7 do
				setPropertyFromGroup('strumLineNotes', i, 'y', notePos[i + 1])
				setPropertyFromGroup('strumLineNotes', i, 'scale.x', 1.0)
				setPropertyFromGroup('strumLineNotes', i, 'scale.y', 0.35)
				
				noteTweenY('noteGoUp'..i, i, notePos[i + 1] - 20, 0.7 / playbackRate, 'elasticOut')
				noteTweenScaleX('noteXSCALE'..i, i, 0.7, 0.7 / playbackRate, 'circOut')
				noteTweenScaleY('noteYSCALE'..i, i, 0.7, 0.7 / playbackRate, 'circOut')
			end
		end
		if curBeat % 2 == 0 then
			for i = 0, 7 do
				cancelTween('noteGoRight'..i)
				noteTweenX('noteGoLeft'..i, i, notePosX[i + 1] - 20, 0.7 / playbackRate, 'expoOut')
			end
		end
		if curBeat % 2 == 1 then
			for i = 0, 7 do
				cancelTween('noteGoLeft'..i)
				noteTweenX('noteGoRight'..i, i, notePosX[i + 1] + 20, 0.7 / playbackRate, 'expoOut')
			end
		end
	end
	if curBeat >= 200 and curBeat <= 286 then
		if curBeat % 1 == 0 then
			for i = 0, 3 do
				setPropertyFromGroup('strumLineNotes', i, 'y', notePos[i + 1])
				setPropertyFromGroup('strumLineNotes', i, 'scale.x', 1.0)
				setPropertyFromGroup('strumLineNotes', i, 'scale.y', 0.5)
					
				noteTweenY('noteGoUp'..i, i, notePos[i + 1] - 20, 0.7 / playbackRate, 'elasticOut')
				noteTweenScaleX('noteXSCALE'..i, i, 0.7, 0.7 / playbackRate, 'circOut')
				noteTweenScaleY('noteYSCALE'..i, i, 0.7, 0.7 / playbackRate, 'circOut')
			end
		end
		if curBeat % 2 == 0 then
			for i = 0, 7 do
				cancelTween('noteGoRight'..i)
				noteTweenX('noteGoLeft'..i, i, notePosX[i + 1] - 20, 0.7 / playbackRate, 'expoOut')
			end
		end
		if curBeat % 2 == 1 then
			for i = 0, 7 do
				cancelTween('noteGoLeft'..i)
				noteTweenX('noteGoRight'..i, i, notePosX[i + 1] + 20, 0.7 / playbackRate, 'expoOut')
			end
		end
	end
end

function onUpdatePost()
	if curBeat >= 208 and curBeat < 224 then
		setTextString('timeTxt', 'Nic')
	end
	
	if curBeat >= 224 and curBeat < 240 then
		setTextString('timeTxt', 'Nic is near')
	end
	
	if curBeat >= 240 and curBeat < 256 then
		setTextString('timeTxt', 'Nic will destroy all .exes')
	end
	
	if curBeat >= 256 and curBeat < 270 then
		setTextString('timeTxt', 'Bow down to Nic')
	end
	
	if curBeat >= 270 and curBeat < 288 then
		setTextString('timeTxt', 'or else')
	end
end

function onUpdate()
	if curBeat == 30 then
		doTweenZoom('camZoom', 'camGame', 1.4 * zoomMult, 0.4 / playbackRate, 'quintIn')
		setProperty('camZooming', true)
	end
	
	if curBeat == 32 then
		cancelTween('camZoom')
		doTweenZoom('camZoom', 'camGame', 0.7 * zoomMult, 0.7 / playbackRate, 'sineOut')
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('defaultCamZoom', 0.7 * zoomMult)
	end
	
	if curBeat == 96 or curBeat == 128 or curBeat == 144 then
		setProperty('defaultCamZoom', 1.4 * zoomMult)
	end
	
	if curBeat == 97 or curBeat == 136 or curBeat == 152 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('defaultCamZoom', 0.7 * zoomMult)
	end
	
	if curBeat == 200 then
		noteTweenY('GFNote1', 4, notePos[5] + 900, 12 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote2', 5, notePos[6] + 900, 12.6 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote3', 7, notePos[8] + 900, 13.2 / playbackRate, 'cubeInOut')
		
		noteTweenAngle('GFNoteAngle1', 4, -10, 7 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFNoteAngle2', 5, 10, 7.6 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFNoteAngle3', 7, 15, 8.2 / playbackRate, 'cubeInOut')
	end
	
	if curBeat == 208 then
		doTweenAngle('camAngle', 'camGame', 25, 36 / playbackRate, 'cubeInOut')
		doTweenAngle('camAngleHUD', 'camHUD', 25, 36 / playbackRate, 'cubeInOut')
		
		doTweenZoom('camGame', 'camGame', 1.4 * zoomMult, 34 / playbackRate, 'cubeInOut')
		
		noteTweenDirection('GFDirectionChange', 6, 360 * 100, 34 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFAngleChange', 6, 360 * 100, 34 / playbackRate, 'cubeInOut')
		
		doTweenColor('whiteBG', 'whiteBG', '820101', 36 / playbackRate, 'cubeInOut')
	end
	
	if curBeat == 286 then
		doTweenAngle('camAngle', 'camGame', 0, 0.6 / playbackRate, 'cubeInOut')
		doTweenAngle('camAngleHUD', 'camHUD', 0, 0.6 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote1', 4, notePos[5], 1 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote2', 5, notePos[6], 1 / playbackRate, 'cubeInOut')
		noteTweenY('GFNote3', 7, notePos[8], 1 / playbackRate, 'cubeInOut')
	end
	
	if curBeat == 288 then
		doTweenColor('whiteBG', 'whiteBG', 'FFFFFF', 0.01 / playbackRate, 'linear')
		cameraFlash('game', 'FFFFFF', 0.7, false)
	end
	
	if curBeat == 292 then
		setProperty('NicJumpscare.alpha', 1)
		doTweenX('scaleX', 'NicJumpscare.scale', 1, 0.5 / playbackRate, 'circOut')
		doTweenY('scaleY', 'NicJumpscare.scale', 1, 0.5 / playbackRate, 'circOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'GFNoteAngle2' then
		noteTweenAngle('GFNoteAngleFix1', 4, 0, 1 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFNoteAngleFix2', 5, 0, 1 / playbackRate, 'cubeInOut')
		noteTweenAngle('GFNoteAngleFix3', 7, 0, 1 / playbackRate, 'cubeInOut')
	end
end