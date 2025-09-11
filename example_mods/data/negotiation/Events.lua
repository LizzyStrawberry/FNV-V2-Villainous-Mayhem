function onCreate()
	addCharacterToList("Negotiation Aileen", "boyfriend")
	addCharacterToList("Negotiation Marco", "boyfriend")
	
	setGlobalFromScript('scripts/OpeningCards', 'allowIntroCard', false)
	
	makeLuaSprite('screamMeme', 'effects/babyScream', 0, 1000)
	setObjectCamera('screamMeme', 'hud')
	setScrollFactor('screamMeme', 0, 0)
	scaleObject("screamMeme", 0.5, 0.5)
	screenCenter("screamMeme", "X")
	setProperty("screamMeme.angle", -75)
	addLuaSprite('screamMeme', false)
	
	makeLuaSprite('blackBG', '', -500, -500)
	makeGraphic('blackBG', 1280, 720, '000000')
	setScrollFactor('blackBG', 0, 0)
	scaleObject("blackBG", 3, 3)
	setObjectCamera('blackBG', 'game')
	addLuaSprite('blackBG', true)
	
	setProperty("camHUD.alpha", 0)
end

function onCreatePost()
	setProperty("gf.x", getProperty("dad.x") + 275)
	setProperty("gf.y", getProperty("dad.y"))
	
	if not optimizationMode then
		for note = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', note, 'mustPress') and getPropertyFromGroup('unspawnNotes', note, 'strumTime') >= 64000 and getPropertyFromGroup('unspawnNotes', note, 'strumTime') <= 115000 then
				setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/AileenNOTE_assets');
			end
		end
	end
end

function onCountdownTick(counter)
	if getProperty("countdownSelected") == 0 then -- Default Psych Engine
		if counter == 1 then
			setObjectCamera("countdownReady", "other")
		elseif counter == 2 then
			setObjectCamera("countdownSet", "other")
		elseif counter == 3 then
			setObjectCamera("countdownGo", "other")
		end
	elseif getProperty("countdownSelected") == 1 then -- Custom "Normal"
		if counter == 0 then
			setObjectCamera("countdownReady", "other")
		elseif counter == 1 then
			setObjectCamera("countdownSet", "other")
		elseif counter == 2 then
			setObjectCamera("countdownGo", "other")
		end
	elseif getProperty("countdownSelected") == 2 then -- Custom Cuphead Style
		setObjectCamera("countdownReady", "other")
	end
end

function onSongStart()
	doTweenAlpha("blackBGRemove", "blackBG", 0, 10 / playbackRate, "quirtInOut")
	doTweenAlpha("hudFadeIn", "camHUD", 1, 5 / playbackRate, "quirtInOut")
end

function onBeatHit()
	if curBeat == 32 then
		cameraFlash("game", "FFFFFF", 0.7 / playbackRate, false)
		callScript("scripts/OpeningCards", "setUpCard", false)
		setGlobalFromScript('scripts/OpeningCards', 'allowIntroCard', true)
	end
	if curBeat == 159 then
		doTweenY("babyAppear", "screamMeme", 200, 0.3 / playbackRate, "circOut")
		doTweenAngle("babySpin", "screamMeme", 0, 0.4 / playbackRate, "circOut")
	end
	if curBeat == 160 then
		doTweenX("babyResizeX", "screamMeme.scale", 5, 0.5 / playbackRate, "circOut")
		doTweenY("babyResizeY", "screamMeme.scale", 5, 0.5 / playbackRate, "circOut")
		doTweenAlpha("babyGoBye", "screamMeme", 0, 1.5 / playbackRate, "sineOut")
		
		callScript("stages/Office", "setScene", {"Seer"})
	end
	if curBeat == 288 then
		cameraFlash("game", "FFFFFF", 0.7 / playbackRate, false)
		callScript("stages/Office", "setScene", {"Cross"})
	end
	if curBeat == 368 then
		doTweenAlpha("blackBGAdd", "blackBG", 1, 6 / playbackRate, "quirtInOut")
	end
	if curBeat == 384 then
		doTweenAlpha("hudFadeOut", "camHUD", 0, 1.5 / playbackRate, "circOut")
	end
	
	if (curBeat >= 32 and curBeat < 96) or (curBeat >= 288 and curBeat <= 352) then
		if curBeat % 2 == 0 then
			triggerEvent("Add Camera Zoom", "0.045", "0.047")
		end
		if curBeat % 8 == 2 then
			for i = 0, 7 do
				noteTweenAngle("NoteAngle"..i, i, 360, (0.75 + (i * 0.04)) / playbackRate, "circOut")
			end
		end
		if curBeat % 8 == 6 then
			for i = 0, 7 do
				noteTweenAngle("NoteAngle"..i, i, 0, (0.75 + (i * 0.04)) / playbackRate, "circOut")
			end
		end
	end
	if curBeat == 161 then
		for i = 0, 7 do
			setPropertyFromGroup("strumLineNotes", i, "angle", 360)
		end
	end
	if curBeat == 288 then
		for i = 0, 7 do
			setPropertyFromGroup("strumLineNotes", i, "angle", 0)
		end
	end
	if curBeat >= 192 and curBeat < 224 then
		if curBeat % 2 == 0 then
			triggerEvent("Add Camera Zoom", "0.045", "0.047")
		end
		if curBeat % 8 == 2 then
			for i = 0, 7 do
				noteTweenAngle("NoteAngle"..i, i, 0, (0.75 + (i * 0.04)) / playbackRate, "circOut")
			end
		end
		if curBeat % 8 == 6 then
			for i = 0, 7 do
				noteTweenAngle("NoteAngle"..i, i, 360, (0.75 + (i * 0.04)) / playbackRate, "circOut")
			end
		end
	end
	if curBeat >= 96 and curBeat < 160 then
		triggerEvent("Add Camera Zoom", "0.04", "0.042")
		if curBeat % 2 == 1 then
			noteSpinSequence("normal")
		end
	end
	if curBeat >= 224 and curBeat < 288 then
		triggerEvent("Add Camera Zoom", "0.04", "0.042")
		if curBeat % 2 == 1 then
			noteSpinSequence("reverse")
		end
	end
end

local sequence = {0, 7, 1, 6, 2, 5, 3, 4}
local spinNum = 0
function noteSpinSequence(direction)
	if direction == "normal" then
		sequence = {0, 7, 1, 6, 2, 5, 3, 4}
	elseif direction == "reverse" then
		sequence = {7, 0, 6, 1, 5, 2, 4, 3}
	end
	
	if spinNum % 2 == 0 then
		setPropertyFromGroup("strumLineNotes", sequence[spinNum + 1], "angle", 0)
		noteTweenAngle("NoteSequence"..spinNum, sequence[spinNum + 1], 360, 0.5 / playbackRate, "circOut")
	else
		setPropertyFromGroup("strumLineNotes", sequence[spinNum + 1], "angle", 360)
		noteTweenAngle("NoteSequence"..spinNum, sequence[spinNum + 1], 0, 0.5 / playbackRate, "circOut")
	end
	
	spinNum = spinNum + 1
	if spinNum > 7 then
		spinNum = 0
	end
end