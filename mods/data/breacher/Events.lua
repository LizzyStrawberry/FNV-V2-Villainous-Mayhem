function onCreate()
	makeLuaSprite('whiteBG', '', 0, 0)
	makeGraphic('whiteBG', screenWidth, screenHeight, 'FFFFFF')
	setScrollFactor('whiteBG', 0, 0)
	setObjectCamera('whiteBG', 'other')
	setProperty('whiteBG.alpha', 0)
	addLuaSprite('whiteBG', false)
	
	makeLuaText('tip', "Your notes are here!", 1000, -180, 170)
	if downscroll then
		setProperty('tip.y', 520)
	end
	setTextSize('tip', 34)
	setProperty('tip.alpha', 0)
	addLuaText('tip')
	
	setProperty('camGame.alpha', 0)
	setProperty('gf.alpha', 0)
end

function onSongStart()
	doTweenZoom('camGame', 'camGame', 1.0, 11.79 / playbackRate, 'easeInOut')
	doTweenAlpha('camGame', 'camGame', 1, 9.79 / playbackRate, 'easeInOut')
	doTweenAlpha('tipAlpha', 'tip', 1, 0.7 / playbackRate, 'easeInOut')
	runTimer('tipOut', 2.5 / playbackRate)
end

function onUpdate()
	if curBeat == 32 then
		cameraFlash('camGame', 'FFFFFF', 0.6 / playbackRate, false)
		setProperty('defaultCamZoom', 1.3)
		setProperty('camZooming', true)
	end
	if curBeat == 80 or curBeat == 308 then
		setProperty('defaultCamZoom', 0.7)
	end
	if curBeat == 176 then
		setProperty('camGame.alpha', 0)
		doTweenAlpha('camGame', 'camGame', 1, 0.8, 'quartOut')
		setProperty('defaultCamZoom', 1.3)
	end
	if curBeat == 208 then
		setProperty('defaultCamZoom', 0.9)
	end
	if curBeat == 272 then
		setProperty('defaultCamZoom', 1.3)
	end
	if curBeat == 292 then
		setProperty('defaultCamZoom', 1.3)
	end
	if curBeat == 298 then
		setProperty('defaultCamZoom', 0.6)
		setProperty('camZooming', false)
	end
	if curBeat == 300 then
		doTweenZoom('camGame', 'camGame', 1.3, 0.7 / playbackRate, 'bounceInOut')
	end
	if curBeat == 302 then
		setProperty('camZooming', true)
		cameraFlash('camGame', 'FFFFFF', 1.6 / playbackRate, false)
		setProperty('gf.alpha', 1)
		cameraShake('camGame', 0.015, 1.2 / playbackRate)
		cameraShake('camHUD', 0.02, 1.2 / playbackRate)
		setProperty('defaultCamZoom', 1.3)
	end
	if curBeat == 500 then
		cameraFlash('camGame', 'FFFFFF', 1.6 / playbackRate, false)
	end
	if curBeat == 530 then
		doTweenAlpha('whiteBG', 'whiteBG', 1, 0.7 / playbackRate, 'quartInOut')
		runTimer('CRTOut', 0.5 / playbackRate)
	end
end

function onBeatHit()
	if (curBeat >= 80 and curBeat <= 112) or (curBeat >= 371 and curBeat <= 371) then
		triggerEvent('Add Camera Zoom', 0.02, 0.015)
	end
	if (curBeat >= 144 and curBeat <= 176) or (curBeat >= 308 and curBeat < 371) or (curBeat >= 404 and curBeat < 500) then
		triggerEvent('Add Camera Zoom', 0.04, 0.035)
	end
	if curBeat == 500 then
		triggerEvent('Add Camera Zoom', 0.06, 0.055)
	end
end

function onTimerCompleted(tag)
	if tag == 'CRTOut' then
		setProperty('camGame.alpha', 0)
		setProperty('camHUD.alpha', 0)
		doTweenY('whiteBGScaleYOut', 'whiteBG.scale', 0.02, 0.6 / playbackRate, 'quartIn')
	end
	if tag == 'tipOut' then
		doTweenAlpha('tipAlpha', 'tip', 0, 0.7 / playbackRate, 'easeInOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'whiteBGScaleYOut' then
		doTweenX('whiteBGScaleXOut', 'whiteBG.scale', 0.02, 0.16 / playbackRate, 'quartOut')
		doTweenY('whiteBGScaleYOut2', 'whiteBG.scale', 0.8, 0.165 / playbackRate, 'quartOut')
	end
	if tag == 'whiteBGScaleYOut2' then
		doTweenX('whiteBGScaleXOut', 'whiteBG.scale', 0.9, 0.16 / playbackRate, 'quartOut')
		doTweenY('whiteBGScaleYOut3', 'whiteBG.scale', 0, 0.175 / playbackRate, 'quartOut')
	end
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
	if not isMayhemMode and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
		if getProperty('health') > 0.2 then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				if difficulty == 1 then
					setProperty('health', health- 0.008);
				else
					setProperty('health', health- 0.006);
				end
			else
				if difficulty == 1 then
					setProperty('health', health- 0.016);
				else
					setProperty('health', health- 0.012);
				end
			end
		end
	end
end