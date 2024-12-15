local allowCountdown = false
local playDialogueAfterVideo = false

function onStartCountdown() -- for dialogue
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
		if isStoryMode and not allowCountdown and not seenCutscene then
			startVideo('Week2_Song1Cutscene');
			allowCountdown = true;
			playDialogueAfterVideo = true;
			return Function_Stop;
		elseif isStoryMode and playDialogueAfterVideo then
			setProperty('inCutscene', true);
			runTimer('startDialogue', 0.8);
			playDialogueAfterVideo = false;
			return Function_Stop;
		end
		return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', '');
	end
end

-- Basic Psych Engine knowledge lmao