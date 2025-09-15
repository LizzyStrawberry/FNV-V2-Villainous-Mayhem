local headLeftOriginY1
local headLeftOriginY1
local headRightOriginY1
local headRightOriginY2
local clonesOriginScaleY

local gfX
local dadX

local glitchText = {'??????', 'ERR0R', 'D3BUG', '!*&%^(', '?!?!#&$', '??<:"{|}?', '!@#$%&^((&!^', 'BUGDEB', 'KAIZOKU', '?>_+!#@(', 'X',
					'?!@#%&$(!!^*(!@)^', 'XXXXXXXXX', 'BUGGED', 'D0NT D13', 'MARAUDER', '!)@(#&&$X13U0X'}
local curNum

function onCreate()
	setProperty('gf.visible', false)
	
	headLeftOriginY1 = getProperty('headLeft.y')
	headLeftOriginY2 = getProperty('headLeft2.y')
	headRightOriginY1 = getProperty('headRight.y')
	headRightOriginY2 = getProperty('headRight2.y')
	clonesOriginScaleY = getProperty('clones.scale.y')
	
	setProperty('headLeft.alpha', 0)
	setProperty('headLeft2.alpha', 0)
	setProperty('headRight.alpha', 0)
	setProperty('headRight2.alpha', 0)
	setProperty('clones.alpha', 0)
	
	setProperty('boyfriend.alpha', 0)
	setProperty('dad.alpha', 0)
	
	gfX = getProperty('boyfriend.x')
	dadX = getProperty('dad.x')
	setProperty('boyfriend.x', gfX - 300)
	setProperty('dad.x', dadX + 400)
	
	curNum = getRandomInt(1, 5)
end

function onCreatePost()
	cameraHudY = getProperty('camHUD.y')

	setProperty('iconP1.alpha', 0)
	setProperty('iconP2.alpha', 0)
	setProperty('healthBar.alpha', 0)
	setProperty('healthBarBG.alpha', 0)
	
	addHaxeLibrary("Application", "lime.app")
	addHaxeLibrary('Lib', 'openfl')
end

local allowTween = false
function onSongStart()
	doTweenZoom('beginZoom', 'camGame', 1.3 * zoomMult, 11 / playbackRate, 'quadIn')
    runHaxeCode([[
        game.songLength = (55 * 1000);
    ]])
	
	allowTween = true
end

function onUpdate()
	if curBeat == 32 then
		doTweenAlpha('dadReveal', 'dad', 1, 1.4 / playbackRate, 'quadIn')
		doTweenAlpha('showUp', 'headLeft', 1, 1.4 / playbackRate, 'cubeInOut')
	end
	if curBeat == 64 then
		doTweenAlpha('showUp', 'headLeft2', 1, 1.4 / playbackRate, 'cubeInOut')
	end
	if curBeat == 94 then
		doTweenAlpha('dadRevealOff', 'dad', 0, 0.6 / playbackRate, 'quadIn')
	end
	if curBeat == 96 then
		doTweenAlpha('gfReveal', 'boyfriend', 1, 1.4 / playbackRate, 'quadIn')
		doTweenAlpha('showUp', 'headRight', 1, 1.4 / playbackRate, 'cubeInOut')
		
		doTweenZoom('beginZoomAgain', 'camGame', 0.8, 20 / playbackRate, 'quadIn')
	end
	if curBeat == 128 then
		doTweenAlpha('showUp', 'headRight2', 1, 1.4 / playbackRate, 'cubeInOut')
	end
	if curBeat == 156 then
		setProperty('defaultCamZoom', 1.6 * zoomMult)
	end
	if curBeat == 159 then
		doTweenAlpha('showUp', 'clones', 1, 2 / playbackRate, 'cubeInOut')
		doTweenX('timeBarBGScale', 'timeBarBG.scale', 5, 0.7 / playbackRate, 'cubeInOut')
		doTweenX('timeBarScale', 'timeBar.scale', 5, 0.7 / playbackRate, 'cubeInOut')
	end
	if curBeat == 160 then
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
		setProperty('defaultCamZoom', 0.8 * zoomMult)
		
		doTweenAlpha('dadReveal', 'dad', 1, 0.4 / playbackRate, 'circOut')
		doTweenX('dadMove', 'dad', dadX, 0.7 / playbackRate, 'circOut')
		doTweenX('GFMove', 'boyfriend', gfX, 1.4 / playbackRate, 'circOut')
		
		if getPropertyFromClass('ClientPrefs', 'trampolineMode') then
			doTweenX('trampoline', 'trampoline', gfX, 0.7 / playbackRate, 'circOut')		
		end
		
		doTweenAlpha('healthBar', 'healthBar', 1, 1.4 / playbackRate, 'circOut')
		doTweenAlpha('healthBarBG', 'healthBarBG', 1, 1.4 / playbackRate, 'circOut')
		for i = 1, 2 do
			doTweenAlpha('iconP'..i..'alpha', 'iconP'..i, 1, 1.4 / playbackRate, 'circOut')
		end
	end
	if curBeat == 224 then
		if shadersEnabled == true then
			doTweenAlpha('hello', 'moreClones', 1, 20 / playbackRate, 'easeInOut')
		end
		setProperty('camGame.alpha', 0)
		setProperty('defaultCamZoom', 1.2 * zoomMult)
	end
	if curBeat == 226 then
		doTweenAlpha('camGame', 'camGame', 1, 0.7 / playbackRate, 'easeInOut')
	end
	if curBeat == 352 then
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
		setProperty('defaultCamZoom', 0.8 * zoomMult)
	end
	if curBeat == 384 then
		setProperty('defaultCamZoom', 1.0 * zoomMult)
	end
	if curBeat == 385 then
		setProperty('defaultCamZoom', 1.2 * zoomMult)
	end
	if curBeat == 386 then
		setProperty('defaultCamZoom', 1.4 * zoomMult)
	end
	if curBeat == 387 then
		setProperty('defaultCamZoom', 1.6 * zoomMult)
	end
	if curBeat == 388 then
		cameraFlash('game', 'FFFFFF', 0.8 / playbackRate, false)
		setProperty('defaultCamZoom', 0.8 * zoomMult)
	end
