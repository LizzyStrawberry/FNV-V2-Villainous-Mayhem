function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('BGP0', 'bgs/iniquitous/backgroundStage', -340, -120);
		setScrollFactor('BGP0', 0.9, 0.9);
		scaleObject('BGP0', 1.1, 1.1)
		
		makeLuaSprite('BGP1', 'bgs/iniquitous/background', -340, -120);
		setScrollFactor('BGP1', 0.9, 0.9);
		scaleObject('BGP1', 1.1, 1.1)
		
		makeLuaSprite('GFPart', 'bgs/iniquitous/gfPart', -320, -120);
		setScrollFactor('GFPart', 0.9, 0.9);
		scaleObject('GFPart', 1.1, 1.1)
		
		makeLuaSprite('BGP2', 'bgs/iniquitous/bgPart2', -340, -420);
		setScrollFactor('BGP2', 0.9, 0.9);
		scaleObject('BGP2', 1.5, 1.5)
		setProperty('BGP2.alpha', 0)
		
		makeLuaSprite('Base', 'bgs/iniquitous/base', -340, -120);
		setScrollFactor('Base', 0.9, 0.9);
		scaleObject('Base', 1.1, 1.1)
		setProperty('Base.alpha', 0)
		
		setProperty('defaultCamZoom', 0.7 * zoomMult)
		
		setObjectOrder('Base', getObjectOrder('dadGroup') + 1)

		addLuaSprite('BGP0', false);
		addLuaSprite('BGP1', false);
		addLuaSprite('GFPart', false);
		addLuaSprite('BGP2', false);
		addLuaSprite('Base', false);
	end

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
