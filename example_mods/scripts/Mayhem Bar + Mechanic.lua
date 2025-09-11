local mayhemEnabled = true

local marcoMainSongs = {'Scrouge', 'Toxic Mishap Remix', 'Villainy', 'Cheap Skate V1', 'Toxic Mishap', 'Shucks V2'}

local maxedOut = false
local activated = false

secondChanceGiven = false
local secondChanceAllowed = false

local refill = false

-- Health Calculations
local stepsPerSecond
local totalHealthGain = 0.75 -- Normally without Mayhem Mode
local healthGainPerStep

function onCreate()
	if (not getPropertyFromClass('ClientPrefs', 'buff1Selected') and not getPropertyFromClass('ClientPrefs', 'buff2Selected')
	and not getPropertyFromClass('ClientPrefs', 'buff3Selected')) or not mechanics or botPlay then
		mayhemEnabled = false
	end
	
	--Resetting
	for i = 1, 3 do
		if getPropertyFromClass('ClientPrefs', 'buff'..i..'Selected') then
			setPropertyFromClass('ClientPrefs', 'buff'..i..'Active', false)
		end
	end
	
	-- Song Specifications and exceptions
	if songName == 'Iniquitous' or songName == 'Couple Clash' or (isIniquitousMode and week == 'weekkiana') then
		mayhemEnabled = false
	end
end

