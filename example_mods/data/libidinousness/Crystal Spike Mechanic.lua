local spikeTableX = {430, 660, 900}
local spikeTableY = {840, 800, 730}
local boyfriendTableX = {570, 780, 990}
local boyfriendTableY = {970, 920, 870}
local hitBoxTableX = {570, 770, 990}
local hitBoxTableY = {980, 950, 880}
local timer = {0, 8, 16, 24, 32}

local enable = false
local attack = false
local damaged = false
local flash = false
local allowedToMove = false
local playerPosition = 2 -- Default: 2
local moving = false
local sickBeat = 0
local spikeSelected = 0
local spikeSelectedSecondary = 0
local checkForSecondTrap = 0
local botSafeSpot = 0
local botMove = "NOMOVE"
local autoCharmEnabled = false
local iconAlphaLower = false

function onCreate()
	setProperty('boyfriend.x', boyfriendTableX[2])
	setProperty('boyfriend.y', boyfriendTableY[2])
	if mechanics then
		precacheSound('CrystalAppear')
		precacheSound('CrystalAlarm')
		precacheSound('CrystalHit')
		precacheSound('gfMove')
		if not performanceWarn then
			spikeSelected = getRandomInt(1, 3)
			----debugPrint('First Spike: '..spikeSelected)
			
			checkForSecondTrap = getRandomInt(1, 2)
			----debugPrint('Allow Second Spike?: '..checkForSecondTrap)

			spikeSelectedSecondary = getRandomInt(1, 3)
			if spikeSelectedSecondary == spikeSelected then
				runTimer('redoSecondarySpike', 0.01)
			end
			
			botSafeSpot = getRandomInt(1, 3)
			if playerPosition > botSafeSpot then
				botMove = "LEFT"
			elseif playerPosition < botSafeSpot then
				botMove = "RIGHT"
			else
				botMove = "NOMOVE"
			end
			if botSafeSpot == spikeSelected or botSafeSpot == spikeSelectedSecondary or (botSafeSpot >= spikeSelected and botSafeSpot <= spikeSelectedSecondary) then
				runTimer('redoSafeSpot', 0.01)
			end
			
			timerSelected = getRandomInt(3, 5)
			
			-- Create Spikes and Warning
			makeAnimatedLuaSprite('Spike 1', 'effects/Spike 1', 380, 750);
			addAnimationByPrefix('Spike 1', 'penetrate1', 'Spike 1 appear0', 24 / playbackRate, false);
			setProperty('Spike 1.alpha', 0)
			addLuaSprite('Spike 1', true)
			
			makeAnimatedLuaSprite('Spike 2', 'effects/Spike 2', 660, 720);
			addAnimationByPrefix('Spike 2', 'penetrate2', 'Spike 2 appear0', 24 / playbackRate, false);
			setProperty('Spike 2.alpha', 0)
			addLuaSprite('Spike 2', true)
			
			makeAnimatedLuaSprite('Spike 3', 'effects/Spike 3', 880, 580);
			addAnimationByPrefix('Spike 3', 'penetrate3', 'Spike 3 appear0', 24 / playbackRate, false);
			setProperty('Spike 3.alpha', 0)
			addLuaSprite('Spike 3', true)
			
			makeLuaSprite('warnCircle', 'effects/warn', spikeTableX[spikeSelected], spikeTableY[spikeSelected]);
			setScrollFactor('warnCircle', 0.95, 0.95);
			setObjectOrder('warnCircle', getObjectOrder('dadGroup') + 1)
			setProperty('warnCircle.alpha', 0)
			addLuaSprite('warnCircle', false)
			
			makeLuaSprite('secondaryWarnCircle', 'effects/warn', spikeTableX[spikeSelectedSecondary], spikeTableY[spikeSelectedSecondary]);
			setScrollFactor('secondaryWarnCircle', 0.95, 0.95);
			setObjectOrder('secondaryWarnCircle', getObjectOrder('dadGroup') + 1)
			setProperty('secondaryWarnCircle.alpha', 0)
			addLuaSprite('secondaryWarnCircle', false)
		else
			boyfriendTableX = {530, 730, 930}
			boyfriendTableY = {420, 420, 420}
			spikeTableX = {530, 730, 920}
			spikeTableY = {420, 400, 390}
			precacheSound('CrystalAppear')
			precacheSound('CrystalAlarm')
			precacheSound('CrystalHit')
			precacheSound('gfMove')
			
			spikeSelected = getRandomInt(1, 3)
			----debugPrint('First Spike: '..spikeSelected)
			
			checkForSecondTrap = getRandomInt(1, 2)
			----debugPrint('Allow Second Spike?: '..checkForSecondTrap)

			spikeSelectedSecondary = getRandomInt(1, 3)
			if spikeSelectedSecondary == spikeSelected then
				runTimer('redoSecondarySpike', 0.01)
			end
			
			botSafeSpot = getRandomInt(1, 3)
			if playerPosition > botSafeSpot then
				botMove = "LEFT"
			elseif playerPosition < botSafeSpot then
				botMove = "RIGHT"
			else
				botMove = "NOMOVE"
			end
			if botSafeSpot == spikeSelected or botSafeSpot == spikeSelectedSecondary or (botSafeSpot >= spikeSelected and botSafeSpot <= spikeSelectedSecondary) then
				runTimer('redoSafeSpot', 0.01)
			end
			
			timerSelected = getRandomInt(3, 5)
			
			-- Create Spikes and Warning
			makeAnimatedLuaSprite('Spike 1', 'effects/Spike 1', spikeTableX[1] + 10, spikeTableY[1] - 50);
			addAnimationByPrefix('Spike 1', 'penetrate1', 'Spike 1 appear0', 24 / playbackRate, false);
			setScrollFactor('Spike 1', 0, 0);
			scaleObject('Spike 1', 0.5, 0.5)
			setProperty('Spike 1.alpha', 0)
			addLuaSprite('Spike 1', true)
			
			makeAnimatedLuaSprite('Spike 2', 'effects/Spike 2', spikeTableX[2] + 10, spikeTableY[2] - 30);
			addAnimationByPrefix('Spike 2', 'penetrate2', 'Spike 2 appear0', 24 / playbackRate, false);
			setScrollFactor('Spike 2', 0, 0);
			scaleObject('Spike 2', 0.5, 0.5)
			setProperty('Spike 2.alpha', 0)
			addLuaSprite('Spike 2', true)
			
			makeAnimatedLuaSprite('Spike 3', 'effects/Spike 3', spikeTableX[3] + 10, spikeTableY[3] - 60);
			addAnimationByPrefix('Spike 3', 'penetrate3', 'Spike 3 appear0', 24 / playbackRate, false);
			setScrollFactor('Spike 3', 0, 0);
			scaleObject('Spike 3', 0.5, 0.5)
			setProperty('Spike 3.alpha', 0)
			addLuaSprite('Spike 3', true)
			
			makeLuaSprite('warnCircle', 'effects/warn', spikeTableX[spikeSelected], spikeTableY[spikeSelected]);
			setScrollFactor('warnCircle', 0, 0);
			scaleObject('warnCircle', 0.5, 0.5)
			setObjectOrder('warnCircle', getObjectOrder('gfOptimized') + 1)
			setProperty('warnCircle.alpha', 0)
			addLuaSprite('warnCircle', false)
			
			makeLuaSprite('secondaryWarnCircle', 'effects/warn', spikeTableX[spikeSelectedSecondary], spikeTableY[spikeSelectedSecondary]);
			setScrollFactor('secondaryWarnCircle', 0, 0);
			scaleObject('secondaryWarnCircle', 0.5, 0.5)
			setObjectOrder('secondaryWarnCircle', getObjectOrder('gfOptimized') + 1)
			setProperty('secondaryWarnCircle.alpha', 0)
			addLuaSprite('secondaryWarnCircle', false)
		end
	end
