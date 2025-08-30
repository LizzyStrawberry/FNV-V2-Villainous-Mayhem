--Mayhem Bar
local maxedOut = false
local activated = false
local refill = false

--Charms
local allowHealCharm = false

function onCreate()
	setProperty('gf.x', getProperty('gf.x') - 50)
	setProperty('gf.y', getProperty('gf.y') + 50)
	setPropertyFromClass('PlayState', 'gfSpeed', 2)
	setProperty('boyfriend.y', getProperty('boyfriend.y') + 50)
	makeLuaSprite('leftBGEffect', 'effects/bgEffect', -100, 0)
	setScrollFactor('leftBGEffect', 0, 0)
	setObjectCamera('leftBGEffect', 'game')
	setProperty('leftBGEffect.alpha', 0)
	addLuaSprite('leftBGEffect', true)
	
	makeLuaSprite('rightBGEffect', 'effects/bgEffect', 100, 0)
	setScrollFactor('rightBGEffect', 0, 0)
	setObjectCamera('rightBGEffect', 'game')
	setProperty('rightBGEffect.alpha', 0)
	setProperty('rightBGEffect.flipX', true)
	addLuaSprite('rightBGEffect', true)
	
	makeLuaSprite('blackBG', '', -300, -300)
	makeGraphic('blackBG', 2000, 2000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	setProperty('blackBG.alpha', 0)
	addLuaSprite('blackBG', true)
	
	--Guide
	if downscroll then
		makeLuaText('warning', 'WARNING:\nDefault keybinds will be used\nfor the charm and mayhem bar on this song!!\nBoth mechanics are scripted here, and vary from normal gameplay!\n(1 - Resistance Charm | ALT - Mayhem Bar)', 1000, 150, 570)
	else
		makeLuaText('warning', 'WARNING:\nDefault keybinds will be used\nfor the charm and mayhem bar on this song!!\nBoth mechanics are scripted here, and vary from normal gameplay!\n(1 - Resistance Charm | ALT - Mayhem Bar)', 1000, 150, 70)
	end
	setTextSize('warning', 25)
	setProperty('warning.alpha', 0)
	setTextAlignment('warning', 'CENTER')
	addLuaText('warning')
	
	makeLuaText('guideCharms', 'This is your Charm Socket.\nYou can use the charms you unlock throughout the game,\naka Resistance, Auto Dodge and Healing. Be sure to set your preferred keybinds for them! Lets test the Resistance charm!', 1000, 100, 260)
	setTextSize('guideCharms', 25)
	setProperty('guideCharms.alpha', 0)
	setTextAlignment('guideCharms', 'LEFT')
	addLuaText('guideCharms')
	
	makeLuaText('tip', 'Press 1 (default keybind) to activate your charm!', 1000, 150, 300)
	setTextSize('tip', 40)
	setProperty('tip.alpha', 0)
	addLuaText('tip')
	
	if downscroll then
		makeLuaText('guideMayhem', 'This is your Mayhem bar!\nHitting notes will fill your bar up, and once full and activated by pressing your mayhem button,\nit will grant you temporary power ups throughout your session!\nLets test the Health Regeneration Buff!', 1000, 140, 210)
	else
		makeLuaText('guideMayhem', 'This is your Mayhem bar!\nHitting notes will fill your bar up, and once full and activated by pressing your mayhem button,\nit will grant you temporary power ups throughout your session!\nLets test the Health Regeneration Buff!', 1000, 140, 410)
	end
	setTextSize('guideMayhem', 25)
	setProperty('guideMayhem.alpha', 0)
	setTextAlignment('guideMayhem', 'CENTER')
	addLuaText('guideMayhem')
	
	makeLuaSprite('charmSocket', 'effects/empty_charm', 10, 270)
	scaleObject('charmSocket', 0.25, 0.25)
	setObjectCamera('charmSocket', 'hud')
	addLuaSprite('charmSocket', true)
	
	makeLuaSprite('resCharm', 'effects/charm_1', 10, 270)
	scaleObject('resCharm', 0.25, 0.25)
	setObjectCamera('resCharm', 'hud')
	
	padColor = rgbToHex(getProperty('dad.healthColorArray'))
		
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
	setObjectOrder('mayhemPads', getObjectOrder('healthBarBG'))
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
		
	if downscroll then
		setProperty('reloadBar.y', 110)
		setProperty('mayhembackBar.y', 110)
		setProperty('mayhemPads.y', 110)
		setProperty('mayhemBar.y', 110)
		setProperty('mayhemText.y', 110)
	end
end

function onSongStart()
	doTweenAlpha('blackBG', 'blackBG', 0.7, 0.4 / playbackRate, 'sineOut')
	doTweenAlpha('guideCharms', 'guideCharms', 1, 0.4 / playbackRate, 'sineOut')
	doTweenAlpha('healthBar', 'healthBar', 0.4, 0.4 / playbackRate, 'sineOut')
	doTweenAlpha('warning', 'warning', 1, 0.4 / playbackRate, 'sineOut')
end
	
local tweenNotDone = false
local playedSound1 = false
local playedSound2 = false
function onUpdate()	
	setProperty('mayhembackBar.alpha', getProperty('healthBar.alpha'))
	setProperty('reloadBar.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('mayhemPads.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('mayhemBar.alpha', getProperty('mayhembackBar.alpha'))
	setProperty('mayhemText.alpha', getProperty('mayhembackBar.alpha'))
	
	if maxedOut and activated == true and tweenNotDone == false and refill == false then
		tweenNotDone = true
		doTweenX('mayhemBackBarScale', 'mayhembackBar.scale', 0, 8, 'linear')
	end
	
	if curBeat == 16 then
		doTweenAlpha('healthBar', 'healthBar', 1, 0.4 / playbackRate, 'sineOut')
		doTweenAlpha('guideCharms', 'guideCharms', 0, 0.4 / playbackRate, 'sineOut')
		doTweenAlpha('guideMayhem', 'guideMayhem', 1, 0.4 / playbackRate, 'sineOut')
		doTweenAlpha('charmSocket', 'charmSocket', 0.4, 0.4 / playbackRate, 'sineOut')
	end
	if curBeat == 29 then
		doTweenAlpha('blackBG', 'blackBG', 0, 0.4 / playbackRate, 'sineOut')
		doTweenAlpha('guideMayhem', 'guideMayhem', 0, 0.4 / playbackRate, 'sineOut')
		doTweenAlpha('warning', 'warning', 0, 0.4 / playbackRate, 'sineOut')
		doTweenAlpha('charmSocket', 'charmSocket', 1, 0.4 / playbackRate, 'sineInOut')
	end
	
	if curStep == 128 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false) 
	end
	
	if curBeat == 96 then
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		setProperty('defaultCamZoom', 1.3 * zoomMult)
	end
	if curBeat == 140 or curBeat == 156 then
		doTweenAlpha('blackBG', 'blackBG', 0.6, 0.4 / playbackRate, 'sineOut')
	end
	if curBeat == 144 then
		doTweenAlpha('blackBG', 'blackBG', 0, 0.4 / playbackRate, 'sineOut')
		if charmPressed == true then
			removeLuaSprite('charmSocket', true)
			addLuaSprite('resCharm', true)
					
			setProperty('resCharm.scale.x', 0.27)
			setProperty('resCharm.scale.y', 0.27)
			doTweenX('charmScaleX', 'resCharm.scale', 0.25, 0.7, 'circOut')
			doTweenY('charmScaleY', 'resCharm.scale', 0.25, 0.7, 'circOut')
			
			if not playedSound1 then
				playedSound1 = true
				playSound('confirmMenu')
			end
			allowHealCharm = true;
		else
			setTextString('tip', 'Missed..')
			setProperty('tip.alpha', 1)
			doTweenAlpha('tip', 'tip', 0, 0.4 / playbackRate, 'sineOut')
		end
	end
	if curBeat >= 140 and curBeat < 144 then
		if curStep % 4 == 0 then
			setProperty('tip.alpha', 1)
		end
		if curStep % 4 == 2 then
			setProperty('tip.alpha', 0)
		end
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ONE') then
			setPropertyFromClass('PlayState', 'checkForPowerUp', true)
			charmPressed = true
		end
	end
	if curBeat >= 156 and curBeat < 160 then
		setTextString('tip', 'Press ALT (Default Keybind) to activate your buff!')
		if curStep % 4 == 0 then
			setProperty('tip.alpha', 1)
		end
		if curStep % 4 == 2 then
			setProperty('tip.alpha', 0)
		end
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ALT') then
			setPropertyFromClass('PlayState', 'checkForPowerUp', true)
			mayhemPressed = true
		end
	end
	if curBeat == 160 then
		if mayhemPressed == true then
			activated = true;
			if not playedSound2 then
				playedSound2 = true
				playSound('confirmMenu')
			end
		else
			setTextString('tip', 'Missed..')
			setProperty('tip.alpha', 1)
			doTweenAlpha('tip', 'tip', 0, 0.4 / playbackRate, 'sineOut')
		end
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		setProperty('defaultCamZoom', 0.9 * zoomMult)
		setProperty('blackBG.alpha', 0)
	end
	if curBeat == 224 then
		setProperty('defaultCamZoom', 1.3 * zoomMult)
	end
	if curBeat == 256 then
		cameraFlash('game', 'FFFFFF', 0.5 / playbackRate, false)
		setProperty('defaultCamZoom', 0.9 * zoomMult)
	end
end

function onStepHit()
	if activated then
		if curStep % 2 == 0 then
			setProperty('health', getHealth() + 0.045)
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if not maxedOut and (not isSustainNote) then
		setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') + 0.019)
	end
	if maxedOut == false and getProperty('mayhembackBar.scale.x') >= 1 then
		setProperty('mayhembackBar.scale.x', 1)
		setProperty('reloadBar.scale.x', 0)
		maxedOut = true
	end
	if not maxedOut and isSustainNote then
		setProperty('mayhembackBar.scale.x', getProperty('mayhembackBar.scale.x') + 0.00115)
	end
	if activated then
		addScore(450)
	end
	
	if (curBeat >= 160 and curBeat <= 224) then
		if direction == 0 then
			setProperty('rightBGEffect.color', getColorFromHex('9700FF'))
			setProperty('rightBGEffect.alpha', 1)
			cancelTween('rightBGEffect')
			doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 1 then
			setProperty('rightBGEffect.color', getColorFromHex('00FFFF'))
			setProperty('rightBGEffect.alpha', 1)
			cancelTween('rightBGEffect')
			doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 2 then
			setProperty('rightBGEffect.color', getColorFromHex('00FF00'))
			setProperty('rightBGEffect.alpha', 1)
			cancelTween('rightBGEffect')
			doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 3 then
			setProperty('rightBGEffect.color', getColorFromHex('FF0000'))
			setProperty('rightBGEffect.alpha', 1)
			cancelTween('rightBGEffect')
			doTweenAlpha('rightBGEffect', 'rightBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
	end
end

function onBeatHit()
	if (curBeat >= 160 and curBeat <= 224) then
		triggerEvent('Add Camera Zoom', 0.04, 0.035)
	end
	
	if maxedOut then
		if curBeat % 1 == 0 then
			setProperty('mayhembackBar.color', getColorFromHex('FFFFFF'))
			doTweenColor('mayhemBackBarColor', 'mayhembackBar', backColor, 0.8 / playbackRate, 'sineOut')
		end
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

function opponentNoteHit(id, direction, noteType, isSustainNote, noteDat) -- health draining mechanic
	health = getProperty('health')
	if getProperty('health') > 0.2 then
		if allowHealCharm == true then
			setProperty('health', health- 0.009);
		else
			setProperty('health', health- 0.018);
		end
	end
	
	if (curBeat >= 160 and curBeat <= 224) then
		if direction == 0 then
			setProperty('leftBGEffect.color', getColorFromHex('9700FF'))
			setProperty('leftBGEffect.alpha', 1)
			cancelTween('leftBGEffect')
			doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 1 then
			setProperty('leftBGEffect.color', getColorFromHex('00FFFF'))
			setProperty('leftBGEffect.alpha', 1)
			cancelTween('leftBGEffect')
			doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 2 then
			setProperty('leftBGEffect.color', getColorFromHex('00FF00'))
			setProperty('leftBGEffect.alpha', 1)
			cancelTween('leftBGEffect')
			doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
		if direction == 3 then
			setProperty('leftBGEffect.color', getColorFromHex('FF0000'))
			setProperty('leftBGEffect.alpha', 1)
			cancelTween('leftBGEffect')
			doTweenAlpha('leftBGEffect', 'leftBGEffect', 0, 0.4 / playbackRate, 'easeOut')
		end
	end
end
function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
    return string.format('%02x%02x%02x', math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end