local drain = false
local kill = false
local charmed = 1
local daSongLength = 0

function onCreate()
	if mechanics then
		makeLuaSprite('barBack', 'effects/faithBarBack', screenWidth - 170, 170)
		setObjectCamera('barBack', 'hud')
		setProperty('barBack.origin.y', 365)
		addLuaSprite('barBack', true)
		
		makeLuaSprite('bar', 'effects/faithBar', screenWidth - 170, 170)
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
			daSongLength = getProperty('songLength') / 1000
			setDrainBar(false)
			
			-- Set custom time
			runHaxeCode([[
				game.songLength = (188 * 1000);
			]])
		end
	end
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
				setProperty('barBack.scale.y', getProperty('barBack.scale.y') + (0.005 * charmed))
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
			
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 and charmed ~= 0.5 then
				charmed = 0.5
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
		drainTime = ((daSongLength + 5) * curScale) / charmed
		--debugPrint("Full Song Length with 5 second increase: "..(daSongLength + 5) / playbackRate)
	end
	
	--debugPrint("Drain time: "..drainTime / playbackRate.." (curScale: "..curScale..")")
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