end

function onSongStart()
	if mechanics then
		setProperty('Spike 1.alpha', 1)
		setProperty('Spike 2.alpha', 1)
		setProperty('Spike 3.alpha', 1)
	end
end

function onUpdate()
	if not performanceWarn then
		if mechanics and curBeat == 96 then
			enable = true
		end
		if mechanics and enable then
			health = getProperty('health')
			if botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 then
				moving = true
				if autoCharmEnabled == false then
					runTimer('redoSafeSpot', 0.01)
					autoCharmEnabled = true
				end
			end
			
			if curBeat % 32 == timerSelected then
				attack = true
			end
			
			-- Hud things
			if not mustHitSection and iconAlphaLower == false then
				doTweenAlpha('iconP1', 'iconP1', 0.3, 0.5, 'sineOut')
				doTweenAlpha('iconP2', 'iconP2', 0.3, 0.5, 'sineOut')
				iconAlphaLower = true
			end
			if mustHitSection and iconAlphaLower == true then
				doTweenAlpha('iconP1', 'iconP1', 1, 0.5, 'sineOut')
				doTweenAlpha('iconP2', 'iconP2', 1, 0.5, 'sineOut')
				iconAlphaLower = false
			end

			-- Allow player to move when they have no notes on their side
			if not mustHitSection then
				allowedToMove = true
			else
				allowedToMove = false
			end
			if (curBeat >= 192 and curBeat < 208) or (curBeat >= 320 and curBeat < 335) 
			or (curBeat >= 352 and curBeat < 368) or (curBeat >= 473 and curBeat < 481)
			or (curBeat >= 497 and curBeat < 513) or (curBeat >= 529 and curBeat < 545)	
			or (curBeat >= 561 and curBeat < 577) or (curBeat >= 529 and curBeat < 545)	then
				allowAttack = false
			else
				allowAttack = true
			end
			
			-- Movement
			if allowedToMove == true and moving == false then
				if keyJustPressed('left') and playerPosition > 1 then
					playSound('gfMove', 0.3)
					playerPosition = playerPosition - 1
					triggerEvent('Play Animation', 'dodge '..getRandomInt(1,2)..' left', 'bf')
					doTweenX('PlayerMoveX', 'boyfriend', boyfriendTableX[playerPosition], 0.4, 'cubeInOut')
					doTweenY('PlayerMoveY', 'boyfriend', boyfriendTableY[playerPosition], 0.4, 'cubeInOut')
					moving = true
				end
				if keyJustPressed('right') and playerPosition < 3 then
					playSound('gfMove', 0.3)
					playerPosition = playerPosition + 1
					triggerEvent('Play Animation', 'dodge '..getRandomInt(1,2)..' right', 'bf')
					doTweenX('PlayerMoveX', 'boyfriend', boyfriendTableX[playerPosition], 0.4, 'cubeInOut')
					doTweenY('PlayerMoveY', 'boyfriend', boyfriendTableY[playerPosition], 0.4, 'cubeInOut')
					moving = true
				end
			end
			
			-- Getting Hit
			if (sickBeat == 4 and playerPosition == spikeSelected and damaged == false)
				or (checkForSecondTrap == 2 and sickBeat == 4 and (playerPosition == spikeSelected or playerPosition == spikeSelectedSecondary) and damaged == false) then
				runTimer('getHit', 0.1)
				runTimer('flashDamage', 2)
				
				playSound('CrystalHit')
					
				damaged = true
				flash = true
			end
			if flash == true then
				if curStep % 2 == 0 then
					setProperty('boyfriend.alpha', 0)
				end
				if curStep % 2 == 1 then
					setProperty('boyfriend.alpha', 1)
				end
			end
		end
	else
		if mechanics and curBeat == 96 then
			enable = true
		end
		if mechanics and enable then
			health = getProperty('health')
			if botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 then
				moving = true
				if autoCharmEnabled == false then
					runTimer('redoSafeSpot', 0.01)
					autoCharmEnabled = true
				end
			end
			
			if curBeat % 32 == timerSelected then
				attack = true
			end
			
			-- Hud things
			if not mustHitSection and iconAlphaLower == false then
				doTweenAlpha('iconP1', 'iconP1', 0.3, 0.5, 'sineOut')
				doTweenAlpha('iconP2', 'iconP2', 0.3, 0.5, 'sineOut')
				iconAlphaLower = true
			end
			if mustHitSection and iconAlphaLower == true then
				doTweenAlpha('iconP1', 'iconP1', 1, 0.5, 'sineOut')
				doTweenAlpha('iconP2', 'iconP2', 1, 0.5, 'sineOut')
				iconAlphaLower = false
			end

			-- Allow player to move when they have no notes on their side
			if not mustHitSection then
				allowedToMove = true
			else
				allowedToMove = false
			end
			if (curBeat >= 192 and curBeat < 208) or (curBeat >= 320 and curBeat < 335) 
			or (curBeat >= 352 and curBeat < 368) or (curBeat >= 473 and curBeat < 481)
			or (curBeat >= 497 and curBeat < 513) or (curBeat >= 529 and curBeat < 545)	
			or (curBeat >= 561 and curBeat < 577) or (curBeat >= 529 and curBeat < 545)	then
				allowAttack = false
			else
				allowAttack = true
			end
			
			-- Movement
			if allowedToMove == true and moving == false then
				if keyJustPressed('left') and playerPosition > 1 then
					playSound('gfMove', 0.3)
					playerPosition = playerPosition - 1
					doTweenX('PlayerMoveX', 'gfOptimized', boyfriendTableX[playerPosition], 0.4, 'cubeInOut')
					doTweenY('PlayerMoveY', 'gfOptimized', boyfriendTableY[playerPosition], 0.4, 'cubeInOut')
					runTimer('gfLowQAnimationFixLeft', 0.1)
					moving = true
				end
				if keyJustPressed('right') and playerPosition < 3 then
					playSound('gfMove', 0.3)
					playerPosition = playerPosition + 1
					doTweenX('PlayerMoveX', 'gfOptimized', boyfriendTableX[playerPosition], 0.4, 'cubeInOut')
					doTweenY('PlayerMoveY', 'gfOptimized', boyfriendTableY[playerPosition], 0.4, 'cubeInOut')
					runTimer('gfLowQAnimationFixRight', 0.1)
					moving = true
				end
			end
			
			-- Getting Hit
			if (sickBeat == 4 and playerPosition == spikeSelected and damaged == false)
				or (checkForSecondTrap == 2 and sickBeat == 4 and (playerPosition == spikeSelected or playerPosition == spikeSelectedSecondary) and damaged == false) then
				runTimer('getHit', 0.1)
				runTimer('flashDamage', 2)
				
				playSound('CrystalHit')
					
				damaged = true
				flash = true
			end
			if flash == true then
				if curStep % 2 == 0 then
					setProperty('gfOptimized.alpha', 0)
				end
				if curStep % 2 == 1 then
					setProperty('gfOptimized.alpha', 1)
				end
			end
		end
	end
