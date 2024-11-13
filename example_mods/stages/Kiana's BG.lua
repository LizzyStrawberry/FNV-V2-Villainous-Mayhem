function onCreate()
	-- background shit
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		makeLuaSprite('BG', 'bgs/kiana/New/background', -1260, -1000);
		setScrollFactor('BG', 0.95, 0.95);
		scaleObject('BG', 2, 2)
	
		makeLuaSprite('BGP1', 'bgs/kiana/New/background-p1', -860, -500);
		setScrollFactor('BGP1', 0.95, 0.95);
		scaleObject('BGP1', 1.6, 1.6)
		
		makeLuaSprite('BGP2', 'bgs/kiana/New/background-p2', -860, -500);
		setScrollFactor('BGP2', 0.95, 0.95);
		scaleObject('BGP2', 1.6, 1.6)
	
		makeLuaSprite('Ground', 'bgs/kiana/New/Ground', -1060, -470);
		setScrollFactor('Ground', 0.95, 0.95);
		scaleObject('Ground', 1.6, 1.6)
		
		makeLuaSprite('CBack', 'bgs/kiana/New/crystalsBack', -560, -70);
		setScrollFactor('CBack', 0.95, 0.95);
		scaleObject('CBack', 1.3, 1.3)
		
		makeLuaSprite('CFront', 'bgs/kiana/New/crystalsFront', -1060, -370);
		setProperty('CFront.visible', false)
		setScrollFactor('CFront', 0.95, 0.95);
		scaleObject('CFront', 1.6, 1.6)
	
		addLuaSprite('BGP1', false);
		addLuaSprite('CBack', false);
		addLuaSprite('Ground', false);
		addLuaSprite('BG', false);
		addLuaSprite('CFront', true);
	end
	
	setProperty('defaultCamZoom', 0.7)
		
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
