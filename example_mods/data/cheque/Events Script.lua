function onCreate()	
	makeAnimatedLuaSprite('speaker', 'characters/Speaker', getProperty('boyfriend.x') - 250, getProperty('boyfriend.y') + 450)
	addAnimationByPrefix('speaker', 'idle', 'Speaker0', 24 / playbackRate, false);
	setScrollFactor('speaker', 0.95, 0.95)
	setObjectCamera('speaker', 'game')
	addLuaSprite('speaker', false)
	objectPlayAnimation('speaker', 'idle', true);
	
	makeLuaSprite('blackBG', '', -300, -300)
	makeGraphic('blackBG', 2000, 2000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	addLuaSprite('blackBG', true)
	
	setProperty('healthBar.alpha', 0)
	setProperty('healthBarBG.alpha', 0)
	setProperty('iconP1.alpha', 0)
	setProperty('iconP2.alpha', 0)
	setProperty('scoreTxt.alpha', 0)
	
	setProperty('camGame.zoom', 2.5 * zoomMult)
	
	setProperty('gf.x', getProperty('dad.x') - 210)
	setProperty('gf.y', getProperty('gf.y') - 10)
	setObjectOrder('gfGroup', getObjectOrder('dadGroup') + 1)
end

function onSongStart()
	doTweenAlpha('fadeOut', 'blackBG', 0, 17 / playbackRate, 'cubeInOut')
	doTweenZoom('gamegoWOOO', 'camGame', 0.9 * zoomMult, 19 / playbackRate, 'cubeInOut')
end

function onUpdatePost()
	if curBeat == 62 then
		setProperty('camGame.zoom', 1.0 * zoomMult)
	end
	if curStep == 252 then
		setProperty('camGame.zoom', 1.1 * zoomMult)
	end
	if curStep == 255 then
		setProperty('camGame.zoom', 1.2 * zoomMult)
	end
	if curStep >= 0 and curBeat <= 63 then
		setPropertyFromGroup('opponentStrums',0,'alpha',0)
		setPropertyFromGroup('opponentStrums',1,'alpha',0)
		setPropertyFromGroup('opponentStrums',2,'alpha',0)
		setPropertyFromGroup('opponentStrums',3,'alpha',0)
		setPropertyFromGroup('playerStrums',0,'alpha',0)
		setPropertyFromGroup('playerStrums',1,'alpha',0)
		setPropertyFromGroup('playerStrums',2,'alpha',0)
		setPropertyFromGroup('playerStrums',3,'alpha',0)
	end
	if curStep == 1281 then
		cameraFlash('hud', 'FFFFFF', 1 / playbackRate, false)
	end
	if curBeat == 480 then
		doTweenZoom('gameZoomEnd', 'camGame', 1.1 * zoomMult, 9 / playbackRate, 'easeIn')
		doTweenAlpha('hudGoBye', 'camHUD', 0, 1 / playbackRate, 'circOut')
	end
	if curBeat == 510 then
		setProperty('defaultCamZoom', 1.6 * zoomMult)
		doTweenAlpha('fadeIn', 'blackBG', 1, 1 / playbackRate, 'circOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'gamegoWOOO' then
		setProperty('defaultCamZoom', 0.9 * zoomMult)
	end
	if tag == 'gameZoomEnd' then
		setProperty('defaultCamZoom', 1.1 * zoomMult)
	end
end

function onBeatHit()
	objectPlayAnimation('speaker', 'idle', true);
	if curBeat % 16 == 0 and (curBeat >= 64 and curBeat <= 480) then
		for i = 0, 7 do
			noteTweenAngle('noteTweenAngle'..i, i, 360, 0.6 / playbackRate, 'circOut')
		end
	end
	if curBeat % 32 == 0 and (curBeat >= 64 and curBeat <= 480) then
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums',i,'angle',0)
			setPropertyFromGroup('playerStrums',i,'angle',0)
		end
	end
	if curBeat % 8 == 0 and (curBeat >= 69 and curBeat <= 480) then
		triggerEvent('Add Camera Zoom', '0.03', '0.035')
	end
	if curBeat % 8 == 2 and (curBeat >= 64 and curBeat <= 480) then
		runTimer('woop', 0.01)
	end
	if curBeat % 8 == 4 and (curBeat >= 69 and curBeat <= 480) then
		triggerEvent('Add Camera Zoom', '0.03', '0.035')
	end
	if curBeat % 8 == 6 and (curBeat >= 64 and curBeat <= 480) then
		runTimer('woop', 0.01)
	end
end

function onTimerCompleted(tag)
	if tag == 'woop' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 25)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 25, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 20)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 20, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 20)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 20, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 25)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 25, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 25)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 25, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 20)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 20, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 20)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 20, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 25)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 25, 0.6 / playbackRate, 'sineOut')
	end
end
	
function onUpdate()	
	if curBeat == 64 then
		for i = 0, 7 do
			noteTweenAlpha('noteAlpha'..i, i, 1, 0.01 / playbackRate, 'cubeInOut')
		end
		setProperty('healthBar.alpha', 1)
		setProperty('healthBarBG.alpha', 1)
		setProperty('iconP1.alpha', 1)
		setProperty('iconP2.alpha', 1)
		setProperty('scoreTxt.alpha', 1)
		cameraFlash('hud', 'FFFFFF', 1, false)
	end
end