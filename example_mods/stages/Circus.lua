function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('bg', 'bgs/narrin/background', -340, -200);
		setScrollFactor('bg', 0.9, 0.9);
		scaleObject('bg', 1.2, 1.2)

		addLuaSprite('bg', false);
		
		setProperty('defaultCamZoom', 1.1 * zoomMult)
	end
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
