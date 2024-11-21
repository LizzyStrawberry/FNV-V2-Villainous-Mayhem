local allowCountdown = false
local confirmed = 0

function onStartCountdown() -- for dialogue
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if mechanics then
		if not allowCountdown then
			doTweenAlpha('warningimage', 'Warning', 1, 1 / playbackRate, 'cubeInOut');
			return Function_Stop;
		end
		if allowCountdown then
			cancelAllTweens()
			runTimer('removeEverything', 1)
			return Function_Continue
		end
	end
end

function onCreate()
	if mechanics then
		makeLuaSprite('Warning', 'instructions/Inst-Marcx', 0, 0)
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
			doTweenAlpha('nomorewarningimage', 'Warning', 0, 1 / playbackRate, 'sineOut');
			doTweenAlpha('nomorewarningTXT', 'WarningTXT', 0, 1 / playbackRate, 'sineOut');
			playSound('confirmMenu');
			confirmed = 1
		end
	end
end

function cancelAllTweens()
	cancelTween('warningimage')

	cancelTween('warningTXTbye')
	cancelTween('warningTXThi')
	
	cancelTimer('textgoBye')
	cancelTimer('textgohi')
end

function onTimerCompleted(tag)
	if tag == 'textgohi' then
		runTimer('textgoBye', 1)
		doTweenAlpha('warningTXTbye', 'WarningTXT', 0, 0.6 / playbackRate, 'sineOut');
	end
	if tag == 'textgoBye' then
		runTimer('textgohi', 1)
		doTweenAlpha('warningTXThi', 'WarningTXT', 1, 0.6 / playbackRate, 'sineOut');
	end
	if tag == 'removeEverything' then
		removeLuaSprite('Warning', true)
		removeLuaText('WarningTXT', true)
	end
end