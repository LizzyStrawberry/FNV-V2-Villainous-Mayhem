function onCreate()
	addCharacterToList("Negotiation Aileen", "boyfriend")
	addCharacterToList("Negotiation Marco", "boyfriend")
	
	setGlobalFromScript('scripts/OpeningCards', 'allowIntroCard', false)
	
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
	
	if curBeat == 160 then
		cameraFlash("game", "FFFFFF", 0.7 / playbackRate, false)
		callScript("stages/Office", "setScene", {"Seer"})
	end
	if curBeat == 259 then
		cameraFlash("game", "FFFFFF", 0.7 / playbackRate, false)
		callScript("stages/Office", "setScene", {"Cross"})
	end
end