--[[
	Do not ask why I'm making this feature between lua and Source, when I could just do everything through source code.
	I feel more comfortable working with both languages for this.
	With Source, I'm better at making main core changes, and with Lua, I'm better at making main core gameplay changes, so yea
	Enjoy it lmao
]]

local flash = false
local charmUsed = false
local heal = false
local allowCharms = true
function onCreate()
	if not optimizationMode then
		if not mechanics or songName == 'Couple Clash' or (isIniquitousMode and week == 'weekkiana') then --Disable this for exceptions
			allowCharms = false
			setPropertyFromClass('ClientPrefs', 'resistanceCharm', 0);
			setPropertyFromClass('ClientPrefs', 'autoCharm', 0);
			setPropertyFromClass('ClientPrefs', 'healingCharm', -1);
		end
		
		if allowCharms then 
			-- Creating the text for the Charms
			makeLuaText('charmActivate', '', 1000, 100, 320)
			setTextSize('charmActivate', 50)
			setProperty('charmActivate.alpha', 0)
			addLuaText('charmActivate')
			
			makeLuaSprite('charmSocket', 'effects/empty_charm', 10, 270)
			scaleObject('charmSocket', 0.25, 0.25)
			setObjectCamera('charmSocket', 'hud')
			addLuaSprite('charmSocket', true)
			
			if mechanics and (not botPlay) then
				if getPropertyFromClass('ClientPrefs', 'resCharmCollected') == true then
					setPropertyFromClass('ClientPrefs', 'resistanceCharm', 2);
				else
					setPropertyFromClass('ClientPrefs', 'resistanceCharm', 0);
				end
				if getPropertyFromClass('ClientPrefs', 'autoCharmCollected') == true then
					setPropertyFromClass('ClientPrefs', 'autoCharm', 2);
				else
					setPropertyFromClass('ClientPrefs', 'autoCharm', 0);
				end
				if getPropertyFromClass('ClientPrefs', 'healCharmCollected') == true then
					setPropertyFromClass('ClientPrefs', 'healingCharm', 10);
				else
					setPropertyFromClass('ClientPrefs', 'healingCharm', -1);
				end
			else
				setPropertyFromClass('ClientPrefs', 'resistanceCharm', 0);
				setPropertyFromClass('ClientPrefs', 'autoCharm', 0);
				setPropertyFromClass('ClientPrefs', 'healingCharm', -1);
			end
		end
	else
		allowCharms = false
		setPropertyFromClass('ClientPrefs', 'resistanceCharm', 0);
		setPropertyFromClass('ClientPrefs', 'autoCharm', 0);
		setPropertyFromClass('ClientPrefs', 'healingCharm', -1);
	end
end

