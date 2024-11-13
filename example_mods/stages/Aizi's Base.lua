function onCreate()
	-- background shit
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		makeLuaSprite('bg', 'bgs/aizi/background', -340, -200);
		setScrollFactor('bg', 0.9, 0.9);
		scaleObject('bg', 1.5, 1.2)

		addLuaSprite('bg', false);
	end
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
