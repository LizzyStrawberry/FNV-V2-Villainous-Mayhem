function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('nunBG', 'bgs/beatrice/nunBGOLD', -600, -600);
		setScrollFactor('nunBG', 0.9, 0.9);
		scaleObject('nunBG', 1.3, 1.3)
		
		addLuaSprite('nunBG', false);
	end
	
	setProperty('defaultCamZoom', 1.4 * zoomMult)
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
