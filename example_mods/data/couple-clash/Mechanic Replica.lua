--Mayhem Bar
local maxedOut = false
local activated = false
local refill = false

--Charms
local allowHealCharm = false

function onCreate()
	makeLuaSprite('blackBG', '', 0, 0)
	makeGraphic('blackBG', screenWidth, screenHeight, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'hud')
	setProperty('blackBG.alpha', 0)
	addLuaSprite('blackBG', false)
	
	createCharm()
	createMayhemBar()
	
	setPropertyFromClass('PlayState', 'checkForPowerUp', true) -- You will use this here anws
end

function createCharm()
	makeLuaSprite('charmSocket', 'effects/empty_charm', 10, 300)
	scaleObject('charmSocket', 0.25, 0.25)
	setObjectCamera('charmSocket', 'hud')
	setProperty("charmSocket.alpha", 0)
	addLuaSprite('charmSocket', true)
	
	makeLuaSprite('resCharm', 'effects/charm_1', 10, 270)
	scaleObject('resCharm', 0.25, 0.25)
	setProperty("resCharm.alpha", 0)
	setObjectCamera('resCharm', 'hud')
	addLuaSprite('resCharm', true)
	
	makeLuaText('charmActivate', 'Resistance Charm Activated!', 1000, 100, 320)
	setTextSize('charmActivate', 50)
	setProperty('charmActivate.alpha', 0)
	addLuaText('charmActivate')
end

function createMayhemBar()
	padColor = rgbToHex(getProperty('dad.healthColorArray'))
	backColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
		
	makeLuaSprite('reloadBar', 'mayhemBar/mayhembackBar', 450, 550)
	setProperty('reloadBar.color', getColorFromHex('737373'))
	setObjectCamera('reloadBar', 'hud')
	setObjectOrder('reloadBar', getObjectOrder('healthBarBG') + 1)
	setProperty('reloadBar.origin.x', 80)
	setProperty('reloadBar.scale.x', 1)
	addLuaSprite('reloadBar', true)
		
	makeLuaSprite('mayhembackBar', 'mayhemBar/mayhembackBar', 450, 550)
	setProperty('mayhembackBar.color', getColorFromHex(backColor))
	setObjectCamera('mayhembackBar', 'hud')
	setObjectOrder('mayhembackBar', getObjectOrder('reloadBar') + 1)
	setProperty('mayhembackBar.origin.x', 80)
	setProperty('mayhembackBar.scale.x', 0)
	setProperty('mayhembackBar.alpha', 0)
	addLuaSprite('mayhembackBar', true)
		
	makeLuaSprite('mayhemPads', 'mayhemBar/mayhemPads', 450, 550)
	setObjectCamera('mayhemPads', 'hud')
	setObjectOrder('mayhemPads', getObjectOrder('healthBarBG'))
	setProperty('mayhemPads.color', getColorFromHex(padColor))
	addLuaSprite('mayhemPads', true)
		
	makeLuaSprite('mayhemBar', 'mayhemBar/mayhemBar', 450, 550)
	setObjectCamera('mayhemBar', 'hud')
	setObjectOrder('mayhemBar', getObjectOrder('mayhembackBar') + 1)
	addLuaSprite('mayhemBar', true)
		
	makeLuaSprite('mayhemText', 'mayhemBar/mayhemText', 450, 550)
	setObjectCamera('mayhemText', 'hud')
	setObjectOrder('mayhemText', getObjectOrder('mayhemBar') + 1)
	setProperty('mayhemText.color', getColorFromHex(padColor))
	addLuaSprite('mayhemText', true)
		
	if downscroll then
		setProperty('reloadBar.y', 110)
		setProperty('mayhembackBar.y', 110)
		setProperty('mayhemPads.y', 110)
		setProperty('mayhemBar.y', 110)
		setProperty('mayhemText.y', 110)
	end
end