function onCreatePost()	
	if mayhemEnabled then
		-- Calculate Health Gain for buff 1
		stepsPerSecond = (bpm / 60) * 4
		if isMayhemMode then
			totalHealthGain = 10 -- Gain 10 Health in Mayhem Mode
		end
		healthGainPerStep = ((totalHealthGain / 7) / stepsPerSecond) * 2 -- per 2 steps
		
		padColor = rgbToHex(getProperty('dad.healthColorArray'))
		
		for i = 1, #(marcoMainSongs) do
			if songName == marcoMainSongs[i] then
				padColor = '3ac331'
			end
		end
		
		backColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
		
		makeLuaSprite('reloadBar', 'mayhemBar/mayhembackBar', mobileFix("X", 450), 530)
		setProperty('reloadBar.color', getColorFromHex('737373'))
		setObjectCamera('reloadBar', 'hud')
		setObjectOrder('reloadBar', getObjectOrder('healthBarBG') + 1)
		setProperty('reloadBar.origin.x', 80)
		setProperty('reloadBar.scale.x', 1)
		addLuaSprite('reloadBar', true)
		
		makeLuaSprite('mayhembackBar', 'mayhemBar/mayhembackBar', mobileFix("X", 450), 530)
		setProperty('mayhembackBar.color', getColorFromHex(backColor))
		setObjectCamera('mayhembackBar', 'hud')
		setObjectOrder('mayhembackBar', getObjectOrder('reloadBar') + 1)
		setProperty('mayhembackBar.origin.x', 80)
		setProperty('mayhembackBar.scale.x', 0)
		addLuaSprite('mayhembackBar', true)
		
		makeLuaSprite('mayhemPads', 'mayhemBar/mayhemPads', mobileFix("X", 450), 530)
		setObjectCamera('mayhemPads', 'hud')
		setObjectOrder('mayhemPads', getObjectOrder('healthBar'))
		setProperty('mayhemPads.color', getColorFromHex(padColor))
		addLuaSprite('mayhemPads', true)
		
		makeLuaSprite('mayhemBar', 'mayhemBar/mayhemBar', mobileFix("X", 450), 530)
		setObjectCamera('mayhemBar', 'hud')
		setObjectOrder('mayhemBar', getObjectOrder('mayhembackBar') + 1)
		addLuaSprite('mayhemBar', true)
		
		makeLuaSprite('mayhemText', 'mayhemBar/mayhemText', mobileFix("X", 450), 530)
		setObjectCamera('mayhemText', 'hud')
		setObjectOrder('mayhemText', getObjectOrder('mayhemBar') + 1)
		setProperty('mayhemText.color', getColorFromHex(padColor))
		addLuaSprite('mayhemText', true)
		
		makeLuaSprite('leftBGEffect', 'effects/bgEffect', -100, 0)
		setScrollFactor('leftBGEffect', 0, 0)
		setObjectCamera('leftBGEffect', 'hud')
		setProperty('leftBGEffect.alpha', 0)
		addLuaSprite('leftBGEffect', true)
		
		makeLuaSprite('rightBGEffect', 'effects/bgEffect', 100, 0)
		setScrollFactor('rightBGEffect', 0, 0)
		setObjectCamera('rightBGEffect', 'hud')
		setProperty('rightBGEffect.alpha', 0)
		setProperty('rightBGEffect.flipX', true)
		addLuaSprite('rightBGEffect', true)
		
		if downscroll then
			setProperty('reloadBar.y', 110)
			setProperty('mayhembackBar.y', 110)
			setProperty('mayhemPads.y', 110)
			setProperty('mayhemBar.y', 110)
			setProperty('mayhemText.y', 110)
		end
		
		-- Song Specifications
		if songName == 'Sussus Marcus' or songName == 'Villain In Board' or songName == 'Excrete' then
			if downscroll then
				setProperty('reloadBar.y', 110)
				setProperty('mayhembackBar.y', 110)
				setProperty('mayhemPads.y', 110)
				setProperty('mayhemBar.y', 110)
				setProperty('mayhemText.y', 110)
			else
				setProperty('reloadBar.y', 510)
				setProperty('mayhembackBar.y', 510)
				setProperty('mayhemPads.y', 510)
				setProperty('mayhemBar.y', 510)
				setProperty('mayhemText.y', 510)
			end
		end
		if not isMayhemMode and (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics then
			if downscroll then
				setProperty('reloadBar.y', 30)
				setProperty('mayhembackBar.y', 30)
				setProperty('mayhemPads.y', 30)
				setProperty('mayhemBar.y', 30)
				setProperty('mayhemText.y', 30)
			else
				setProperty('reloadBar.y', 600)
				setProperty('mayhembackBar.y', 600)
				setProperty('mayhemPads.y', 600)
				setProperty('mayhemBar.y', 600)
				setProperty('mayhemText.y', 600)
			end
			setProperty('mayhembackBar.alpha', 0)
		end
		if songName == 'Libidinousness' and mechanics then
			if downscroll then
				setProperty('reloadBar.y', 30)
				setProperty('mayhembackBar.y', 30)
				setProperty('mayhemPads.y', 30)
				setProperty('mayhemBar.y', 30)
				setProperty('mayhemText.y', 30)
			else
				setProperty('reloadBar.y', 600)
				setProperty('mayhembackBar.y', 600)
				setProperty('mayhemPads.y', 600)
				setProperty('mayhemBar.y', 600)
				setProperty('mayhemText.y', 600)
			end
		end
	end
end

local mayhemAlphaLower = false
function onUpdatePost()
	if mayhemEnabled then
		healthLeft = getHealth();
		
		-- Set Bar Position
		if not isMayhemMode and songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner' then
			setProperty('reloadBar.alpha', getProperty('mayhembackBar.alpha'))
			setProperty('mayhemPads.alpha', getProperty('mayhembackBar.alpha'))
			setProperty('mayhemBar.alpha', getProperty('mayhembackBar.alpha'))
			setProperty('mayhemText.alpha', getProperty('mayhembackBar.alpha'))
		elseif songName == 'Libidinousness' then
			if not mustHitSection and not mayhemAlphaLower then
				doTweenAlpha('mayhembackBar', 'mayhembackBar', 0.3, 0.5, 'sineOut')
				doTweenAlpha('reloadBar', 'reloadBar', 0.3, 0.5, 'sineOut')
				doTweenAlpha('mayhemPads', 'mayhemPads', 0.3, 0.5, 'sineOut')
				doTweenAlpha('mayhemBar', 'mayhemBar', 0.3, 0.5, 'sineOut')
				doTweenAlpha('mayhemText', 'mayhemText', 0.3, 0.5, 'sineOut')
				mayhemAlphaLower = true
			end
			if mustHitSection and mayhemAlphaLower then
				doTweenAlpha('mayhembackBar', 'mayhembackBar', 1, 0.5, 'sineOut')
				doTweenAlpha('reloadBar', 'reloadBar', 1, 0.5, 'sineOut')
				doTweenAlpha('mayhemPads', 'mayhemPads', 1, 0.5, 'sineOut')
				doTweenAlpha('mayhemBar', 'mayhemBar', 1, 0.5, 'sineOut')
				doTweenAlpha('mayhemText', 'mayhemText', 1, 0.5, 'sineOut')
				mayhemAlphaLower = false
			end
		else
			setProperty('mayhembackBar.alpha', getProperty('healthBar.alpha'))
			setProperty('reloadBar.alpha', getProperty('mayhembackBar.alpha'))
			setProperty('mayhemPads.alpha', getProperty('mayhembackBar.alpha'))
			setProperty('mayhemBar.alpha', getProperty('mayhembackBar.alpha'))
			setProperty('mayhemText.alpha', getProperty('mayhembackBar.alpha'))
			
			setProperty('mayhembackBar.visible', getProperty('healthBar.visible'))
			setProperty('reloadBar.visible', getProperty('mayhembackBar.visible'))
			setProperty('mayhemPads.visible', getProperty('mayhembackBar.visible'))
			setProperty('mayhemBar.visible', getProperty('mayhembackBar.visible'))
			setProperty('mayhemText.visible', getProperty('mayhembackBar.visible'))
		end
		
		-- Mayhem mechanics
		-- 1) Health Increase on Step (Unlocked on Marco's main week)
		-- 2) Second Chance (Unlocked on Beatrice's main week)
		-- 3) Immunity (Unlocked on Kiana's main week / IT'S SHOWN ON HEALTH DRAINING SCRIPTS)
		if getPropertyFromClass('ClientPrefs', 'buff1Unlocked') and getPropertyFromClass('ClientPrefs', 'buff1Selected') then
			if keyJustPressed('mayhem') and maxedOut and not activated and not refill then
				activated = true
				doTweenX('mayhemBackBarScale', 'mayhembackBar.scale', 0, 7, 'linear')
				
				if not isMayhemMode then
					if (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics then
						cancelTween('backBarfill')
					elseif songName == 'Toybox' and mechanics then
						if curBeat >= 136 and curBeat < 456 then
							cancelTween('backBarfill')
							cancelTimer('drainDelay')
						end
					end
				end
				
				setPropertyFromClass('ClientPrefs', 'buff1Active', true)
			end
		end
		
		if getPropertyFromClass('ClientPrefs', 'buff2Unlocked') and getPropertyFromClass('ClientPrefs', 'buff2Selected') then
			if keyJustPressed('mayhem') and maxedOut and not activated and not secondChanceAllowed and not refill then
				activated = true
				secondChanceAllowed = true
				doTweenX('mayhemBackBarScaleBuff2', 'mayhembackBar.scale', 0, 7, 'circOut')

				setPropertyFromClass('ClientPrefs', 'buff2Active', true)
			end
			if not secondChanceGiven and healthLeft <= 0 and activated then
				cameraFlash('hud', 'FFFFFF', 0.6 / playbackRate, false)
				secondChanceGiven = true
				if isMayhemMode then
					setProperty('health', 50)
				else
					if songName == "Toybox" and mechanics then
						if curBeat >= 136 and curBeat < 456 then
							setProperty('health', 1.5)
							setProperty("barBack.scale.x", getHealth() / 2)
							callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
						else
							setProperty('health', 2)
						end
					else
						setProperty('health', 2)
					end
				end
				
				setPropertyFromClass('ClientPrefs', 'buff2Active', false)
			end
		end
		
		if getPropertyFromClass('ClientPrefs', 'buff3Unlocked') and getPropertyFromClass('ClientPrefs', 'buff3Selected') then
			if keyJustPressed('mayhem') and maxedOut and not activated and not refill then
				activated = true
				doTweenX('mayhemBackBarScaleBuff3', 'mayhembackBar.scale', 0, 7, 'linear')
				setPropertyFromClass('ClientPrefs', 'buff3Active', true)
				
				-- Song Specifications
				if not isMayhemMode then
					if (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics then
						pauseTween('backBarfill')
					elseif songName == 'Toybox' and mechanics then
						if curBeat >= 136 and curBeat < 456 then
							pauseTween('backBarfill')
						end
					end
				end
			end
		end
		
		-- Disable bonus
		if activated and not getPropertyFromClass('PlayState', 'checkForPowerUp') then
			setPropertyFromClass('PlayState', 'checkForPowerUp', true)
		end
	end
end

function onStepHit()
	if mayhemEnabled then
		if activated and getPropertyFromClass('ClientPrefs', 'buff1Unlocked') and getPropertyFromClass('ClientPrefs', 'buff1Selected') then
			if curStep % 2 == 0 then
				if isMayhemMode then
					setProperty('health', getHealth() + healthGainPerStep)
				else
					-- Song Specifications
					if (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics
						and getProperty('barBack.scale.y') < 1 then
						setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.0025)
					elseif songName == 'Toybox' and mechanics then
						if curBeat >= 136 and curBeat < 456 then
							setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.005)
						else
							setProperty('health', getHealth() + healthGainPerStep)
						end
					else
						setProperty('health', getHealth() + healthGainPerStep)
					end
				end
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if mayhemEnabled then
		if not secondChanceAllowed then
			if not maxedOut then
				if not isSustainNote then
					setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') + 0.012)
				else
					setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') + 0.00115)
				end
				if getProperty('mayhembackBar.scale.x') >= 1 then
					setProperty('mayhembackBar.scale.x', 1)
					setProperty('reloadBar.scale.x', 0)
					maxedOut = true
				end
			end
		end
		
		if activated then
			addScore(450)
			
			if direction == 0 then
				if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('f65215'))
				elseif boyfriendName == 'ourple' then
					setProperty('leftBGEffect.color', getColorFromHex('fff31d'))
				elseif boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('d2fffb'))
				elseif boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('dcdcdc'))
				elseif boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
					setProperty('leftBGEffect.color', getColorFromHex('4c9e64'))
				else
					setProperty('leftBGEffect.color', getColorFromHex('9700FF'))
				end
			end
			if direction == 1 then
				if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('f4cabb'))
				elseif boyfriendName == 'ourple' then
					setProperty('leftBGEffect.color', getColorFromHex('327dff'))
				elseif boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('3bc2b2'))
				elseif boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('729576'))
				elseif boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
					setProperty('leftBGEffect.color', getColorFromHex('288543'))
				else
					setProperty('leftBGEffect.color', getColorFromHex('00FFFF'))
				end
			end
			if direction == 2 then
				if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('edbeec'))
				elseif boyfriendName == 'ourple' then
					setProperty('leftBGEffect.color', getColorFromHex('32ffab'))
				elseif boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('d2fffb'))
				elseif boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('729576'))
				elseif boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
					setProperty('leftBGEffect.color', getColorFromHex('8bbd99'))
				else
					setProperty('leftBGEffect.color', getColorFromHex('00FF00'))
				end
			end
			if direction == 3 then
				if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('ee25e8'))
				elseif boyfriendName == 'ourple' then
					setProperty('leftBGEffect.color', getColorFromHex('ff1dc0'))
				elseif boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('3bc2b2'))
				elseif boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
					setProperty('leftBGEffect.color', getColorFromHex('565656'))
				elseif boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
					setProperty('leftBGEffect.color', getColorFromHex('23743a'))
				else
					setProperty('leftBGEffect.color', getColorFromHex('FF0000'))
				end
			end
			
			setProperty('rightBGEffect.color', getProperty("leftBGEffect.color")) -- Same as left
			
			setProperty('leftBGEffect.alpha', 1)
			cancelTween('leftBGEffect')
			doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
				
			setProperty('rightBGEffect.alpha', 1)
			cancelTween('rightBGEffect')
			doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if mayhemEnabled then
		if not maxedOut and getProperty('mayhembackBar.scale.x') > 0 then
			setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') - 0.015)
		end
	end