end

function onStepHit()
	if not performanceWarn then
		if mechanics and enable then
			if attack == true and (not mustHitSection) and allowAttack == true then
				if curStep % 4 == 0 and sickBeat == 1 and (getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 or botPlay) then -- THIS IS ONLY FOR THE AUTO PLAY CHARM AND botPlay
					if botMove == "LEFT" then
						triggerEvent('Play Animation', 'dodge '..getRandomInt(1,2)..' left', 'bf')
					elseif botMove == "RIGHT" then
						triggerEvent('Play Animation', 'dodge '..getRandomInt(1,2)..' right', 'bf')
					elseif botMove == "NOMOVE" then
						-- Do Nothing
					end
					playerPosition = botSafeSpot
					playSound('gfMove', 0.3)
					doTweenX('PlayerMoveX', 'boyfriend', boyfriendTableX[playerPosition], 0.4, 'cubeInOut')
					doTweenY('PlayerMoveY', 'boyfriend', boyfriendTableY[playerPosition], 0.4, 'cubeInOut')
				end
				
				-- Manual Attack
				if curStep % 4 == 0 and sickBeat < 3 then
					playSound('CrystalAlarm', 0.3)
					setProperty('warnCircle.alpha', 1)
					doTweenAlpha('warnGoAway', 'warnCircle', 0, 0.5/ playbackRate, 'circOut')
					if checkForSecondTrap == 2 then
						setProperty('secondaryWarnCircle.alpha', 1)
						doTweenAlpha('warn2GoAway', 'secondaryWarnCircle', 0, 0.5 / playbackRate, 'circOut')
					end
				end
				if curStep % 4 == 0 and sickBeat == 3 then
					playSound('CrystalAppear')
					cancelTween('warnGoAway')
					setProperty('warnCircle.alpha', 0)
					objectPlayAnimation('Spike '..spikeSelected, 'penetrate'..spikeSelected);
					if checkForSecondTrap == 2 then
						cancelTween('warn2GoAway')
						setProperty('secondaryWarnCircle.alpha', 0)
						objectPlayAnimation('Spike '..spikeSelectedSecondary, 'penetrate'..spikeSelectedSecondary);
					end
				end
				if curStep % 4 == 0 and sickBeat < 5 then
					sickBeat = sickBeat + 1
					----debugPrint('SickBeat: '..sickBeat)
				end
				if curStep % 4 == 0 and sickBeat == 5 then
					
					spikeSelected = getRandomInt(1, 3)
					--debugPrint('First Spike: '..spikeSelected)

					checkForSecondTrap = getRandomInt(1, 2)
					--debugPrint('Second Spike: '..spikeSelectedSecondary)
					--debugPrint('Allow Second Spike?: '..checkForSecondTrap)
					
					spikeSelectedSecondary = getRandomInt(1, 3)
					if spikeSelectedSecondary == spikeSelected then
						runTimer('redoSecondarySpike', 0.01)
					end
					
					if getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 or botPlay then -- Auto Charm Enabled
						botSafeSpot = getRandomInt(1, 3)
						if playerPosition > botSafeSpot then
							botMove = "LEFT"
						elseif playerPosition < botSafeSpot then
							botMove = "RIGHT"
						else
							botMove = "NOMOVE"
						end
						--debugPrint('Safe Spot: '..botSafeSpot)
						if botSafeSpot == spikeSelected or botSafeSpot == spikeSelectedSecondary then
							runTimer('redoSafeSpot', 0.01)
						end
					end
					
					timerSelected = getRandomInt(1, 5)
					setProperty('warnCircle.x', spikeTableX[spikeSelected])
					setProperty('warnCircle.y', spikeTableY[spikeSelected])
					setProperty('secondaryWarnCircle.x', spikeTableX[spikeSelectedSecondary])
					setProperty('secondaryWarnCircle.y', spikeTableY[spikeSelectedSecondary])

					--debugPrint('New curBeat %: '..timer[timerSelected])

					sickBeat = 0
					attack = false
					damaged = false
				end
			end
		end
	else
		if mechanics and enable then
			if attack == true and (not mustHitSection) and allowAttack == true then
				if curStep % 4 == 0 and sickBeat == 1 and (getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 or botPlay) then -- THIS IS ONLY FOR THE AUTO PLAY CHARM AND botPlay
					playerPosition = botSafeSpot
					playSound('gfMove', 0.3)
					doTweenX('PlayerMoveX', 'gfOptimized', boyfriendTableX[playerPosition], 0.4, 'cubeInOut')
					doTweenY('PlayerMoveY', 'gfOptimized', boyfriendTableY[playerPosition], 0.4, 'cubeInOut')
				end
				
				-- Manual Attack
				if curStep % 4 == 0 and sickBeat < 3 then
					playSound('CrystalAlarm', 0.3)
					setProperty('warnCircle.alpha', 1)
					doTweenAlpha('warnGoAway', 'warnCircle', 0, 0.5/ playbackRate, 'circOut')
					if checkForSecondTrap == 2 then
						setProperty('secondaryWarnCircle.alpha', 1)
						doTweenAlpha('warn2GoAway', 'secondaryWarnCircle', 0, 0.5 / playbackRate, 'circOut')
					end
				end
				if curStep % 4 == 0 and sickBeat == 3 then
					playSound('CrystalAppear')
					cancelTween('warnGoAway')
					setProperty('warnCircle.alpha', 0)
					objectPlayAnimation('Spike '..spikeSelected, 'penetrate'..spikeSelected);
					if checkForSecondTrap == 2 then
						cancelTween('warn2GoAway')
						setProperty('secondaryWarnCircle.alpha', 0)
						objectPlayAnimation('Spike '..spikeSelectedSecondary, 'penetrate'..spikeSelectedSecondary);
					end
				end
				if curStep % 4 == 0 and sickBeat < 5 then
					sickBeat = sickBeat + 1
					----debugPrint('SickBeat: '..sickBeat)
				end
				if curStep % 4 == 0 and sickBeat == 5 then
					spikeSelected = getRandomInt(1, 3)
					--debugPrint('First Spike: '..spikeSelected)

					checkForSecondTrap = getRandomInt(1, 2)
					--debugPrint('Second Spike: '..spikeSelectedSecondary)
					--debugPrint('Allow Second Spike?: '..checkForSecondTrap)
					
					spikeSelectedSecondary = getRandomInt(1, 3)
					if spikeSelectedSecondary == spikeSelected then
						runTimer('redoSecondarySpike', 0.01)
					end
					
					if getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 or botPlay then -- Auto Charm Enabled
						botSafeSpot = getRandomInt(1, 3)
						if playerPosition > botSafeSpot then
							botMove = "LEFT"
						elseif playerPosition < botSafeSpot then
							botMove = "RIGHT"
						else
							botMove = "NOMOVE"
						end
						--debugPrint('Safe Spot: '..botSafeSpot)
						if botSafeSpot == spikeSelected or botSafeSpot == spikeSelectedSecondary then
							runTimer('redoSafeSpot', 0.01)
						end
					end
					
					timerSelected = getRandomInt(1, 5)
					setProperty('warnCircle.x', spikeTableX[spikeSelected])
					setProperty('warnCircle.y', spikeTableY[spikeSelected])
					setProperty('secondaryWarnCircle.x', spikeTableX[spikeSelectedSecondary])
					setProperty('secondaryWarnCircle.y', spikeTableY[spikeSelectedSecondary])

					--debugPrint('New curBeat %: '..timer[timerSelected])

					sickBeat = 0
					attack = false
					damaged = false
				end
			end
		end
	end