local tweenNotDone = false
function onUpdate(elapsed)
	followMayhemBar()
	
	if maxedOut and activated and not tweenNotDone and not refill then
		tweenNotDone = true
		doTweenX('mayhemBackBarScale', 'mayhembackBar.scale', 0, 8, 'linear')
	end
end

function onBeatHit()
	-- Bar stuff
	if maxedOut and curBeat >= 158 then
		if curBeat % 1 == 0 then
			setProperty('mayhembackBar.color', getColorFromHex('FFFFFF'))
			doTweenColor('mayhemBackBarColor', 'mayhembackBar', backColor, 0.8 / playbackRate, 'sineOut')
		end
	end
	
	-- Scripted Events
	if curBeat == 140 then
		doTweenY("charmY", "charmSocket", 270, 0.75 / playbackRate, "circOut")
		doTweenAlpha("charmAppear", "charmSocket", 1, 0.75 / playbackRate, "circOut")
	end
	if curBeat == 142 then
		removeLuaSprite('charmSocket', true)
					
		setProperty('resCharm.alpha', 1)
		setProperty('resCharm.scale.x', 0.27)
		setProperty('resCharm.scale.y', 0.27)
		doTweenX('charmScaleX', 'resCharm.scale', 0.25, 0.7, 'circOut')
		doTweenY('charmScaleY', 'resCharm.scale', 0.25, 0.7, 'circOut')
		
		setProperty('charmActivate.alpha', 1)
		scaleObject('charmActivate', 1.1, 1.1)
		doTweenX('RCharmActivateScaleX', 'charmActivate.scale', 1, 0.7, 'circOut')
		doTweenY('RCharmActivateScaleY', 'charmActivate.scale', 1, 0.7, 'circOut')
		runTimer('FlashEnd', 1.55)
					
		playSound('confirmMenu', 0.6)
		
		allowHealCharm = true
	end
	if curBeat == 158 then
		doTweenY("mayhemY", "mayhembackBar", 530, 0.75 / playbackRate, "circOut")
		doTweenAlpha("mayhemAppear", "mayhembackBar", 1, 0.75 / playbackRate, "circOut")
	end
	if curBeat == 160 then
		playSound('confirmMenu', 0.6)
		activated = true
	end
end

function onStepHit()
	if activated and curStep % 2 == 0 then
		setProperty('health', getHealth() + 0.045)
	end
end

function goodNoteHit(id, direction, noteType, isSus)
	if not maxedOut then
		setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') + (isSus and 0.0012 or 0.2))
	end
	if not maxedOut and getProperty('mayhembackBar.scale.x') >= 1 then
		setProperty('mayhembackBar.scale.x', 1)
		setProperty('reloadBar.scale.x', 0)
		maxedOut = true
	end
	if activated then
		addScore(450)
	end
end

function opponentNoteHit()
	if getHealth() > 0.2 then
		setProperty('health', getHealth() - (allowHealCharm and 0.007 or 0.014))
	end
end

function onTweenCompleted(tag)
	if tag == 'mayhemBackBarScale' then
		doTweenX('reloading', 'reloadBar.scale', 1, 10, 'linear')
		setProperty('mayhembackBar.color', getColorFromHex(backColor))
		
		activated = false
	end
	if tag == 'reloading' then
		maxedOut = false
		refill = false
	end
end

function onTimerCompleted(tag)
	if tag == 'FlashEnd' then
		doTweenAlpha('charmActivate', 'charmActivate', 0, 0.6 / playbackRate, 'cubeInOut')
	end
end

function followMayhemBar()
	setProperty('reloadBar.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('reloadBar.y', getProperty('mayhembackBar.y'))
	setProperty('mayhemPads.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('mayhemPads.y', getProperty('mayhembackBar.y'))
	setProperty('mayhemBar.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('mayhemBar.y', getProperty('mayhembackBar.y'))
	setProperty('mayhemText.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('mayhemText.y', getProperty('mayhembackBar.y'))
end

function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
    return string.format('%02x%02x%02x', math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end