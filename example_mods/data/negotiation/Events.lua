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

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
	if not isMayhemMode and difficulty == 1 and mechanics and not getPropertyFromClass('ClientPrefs', 'buff3Active') then
		if getProperty('health') > 0.2 then
			if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
				setProperty('health', health- 0.006);
			else
				setProperty('health', health- 0.012);
			end
		end
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
	
	if (curBeat >= 32 and curBeat < 96) or (curBeat >= 192 and curBeat < 224)
	or (curBeat >= 288 and curBeat <= 352) then
		if curBeat % 2 == 0 then
			triggerEvent("Add Camera Zoom", "0.045", "0.047")
		end
		if curBeat % 4 == 2 then
			for i = 0, 7 do
				noteTweenAngle("NoteAngle"..i, i, 360, (0.5 + (i * 0.04)) / playbackRate, "circOut")
			end
		end
	end
	if (curBeat >= 96 and curBeat < 160) or (curBeat >= 224 and curBeat < 288) then
		triggerEvent("Add Camera Zoom", "0.04", "0.042")
	end
end

function onTweenCompleted(tag)
	for i = 0, 7 do
		if tag == "NoteAngle"..i then
			setPropertyFromGroup("strumLineNotes", i, "angle", 0)
		end
	end
end