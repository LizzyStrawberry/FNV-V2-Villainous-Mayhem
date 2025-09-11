local beatsAllowed = {0, 2, 4, 8, 16, 32, 63}
local beatsStaticAllowed = {0, 2, 4, 8, 16, 31}
local beatSelected
local beatStaticSelected
local qteGoalScale
local allow = false
local qteActive = false
local flash = false
local speed = 1

function onCreate()
	if mechanics then
		precacheSound('checkmark')
		precacheSound('checkmarkReverse')
		speed = string.format("%.2f",getRandomFloat(1.0, 4.5))
		qteGoalScale = string.format("%.2f",getRandomFloat(0.2, 0.8))
		--debugPrint('QTE SCALE: '..qteGoalScale)
		
		beatSelected = getRandomInt(1, #(beatsAllowed))
		beatStaticSelected = getRandomInt(1, #(beatsStaticAllowed))
		--debugPrint('BEAT SELECTED: '..beatSelected)
		
		makeLuaSprite('qteGoal', 'effects/qteGoal', mobileFix("X", -165), -100)
		setScrollFactor('qteGoal', 0, 0)
		setObjectCamera('qteGoal', 'hud')
		setProperty('qteGoal.scale.x', qteGoalScale)
		setProperty('qteGoal.scale.y', qteGoalScale)
		setProperty('qteGoal.alpha', 0)
		addLuaSprite('qteGoal', true)

		
		makeLuaSprite('qte', 'effects/qte', mobileFix("X", -165), -100)
		setScrollFactor('qte', 0, 0)
		setObjectCamera('qte', 'hud')
		setProperty('qte.scale.x', 1.5)
		setProperty('qte.scale.y', 1.5)
		setProperty('qte.alpha', 0)
		addLuaSprite('qte', true)
		
		makeAnimatedLuaSprite('Static', 'effects/staticIniquitous', -100, 0)
		for i = 1, 4 do
			addAnimationByPrefix('Static', 'Stun'..i, 'static'..i, 24, true)
		end
		setProperty('Static.alpha', 0)
		setGraphicSize("Static", screenWidth*1.25, screenHeight)
		setScrollFactor('Static', 0, 0)
		setObjectCamera('Static', 'hud')
		addLuaSprite('Static', true)
		end
end

local autoPlay = false
function onUpdate()
	if mechanics then
		if not autoPlay then
			autoPlay = botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1
		end
		if qteActive == true then
			--debugPrint('QTE SCALE: '..string.format("%.2f",getProperty('qte.scale.x')))
			if autoPlay then --IF BOTPLAY or AUTO DODGE CHARM IS ENABLED
				if getProperty('qte.scale.x') <= getProperty('qteGoal.scale.x') and getProperty('qte.scale.x') >= getProperty('qteGoal.scale.x') - 0.03 then			
					playSound('checkmark')
					
					cancelTween('qteScaleX')
					cancelTween('qteScaleY')
					runTimer('reset', 0.8)
					
					flash = true
					qteActive = false
					allow = false
				end
			elseif getProperty('qte.scale.x') > 0 and keyJustPressed('dodge') then
				if getProperty('qte.scale.x') <= getProperty('qteGoal.scale.x') + 0.03 and getProperty('qte.scale.x') >= getProperty('qteGoal.scale.x') - 0.03 then			
					playSound('checkmark')
					
					cancelTween('qteScaleX')
					cancelTween('qteScaleY')
					runTimer('reset', 0.8)
					
					flash = true
					qteActive = false
					allow = false
				else
					cameraFlash('hud', 'FF0000', 0.6, false)
					if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
						setProperty('health', getHealth() - 0.500)
					else
						setProperty('health', getHealth() - 1)
					end
					
					playSound('checkmarkReverse')
					cancelTween('qteScaleX')
					cancelTween('qteScaleY')
					
					qteActive = false
					allow = false
					runTimer('reset', 0.01)
				end
			end
			if getProperty('qte.scale.x') == 0 then
				cameraFlash('hud', 'FF0000', 0.6, false)
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', getHealth() - 0.500)
				else
					setProperty('health', getHealth() - 1)
				end
				
				playSound('checkmarkReverse')
				
				qteActive = false
				allow = false
				runTimer('reset', 0.01)
			end
		end
		if flash == true then
			if curStep % 4 == 0 then
				setProperty('qte.alpha', 1)
			end
			if curStep % 4 == 2 then
				setProperty('qte.alpha', 0)
			end
		end
	end
end

function onBeatHit()
	if mechanics then
		if ((curBeat >= 132 and curBeat < 464) or curBeat >= 544) and curBeat % 64 == beatsAllowed[beatSelected] and allow == false then
			allow = true
		end
		--Shut the mechanic off to let monologue play
		if curBeat == 464 then
			allow = false
			qteActive = false
		end
		if (not mustHitSection) and allow == true and qteActive == false then
			doTweenX('qteScaleX', 'qte.scale', 0, speed, 'easeIn')
			doTweenY('qteScaleY', 'qte.scale', 0, speed, 'easeIn')
			doTweenAlpha('qteGoalAlphaFadeIn', 'qteGoal', 1, 0.6, 'easeIn')
			doTweenAlpha('qteAlphaFadeIn', 'qte', 1, 0.6, 'easeIn')
			qteActive = true
		end
		
		if curBeat >= 128 and curBeat % 32 == beatsStaticAllowed[beatStaticSelected] then
			objectPlayAnimation('Static','Stun'..getRandomInt(1,4), true)
			playSound('Static Noises/Glitch-'..getRandomInt(1,4), 1)
			setProperty('Static.alpha', 1)
			runTimer('StaticByeBye', 0.06)
		end
	end
end

function onTimerCompleted(tag)
	if mechanics then
		if tag == 'reset' then
			flash = false
			doTweenAlpha('qteGoalAlphaFadeOut', 'qteGoal', 0, 1, 'cubeInOut')
			doTweenAlpha('qteAlphaFadeOut', 'qte', 0, 1, 'cubeInOut')
		end
		
		if tag == 'StaticByeBye' then
			doTweenAlpha('StaticGoByeBye', 'Static', 0, 1.4, 'linear')
		end
	end
end

function onTweenCompleted(tag)
	if mechanics then
		if tag == 'qteGoalAlphaFadeOut' then
			speed = string.format("%.2f",getRandomFloat(1.0, 4.5))
			qteGoalScale = string.format("%.2f", getRandomFloat(0.1, 0.8))
			
			beatSelected = getRandomInt(1, #(beatsAllowed))
			beatStaticSelected = getRandomInt(1, #(beatsStaticAllowed))
			
			setProperty('qteGoal.scale.x', qteGoalScale)
			setProperty('qteGoal.scale.y', qteGoalScale)
			setProperty('qte.scale.x', 1.5)
			setProperty('qte.scale.y', 1.5)
		end
	end
end