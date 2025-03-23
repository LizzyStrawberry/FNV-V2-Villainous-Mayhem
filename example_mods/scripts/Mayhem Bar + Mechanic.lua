local marcoMainSongs = {'Scrouge', 'Toxic Mishap Remix', 'Villainy', 'Cheap Skate V1', 'Toxic Mishap', 'Shucks V2'}
local mayhemEnabled = true
local maxedOut = false
local activated = false
local secondChanceGiven = false
local secondChanceAllowed = false
local charmed = 1

local refill = false

function onCreate()
	if (not getPropertyFromClass('ClientPrefs', 'buff1Selected') and not getPropertyFromClass('ClientPrefs', 'buff2Selected')
	and not getPropertyFromClass('ClientPrefs', 'buff3Selected')) or (not mechanics) or botPlay then
		mayhemEnabled = false
	end
	
	--Resetting
	if getPropertyFromClass('ClientPrefs', 'buff1Selected') == true then
		setPropertyFromClass('ClientPrefs', 'buff1Active', false)
	end
	if getPropertyFromClass('ClientPrefs', 'buff2Selected') == true then
		setPropertyFromClass('ClientPrefs', 'buff2Active', false)
	end
	if getPropertyFromClass('ClientPrefs', 'buff3Selected') == true then
		setPropertyFromClass('ClientPrefs', 'buff3Active', false)
	end
	
	-- Song Specifications and exceptions
	if songName == 'Iniquitous' or songName == 'Couple Clash' or (isIniquitousMode and week == 'weekkiana') then
		mayhemEnabled = false
	end
end

