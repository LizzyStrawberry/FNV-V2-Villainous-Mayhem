local allowCountdown = false
local confirmed = 0
local playDialogueVideo = false
local allowMechanics = false

function onStartCountdown() -- for dialogue
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if isStoryMode and not playDialogueVideo and not allowCountdown and not seenCutscene then
		startVideo('Week1_Song1Cutscene');
		seenCutscene = true
		playDialogueVideo = true;
		return Function_Stop;
	elseif playDialogueVideo then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		playDialogueVideo = false;
		return Function_Stop;
	else
		allowMechanics = true
		runTimer('textgohi', 0.01)
	end
	
	if allowMechanics and mechanics and ((isStoryMode and difficulty >= 1) or (not isStoryMode and difficulty >= 0)) then
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
	if isStoryMode then
		precacheSound('Week1_TrueEnd')
	end
	
	if mechanics and ((isStoryMode and difficulty >= 1) or (not isStoryMode and difficulty >= 0)) then
		makeLuaSprite('Warning', 'instructions/Inst-MarcoSpeed', 0, 0)
		setObjectCamera('Warning', 'other')
		setProperty('Warning.alpha', 0)
		scaleObject('Warning', 0.67, 0.67)
		addLuaSprite('Warning')
		
		makeLuaSprite('bossFight', 'instructions/bossFightWarning', 0, 0)
		setObjectCamera('bossFight', 'other')
		setProperty('bossFight.alpha', 0)
		scaleObject('bossFight', 0.67, 0.67)
		addLuaSprite('bossFight')
		
		makeLuaText('WarningTXT', 'PRESS Y TO START!', 900, 0, 650)
		setTextAlignment('WarningTXT', 'LEFT')
		setTextSize('WarningTXT', 40)
		setProperty('WarningTXT.alpha', 0)
		setObjectCamera('WarningTXT', 'other')
		addLuaText('WarningTXT')
		
		makeLuaText('endingTXT', 'After their final send-off, Girlfriend did a cute peace sign and Marco almost had a mental breakdown.\nBut wait, what is this?\nThe Teleporter suddenly turned on and teleported GF away!\nMarco gets relieved, and lets his assistant Aileen know that this experience was like having a constipation whilst having an acid reflux at the same time.\nJust as he is about to leave, the portal glows again, and in drops a new intruder!\nShe looks like GF but with gold hair and an indigo dress. She seems determined to rap battle Marco, but he is very tired, so he shoots that motherfucker and asks Aileen to clean this mess, in which she obeys.', 1050, 0, 0)
		setTextAlignment('endingTXT', 'CENTER')
		setTextSize('endingTXT', 30)
		screenCenter('endingTXT', 'XY')
		setProperty('endingTXT.alpha', 0)
		setObjectCamera('endingTXT', 'other')
		addLuaText('endingTXT')
	end
end

local endingSequence = 0
local ending = false
function onUpdate()
	if mechanics and allowMechanics and ((isStoryMode and difficulty >= 1) or (not isStoryMode and difficulty >= 0)) then
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Y') and confirmed == 0 then
			allowCountdown = true
			startCountdown();
			doTweenAlpha('nomorewarningimage', 'Warning', 0, 1 / playbackRate, 'sineOut');
			doTweenAlpha('nomoreBossFightWarning', 'bossFight', 0, 1 / playbackRate, 'sineOut');
			doTweenAlpha('nomorewarningTXT', 'WarningTXT', 0, 1 / playbackRate, 'sineOut');
			playSound('confirmMenu');
			confirmed = 1
		end
	end
	if endingSequence == 1 and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') then
		endingSequence = 2;
		setProperty('WarningTXT.alpha', 0)
		setProperty('camHUD.visible', false)
		playSound('Week1_TrueEnd', 1, 'aileenRant')
	end
end

function onEndSong()
	if not ending and isStoryMode then
		ending = true
		doTweenAlpha('goodbyeHud', 'camHUD', 0, 0.6, 'sineOut');
		doTweenAlpha('goodbyeGame', 'camGame', 0, 0.6, 'sineOut');
		doTweenAlpha('helloEnding', 'endingTXT', 1, 1, 'sineOut');
		runTimer('allowEnter', 7)
		return Function_Stop
	end
	return Function_Continue
end

function cancelAllTweens()
	cancelTween('warningimage')
	
	cancelTween('bossFightFlashBye')
	cancelTween('bossFightFlashHello')
	cancelTween('warningTXTbye')
	cancelTween('warningTXThi')
	
	cancelTimer('textgoBye')
	cancelTimer('textgohi')
end

function onSoundFinished(tag)
	if tag == 'aileenRant' then
		endSong();
	end
end

function onTweenCompleted(tag)
	if tag == 'endingTXT' then
		endingSequence = 1
	end
end

function onTimerCompleted(tag)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', '');
	end
	
	if tag == 'textgohi' then
		runTimer('textgoBye', 1)
		doTweenAlpha('warningTXTbye', 'WarningTXT', 0, 0.6 / playbackRate, 'sineOut');
		doTweenAlpha('bossFightFlashBye', 'bossFight', 0, 0.85 / playbackRate, 'sineOut');
	end
	if tag == 'textgoBye' then
		runTimer('textgohi', 1)
		doTweenAlpha('warningTXThi', 'WarningTXT', 1, 0.6, 'sineOut');
		doTweenAlpha('bossFightFlashHello', 'bossFight', 1, 0.85 / playbackRate, 'sineOut');
	end
	if tag == 'removeEverything' then
		removeLuaSprite('Warning', true)
		removeLuaSprite('bossFight', true)
		removeLuaText('WarningTXT', true)
	end
	
	if tag == 'allowEnter' then
		setTextString('WarningTXT', 'Press ENTER to Continue.')
	 	doTweenAlpha('endingTXT', 'WarningTXT', 1, 0.6, 'sineOut');
	end
end