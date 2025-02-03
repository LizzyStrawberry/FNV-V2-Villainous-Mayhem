function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('BG', 'bgs/kiana/Old/background', -1260, -1000);
		setScrollFactor('BG', 0.95, 0.95);
		scaleObject('BG', 2, 2)
	
		makeLuaSprite('BGP1', 'bgs/kiana/Old/background-p1', -1260, -1000);
		setScrollFactor('BGP1', 0.95, 0.95);
		scaleObject('BGP1', 2, 2)
		
		makeLuaSprite('BGP2', 'bgs/kiana/Old/background-p2', -1260, -1000);
		setScrollFactor('BGP2', 0.95, 0.95);
		scaleObject('BGP2', 2, 2)
	
		makeLuaSprite('Ground', 'bgs/kiana/Old/Ground', -1260, -970);
		setScrollFactor('Ground', 0.95, 0.95);
		scaleObject('Ground', 2, 2)
	
		addLuaSprite('BGP1', false);
		addLuaSprite('Ground', false);
		addLuaSprite('BG', false);
	end
	
	setProperty('defaultCamZoom', 0.7)
		
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
