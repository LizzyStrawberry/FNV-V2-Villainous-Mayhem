-- Check if enabled
local mayhemEnabled = false

local mayhemX, mayhemY = 450, 530

-- Mayhem Checks
local maxedOut, activated, refill = false, false, false
-- View onSectionHit to understand
local alphaSectionSwitch = false 

-- Buff 2 Checks
secondChanceGiven = false

-- Health Calculations
local stepsPerSecond, healthGainPerStep
local totalHealthGain = 0.75 -- Normally without Mayhem Mode

-- Pad, backBar and Pad color exceptions
local padColor, backColor
local marcoMainSongs = {'Scrouge', 'Toxic Mishap Remix', 'Villainy', 'Cheap Skate V1', 'Toxic Mishap', 'Shuckle Fuckle'}

-- Used in Song Checks
local holyTrinity = {'Forsaken', 'Forsaken (Picmixed)', 'Partner'}
local holyTrinityChecked = false

-- Buff Properties
local curBuff = -1
local locatedBuff = false

-- Colors for effect
local colArray = {"9700FF", "00FFFF", "00FF00", "FF0000"}

-- Checking if mayhem is on + Creation
function checkIfEnabled()
	-- Check for buffs being disabled
	local disabledBuffs = 0
	for i = 1, 3 do
		--debugPrint("Checking Buff Number "..i.."...")
		if not getPropertyFromClass('ClientPrefs', 'buff'..i..'Selected') then disabledBuffs = disabledBuffs + 1 end
	end
	if disabledBuffs == 3 then return false end
	
	-- Check if botplay OR mechanics are on/off
	--debugPrint("Checking Botplay and Mechanics..")
	if botPlay or not mechanics then return false end
	
	-- User exceptions
	--debugPrint("Checking User Specifications..")
	if songName == "Iniquitous" or songName == "Couple Clash" or (isIniquitousMode and week == 'weekkiana') then return false end
	
	return true
end

function onCreate()
	-- Set variable
	mayhemEnabled = checkIfEnabled()
	--debugPrint("Mayhem is "..(mayhemEnabled and "On!" or "Off!"))
	
	-- Reset FIRSTLY before continuing
	for i = 1, 3 do setPropertyFromClass('ClientPrefs', 'buff'..i..'Active', false) end
end

function onCreatePost()	
	if mayhemEnabled then
		-- Calculate Health Gain for buff 1
		stepsPerSecond = (bpm / 60) * 4
		-- Gain 10 Health in Mayhem Mode instead of the usual
		if isMayhemMode then totalHealthGain = 10 end
		-- Calculate Health Gain per step
		healthGainPerStep = ((totalHealthGain / 7) / stepsPerSecond) * 2 -- per 2 steps
		
		-- Set Pad and backBar Color
		padColor = rgbToHex(getProperty('dad.healthColorArray'))
		for i = 1, #(marcoMainSongs) do
			if songName == marcoMainSongs[i] then padColor = '3ac331' end
		end
		backColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
		
		-- Create Mayhem UI
		createMayhemBar()
		
		-- Locate Buff
		if not locatedBuff then
			for buff = 1, 3 do 
				if getPropertyFromClass('ClientPrefs', 'buff'..buff..'Selected') then
					curBuff = buff
					locatedBuff = true
					--debugPrint("Current Buff Active: "..curBuff)
				end
			end
		end
	end
end

