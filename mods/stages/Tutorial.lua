function onCreate()
	-- background shit
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		makeLuaSprite('bg', 'bgs/coupleClash/Background', -400, 80);
		setScrollFactor('bg', 0.9, 0.9);
		scaleObject('bg', 1.7, 1.7)
	
		setProperty('defaultCamZoom', 0.9)

		addLuaSprite('bg', false);
	end

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
