--[[
	Do not ask why I'm making this feature between lua and Source, when I could just do everything through source code.
	I feel more comfortable working with both languages for this.
	With Source, I'm better at making main core changes, and with Lua, I'm better at making main core gameplay changes, so yea
	Enjoy it lmao
]]

local allowCharms, locatedCharm = false, false
local curCharm = -1
local charmTypes = {"Resistance", "Auto", "Healing"}
local charmTypeShortened = {"res", "auto", "heal"}

-- Check if Enabled + Creation
function checkIfEnabled()
	-- Mechanic or Botplay Check
	--debugPrint("Checking Botplay or Mechanics...")
	if not mechanics or botPlay then return false end
	
	-- Token Check
	--debugPrint("Checking Tokens..")
	if getPropertyFromClass('ClientPrefs', 'tokens') <= 0 then return false end
	
	-- User Exceptions
	--debugPrint("Checking User Exceptions..")
	if songName == 'Couple Clash' or (isIniquitousMode and week == 'mainweekkiana') then return false end
	--debugPrint("Checked all values!")
	
	return true
end

function onCreate()
	allowCharms = checkIfEnabled()
	
	if allowCharms then 
		-- Creating the text for the Charms
		makeLuaText('activationTxt', '', screenWidth, 0, 320)
		setTextSize('activationTxt', 50)
		setProperty('activationTxt.alpha', 0)
		addLuaText('activationTxt')
			
		makeLuaSprite('charmSocket', 'effects/empty_charm', 10, 270)
		scaleObject('charmSocket', 0.25, 0.25)
		setObjectCamera('charmSocket', 'hud')
		addLuaSprite('charmSocket', true)

		setPropertyFromClass('ClientPrefs', 'resistanceCharm', getPropertyFromClass('ClientPrefs', 'resCharmCollected') and 2 or 0)
		setPropertyFromClass('ClientPrefs', 'autoCharm', getPropertyFromClass('ClientPrefs', 'autoCharmCollected') and 2 or 0)
		setPropertyFromClass('ClientPrefs', 'healingCharm', getPropertyFromClass('ClientPrefs', 'healCharmCollected') and 10 or -1)
	else
		setPropertyFromClass('ClientPrefs', 'resistanceCharm', 0)
		setPropertyFromClass('ClientPrefs', 'autoCharm', 0)
		setPropertyFromClass('ClientPrefs', 'healingCharm', -1)
	end
end

-- Main Body
function configureCharmPatches()
	-- Reduce Tokens by 1
	local tokenAmount = getPropertyFromClass('ClientPrefs', 'tokens')
	setPropertyFromClass('ClientPrefs', 'tokens', tokenAmount - 1)
	saveSettings()
				
	-- Disable bonus
	setPropertyFromClass('PlayState', 'checkForPowerUp', true)
		
	-- Activate Charm (Exception: Healing Charm)
	--debugPrint("Checking Current Charm..")
	if curCharm ~= 3 then setPropertyFromClass('ClientPrefs', string.lower(charmTypes[curCharm])..'Charm', 1) 
	else healCheck(false) end
			
	--debugPrint("Configuring..")			
	-- Configure Charm Socket, Text and Charm Activation
	loadGraphic('charmSocket', 'effects/charm_'..curCharm)
	setProperty('charmSocket.scale.x', 0.27)
	setProperty('charmSocket.scale.y', 0.27)
	doTweenX('charmScaleX', 'charmSocket.scale', 0.25, 0.7, 'circOut')
	doTweenY('charmScaleY', 'charmSocket.scale', 0.25, 0.7, 'circOut')
					
	setTextString('activationTxt', charmTypes[curCharm]..' Charm Activated!')
	setProperty('activationTxt.alpha', 1)
	setProperty('activationTxt.scale.x', 1.1)
	setProperty('activationTxt.scale.y', 1.1)
	doTweenX('activationScaleFixX', 'activationTxt.scale', 1, 0.7, 'circOut')
	doTweenY('activationScaleFixY', 'activationTxt.scale', 1, 0.7, 'circOut')
	runTimer('finishFlash', 1.75)
					
	playSound('confirmMenu', 1, "charmOn")
	
	--debugPrint("Done!")
end

-- Main Body
function onUpdate(elapsed)
	if allowCharms then
		-- Check what charm has been used
		if not locatedCharm then
			for key = 1, 3 do
				local charmAllowed = getPropertyFromClass("ClientPrefs", charmTypeShortened[key].."CharmCollected")
				if charmAllowed and keyJustPressed('charm'..key) then
					-- Save charm number
					--debugPrint("Current Charm is "..key.."!")
					curCharm = key
	
					configureCharmPatches()
					locatedCharm = true
				end
			end
		end

		-- Healing Charm After-Check
		if locatedCharm and curCharm == 3 and keyJustPressed('charm3') then
			if getPropertyFromClass('ClientPrefs', 'healingCharm') ~= 0 then healCheck(true) end
		end
	end
end

-- Healing Charm Check
function healCheck(effect)
	-- Healing Check
	local healsLeft = getPropertyFromClass('ClientPrefs', 'healingCharm')
	setPropertyFromClass('ClientPrefs', 'healingCharm', healsLeft - 1)
	
	cameraFlash('game', '00FF00', 0.4 / playbackRate, false)
	
	if songName == 'Toybox' and (curBeat >= 136 and curBeat < 456) and not isMayhemMode then -- Song Specific Check
		setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.12)
		cancelTween('backBarfill') cancelTimer('drainDelay')
							
		callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
		
	else setHealth(getHealth() + (isMayhemMode and 3 or 0.5)) end
	
	if effect then
		setProperty('charmSocket.scale.x', 0.27)
		setProperty('charmSocket.scale.y', 0.27)
		doTweenX('charmScaleX', 'charmSocket.scale', 0.25, 0.7, 'circOut')
		doTweenY('charmScaleY', 'charmSocket.scale', 0.25, 0.7, 'circOut')
		
		playSound('confirmMenu', 1, "charmOn")
	end
	
	if getPropertyFromClass('ClientPrefs', 'healingCharm') == 0 then setProperty('charmSocket.alpha', 0.5) end
end

function onTimerCompleted(tag)
	if tag == 'finishFlash' then doTweenAlpha('activationTxt', 'activationTxt', 0, 0.6, 'cubeInOut') end
end