function onCreatePost()	
	if mayhemEnabled == true then
		padColor = rgbToHex(getProperty('dad.healthColorArray'))
		
		for i = 1, #(marcoMainSongs) do
			if songName == marcoMainSongs[i] then
				padColor = '3ac331'
			end
		end
		
		backColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
		
		makeLuaSprite('reloadBar', 'mayhemBar/mayhembackBar', 450, 530)
		setProperty('reloadBar.color', getColorFromHex('737373'))
		setObjectCamera('reloadBar', 'hud')
		setObjectOrder('reloadBar', getObjectOrder('healthBarBG') + 1)
		setProperty('reloadBar.origin.x', 80)
		setProperty('reloadBar.scale.x', 1)
		addLuaSprite('reloadBar', true)
		
		makeLuaSprite('mayhembackBar', 'mayhemBar/mayhembackBar', 450, 530)
		setProperty('mayhembackBar.color', getColorFromHex(backColor))
		setObjectCamera('mayhembackBar', 'hud')
		setObjectOrder('mayhembackBar', getObjectOrder('reloadBar') + 1)
		setProperty('mayhembackBar.origin.x', 80)
		setProperty('mayhembackBar.scale.x', 0)
		addLuaSprite('mayhembackBar', true)
		
		makeLuaSprite('mayhemPads', 'mayhemBar/mayhemPads', 450, 530)
		setObjectCamera('mayhemPads', 'hud')
		setObjectOrder('mayhemPads', getObjectOrder('healthBar'))
		setProperty('mayhemPads.color', getColorFromHex(padColor))
		addLuaSprite('mayhemPads', true)
		
		makeLuaSprite('mayhemBar', 'mayhemBar/mayhemBar', 450, 530)
		setObjectCamera('mayhemBar', 'hud')
		setObjectOrder('mayhemBar', getObjectOrder('mayhembackBar') + 1)
		addLuaSprite('mayhemBar', true)
		
		makeLuaSprite('mayhemText', 'mayhemBar/mayhemText', 450, 530)
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
	if mayhemEnabled == true then
		healthLeft = getHealth();
		
		if not isMayhemMode and songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner' then
			setProperty('reloadBar.alpha', getProperty('mayhembackBar.alpha'))
			setProperty('mayhemPads.alpha', getProperty('mayhembackBar.alpha'))
			setProperty('mayhemBar.alpha', getProperty('mayhembackBar.alpha'))
			setProperty('mayhemText.alpha', getProperty('mayhembackBar.alpha'))
		elseif songName == 'Libidinousness' then
			if not mustHitSection and mayhemAlphaLower == false then
				doTweenAlpha('mayhembackBar', 'mayhembackBar', 0.3, 0.5, 'sineOut')
				doTweenAlpha('reloadBar', 'reloadBar', 0.3, 0.5, 'sineOut')
				doTweenAlpha('mayhemPads', 'mayhemPads', 0.3, 0.5, 'sineOut')
				doTweenAlpha('mayhemBar', 'mayhemBar', 0.3, 0.5, 'sineOut')
				doTweenAlpha('mayhemText', 'mayhemText', 0.3, 0.5, 'sineOut')
				mayhemAlphaLower = true
			end
			if mustHitSection and mayhemAlphaLower == true then
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
		if getPropertyFromClass('ClientPrefs', 'buff1Unlocked') == true and getPropertyFromClass('ClientPrefs', 'buff1Selected') == true then
			if keyJustPressed('mayhem') and maxedOut and activated == false and refill == false then
				activated = true
				doTweenX('mayhemBackBarScale', 'mayhembackBar.scale', 0, 7, 'linear')
				
				if not isMayhemMode and (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics then
					cancelTween('backBarfill')
				end
				if not isMayhemMode and songName == 'Toybox' and mechanics then
					if (curBeat >= 136 and curBeat < 456) then
						cancelTween('backBarfill')
						cancelTimer('drainDelay')
					end
				end
				
				setPropertyFromClass('ClientPrefs', 'buff1Active', true)
			end
		end
		
		if getPropertyFromClass('ClientPrefs', 'buff2Unlocked') == true and getPropertyFromClass('ClientPrefs', 'buff2Selected') == true then
			if keyJustPressed('mayhem') and maxedOut and activated == false and secondChanceAllowed == false and refill == false then
				activated = true
				doTweenX('mayhemBackBarScaleBuff2', 'mayhembackBar.scale', 0, 7, 'circOut')
				secondChanceAllowed = true
				
				if isMayhemMode then
					setPropertyFromClass('ClientPrefs', 'buff2Active', true)
				end
			end
			if secondChanceGiven == false and healthLeft <= 0 and activated then
				cameraFlash('hud', 'FFFFFF', 0.6, false)
				if isMayhemMode then
					setProperty('health', 30)
				else
					setProperty('health', 2)
				end
				secondChanceGiven = true
			end
		end
		
		if getPropertyFromClass('ClientPrefs', 'buff3Unlocked') == true and getPropertyFromClass('ClientPrefs', 'buff3Selected') == true then
			if keyJustPressed('mayhem') and maxedOut and activated == false and refill == false then
				activated = true
				doTweenX('mayhemBackBarScaleBuff3', 'mayhembackBar.scale', 0, 7, 'linear')
				setPropertyFromClass('ClientPrefs', 'buff3Active', true)
				
				-- Song Specifications
				if not isMayhemMode and (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics then
					pauseTween('backBarfill')
				end
				if not isMayhemMode and songName == 'Toybox' and mechanics then
					if (curBeat >= 136 and curBeat < 456) and mechanics and not isMayhemMode then
						pauseTween('backBarfill')
					end
				end
			end
		end
		
		--disable bonus
		if activated and getPropertyFromClass('PlayState', 'checkForPowerUp') == false then
			setPropertyFromClass('PlayState', 'checkForPowerUp', true)
		end
	end
end

function onStepHit()
	if mayhemEnabled == true then
		if activated and getPropertyFromClass('ClientPrefs', 'buff1Unlocked') == true and getPropertyFromClass('ClientPrefs', 'buff1Selected') == true then
			if curStep % 2 == 0 then
				if isMayhemMode then
					if bpm >= 60 and bpm <= 100 then
						setProperty('health', getHealth() + 0.275)
					elseif bpm > 100 and bpm <= 140 then
						setProperty('health', getHealth() + 0.225)
					elseif bpm > 140 and bpm <= 180 then
						setProperty('health', getHealth() + 0.175)
					elseif bpm > 180 then
						setProperty('health', getHealth() + 0.125)
					end
				else
					-- Song Specifications
					if (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics
						and getProperty('barBack.scale.y') < 1 then
						setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.005)
					elseif songName == 'Toybox' and mechanics then
						if (curBeat >= 136 and curBeat < 456) and mechanics and not isMayhemMode then
							setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.005)
						else
							setProperty('health', getHealth() + 0.035)
						end
					else
						if bpm >= 60 and bpm <= 100 then
							setProperty('health', getHealth() + 0.0375)
						elseif bpm > 100 and bpm <= 140 then
							setProperty('health', getHealth() + 0.0275)
						elseif bpm > 140 and bpm <= 180 then
							setProperty('health', getHealth() + 0.0175)
						elseif bpm > 180 then
							setProperty('health', getHealth() + 0.0125)
						end
					end
				end
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if mayhemEnabled == true then
		if secondChanceAllowed == false then
			if not maxedOut and (not isSustainNote) then
				setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') + 0.012)
			end
			if maxedOut == false and getProperty('mayhembackBar.scale.x') >= 1 then
				setProperty('mayhembackBar.scale.x', 1)
				setProperty('reloadBar.scale.x', 0)
				maxedOut = true
			end
			if not maxedOut and isSustainNote then
				setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') + 0.00115)
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
				
				setProperty('leftBGEffect.alpha', 1)
				cancelTween('leftBGEffect')
				doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
				
				if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('f65215'))
				elseif boyfriendName == 'ourple' then
					setProperty('rightBGEffect.color', getColorFromHex('fff31d'))
				elseif boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('d2fffb'))
				elseif boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('dcdcdc'))
				elseif boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
					setProperty('rightBGEffect.color', getColorFromHex('4c9e64'))
				else
					setProperty('rightBGEffect.color', getColorFromHex('9700FF'))
				end
				
				setProperty('rightBGEffect.alpha', 1)
				cancelTween('rightBGEffect')
				doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
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
				
				setProperty('leftBGEffect.alpha', 1)
				cancelTween('leftBGEffect')
				doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
				
				if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('f4cabb'))
				elseif boyfriendName == 'ourple' then
					setProperty('rightBGEffect.color', getColorFromHex('327dff'))
				elseif boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('3bc2b2'))
				elseif boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('729576'))
				elseif boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
					setProperty('rightBGEffect.color', getColorFromHex('288543'))
				else
					setProperty('rightBGEffect.color', getColorFromHex('00FFFF'))
				end
				
				setProperty('rightBGEffect.alpha', 1)
				cancelTween('rightBGEffect')
				doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
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
				
				setProperty('leftBGEffect.alpha', 1)
				cancelTween('leftBGEffect')
				doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
				
				if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('edbeec'))
				elseif boyfriendName == 'ourple' then
					setProperty('rightBGEffect.color', getColorFromHex('32ffab'))
				elseif boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('d2fffb'))
				elseif boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('729576'))
				elseif boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
					setProperty('rightBGEffect.color', getColorFromHex('8bbd99'))
				else
					setProperty('rightBGEffect.color', getColorFromHex('00FF00'))
				end
				
				setProperty('rightBGEffect.alpha', 1)
				cancelTween('rightBGEffect')
				doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
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
				setProperty('leftBGEffect.alpha', 1)
				cancelTween('leftBGEffect')
				doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
				
				if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('ee25e8'))
				elseif boyfriendName == 'ourple' then
					setProperty('rightBGEffect.color', getColorFromHex('ff1dc0'))
				elseif boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('3bc2b2'))
				elseif boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
					setProperty('rightBGEffect.color', getColorFromHex('565656'))
				elseif boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
					setProperty('rightBGEffect.color', getColorFromHex('23743a'))
				else
					setProperty('rightBGEffect.color', getColorFromHex('FF0000'))
				end
				setProperty('rightBGEffect.alpha', 1)
				cancelTween('rightBGEffect')
				doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
			end
		end
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if mayhemEnabled == true then
		if not maxedOut and getProperty('mayhembackBar.scale.x') > 0 then
			setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') - 0.015)
		end
	end
