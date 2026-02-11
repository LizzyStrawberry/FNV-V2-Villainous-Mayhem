function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('bg', 'bgs/DV/background', -800, -600);
		setScrollFactor('bg', 0.9, 0.9);
		scaleObject('bg', 1.1, 1.1)

		addLuaSprite('bg', false);
	end
	
	setProperty('defaultCamZoom', 1.3)
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
