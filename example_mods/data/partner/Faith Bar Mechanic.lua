local drain = false
local kill = false
local charmed = 1

function onCreate()
	if mechanics then
		makeLuaSprite('barBack', 'effects/faithBarBack', 1100, 170)
		setObjectCamera('barBack', 'hud')
		setProperty('barBack.origin.y', 365)
		addLuaSprite('barBack', true)
		
		makeLuaSprite('bar', 'effects/faithBar', 1100, 170)
		setObjectCamera('bar', 'hud')
		addLuaSprite('bar', true)
		
		if not isMayhemMode then
			setProperty('healthBar.visible', false)
			setProperty('healthBarBG.visible', false)
		end
	end
end

function onSongStart()
	if mechanics then
		if not isMayhemMode then
			daSongLength = (getProperty('songLength') + 91000) / 1000 / playbackRate
			setDrainBar(false)
		end
	end
end

function onUpdatePost()
	for i = 0, 3 do
		setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
	end

	setPropertyFromGroup('strumLineNotes', 4, 'x', 290)
	setPropertyFromGroup('strumLineNotes', 5, 'x', 410)
	setPropertyFromGroup('strumLineNotes', 6, 'x', 760)
	setPropertyFromGroup('strumLineNotes', 7, 'x', 890)
end

function noteMiss(id, direction, noteType, isSustainNote)
	if mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
		if isMayhemMode then
			if getProperty('barBack.scale.y') > 0 then
				setProperty('barBack.scale.y', getProperty('barBack.scale.y') - (0.0065 / charmed))
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if mechanics then
		if isMayhemMode then
			if getProperty('barBack.scale.y') < 1 then
				setProperty('barBack.scale.y', getProperty('barBack.scale.y') + (0.008 * charmed))
			end
		end
	end
end

function onUpdate()
	if mechanics then
		if not isMayhemMode then
			setProperty('health', getProperty('barBack.scale.y') * 2)
			if getProperty('barBack.scale.y') < 0 then
				setProperty('barBack.scale.y', 0)
			end
			
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 and charmed ~= 0.2 then
				charmed = 0.2
				if kill then
					setDrainBar(true)
				else
					setDrainBar(false)
				end
			end
			
			if difficulty == 0 and getProperty('songMisses') > 45 and not kill then
				setDrainBar(true)
				kill = true
			end
			
			if difficulty == 1 and getProperty('songMisses') > 25 and not kill then
				setDrainBar(true)
				kill = true
			end
			
			if difficulty == 2 and getProperty('songMisses') > 12 and not kill then
				setDrainBar(true)
				kill = true
			end
			
			if drain then
				setProperty('health', 0)
			end
		end
		if isMayhemMode then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				charmed = 2
			end		
		end
	end
end

function setDrainBar(terminate)
	local curScale = getProperty('barBack.scale.y')
	local drainTime = 0

	if terminate then
		drainTime = (4 * curScale) / charmed
		setTextColor('scoreTxt', 'FF0000')
	else
		local remainingTime = (daSongLength - (getSongPosition() / 1000))
		drainTime = (remainingTime * curScale) / charmed
	end
	
	--debugPrint("Current Drain Time: "..drainTime)
	doTweenY('backBarfill', 'barBack.scale', 0, drainTime / playbackRate, 'linear')
end

function onBeatHit()
	if mechanics and curBeat >= 16 then
		if isMayhemMode then
			if getProperty('barBack.scale.y') > 0 and not getPropertyFromClass('ClientPrefs', 'buff3Active') then
				setProperty('barBack.scale.y', getProperty('barBack.scale.y') - (0.005 / charmed))
			end
		end
	end
end

function onStepHit()
	if mechanics and curBeat >= 16 and not getPropertyFromClass('ClientPrefs', 'buff3Active') then
		if isMayhemMode then
			if curStep % 2 == 0 then
				if getProperty('barBack.scale.y') <= 0.75 and getProperty('barBack.scale.y') >= 0.501 then
					setProperty('health', getHealth() - (0.1 / charmed))
				end
				if getProperty('barBack.scale.y') <= 0.50 and getProperty('barBack.scale.y') >= 0.3501 then
					setProperty('health', getHealth() - (0.25 / charmed))
				end
				if getProperty('barBack.scale.y') <= 0.35 and getProperty('barBack.scale.y') >= 0.2501 then
					setProperty('health', getHealth() - (0.50 / charmed))
				end
				if getProperty('barBack.scale.y') <= 0.25 and getProperty('barBack.scale.y') >= 0.0101 then
					setProperty('health', getHealth() - (0.75 / charmed))
				end
			end
			if getProperty('barBack.scale.y') <= 0.01 and getProperty('barBack.scale.y') >= 0 then
				setProperty('health', getHealth() - (1 / charmed))
			end
		end
	end
end

function onPause()
	if not isMayhemMode then
		cancelTween("backBarfill")
	end
end

function onResume()
	if not isMayhemMode then
		if kill then setDrainBar(true) else setDrainBar(false) end
	end
end

function onTweenCompleted(tag)
	if mechanics then
		if not isMayhemMode then
			if tag == 'backBarfill' then
				if getPropertyFromClass("ClientPrefs", "buff2Active") then
					cancelTween("backBarfill")
					setProperty("barBack.scale.y", 1)
					
					cameraFlash('hud', 'FFFFFF', 0.6 / playbackRate, false)
					setGlobalFromScript("scripts/Mayhem Bar + Mechanic", "secondChanceGiven", true)
					setPropertyFromClass('ClientPrefs', 'buff2Active', false)
					
					runTimer("rechargeCooldown", 0.5)
				else
					drain = true
				end
			end
		end
	end
end

function onTimerCompleted(tag)
	if tag == "rechargeCooldown" then
		if kill then setDrainBar(true) else setDrainBar(false) end
	end
end