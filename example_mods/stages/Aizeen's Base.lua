function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('bg', 'bgs/aizeen/background', -410, -200);
		setScrollFactor('bg', 0.95, 0.95);
		scaleObject('bg', 1.15, 1.1)
	
		if not songName == 'Cheque' then
			setProperty('defaultCamZoom', 0.9)
		end

		addLuaSprite('bg', false);
	end
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
