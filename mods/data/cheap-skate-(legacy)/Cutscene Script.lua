local allowCountdown = false

function onStartCountdown() -- for dialogue
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		startVideo('WeekLegacy_Song1Cutscene');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end