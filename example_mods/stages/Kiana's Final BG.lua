function onCreate()
	-- background shit
	if not optimizationMode then
		if not performanceWarn then
			makeLuaSprite('BG', 'bgs/kiana/Final/Background', -1200, -600);
			setScrollFactor('BG', 0.95, 0.95);
			scaleObject('BG', 3.6, 3.6)
			
			makeLuaSprite('CFront', 'bgs/kiana/Final/GroundCrystals', -300, 340);
			setScrollFactor('CFront', 0.95, 0.95);
			setObjectOrder('CFront', getObjectOrder('dadGroup') + 1)
			scaleObject('CFront', 2, 2)
		
			addLuaSprite('BG', false);
			addLuaSprite('CFront', false);
		else
			makeLuaSprite('bgIntro', 'bgs/kiana/Final/kianaOptimized-intro', -120, -100)
			scaleObject('bgIntro', 1.2, 1.2)
			setScrollFactor('bgIntro', 0, 0)
			
			makeLuaSprite('kianaOptimized', 'bgs/kiana/Final/kianaOptimized', -120, -100)
			scaleObject('kianaOptimized', 1.2, 1.2)
			setScrollFactor('kianaOptimized', 0, 0)
			setProperty('kianaOptimized.alpha', 0)

			makeLuaSprite('gfOptimized', 'bgs/kiana/Final/gfOptimized', 730, 420)
			setScrollFactor('gfOptimized', 0, 0)
			
			addLuaSprite('bgIntro', false)
			addLuaSprite('kianaOptimized', false)
			addLuaSprite('gfOptimized', true)
			
			setProperty('defaultCamZoom', 0.85)
		end		
	end
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