-- Creation, exception check and position fix for UI
function createMayhemBar()
	mayhemX = mobileFix("X", mayhemX)
	makeLuaSprite('reloadBar', 'mayhemBar/mayhemBackBar', mayhemX, mayhemY)
	setProperty('reloadBar.color', getColorFromHex('737373'))
	setObjectCamera('reloadBar', 'hud')
	setObjectOrder('reloadBar', getObjectOrder('healthBarBG') + 1)
	setProperty('reloadBar.origin.x', 80)
	setProperty('reloadBar.scale.x', 1)
	addLuaSprite('reloadBar', true)
		
	makeLuaSprite('mayhembackBar', 'mayhemBar/mayhemBackBar', mayhemX, mayhemY)
	setProperty('mayhembackBar.color', getColorFromHex(backColor))
	setObjectCamera('mayhembackBar', 'hud')
	setObjectOrder('mayhembackBar', getObjectOrder('reloadBar') + 1)
	setProperty('mayhembackBar.origin.x', 80)
	setProperty('mayhembackBar.scale.x', 0)
	addLuaSprite('mayhembackBar', true)
		
	makeLuaSprite('mayhemPads', 'mayhemBar/mayhemPads', mayhemX, mayhemY)
	setObjectCamera('mayhemPads', 'hud')
	setObjectOrder('mayhemPads', getObjectOrder('healthBar'))
	setProperty('mayhemPads.color', getColorFromHex(padColor))
	addLuaSprite('mayhemPads', true)
		
	makeLuaSprite('mayhemBar', 'mayhemBar/mayhemBar', mayhemX, mayhemY)
	setObjectCamera('mayhemBar', 'hud')
	setObjectOrder('mayhemBar', getObjectOrder('mayhembackBar') + 1)
	addLuaSprite('mayhemBar', true)
	
	makeLuaSprite('mayhemText', 'mayhemBar/mayhemText', mayhemX, mayhemY)
	setObjectCamera('mayhemText', 'hud')
	setObjectOrder('mayhemText', getObjectOrder('mayhemBar') + 1)
	setProperty('mayhemText.color', getColorFromHex(padColor))
	addLuaSprite('mayhemText', true)
		
	for _, dir in ipairs({"left", "right"}) do
		makeLuaSprite(dir..'BGEffect', 'effects/bgEffect')
		setGraphicSize(dir.."BGEffect", screenWidth, screenHeight)
		setObjectCamera(dir..'BGEffect', 'hud')
		setProperty(dir..'BGEffect.alpha', 0)
		setProperty('rightBGEffect.flipX', dir == "left" and false or true)
		addLuaSprite(dir..'BGEffect', true)
	end
	
	lookForExceptions()
end

function lookForExceptions()
	-- Downscroll Check
	if downscroll then mayhemY = 110 end
		
	if songName == 'Sussus Marcus' or songName == 'Villain In Board' or songName == 'Excrete' then
		if not downscroll then mayhemY = 510 end
		setProperty('reloadBar.y', mayhemY)
	end
		
	for i = 1, #holyTrinity do
		if not isMayhemMode and songName == holyTrinity[i] then
			mayhemY = downscroll and 30 or 600
			setProperty('mayhembackBar.alpha', 0)
			holyTrinityChecked = true
		end
	end
		
	if songName == 'Libidinousness' then 
		mayhemY = downscroll and 30 or 600 
		alphaSectionSwitch = true
		--debugPrint("Libidinousness Check Found!")
	end

	setProperty('reloadBar.y', mayhemY)
end