end

function onEndSong()
	enable = false;
	allow = false
	return Function_Continue;
end

function onTweenCompleted(tag)
	if tag == 'PlayerMoveX' then
		moving = false
	end
end

function onTimerCompleted(tag)
	if tag == 'getHit' then
		if not performanceWarn then
			triggerEvent('Play Animation', 'hit', 'bf')
		end
		if ((isStoryMode and difficulty == 1) or (not isStoryMode and difficulty == 0)) and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				if not isMayhemMode then
					setProperty('health', health - 0.495)
				else
					setProperty('health', health - 4)
				end
			else
				if not isMayhemMode then
					setProperty('health', health - 0.99)
				else
					setProperty('health', health - 8)
				end
			end
		elseif ((isStoryMode and difficulty == 2) or (not isStoryMode and difficulty == 1)) and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				if not isMayhemMode then
					setProperty('health', health - 0.99)
				else
					setProperty('health', health - 7)
				end
			else
				if not isMayhemMode then
					setProperty('health', 0)
				else
					setProperty('health', health - 15)
				end
			end
		end
	end
	if tag == 'flashDamage' then
		flash = false
		if not performanceWarn then
			setProperty('boyfriend.alpha', 1)
		else
			setProperty('gfOptimized.alpha', 1)
		end
	end
	if tag == 'redoSecondarySpike' then
		spikeSelectedSecondary = getRandomInt(1, 3)
		--debugPrint('NEW Secondary Spike: '..spikeSelectedSecondary)
		setProperty('secondaryWarnCircle.x', spikeTableX[spikeSelectedSecondary])
		setProperty('secondaryWarnCircle.y', spikeTableY[spikeSelectedSecondary])
		if spikeSelectedSecondary == spikeSelected then
			runTimer('redoSecondarySpike', 0.01)
		end
		botSafeSpot = getRandomInt(1, 3)
		if playerPosition > botSafeSpot then
			botMove = "LEFT"
		elseif playerPosition < botSafeSpot then
			botMove = "RIGHT"
		else
			botMove = "NOMOVE"
		end
		if botSafeSpot == spikeSelected or botSafeSpot == spikeSelectedSecondary then
			runTimer('redoSafeSpot', 0.01)
		end
	end
	if tag == 'redoSafeSpot' then
		botSafeSpot = getRandomInt(1, 3)
		if playerPosition > botSafeSpot then
			botMove = "LEFT"
		elseif playerPosition < botSafeSpot then
			botMove = "RIGHT"
		else
			botMove = "NOMOVE"
		end
		--debugPrint('NEW Safe Spot: '..botSafeSpot)
		if botSafeSpot == spikeSelected or botSafeSpot == spikeSelectedSecondary then
			runTimer('redoSafeSpot', 0.01)
		end
	end
	if tag == 'gfLowQAnimationFixLeft' then
		loadGraphic('gfOptimized', 'bgs/kiana/Final/gfOptimized-dodge')
		setProperty('gfOptimized.flipX', false)
		runTimer('fixAgain', 0.2)
	end
	if tag == 'gfLowQAnimationFixRight' then
		loadGraphic('gfOptimized', 'bgs/kiana/Final/gfOptimized-dodge')
		runTimer('fixAgain', 0.2)
		setProperty('gfOptimized.flipX', true)
	end
	if tag == 'fixAgain' then
		loadGraphic('gfOptimized', 'bgs/kiana/Final/gfOptimized')
		setProperty('gfOptimized.flipX', false)
	end
end