local challenges = {
	'scrollSpeedChange',
	'rating',
	'exactMisses',
	'moreHealthDamage',
	'noCharms',
	'noMayhem',
	'noBoth',
	'setHealth',
	'noGhostTap'
}
local chalBackUp = {
	'scrollSpeedChange',
	'rating',
	'exactMisses',
	'moreHealthDamage',
	'noCharms',
	'noMayhem',
	'noBoth',
	'setHealth',
	'noGhostTap'
}
local toUseChallenges = 2
local toUseCombinations = 6
local curChallenge
local curChallengeBonus
local chal1 = ''
local chal2 = ''
local rateNum
local numMiss
local healthDamage
local healthGoal

local allowCombo = false
local allowChallenges = false

function onCreate()
	allowChallenges = (getPropertyFromClass('PlayState', 'mayhemSongsPlayed') >= toUseChallenges)
end

function onCreatePost()
	if allowChallenges then
		if getPropertyFromClass('ClientPrefs', 'buff1Selected') == true or getPropertyFromClass('ClientPrefs', 'buff2Selected') == true 
		or getPropertyFromClass('ClientPrefs', 'buff3Selected') == true then
			setPropertyFromClass('ClientPrefs', 'buff1Active', false)
			setPropertyFromClass('ClientPrefs', 'buff2Active', false)
			setPropertyFromClass('ClientPrefs', 'buff3Active', false)
		end
		math.randomseed(os.time())
		math.random(); math.random(); math.random()
		
		if getPropertyFromClass("PlayState", 'mayhemNRMode') == "Random" then
			table.insert(challenges, 'NRMode')
		end
		
		if getPropertyFromClass('PlayState', 'mayhemSongsPlayed') >= toUseCombinations then
			for i = 1, 10 do
				table.insert(challenges, math.random(i, #(challenges)),'combineRandom')
			end
		end
		
		speedNum = getRandomFloat(1.05, 1.5)
		makeLuaText('challengeShowcase', 'Challenges: ', 750, 0, getProperty('healthBar.y') + 300)
		screenCenter('challengeShowcase')
		if getPropertyFromClass('ClientPrefs', 'buff1Selected') == true or getPropertyFromClass('ClientPrefs', 'buff2Selected') == true 
		or getPropertyFromClass('ClientPrefs', 'buff3Selected') == true then
			setProperty('challengeShowcase.y', getProperty('challengeShowcase.y') + 150)
		else
			setProperty('challengeShowcase.y', getProperty('challengeShowcase.y') + 200)
		end
		setObjectCamera('challengeShowcase', 'hud')
		setTextSize('challengeShowcase', 24)
		addLuaText('challengeShowcase', true)
		
		if downscroll then
			if getPropertyFromClass('ClientPrefs', 'buff1Selected') == true or getPropertyFromClass('ClientPrefs', 'buff2Selected') == true 
			or getPropertyFromClass('ClientPrefs', 'buff3Selected') == true then
				setProperty('challengeShowcase.y', getProperty('challengeShowcase.y') - 330)
			else
				setProperty('challengeShowcase.y', getProperty('challengeShowcase.y') - 430)
			end
		end
		
		setUpChallenge()
	end
end

function setUpChallenge()
	if getPropertyFromClass("PlayState", 'mayhemNRMode') == "Random" then
		for i = 1, #(challenges) do
			if challenges[i] == "NRMode" then
				curChallenge = i;
				break
			end
		end
	else
		curChallenge = math.random(1, #(challenges) - 1)
	end
	
	if challenges[curChallenge] == 'scrollSpeedChange' then
		chal1 = 'Scroll Speed Changed: '..(math.floor(speedNum * 100)/100)..'x'
		triggerEvent('Change Scroll Speed', math.floor(speedNum * 100)/100, 0)
	elseif challenges[curChallenge] == 'rating' then
		rateNum = getRandomInt(70, 95)
		chal1 = 'Beat the song with a rating of '..rateNum..'% and up!'
	elseif challenges[curChallenge] == 'exactMisses' then
		numMiss = getRandomInt(5, 35)
		chal1 = 'Beat the song with exactly '..numMiss..' misses!'
	elseif challenges[curChallenge] == 'moreHealthDamage' then
		healthDamage = getRandomInt(2, 12)
		chal1 = 'Bonus Health Damage: +'..healthDamage + 1
	elseif challenges[curChallenge] == 'noCharms' then
		chal1 = 'Beat the song without using any charms!'
	elseif challenges[curChallenge] == 'noMayhem' then
		chal1 = 'Beat the song without using any buffs!'
	elseif challenges[curChallenge] == 'noBoth' then
		chal1 = 'Beat the song without using any charms or buffs!'
	elseif challenges[curChallenge] == 'setHealth' then
		healthGoal = getRandomInt(85, 150)
		chal1 = 'Beat the song with '..healthGoal..' or more health!'
	elseif challenges[curChallenge] == 'noGhostTap' then
		setPropertyFromClass('ClientPrefs', 'ghostTapping', false)
		chal1 = 'Ghost Tapping is disabled!'
	elseif challenges[curChallenge] == 'combineRandom' then --Extra work for this
		allowCombo = true
	elseif challenges[curChallenge] == 'NRMode' then
		chal1 = 'Randomized Notes are Enabled!'
	end
	
	setTextString('challengeShowcase', "Challenge:\n"..chal1)
	
	-- For Combinations:
	if allowCombo then
		challenges = {};
		for i = 1, #(chalBackUp) do
			table.insert(challenges, chalBackUp[i])
		end
		comboTime()
	end
end

function comboTime()
	-- For Combinations:
	if allowCombo then
		if getPropertyFromClass("PlayState", 'mayhemNRMode') == "Random" then
			for i = 1, #(challenges) do
				if challenges[i] == "NRMode" then
					curChallenge = i;
					break
				end
			end
		else
			curChallenge = math.random(1, #(challenges))
		end
		
		if challenges[curChallenge] == 'scrollSpeedChange' then
			chal1 = 'Scroll Speed Changed: '..(math.floor(speedNum * 100)/100)..'x'
			triggerEvent('Change Scroll Speed', math.floor(speedNum * 100)/100, 0)
		elseif challenges[curChallenge] == 'rating' then
			rateNum = getRandomInt(70, 95)
			chal1 = 'Beat the song with a rating of '..rateNum..'% and up!'
		elseif challenges[curChallenge] == 'exactMisses' then
			numMiss = getRandomInt(5, 35)
			chal1 = 'Beat the song with exactly '..numMiss..' misses!'
		elseif challenges[curChallenge] == 'moreHealthDamage' then
			healthDamage = getRandomInt(2, 12)
			chal1 = 'Bonus Health Damage: +'..healthDamage + 1
		elseif challenges[curChallenge] == 'noCharms' then
			chal1 = 'Beat the song without using any charms!'
		elseif challenges[curChallenge] == 'noMayhem' then
			chal1 = 'Beat the song without using any buffs!'
		elseif challenges[curChallenge] == 'noBoth' then
			chal1 = 'Beat the song without using any charms or buffs!'
		elseif challenges[curChallenge] == 'setHealth' then
			healthGoal = getRandomInt(85, 150)
			chal1 = 'Beat the song with '..healthGoal..' or more health!'
		elseif challenges[curChallenge] == 'noGhostTap' then
			setPropertyFromClass('ClientPrefs', 'ghostTapping', false)
			chal1 = 'Ghost Tapping is disabled!'
		elseif challenges[curChallenge] == 'NRMode' then
			chal1 = 'Randomized Notes are Enabled!'
		end

		curChallengeBonus = math.random(1, #(challenges))
		
		-- Anti Duplication Measure
		if challenges[curChallengeBonus] == challenges[curChallenge] or
		(challenges[curChallenge] == 'noCharms' and challenges[curChallengeBonus] == 'noMayhem') or 
		(challenges[curChallenge] == 'noMayhem' and challenges[curChallengeBonus] == 'noCharms') or 
		challenges[curChallenge] == 'noBoth' and (challenges[curChallengeBonus] == 'noCharms' or challenges[curChallengeBonus] == 'noMayhem') or 
		challenges[curChallengeBonus] == 'noBoth' and (challenges[curChallenge] == 'noCharms' or challenges[curChallenge] == 'noMayhem') then
			comboReroll()
		else
			if challenges[curChallengeBonus] == 'scrollSpeedChange' then
				chal2 = 'Scroll Speed Changed: '..(math.floor(speedNum * 100)/100)..'x'
				triggerEvent('Change Scroll Speed', math.floor(speedNum * 100)/100, 0)
			elseif challenges[curChallengeBonus] == 'rating' then
				rateNum = getRandomInt(70, 95)
				chal2 = 'Beat the song with a rating of '..rateNum..'% and up!'
			elseif challenges[curChallengeBonus] == 'exactMisses' then
				numMiss = getRandomInt(5, 35)
				chal2 = 'Beat the song with exactly '..numMiss..' misses!'
			elseif challenges[curChallengeBonus] == 'moreHealthDamage' then
				healthDamage = getRandomInt(2, 15)
				chal2 = 'Bonus Health Damage: +'..healthDamage + 1
			elseif challenges[curChallengeBonus] == 'noCharms' then
				chal2 = 'Beat the song without using any charms!'
			elseif challenges[curChallengeBonus] == 'noMayhem' then
				chal2 = 'Beat the song without using any buffs!'
			elseif challenges[curChallengeBonus] == 'noBoth' then
				chal2 = 'Beat the song without using any charms or buffs!'
			elseif challenges[curChallengeBonus] == 'setHealth' then
				healthGoal = getRandomInt(85, 150)
				chal2 = 'Beat the song with '..healthGoal..' or more health!'
			elseif challenges[curChallengeBonus] == 'noGhostTap' then
				setPropertyFromClass('ClientPrefs', 'ghostTapping', false)
				chal2 = 'Ghost Tapping is disabled!'
			end
		
			-- After all this, we want to reset the table since the challenges have been assigned and are not overlapping each other
			challenges = {};
			for i = 1, #(chalBackUp) do
				table.insert(challenges, chalBackUp[i])
			end

			if downscroll then
				setProperty('challengeShowcase.y', getProperty('challengeShowcase.y') + 10)
			else
				setProperty('challengeShowcase.y', getProperty('challengeShowcase.y') - 20)
			end
			setTextString('challengeShowcase', "Challenges:\n1) "..chal1.."\n2) "..chal2)
		end
	end
end

function comboReroll()
	curChallengeBonus = math.random(1, #(challenges))
	
	if challenges[curChallengeBonus] == challenges[curChallenge] or
	(challenges[curChallenge] == 'noCharms' and challenges[curChallengeBonus] == 'noMayhem') or 
	(challenges[curChallenge] == 'noMayhem' and challenges[curChallengeBonus] == 'noCharms') or 
	challenges[curChallenge] == 'noBoth' and (challenges[curChallengeBonus] == 'noCharms' or challenges[curChallengeBonus] == 'noMayhem') or
	challenges[curChallengeBonus] == 'noBoth' and (challenges[curChallenge] == 'noCharms' or challenges[curChallenge] == 'noMayhem') then
		comboReroll()
	else
		if challenges[curChallengeBonus] == 'scrollSpeedChange' then
			chal2 = 'Scroll Speed Changed: '..(math.floor(speedNum * 100)/100)..'x'
			triggerEvent('Change Scroll Speed', math.floor(speedNum * 100)/100, 0)
		elseif challenges[curChallengeBonus] == 'rating' then
			rateNum = getRandomInt(70, 95)
			chal2 = 'Beat the song with a rating of '..rateNum..'% and up!'
		elseif challenges[curChallengeBonus] == 'exactMisses' then
			numMiss = getRandomInt(5, 35)
			chal2 = 'Beat the song with exactly '..numMiss..' misses!'
		elseif challenges[curChallengeBonus] == 'moreHealthDamage' then
			healthDamage = getRandomInt(2, 12)
			chal2 = 'Bonus Health Damage: +'..healthDamage + 1
		elseif challenges[curChallengeBonus] == 'noCharms' then
			chal2 = 'Beat the song without using any charms!'
		elseif challenges[curChallengeBonus] == 'noMayhem' then
			chal2 = 'Beat the song without using any buffs!'
		elseif challenges[curChallengeBonus] == 'noBoth' then
			chal2 = 'Beat the song without using any charms or buffs!'
		elseif challenges[curChallengeBonus] == 'setHealth' then
			healthGoal = getRandomInt(85, 150)
			chal2 = 'Beat the song with '..healthGoal..' or more health!'
		elseif challenges[curChallengeBonus] == 'noGhostTap' then
			setPropertyFromClass('ClientPrefs', 'ghostTapping', false)
			chal2 = 'Ghost Tapping is disabled!'
		elseif challenges[curChallengeBonus] == 'NRMode' then
			setPropertyFromClass('PlayState', 'mayhemNRMode', 'Random')
			chal2 = 'Randomized Notes are Enabled!'
		end
		
		-- After all this, we want to reset the table since the challenges have been assigned and are not overlapping each other
		challenges = {};
		for i = 1, #(chalBackUp) do
			table.insert(challenges, chalBackUp[i])
		end

		if downscroll then
			setProperty('challengeShowcase.y', getProperty('challengeShowcase.y') + 10)
		else
			setProperty('challengeShowcase.y', getProperty('challengeShowcase.y') - 20)
		end
		setTextString('challengeShowcase', "Challenges:\n1) "..chal1.."\n2) "..chal2)
	end
end

local allowed
local allowedCharms
local allowedBuffs
local allowedBoth
function onSongStart()
	if challenges[curChallenge] == 'noMayhem' then
		allowedBuffs = true;
	end
	if challenges[curChallenge] == 'noBoth' then
		allowedBoth = true;
	end
	if allowCombo then
		if challenges[curChallengeBonus] == 'noMayhem' then
			allowedBuffs = true;
		end
		if challenges[curChallengeBonus] == 'noBoth' then
			allowedBoth = true;
		end
	end
end

local showChal = 2
local healthDamageCut = false
function onUpdate()
	if allowChallenges then
		-- Challenge text shit
		if showChal == 2 then
			showChal = 1
			runTimer('chalDisappear', 10 / playbackRate)
		end
		if showChal == 0 and (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TAB') or pressAction("healthBar")) then
			doTweenAlpha('challengeAppear', 'challengeShowcase', 1, 0.8 / playbackRate, 'circOut')
			showChal = 1
		end
		
		-- For healthDamage
		if challenges[curChallenge] == 'moreHealthDamage' and healthDamageCut == false
		and getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
			healthDamageCut = true
			healthDamage = healthDamage / 2
			
			chal1 = 'Bonus Health Damage: +'..healthDamage + 1
			
			if allowCombo then
				setTextString('challengeShowcase', "Challenges:\n1) "..chal1.."\n2) "..chal2)
			else
				setTextString('challengeShowcase', "Challenge:\n"..chal1)
			end
		end
		if challenges[curChallengeBonus] == 'moreHealthDamage' and healthDamageCut == false
		and getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
			healthDamageCut = true
			healthDamage = healthDamage / 2
			
			chal2 = 'Bonus Health Damage: +'..healthDamage + 1
		
			if allowCombo then
				setTextString('challengeShowcase', "Challenges:\n1) "..chal1.."\n2) "..chal2)
			end
		end
			
		-- Challenges
		if challenges[curChallenge] == 'exactMisses' then
			if misses == numMiss then
				allowed = true
			else
				allowed = false
			end
		elseif challenges[curChallenge] == 'noCharms' then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1
				or getPropertyFromClass('ClientPrefs', 'healingCharm') <= 9 then
				allowedCharms = false
			else
				allowedCharms = true
			end
		elseif challenges[curChallenge] == 'noMayhem' then
			if getPropertyFromClass('ClientPrefs', 'buff1Active') == true or getPropertyFromClass('ClientPrefs', 'buff2Active') == true
				or getPropertyFromClass('ClientPrefs', 'buff3Active') == true then
				allowedBuffs = false
			end
		elseif challenges[curChallenge] == 'noBoth' then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1
				or getPropertyFromClass('ClientPrefs', 'healingCharm') <= 9 or getPropertyFromClass('ClientPrefs', 'buff1Active') == true
				or getPropertyFromClass('ClientPrefs', 'buff2Active') == true or getPropertyFromClass('ClientPrefs', 'buff3Active') == true then
				allowedBoth = false
			end
		end
		
		if allowCombo then
			if challenges[curChallengeBonus] == 'exactMisses' then
				if misses == numMiss then
					allowed = true
				else
					allowed = false
				end
			elseif challenges[curChallengeBonus] == 'noCharms' then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1
					or getPropertyFromClass('ClientPrefs', 'healingCharm') <= 9 then
					allowedCharms = false
				else
					allowedCharms = true
				end
			elseif challenges[curChallengeBonus] == 'noMayhem' then
				if getPropertyFromClass('ClientPrefs', 'buff1Active') == true or getPropertyFromClass('ClientPrefs', 'buff2Active') == true
					or getPropertyFromClass('ClientPrefs', 'buff3Active') == true then
					allowedBuffs = false
				end
			elseif challenges[curChallengeBonus] == 'noBoth' then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1
					or getPropertyFromClass('ClientPrefs', 'healingCharm') <= 9 or getPropertyFromClass('ClientPrefs', 'buff1Active') == true
					or getPropertyFromClass('ClientPrefs', 'buff2Active') == true or getPropertyFromClass('ClientPrefs', 'buff3Active') == true then
					allowedBoth = false
				end
			end
		end
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if allowChallenges then
		if not isSustainNote and challenges[curChallenge] == 'moreHealthDamage' and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			setProperty('health', getHealth() - healthDamage)
		end
		if allowCombo then
			if not isSustainNote and challenges[curChallengeBonus] == 'moreHealthDamage' and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
				setProperty('health', getHealth() - healthDamage)
			end
		end
	end
end

function onEndSong()
	if allowChallenges then
		if challenges[curChallenge] == 'rating' then
			if rating < (rateNum / 100) then
				setProperty('health', 0)
				return Function_Stop;
			end
		elseif challenges[curChallenge] == 'exactMisses' then
			if allowed == false then
				setProperty('health', 0)
				return Function_Stop;
			end
		elseif challenges[curChallenge] == 'noCharms' then
			if allowedCharms == false then
				setProperty('health', 0)
				return Function_Stop;
			end
		elseif challenges[curChallenge] == 'noMayhem' then
			if allowedBuffs == false then
				setProperty('health', 0)
				return Function_Stop;
			end
		elseif challenges[curChallenge] == 'noBoth' then
			if allowedBoth == false then
				setProperty('health', 0)
				return Function_Stop;
			end
		elseif challenges[curChallenge] == 'setHealth' then
			if getProperty('health') <= healthGoal then
				setProperty('health', 0)
				return Function_Stop;
			end
		elseif challenges[curChallenge] == 'noGhostTap' then
			setPropertyFromClass('Clientprefs', 'ghostTapping', true)
		end
		setPropertyFromClass('PlayState', 'mayhemTotalChallenges', getPropertyFromClass('PlayState', 'mayhemTotalChallenges') + 1)
		
		if allowCombo then
			if challenges[curChallengeBonus] == 'rating' then
				if rating < (rateNum / 100) then
					setProperty('health', 0)
					return Function_Stop;
				end
			elseif challenges[curChallengeBonus] == 'exactMisses' then
				if allowed == false then
					setProperty('health', 0)
					return Function_Stop;
				end
			elseif challenges[curChallengeBonus] == 'noCharms' then
				if allowedCharms == false then
					setProperty('health', 0)
					return Function_Stop;
				end
			elseif challenges[curChallengeBonus] == 'noMayhem' then
				if allowedBuffs == false then
					setProperty('health', 0)
					return Function_Stop;
				end
			elseif challenges[curChallengeBonus] == 'noBoth' then
				if allowedBoth == false then
					setProperty('health', 0)
					return Function_Stop;
				end
			elseif challenges[curChallengeBonus] == 'setHealth' then
				if getProperty('health') <= healthGoal then
					setProperty('health', 0)
					return Function_Stop;
				end
			elseif challenges[curChallengeBonus] == 'noGhostTap' then
				setPropertyFromClass('Clientprefs', 'ghostTapping', true)
			end
			setPropertyFromClass('PlayState', 'mayhemTotalChallenges', getPropertyFromClass('PlayState', 'mayhemTotalChallenges') + 1)
		end
	end
	return Function_Continue;
end

function onTimerCompleted(tag)
	if tag == 'chalDisappear' then
		doTweenAlpha('challengeDisappear', 'challengeShowcase', 0, 0.8 / playbackRate, 'sineInOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'challengeDisappear' then
		showChal = 0
	end
	if tag == 'challengeAppear' then
		showChal = 2
	end
end