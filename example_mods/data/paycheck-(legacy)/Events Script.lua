function onCreate()
	setProperty('gf.visible', false)
	
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
end

function onSongStart()
	doTweenAlpha('fadeOut', 'blackBG', 0, 11.7 / playbackRate, 'cubeInOut')
	doTweenZoom('gamegoWOOO', 'camGame', 1.3, 11.7 / playbackRate, 'cubeIn')
end

function onUpdatePost()
	if curStep >= 0 and curBeat <= 31 then
		setPropertyFromGroup('opponentStrums',0,'alpha',0)
		setPropertyFromGroup('opponentStrums',1,'alpha',0)
		setPropertyFromGroup('opponentStrums',2,'alpha',0)
		setPropertyFromGroup('opponentStrums',3,'alpha',0)
		setPropertyFromGroup('playerStrums',0,'alpha',0)
		setPropertyFromGroup('playerStrums',1,'alpha',0)
		setPropertyFromGroup('playerStrums',2,'alpha',0)
		setPropertyFromGroup('playerStrums',3,'alpha',0)
	end
end

function onBeatHit()
	if curBeat % 16 == 0 and curBeat >= 32 then
		for i = 0, 7 do
			noteTweenAngle('noteTweenAngle'..i, i, 360, 0.6, 'circOut')
		end
	end
	if curBeat % 16 == 8 and curBeat >= 32 then
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums',i,'angle',0)
			setPropertyFromGroup('playerStrums',i,'angle',0)
		end
	end
	if curBeat % 4 == 0 and curBeat >= 35 then
		triggerEvent('Add Camera Zoom', '0.02', '0.025')
	end
	if curBeat % 4 == 1 and curBeat >= 32 then
		runTimer('woop', 0.01)
	end
	if curBeat % 4 == 2 and curBeat >= 35 then
		triggerEvent('Add Camera Zoom', '0.02', '0.025')
	end
	if curBeat % 4 == 3 and curBeat >= 32 then
		runTimer('woop', 0.01)
	end
end

function onTimerCompleted(tag)
	if tag == 'woop' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 15)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 10)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 10)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 15)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 15)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 15, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 10)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 10)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 10, 0.6, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 15)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 15, 0.6, 'sineOut')
	end
end
	
function onUpdate()	
	if curBeat == 32 then
		for i = 0, 7 do
			noteTweenAlpha('noteAlpha'..i, i, 1, 0.01, 'cubeInOut')
		end
		setProperty('healthBar.alpha', 1)
		setProperty('healthBarBG.alpha', 1)
		setProperty('iconP1.alpha', 1)
		setProperty('iconP2.alpha', 1)
		setProperty('scoreTxt.alpha', 1)
		cameraFlash('hud', 'FFFFFF', 0.5, false)
	end
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and difficulty >= 1 then
			if getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.009);
				else
					setProperty('health', health- 0.018);
				end
			end
		end
end