end

local change = false
function onUpdatePost()
	if curBeat >= 160 then
		setTextString('timeTxt', glitchText[curNum])
		
		if curStep % 2 == 0 then
			curNum = getRandomInt(1, #(glitchText))
			change = false
		end
		if curBeat % 4 == 0 then
			change = true
		end
	end
end

function onBeatHit()
	if shadersEnabled then
		if curBeat % 4 == 0 then
			if curBeat > 352 and curBeat < 480 then
				doTweenY('moreClonesMoveY', 'moreClones', -340, 0.7 / playbackRate, 'quadInOut')
			end
			setProperty('moreClones.x', -900)
			doTweenX('moreClonesMove', 'moreClones', -1800, 1.71 / playbackRate, 'linear')
			
			if curBeat >= 160 and curBeat <= 480 then
				triggerEvent('Add Camera Zoom', '0.060', '0.025')
			end
		end
		if curBeat % 4 == 2 then
			if curBeat >= 352 and curBeat < 480 then
				doTweenY('moreClonesMoveY', 'moreClones', -170, 0.7 / playbackRate, 'quadInOut')
			end
		end
		if (curBeat >= 160 and curBeat < 224) or (curBeat >= 352 and curBeat < 480) then
			if curBeat % 1 == 0 then
				setProperty('camHUD.y', cameraHudY + 28)
				doTweenY('canHud', 'camHUD', cameraHudY, 0.4 / playbackRate, 'circOut')
			end
		end
	end
end

function onStepHit()
	if curStep % 4 == 0 then
		setProperty('headLeft.y', headLeftOriginY1 + 20)
		setProperty('headLeft2.y', headLeftOriginY2 + 20)
		setProperty('headRight.y', headRightOriginY1 + 20)
		setProperty('headRight2.y', headRightOriginY2 + 20)
		setProperty('clones.scale.y', clonesOriginScaleY - 0.08)
		
		doTweenY('headLeft1Bop', 'headLeft', headLeftOriginY1, 0.26 / playbackRate, 'sineOut')
		doTweenY('headLeft2Bop', 'headLeft2', headLeftOriginY2, 0.26 / playbackRate, 'sineOut')
		doTweenY('headRight1Bop', 'headRight', headRightOriginY1, 0.26 / playbackRate, 'sineOut')
		doTweenY('headRight2Bop', 'headRight2', headRightOriginY2, 0.26 / playbackRate, 'sineOut')
		doTweenY('clonesBop', 'clones.scale', clonesOriginScaleY, 0.26 / playbackRate, 'sineOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'beginZoom' then
		setProperty('defaultCamZoom', 1.3 * zoomMult)
	end
	if tag == 'beginZoomAgain' then
		setProperty('defaultCamZoom', 0.8 * zoomMult)
	end
end