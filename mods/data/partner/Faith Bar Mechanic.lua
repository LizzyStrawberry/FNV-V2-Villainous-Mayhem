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
			doTweenY('backBarfill', 'barBack.scale', 0, daSongLength + 20, 'linear')
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
			
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				charmed = 0.2
			end
			
			if difficulty == 0 and getProperty('songMisses') > 45 and not kill then
				cancelTween('backBarfill')
				doTweenY('backBarfill', 'barBack.scale', 0, 4, 'linear')
				setTextColor('scoreTxt', 'FF0000')
				kill = true
			end
			
			if difficulty == 1 and getProperty('songMisses') > 25 and not kill then
				cancelTween('backBarfill')
				doTweenY('backBarfill', 'barBack.scale', 0, 4, 'linear')
				setTextColor('scoreTxt', 'FF0000')
				kill = true
			end
			
			if difficulty == 2 and getProperty('songMisses') > 12 and not kill then
				cancelTween('backBarfill')
				doTweenY('backBarfill', 'barBack.scale', 0, 4 / charmed, 'linear')
				setTextColor('scoreTxt', 'FF0000')
				kill = true
			end
			
			if drain == true then
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

function onBeatHit()
	if mechanics and curBeat >= 16 then
		if isMayhemMode then
			if getProperty('barBack.scale.y') > 0 and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
				setProperty('barBack.scale.y', getProperty('barBack.scale.y') - (0.005 / charmed))
			end
		end
	end
end

function onStepHit()
	if mechanics and curBeat >= 16 and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
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

function onTweenCompleted(tag)
	if mechanics then
		if not isMayhemMode then
			if tag == 'backBarfill' then
				drain = true
			end
		end
	end
end