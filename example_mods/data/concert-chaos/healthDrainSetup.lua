local drain
local powerUpActive = false
function onCreate()
	if mechanics then
		setDrain()
		setGlobalFromScript("scripts/HealthDrainModule", "allowDrain", true)
		setGlobalFromScript("scripts/HealthDrainModule", "ntToBlock", "managerSoloNotes, GF Sing")
		setGlobalFromScript("scripts/HealthDrainModule", "drainRate", drain)
	end
end

function onUpdate()
	if mechanics and getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 and not powerUpActive then
		drain = drain / 2
		setGlobalFromScript("scripts/HealthDrainModule", "drainRate", drain)
		powerUpActive = true
	end
end

function onStepHit()
	if curStep == 2400 then
		setGlobalFromScript("scripts/HealthDrainModule", "ntToBlock", "managerSoloNotes")
		callScript("scripts/HealthDrainModule", "checkForNTypes", {})
	end
end

function setDrain() 
	if difficulty == 1 then drain = 0.01
	else difficulty = 0.0075 end 
end