function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('nunBG', 'bgs/beatrice/nunBG', -700, -600);
		setScrollFactor('nunBG', 0.9, 0.9);
		scaleObject('nunBG', 1.4, 1.3)
		
		addLuaSprite('nunBG', false);
	end
	
	if songName == 'Point Blank' then
		setProperty('defaultCamZoom', 0.7)
	else
		setProperty('defaultCamZoom', 1.2)
	end
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