function setBarProperties()
	-- Song Specific check (to make sure we mess with the Alpha / Visibility of the mayhembackBar or not)
	local alphaCheck
	if holyTrinityChecked then alphaCheck = true
	else alphaCheck = not isMayhemMode and songName == 'Libidinousness' end
	
	-- Alpha
	if not alphaCheck then setProperty('mayhembackBar.alpha', getProperty('healthBar.alpha')) end
	setProperty('reloadBar.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('mayhemPads.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('mayhemBar.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('mayhemText.alpha', getProperty('mayhembackBar.alpha'))
	
	-- Visibility
	if not alphaCheck then setProperty('mayhembackBar.visible', getProperty('healthBar.visible')) end
	setProperty('reloadBar.visible', getProperty('mayhembackBar.visible'))
	setProperty('mayhemPads.visible', getProperty('mayhembackBar.visible'))
	setProperty('mayhemBar.visible', getProperty('mayhembackBar.visible'))
	setProperty('mayhemText.visible', getProperty('mayhembackBar.visible'))
		
	-- X
	setProperty('mayhembackBar.x', getProperty('reloadBar.x'))
	setProperty('mayhemPads.x', getProperty('reloadBar.x'))
	setProperty('mayhemBar.x', getProperty('reloadBar.x'))
	setProperty('mayhemText.x', getProperty('reloadBar.x'))
			
	-- Y
	setProperty('mayhembackBar.y', getProperty('reloadBar.y'))
	setProperty('mayhemPads.y', getProperty('reloadBar.y'))
	setProperty('mayhemBar.y', getProperty('reloadBar.y'))
	setProperty('mayhemText.y', getProperty('reloadBar.y'))
end

function onSectionHit()
	if alphaSectionSwitch then
		doTweenAlpha("mayhemBackBarAlphaSwitch", "mayhembackBar", mustHitSection and 1 or 0.3, 0.5 / playbackRate, 'sineOut')
	end
end

-- Main Buff checker + Max Out check
function onUpdatePost()
	if mayhemEnabled then	
		
		-- Set Bar Properties
		setBarProperties()
		
		-- Disable bonus if any buff is used!
		if activated and not getPropertyFromClass('PlayState', 'checkForPowerUp') then
			setPropertyFromClass('PlayState', 'checkForPowerUp', true)
		end
		
	--[[ 
		Mayhem mechanics:
		1) Health Increase on Step (Unlocked on Marco's main week)
		2) Second Chance (Unlocked on Beatrice's main week)
		3) Immunity (Unlocked on Kiana's main week / IT'S SHOWN ON HEALTH DRAINING SCRIPTS)
		
		We're gonna check what buff is selected, and activate properties accordingly
	]]
		
		local buffCheck = getPropertyFromClass('ClientPrefs', 'buff'..curBuff..'Selected')
		if buffCheck and not secondChanceGiven then -- Have the second chance check just in case
			if keyJustPressed('mayhem') and maxedOut and not activated and not refill then
				-- Activate and reduce bar
				activated = true
				setPropertyFromClass('ClientPrefs', 'buff'..curBuff..'Active', true)
				doTweenX('barReduce', 'mayhembackBar.scale', 0, 7, curBuff == 2 and "circOut" or 'linear')
				--debugPrint("Buff "..curBuff.." has been activated!")
			end
			
			if activated then
				-- Check what bar you have and do things
				if curBuff == 1 then
					-- Song Specifications
					if not isMayhemMode then
						if songName == 'Toybox' and (curBeat >= 136 and curBeat < 456) then
							cancelTween('backBarfill') cancelTimer('drainDelay')
						else
							for i = 1, #holyTrinity do
								if songName == holyTrinity[i] then cancelTween('backBarfill') end
							end
						end
					end
				elseif curBuff == 2 then
					-- In case you're dead, get revived
					if getHealth() <= 0.0001 and activated then	
						-- Song Specification
						if songName == "Toybox" and (curBeat >= 136 and curBeat < 456) and not isMayhemMode then
							setProperty('health', 1.5) setProperty("barBack.scale.x", getHealth() / 2)
							callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
						else setHealth(isMayhemMode and 50 or 2) end -- Default happening
						
						secondChanceGiven = true -- Give second chance, stop this check for good
						setPropertyFromClass('ClientPrefs', 'buff2Active', false) -- Deactivate
						cameraFlash('hud', 'FFFFFF', 0.6 / playbackRate, false) -- Flash to show that you got revived
					end
				elseif curBuff == 3 then
					-- Song Specifications
					if not isMayhemMode then
						if songName == 'Toybox' and (curBeat >= 136 and curBeat < 456) then pauseTween('backBarfill')
						else
							for i = 1, #holyTrinity do
								if songName == holyTrinity[i] then pauseTween('backBarfill') end
							end
						end
					end
				end
			end
		end
	end
end

function onBeatHit()
	if mayhemEnabled and maxedOut then
		setProperty('mayhembackBar.color', getColorFromHex('FFFFFF'))
		doTweenColor('fixMayhemColor', 'mayhembackBar', backColor, 0.8 / playbackRate, 'sineOut')
	end
end

-- Buff 1: Heal Ability Set
function onStepHit()
	if mayhemEnabled then
		if activated and curBuff == 1 and curStep % 2 == 0 then
			if isMayhemMode then setProperty('health', getHealth() + healthGainPerStep)
			else
				-- Song Specifications (NOT MAYHEM MODE)
				for i = 1, #holyTrinity do
					if songName == holyTrinity[i] and getProperty('barBack.scale.y') < 1 then
						setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.0025)
					end
				end
				if songName == 'Toybox' and (curBeat >= 136 and curBeat < 456) then setProperty('barBack.scale.y', getProperty('barBack.scale.y') + 0.005)
				else setHealth(getHealth() + healthGainPerStep) end
			end
			--debugPrint("Buff 1: Healing Player!")
		end
	end