function onUpdate()
	if allowCharms then
		curHealth = getProperty('health')
		if mechanics then
			if getPropertyFromClass('ClientPrefs', 'tokens') > 0 then
				-- Resistant Charm
				if keyJustPressed('charm1') and getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 2
					and not charmUsed then
					-- tokens
					setPropertyFromClass('ClientPrefs', 'tokens', getPropertyFromClass('ClientPrefs', 'tokens') - 1)
					saveSettings();
					
					-- Setting the Charm up + removing bonus
					setPropertyFromClass('PlayState', 'checkForPowerUp', true)
					setPropertyFromClass('ClientPrefs', 'resistanceCharm', 1);
					loadGraphic('charmSocket', 'effects/charm_1')
					
					setProperty('charmSocket.scale.x', 0.27)
					setProperty('charmSocket.scale.y', 0.27)
					doTweenX('charmScaleX', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					doTweenY('charmScaleY', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					
					-- Text Configuration
					playSound('confirmMenu')
					setTextString('charmActivate', 'Resistance Charm Activated!')
					setProperty('charmActivate.alpha', 1)
					scaleObject('charmActivate', 1.1, 1.1)
					doTweenX('RCharmActivateScaleX', 'charmActivate.scale', 1, 0.7, 'circOut')
					doTweenY('RCharmActivateScaleY', 'charmActivate.scale', 1, 0.7, 'circOut')
					runTimer('FlashEnd', 1.55)
					
					charmUsed = true
				end
				
				-- Auto Dodge Charm
				if keyJustPressed('charm2') and getPropertyFromClass('ClientPrefs', 'autoCharm') == 2 
					and not charmUsed then
					-- tokens + Bonus
					setPropertyFromClass('PlayState', 'checkForPowerUp', true)
					setPropertyFromClass('ClientPrefs', 'tokens', getPropertyFromClass('ClientPrefs', 'tokens') - 1)
					saveSettings();
					
					-- Setting the Charm up
					setPropertyFromClass('ClientPrefs', 'autoCharm', 1);
					loadGraphic('charmSocket', 'effects/charm_2')
					
					setProperty('charmSocket.scale.x', 0.27)
					setProperty('charmSocket.scale.y', 0.27)
					doTweenX('charmScaleX', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					doTweenY('charmScaleY', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					
					-- Text Configuration
					playSound('confirmMenu')
					setTextString('charmActivate', 'Auto Dodge Charm Activated!')
					setProperty('charmActivate.alpha', 1)
					scaleObject('charmActivate', 1.1, 1.1)
					doTweenX('ACharmActivateScaleX', 'charmActivate.scale', 1, 0.7, 'circOut')
					doTweenY('ACharmActivateScaleY', 'charmActivate.scale', 1, 0.7, 'circOut')
					runTimer('FlashEnd', 1.55)
					
					charmUsed = true
				end
				
				-- Healing Charm
				if keyJustPressed('charm3') and getPropertyFromClass('ClientPrefs', 'healingCharm') == 10 
					and not charmUsed and not heal then
					-- tokens + bonus
					setPropertyFromClass('PlayState', 'checkForPowerUp', true)
					setPropertyFromClass('ClientPrefs', 'tokens', getPropertyFromClass('ClientPrefs', 'tokens') - 1)
					saveSettings();
					
					-- Setting the Charm up
					if isMayhemMode then
						setProperty('health', curHealth + 3)
					elseif songName == 'Toybox' then
						if (curBeat >= 136 and curBeat < 456) and mechanics and not isMayhemMode then
							setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.12)
							cancelTween('backBarfill')
							cancelTimer('drainDelay')
							
							callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
						else
							setProperty('health', curHealth + 0.50)
						end
					else
						setProperty('health', curHealth + 0.50)
					end
					setPropertyFromClass('ClientPrefs', 'healingCharm', 9);
					loadGraphic('charmSocket', 'effects/charm_3')
					
					cameraFlash('game', '00FF00', 0.5, false)
					
					setProperty('charmSocket.scale.x', 0.27)
					setProperty('charmSocket.scale.y', 0.27)
					doTweenX('charmScaleX', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					doTweenY('charmScaleY', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					
					-- Text Configuration
					playSound('confirmMenu')
					setTextString('charmActivate', 'Healing Charm Activated!')
					setProperty('charmActivate.alpha', 1)
					scaleObject('charmActivate', 1.1, 1.1)
					doTweenX('ACharmActivateScaleX', 'charmActivate.scale', 1, 0.7, 'circOut')
					doTweenY('ACharmActivateScaleY', 'charmActivate.scale', 1, 0.7, 'circOut')
					runTimer('FlashEnd', 1.55)
					runTimer('heal', 0.1)
					
					charmUsed = true
				end
				if keyJustPressed('charm3') and getPropertyFromClass('ClientPrefs', 'healingCharm') <= 9 
					and getPropertyFromClass('ClientPrefs', 'healingCharm') > 0 and charmUsed and heal then
					-- Setting the Charm up
					if isMayhemMode then
						setProperty('health', curHealth + 3)
					elseif songName == 'Toybox' then
						if (curBeat >= 136 and curBeat < 456) and mechanics and not isMayhemMode then
							setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.12)
							cancelTween('backBarfill')
							cancelTimer('drainDelay')
							
							callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
						else
							setProperty('health', curHealth + 0.50)
						end
					else
						setProperty('health', curHealth + 0.50)
					end
					setPropertyFromClass('ClientPrefs', 'healingCharm', getPropertyFromClass('ClientPrefs', 'healingCharm') - 1);

					setProperty('charmSocket.scale.x', 0.27)
					setProperty('charmSocket.scale.y', 0.27)
					doTweenX('charmScaleX', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					doTweenY('charmScaleY', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					
					if getPropertyFromClass('ClientPrefs', 'healingCharm') == 0 then
						heal = false
						setProperty('charmSocket.alpha', 0.5)
					end
					
					cameraFlash('game', '00FF00', 0.5, false)
					playSound('confirmMenu')
				end
			end
			
			-- In Case you only have 1 token left
			if keyJustPressed('charm3') and getPropertyFromClass('ClientPrefs', 'tokens') == 0
			and getPropertyFromClass('ClientPrefs', 'healingCharm') <= 9 
			and getPropertyFromClass('ClientPrefs', 'healingCharm') > 0 and charmUsed and heal then
				-- Setting the Charm up
				if isMayhemMode then
					setProperty('health', curHealth + 3)
				elseif songName == 'Toybox' then
					if (curBeat >= 136 and curBeat < 456) and mechanics and not isMayhemMode then
						setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.12)
						cancelTween('backBarfill')
						cancelTimer('drainDelay')
						
						callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
					else
						setProperty('health', curHealth + 0.50)
					end
				else
					setProperty('health', curHealth + 0.50)
				end
					
				setPropertyFromClass('ClientPrefs', 'healingCharm', getPropertyFromClass('ClientPrefs', 'healingCharm') - 1);
						
				setProperty('charmSocket.scale.x', 0.27)
				setProperty('charmSocket.scale.y', 0.27)
				doTweenX('charmScaleX', 'charmSocket.scale', 0.25, 0.7, 'circOut')
				doTweenY('charmScaleY', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					
				if getPropertyFromClass('ClientPrefs', 'healingCharm') == 0 then
					heal = false
					setProperty('charmSocket.alpha', 0.5)
				end
						
				cameraFlash('game', '00FF00', 0.5, false)
				playSound('confirmMenu')
			end
			if getPropertyFromClass('ClientPrefs', 'tokens') == 0 and not charmUsed then
				-- Text Configuration
				setProperty('charmSocket.alpha', 0.5)
					
				charmUsed = true
			end
		end
		
		
		if not mechanics or botPlay then
			setProperty('charmSocket.alpha', 0.5)
		end
	end
end


function onTimerCompleted(tag)
	if tag == 'FlashEnd' then
		flash = false
		doTweenAlpha('charmActivate', 'charmActivate', 0, 0.6, 'cubeInOut')
	end
	if tag == 'heal' then
		heal = true
	end
end