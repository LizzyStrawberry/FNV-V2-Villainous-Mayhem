local playedOnce = false
local maxSounds = 3

function onGameOver()
	if not playedOnce then
		local soundPath = "voiceLines/marco/getRekt-"..getRandomInt(1, maxSounds)
		playSound(soundPath, 1, 'deathVoiceLine')
		playedOnce = true
	end
	return Function_Continue
end

function onGameOverConfirm(retry)
	if keyJustPressed("back") then stopSound('deathVoiceLine') end
end