end

-- Glow Effect Check + Mayhem Bar Increase / Decrease Checks
function goodNoteHit(id, dir, nt, isSus)
	if mayhemEnabled and not secondChanceGiven then -- Include a check for the second buff
		-- Set Colors
		colBasedOnChar()
		
		if not activated then
			if not maxedOut then
				setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') + (not isSus and 0.012 or 0.00115))

				if getProperty('mayhembackBar.scale.x') >= 1 then
					setProperty('mayhembackBar.scale.x', 1)
					setProperty('reloadBar.scale.x', 0)
					maxedOut = true
				end
			end
		else
			addScore(isSus and 225 or 450)
			
			setProperty('leftBGEffect.color', getColorFromHex(colArray[dir + 1]))
			setProperty('rightBGEffect.color', getProperty("leftBGEffect.color")) -- Same as left
			
			for _, effect in ipairs({"left", "right"}) do
				setProperty(effect..'BGEffect.alpha', 1)
				cancelTween(effect..'SideGlow')
				doTweenAlpha(effect..'SideGlow', effect..'BGEffect', 0, 0.4 / playbackRate, 'easeOut')
			end
		end
	end
end

function noteMiss()
	if mayhemEnabled then
		if not maxedOut and getProperty('mayhembackBar.scale.x') > 0 then
			setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') - 0.015)
		end
	end
end

function noteMissPress()
	if mayhemEnabled and not getPropertyFromClass('ClientPrefs', 'ghostTapping') then
		if not maxedOut and getProperty('mayhembackBar.scale.x') > 0 then
			setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') - 0.015)
		end
	end
end

-- Completion of tweens
function onTweenCompleted(tag)
	if mayhemEnabled then
		if tag == 'barReduce' then -- Buff 1
			-- Reload, deactivate and fix color
			if not secondChanceGiven then doTweenX('reloading', 'reloadBar.scale', 1, 10, 'linear') end
			setProperty('mayhembackBar.color', getColorFromHex(backColor))
			activated = false
			
			setPropertyFromClass('ClientPrefs', 'buff'..curBuff..'Active', false)
			
			if curBuff == 1 then
				if not isMayhemMode then
					for i = 1, #holyTrinity do
						if songName == holyTrinity[i] then
							local missCheck = 45 -- Casual Default
							if difficultyName == "Villainous" then missCheck = 25
							elseif difficultyName == "Villainous" then missCheck = 12 end
							
							callScript("data/"..songPath.."/Faith Bar Mechanic", "setDrainBar", {getProperty("songMisses") > missCheck and true or false})
						end
					end
				
					if songName == 'Toybox' and (curBeat >= 136 and curBeat < 456) then
						callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
					end
				end
			elseif curBuff == 3 then -- No check for 2, everything happens onUpdate
				if not isMayhemMode then
					if songName == 'Toybox' and (curBeat >= 136 and curBeat < 456) then
						callScript("data/toybox/Narrin Mechanic", "setUpTime", {})
					else
						for i = 1, #holyTrinity do
							if songName == holyTrinity[i] then resumeTween('backBarfill') end
						end
					end
				end
			end
		end
		
		if tag == 'reloading' then
			maxedOut = false refill = false
		end
	end
end

function onDestroy()
	-- Always reset at the end too.
	for i = 1, 3 do setPropertyFromClass('ClientPrefs', 'buff'..i..'Active', false) end
end

-- Helper Functions
function colBasedOnChar()
	if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
		colArray = {'f65215', 'f4cabb', 'edbeec', 'ee25e8'}
	elseif boyfriendName == 'ourple' then
		colArray = {'fff31d', '327dff', '32ffab', 'ff1dc0'}
	elseif boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
		colArray = {'d2fffb', '3bc2b2', 'd2fffb', '3bc2b2'}
	elseif boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
		colArray = {'dcdcdc', '729576', '729576', '565656'}
	elseif boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
		colArray = {'4c9e64', '288543', '8bbd99', '23743a'}
	else
		colArray = {"9700FF", "00FFFF", "00FF00", "FF0000"}
	end
end

function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
    return string.format('%02x%02x%02x', math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end