local LOWPOINTbf = 604;
local LOWPOINTdad = 600;
local started = false;

function onCreate()
	setProperty('gf.visible', false)
	setPropertyFromClass('GameOverSubstate', 'characterName', 'aileenTofu')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'aileenEmbarrassed')
	
	if not isMayhemMode and difficulty == 1 then
		doTweenAngle('healthBarAngle', 'healthBar', 365, 1.4, 'elasticInOut')
		doTweenAngle('healthBarBGAngle', 'healthBarBG', 365, 1.4, 'elasticInOut')
		doTweenAngle('iconP1Angle', 'iconP1', 365, 1.4, 'elasticInOut')
		doTweenAngle('iconP2Angle', 'iconP2', 365, 1.4, 'elasticInOut')
	end
end

function onSongStart()
	if not isMayhemMode and difficulty == 1 then
		started = true
	end
end

function onBeatHit()
	if curBeat % 4 == 1 then
		runTimer('woop', 0.01)
	end
	if curBeat % 4 == 3 then
		runTimer('woop', 0.01)
	end
	if curBeat % 4 == 2 then
		triggerEvent('Add Camera Zoom', '0', '0.025')
	end
	
	if not isMayhemMode and difficulty == 1 and health >= 0.25 and started and mustHitSection and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
		setProperty('health', getHealth() - 0.019)
	end
end

function onTimerCompleted(tag)
	if tag == 'woop' then
		setPropertyFromGroup('strumLineNotes', 0, 'x', getPropertyFromGroup('strumLineNotes', 0, 'x') - 10)
		noteTweenX('noteTweenO0', 0, getPropertyFromGroup('strumLineNotes', 0, 'x') + 10, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 1, 'x', getPropertyFromGroup('strumLineNotes', 1, 'x') - 5)
		noteTweenX('noteTweenO1', 1, getPropertyFromGroup('strumLineNotes', 1, 'x') + 5, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 2, 'x', getPropertyFromGroup('strumLineNotes', 2, 'x') + 5)
		noteTweenX('noteTweenO2', 2, getPropertyFromGroup('strumLineNotes', 2, 'x') - 5, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 3, 'x', getPropertyFromGroup('strumLineNotes', 3, 'x') + 10)
		noteTweenX('noteTweenO3', 3, getPropertyFromGroup('strumLineNotes', 3, 'x') - 10, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 4, 'x', getPropertyFromGroup('strumLineNotes', 4, 'x') - 10)
		noteTweenX('noteTweenO4', 4, getPropertyFromGroup('strumLineNotes', 4, 'x') + 10, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 5, 'x', getPropertyFromGroup('strumLineNotes', 5, 'x') - 5)
		noteTweenX('noteTweenO5', 5, getPropertyFromGroup('strumLineNotes', 5, 'x') + 5, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 6, 'x', getPropertyFromGroup('strumLineNotes', 6, 'x') + 5)
		noteTweenX('noteTweenO6', 6, getPropertyFromGroup('strumLineNotes', 6, 'x') - 5, 0.6 / playbackRate, 'sineOut')
		
		setPropertyFromGroup('strumLineNotes', 7, 'x', getPropertyFromGroup('strumLineNotes', 7, 'x') + 10)
		noteTweenX('noteTweenO7', 7, getPropertyFromGroup('strumLineNotes', 7, 'x') - 10, 0.6 / playbackRate, 'sineOut')
	end
end