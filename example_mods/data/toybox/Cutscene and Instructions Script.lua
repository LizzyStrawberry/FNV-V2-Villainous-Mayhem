local allowCountdown = false
local confirmed = 0

function onStartCountdown() -- for dialogue
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not isMayhemMode and not allowCountdown and isStoryMode and not seenCutscene then
		startVideo('Week3_Song2Cutscene');
		seenCutscene = true
		return Function_Stop;
	end
	if mechanics and difficulty >= 0 then
		if not allowCountdown then
			doTweenAlpha('warningimage', 'Warning', 1, 1, 'cubeInOut');
			doTweenAlpha('warningTXT', 'WarningTXT', 1, 1, 'cubeInOut');
			return Function_Stop;
		end
		if allowCountdown then
			cancelTimer('textgoBye')
			cancelTimer('textgoHi')
			runTimer('removeEverything', 1)
			return Function_Continue
		end
	end
end

function onCreate()
	if mechanics then
		if not isMayhemMode then
			makeLuaSprite('Warning', 'instructions/Inst-Narrin', 0, 0)
		else
			makeLuaSprite('Warning', 'instructions/Inst-NarrinMayhem', 0, 0)
		end
		setObjectCamera('Warning', 'other')
		setProperty('Warning.alpha', 0)
		scaleObject('Warning', 0.67, 0.67)
		addLuaSprite('Warning')
		
		runTimer('textgohi', 1)
		
		makeLuaText('WarningTXT', 'PRESS Y TO START!', 900, 0, 650)
		setTextAlignment('WarningTXT', 'LEFT')
		setTextSize('WarningTXT', 40)
		setProperty('WarningTXT.alpha', 0)
		setObjectCamera('WarningTXT', 'other')
		addLuaText('WarningTXT')
	end
end

function onUpdate()
	if mechanics then
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Y') and confirmed == 0 then
			allowCountdown = true
			startCountdown();
			doTweenAlpha('nomorewarningimage', 'Warning', 0, 1, 'sineOut');
			doTweenAlpha('nomorewarningTXT', 'WarningTXT', 0, 1, 'sineOut');
			playSound('confirmMenu');
			confirmed = 1
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'textgohi' then
		runTimer('textgoBye', 1)
		doTweenAlpha('warningTXTbye', 'WarningTXT', 0, 0.6, 'sineOut');
	end
	if tag == 'textgoBye' then
		runTimer('textgohi', 1)
		doTweenAlpha('warningTXThi', 'WarningTXT', 1, 0.6, 'sineOut');
	end
	if tag == 'removeEverything' then
		removeLuaSprite('Warning', true)
		removeLuaText('WarningTXT', true)
	end
end