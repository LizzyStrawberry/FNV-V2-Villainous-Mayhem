function onCreate()
	-- background shit
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		makeLuaSprite('bg', 'bgs/ourple/background', -240, -100);
		setScrollFactor('bg', 0.9, 0.9);
		--scaleObject('bg', 0.95, 0.95)

		addLuaSprite('bg', false);
	end
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
