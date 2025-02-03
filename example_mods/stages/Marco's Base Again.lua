function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('bg', "bgs/tofu/background", -160, -160);
		setScrollFactor('bg', 0.9, 0.9);
		scaleObject('bg', 0.9, 0.9)
		
		addLuaSprite('bg', false);
	end
	
	setProperty('defaultCamZoom', 0.96)
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
