local allowCountdown = false

function onCreate()
	setGlobalFromScript("scripts/Cutscene and Instructions Handler", "enabled", false)
end

function onStartCountdown() -- for dialogue
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not isMayhemMode and not allowCountdown and not seenCutscene then
		setProperty('inCutscene', true)
		runTimer('startDialogue', 0.8)

		allowCountdown = true

		setPropertyFromClass("PlayState", "seenCutscene", true)
		return Function_Stop
	end
	return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('TCMarcoDialogue', string.lower(getPropertyFromClass('ClientPrefs', 'pauseMusic')))
	end
end