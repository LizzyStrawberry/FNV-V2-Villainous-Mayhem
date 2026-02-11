local drain
local powerUpActive = false
function onCreate()
	if mechanics then
		setDrain()
		setGlobalFromScript("scripts/HealthDrainModule", "allowDrain", true)
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

function setDrain() 
	drain = 0.01375
end