end

function noteMissPress(direction)
	if mayhemEnabled == true and getPropertyFromClass('ClientPrefs', 'ghostTapping') == false then
		if not maxedOut and getProperty('mayhembackBar.scale.x') > 0 then
			setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') - 0.015)
		end
	end
end

function onBeatHit()
	if mayhemEnabled == true then
		if maxedOut then
			if curBeat % 1 == 0 then
				setProperty('mayhembackBar.color', getColorFromHex('FFFFFF'))
				doTweenColor('mayhemBackBarColor', 'mayhembackBar', backColor, 0.8 / playbackRate, 'sineOut')
			end
		end
	end
end

function onTweenCompleted(tag)
	if mayhemEnabled == true then
		if tag == 'mayhemBackBarScale' then
			doTweenX('reloading', 'reloadBar.scale', 1, 10, 'linear')
			setProperty('mayhembackBar.color', getColorFromHex(backColor))
			setPropertyFromClass('ClientPrefs', 'buff1Active', false)
			
			activated = false
			
			if not isMayhemMode and (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics then
				daSongLength = (getProperty('songLength') + 91000) / 1000 / playbackRate
				doTweenY('backBarfill', 'barBack.scale', 0, daSongLength + 20, 'linear')
				
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					charmed = 0.2
				end
				
				if difficulty == 0 and getProperty('songMisses') > 45 then
					cancelTween('backBarfill')
					doTweenY('backBarfill', 'barBack.scale', 0, 4 / charmed, 'linear')
					setTextColor('scoreTxt', 'FF0000')
				end
				
				if difficulty == 1 and getProperty('songMisses') > 25 then
					cancelTween('backBarfill')
					doTweenY('backBarfill', 'barBack.scale', 0, 4 / charmed, 'linear')
					setTextColor('scoreTxt', 'FF0000')
				end
				
				if difficulty == 2 and getProperty('songMisses') > 12 then
					cancelTween('backBarfill')
					doTweenY('backBarfill', 'barBack.scale', 0, 4 / charmed, 'linear')
					setTextColor('scoreTxt', 'FF0000')
				end
			end
			
			if not isMayhemMode and songName == 'Toybox' and mechanics then
				if (curBeat >= 136 and curBeat < 456) and mechanics and not isMayhemMode then
					if getPropertyFromClass('ClientPrefs', 'buff2Selected') == true then
						cancelTween('backBarfill')
						if difficulty == 0 then
							secondsToKill = 45
						end
						if difficulty == 1 then
							secondsToKill = 35
						end
						if difficulty == 2 then
							secondsToKill = 25
						end
						if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
							secondsToKill = (secondsToKill + 15) * (getHealth() / 2)
						else
							secondsToKill = secondsToKill * (getHealth() / 2)
						end
						doTweenY('backBarfill', 'barBack.scale', 0, secondsToKill / playbackRate, 'easeIn')
					else
						setUpTime()
					end
				end
			end
		end
		
		if tag == 'mayhemBackBarScaleBuff2' and secondChanceGiven == false then
			doTweenX('reloading', 'reloadBar.scale', 1, 10, 'linear')
			activated = false
			secondChanceAllowed = false
			setProperty('mayhembackBar.color', getColorFromHex(backColor))
		end
		if tag == 'mayhemBackBarScaleBuff2' and secondChanceGiven == true then
			activated = false
		end
		
		if tag == 'mayhemBackBarScaleBuff3' then
			doTweenX('reloading', 'reloadBar.scale', 1, 10, 'linear')
			activated = false
			setProperty('mayhembackBar.color', getColorFromHex(backColor))
			setPropertyFromClass('ClientPrefs', 'buff3Active', false)
						
			if not isMayhemMode and (songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == 'Partner') and mechanics then
				resumeTween('backBarfill')
			elseif songName == 'Toybox' and mechanics then
				setUpTime()
			end
		end
		
		if tag == 'reloading' then
			maxedOut = false
			refill = false
		end
	end
end

function onDestroy()
	if getPropertyFromClass('ClientPrefs', 'buff1Selected') == true then
		setPropertyFromClass('ClientPrefs', 'buff1Active', false)
	end
	if getPropertyFromClass('ClientPrefs', 'buff2Selected') == true then
		setPropertyFromClass('ClientPrefs', 'buff2Active', false)
	end
	if getPropertyFromClass('ClientPrefs', 'buff3Selected') == true then
		setPropertyFromClass('ClientPrefs', 'buff3Active', false)
	end
end

function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
    return string.format('%02x%02x%02x', math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end

function setUpTime()
	if difficulty == 0 then
		secondsToKill = 45
	end
	if difficulty == 1 then
		secondsToKill = 35
	end
	if difficulty == 2 then
		secondsToKill = 25
	end
				
	if resCharmOn then
		secondsToKill = (secondsToKill + 15) * (getHealth() / 2)
	else
		secondsToKill = secondsToKill * (getHealth() / 2)
	end
	
	if not isMayhemMode and not buff3On then
		runTimer('drainDelay', 0.3 / playbackRate)
	end
end