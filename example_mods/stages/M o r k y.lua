function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('bg', 'bgs/morky/Background', -270, -100);
		setScrollFactor('bg', 0.9, 0.9);
		scaleObject('bg', 1.5, 1.5)
		
		makeLuaSprite('ground', 'bgs/morky/Ground', -300, -20);
		setScrollFactor('ground', 0.9, 0.9);
		scaleObject('ground', 1.5, 1.5)
	
		setProperty('defaultCamZoom', 0.9 * zoomMult)

		addLuaSprite('bg', false);
		addLuaSprite('ground', false);
	end

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