end

function noteMissPress(direction)
	if mayhemEnabled and not getPropertyFromClass('ClientPrefs', 'ghostTapping') then
		if not maxedOut and getProperty('mayhembackBar.scale.x') > 0 then
			setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') - 0.015)
		end
	end
end

function onBeatHit()
	if mayhemEnabled then
		if maxedOut then
			if curBeat % 1 == 0 then
				setProperty('mayhembackBar.color', getColorFromHex('FFFFFF'))
				doTweenColor('mayhemBackBarColor', 'mayhembackBar', backColor, 0.8 / playbackRate, 'sineOut')
			end
		end
	end
end

function onTweenCompleted(tag)
	if mayhemEnabled then
		if tag == 'mayhemBackBarScale' then -- Buff 1
			doTweenX('reloading', 'reloadBar.scale', 1, 10, 'linear')
			setProperty('mayhembackBar.color', getColorFromHex(backColor))
			setPropertyFromClass('ClientPrefs', 'buff1Active', false)
			
			activated = false
			
			if not isMayhemMode then
				if (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics then
					if difficulty == 0 and getProperty('songMisses') > 45 then
						callScript("data/"..songPath.."/Faith Bar Mechanic", "setDrainBar", {true})
					elseif difficulty == 1 and getProperty('songMisses') > 25 then
						callScript("data/"..songPath.."/Faith Bar Mechanic", "setDrainBar", {true})
					elseif difficulty == 2 and getProperty('songMisses') > 12 then
						callScript("data/"..songPath.."/Faith Bar Mechanic", "setDrainBar", {true})
					else
						callScript("data/"..songPath.."/Faith Bar Mechanic", "setDrainBar", {false})
					end
				end
			
				if songName == 'Toybox' and mechanics then
					if curBeat >= 136 and curBeat < 456 then
						callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
					end
				end
			end
		end
		
		if tag == 'mayhemBackBarScaleBuff2' then -- Buff 2
			if not secondChanceGiven then
				activated = false
				secondChanceAllowed = false -- You didn't die yet, reset this
				doTweenX('reloading', 'reloadBar.scale', 1, 10, 'linear')
				setProperty('mayhembackBar.color', getColorFromHex(backColor))
				
				setPropertyFromClass('ClientPrefs', 'buff2Active', false)
			else
				activated = false
			end
		end
		
		if tag == 'mayhemBackBarScaleBuff3' then -- Buff 3
			doTweenX('reloading', 'reloadBar.scale', 1, 10, 'linear')
			activated = false
			setProperty('mayhembackBar.color', getColorFromHex(backColor))
			setPropertyFromClass('ClientPrefs', 'buff3Active', false)
						
			if not isMayhemMode then
				if (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics then
					resumeTween('backBarfill')
				elseif songName == 'Toybox' and mechanics then
					if curBeat >= 136 and curBeat < 456 then
						callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
					end
				end
			end
		end
		
		if tag == 'reloading' then
			maxedOut = false
			refill = false
		end
	end
end

function onDestroy()
	if getPropertyFromClass('ClientPrefs', 'buff1Selected') then
		setPropertyFromClass('ClientPrefs', 'buff1Active', false)
	end
	if getPropertyFromClass('ClientPrefs', 'buff2Selected') then
		setPropertyFromClass('ClientPrefs', 'buff2Active', false)
	end
	if getPropertyFromClass('ClientPrefs', 'buff3Selected') then
		setPropertyFromClass('ClientPrefs', 'buff3Active', false)
	end
end

function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
    return string.format('%02x%02x%02x', math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end