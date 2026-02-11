function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('nunBG', 'bgs/beatrice/NunBG', -700, -600);
		setScrollFactor('nunBG', 0.9, 0.9);
		scaleObject('nunBG', 1.4, 1.35)
		
		addLuaSprite('nunBG', false);
	end
	
	setProperty('defaultCamZoom', songName == 'Point Blank' and 0.7 or 1.2)
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
