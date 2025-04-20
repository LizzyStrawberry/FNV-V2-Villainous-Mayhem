function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('bg', 'bgs/cross/crossBG', -400, -200);
		setScrollFactor('bg', 0.9, 0.9);
		scaleObject("bg", 1.1, 1.1)

		addLuaSprite('bg', false);
	end
	
	setProperty("defaultCamZoom", 0.75)
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
