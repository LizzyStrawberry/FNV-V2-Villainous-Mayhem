local hudStuff = {'iconP1', 'iconP2', 'healthBar', 'healthBarBG', 'scoreTxt'}
local noteNum = 4
local dialogueText = "HA"

function onCreate()
	addCharacterToList('AsulP2', 'dad')
	addCharacterToList('AsulP3', 'dad')
	
	makeLuaSprite('blackBG', '', -800, -600)
	makeGraphic('blackBG', 5000, 5000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setProperty('blackBG.alpha', 0)
	setObjectCamera('blackBG', 'game')
	addLuaSprite('blackBG', true)
	
	makeLuaText('dialogue', "TEST", 2000, -370, 520)
	setTextSize('dialogue', 22)
	setProperty('dialogue.alpha', 0)
	setObjectCamera('dialogue', 'other')
	addLuaText('dialogue')
end

function onUpdate()
	if curBeat == 94 then
		setProperty('camGame.zoom', 1.0)
	end
	
	if curBeat == 95 then
		setProperty('camGame.zoom', 1.3)
	end
	
	if curBeat == 96 then
		setProperty('camGame.zoom', 1.6)
		doTweenAlpha('blackBG', 'blackBG', 1, 0.3 / playbackRate, 'circOut')
		triggerEvent('Change Scroll Speed', '1.3', '0.4')
		
		doTweenAlpha('camHUD', 'camHUD', 0, 0.7 / playbackRate, 'circOut')
		
		setTextString('dialogue', "I-I don't actually want to do this..")
		setProperty('dialogue.alpha', 1)
	end

	if curBeat == 100 then
		setTextString('dialogue', "But you've left me with no choice!")
	end
	
	if curBeat == 102 then
		doTweenAlpha('dialogue', 'dialogue', 0, 0.7 / playbackRate, 'cubeInOut')
	end

	if curBeat == 104 then
		removeLuaSprite('BGP1', true)
		setProperty('BGP2Back.alpha', 1)
		setProperty('fuckyouhaveanotherbridge.alpha', 1)
		setProperty('BGP2.alpha', 1)
		setProperty('fuckinPillars.alpha', 1)
		setProperty('defaultCamZoom', 0.7)
		
		triggerEvent('Change Character', 'dad', 'AsulP2')
	
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		setProperty('blackBG.alpha', 0)
		setProperty('camHUD.alpha', 1)
		
		setProperty('dad.y', 380)
	end
	
	if curBeat == 138 then
		setProperty('defaultCamZoom', 0.35)
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		doTweenY('BGP2BackY', 'BGP2Back.scale', 3, 0.3 / playbackRate, 'circOut')
		doTweenX('BGP2BackX', 'BGP2Back.scale', 3, 0.3 / playbackRate, 'circOut')
	end
	
	if curBeat == 200 then
		triggerEvent('Change Scroll Speed', '1', '0.2')
		setProperty('defaultCamZoom', 0.7)
		doTweenY('BGP2BackY', 'BGP2Back.scale', 1.7, 0.3 / playbackRate, 'circOut')
		doTweenX('BGP2BackX', 'BGP2Back.scale', 1.7, 0.3 / playbackRate, 'circOut')
	end
	
	if curBeat == 263 then
		triggerEvent('Change Scroll Speed', '1.3', '0.2')
	end
	
	if curBeat == 264 then
		setProperty('defaultCamZoom', 0.5)
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		doTweenY('BGP2BackY', 'BGP2Back.scale', 2, 0.3 / playbackRate, 'circOut')
		doTweenX('BGP2BackX', 'BGP2Back.scale', 2, 0.3 / playbackRate, 'circOut')
	end
	
	if curBeat == 296 then
		setProperty('defaultCamZoom', 0.7)
		doTweenY('BGP2BackY', 'BGP2Back.scale', 1.7, 0.3 / playbackRate, 'circOut')
		doTweenX('BGP2BackX', 'BGP2Back.scale', 1.7, 0.3 / playbackRate, 'circOut')
		
		setTextString('dialogue', 'YOU LIKE KIANA?')
		setProperty('dialogue.alpha', 1)
		
		noteTweenX('note1', 4, 290, 0.5 / playbackRate, 'expoOut')
	end
	
	if curBeat == 292 then
		for i = 0, 3 do
			noteTweenAlpha('noteAlpha'..i, i, 0, 0.9 / playbackRate, 'circOut')
		end
		for i = 1, #(hudStuff) do
			doTweenAlpha(hudStuff[i], hudStuff[i], 0, 0.9 / playbackRate, 'circOut')
		end
	end
	if curBeat == 297 then
		noteTweenX('note2', 5, 410, 0.5, 'expoOut')
	end
	if curBeat == 298 then
		noteTweenX('note3', 6, 760, 0.5, 'expoOut')
	end
	if curBeat == 299 then
		noteTweenX('note1', 7, 890, 0.5, 'expoOut')
		
		setTextString('dialogue', "I'LL SHOW YOU KIANA!")
	end
	if curStep == 1200 then
		for i = 4, 7 do
			noteTweenScaleX('noteX'..i, i, 1.2, 0.01 / playbackRate, 'circOut')
			noteTweenScaleY('noteY'..i, i, 1.2, 0.01 / playbackRate, 'circOut')
		end
	end
	
	if curBeat == 304 then
		triggerEvent('Change Scroll Speed', '1.5', '0.2')
	end
	
	if curBeat == 308 then
		removeLuaSprite('BGP2Back', true)
		removeLuaSprite('fuckyouhaveanotherbridge', true)
		removeLuaText('dialogue', true)
		setProperty('BGP3.alpha', 1)

		scaleObject('BGP2', 1.05, 1.6)
		setProperty('BGP2.x', -750)
		setProperty('BGP2.y', -220)
		
		setProperty('defaultCamZoom', 0.7)
		setProperty('boyfriend.visible', false)
		
		triggerEvent('Change Character', 'dad', 'AsulP3')
	
		cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		
		setProperty('dad.y', 380)
		
		for i = 1, #(hudStuff) do
			setProperty(hudStuff[i]..'.alpha', 1)
		end
	end
	
	if curBeat == 472 then
		setProperty('blackBG.alpha', 1)
	end
end

local randomHA = {'HA', 'HAAHAHAHA', 'HAHAHAH', 'HAHA', 'HAHAHAHA'}
function opponentNoteHit()
	if curBeat >= 303 and curBeat < 308 then
		setTextString('dialogue', dialogueText..randomHA[getRandomInt(1, #(randomHA))])
		dialogueText = getTextString('dialogue')
		
		setTextSize('dialogue', getTextSize('dialogue') + getRandomInt(1, 10))
	end
	
	health = getProperty('health')
	if not isMayhemMode then
		if getProperty('health') > 0.2 and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.007);
			else
				setProperty('health', health- 0.014);
			end
		end
	end
end

function onStepHit()
	if curBeat >= 104 and curBeat < 138 then
		if curStep % 64 == 32 or curStep % 64 == 34 or curStep % 64 == 48 or curStep % 64 == 50 or curStep % 64 == 0 or curStep % 64 == 2 then
			triggerEvent('Add Camera Zoom', '0.08', '0.08')
		end
		if curStep % 64 >= 16 and curStep % 64 < 31 then
			if curStep % 4 == 0 then
				triggerEvent('Add Camera Zoom', '0.1', '0.1')
			end
		end
	end
	
	if curBeat >= 138 and curBeat < 200 then
		if curStep % 2 == 0 then
			triggerEvent('Add Camera Zoom', '0.04', '0.04')
		end
	end
	
	if curBeat >= 200 and curBeat < 264 then
		if curStep % 8 == 0 then
			triggerEvent('Add Camera Zoom', '0.02', '0.02')
		end
	end
	
	if curBeat >= 296 and curBeat < 301 then
		if curStep % 4 == 0 then
			triggerEvent('Add Camera Zoom', '0.08', '0.08')
		end
	end
	
	if curBeat >= 308 and curBeat <= 436 then
		if curStep % 2 == 0 then
			triggerEvent('Add Camera Zoom', '0.05', '0.07')
			noteTweenScaleX('noteX'..noteNum, noteNum, 1.2, 0.01 / playbackRate, 'circOut')
			noteTweenScaleY('noteY'..noteNum, noteNum, 1.2, 0.01 / playbackRate, 'circOut')
			
			noteNum = noteNum + 1
			
			if noteNum > 7 then
				noteNum = 4
			end
		end
	end
	
	if curBeat >= 264 and curBeat < 296 then
		if curStep % 64 == 32 or curStep % 64 == 33 or curStep % 64 == 48 or curStep % 64 == 49 or curStep % 64 == 0 or curStep % 64 == 1 then
			triggerEvent('Add Camera Zoom', '0.08', '0.08')
		end
		if curStep % 64 >= 16 and curStep % 64 < 31 then
			if curStep % 4 == 0 then
				triggerEvent('Add Camera Zoom', '0.1', '0.1')
			end
		end
	end
end

function onTweenCompleted(tag)
	for i = 4, 7 do
		if tag == 'noteX'..i then
			noteTweenScaleX('noteXFix'..i, i, 0.7, 0.7 / playbackRate, 'circOut')
		end
		if tag == 'noteY'..i then
			noteTweenScaleY('noteYFix'..i, i, 0.7, 0.7 / playbackRate, 'circOut')
		end
	end
end