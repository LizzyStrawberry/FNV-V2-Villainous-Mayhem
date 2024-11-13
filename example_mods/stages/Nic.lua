function onCreate()
	-- background shit
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		makeLuaSprite('whiteBG', '', -800, -600)
		makeGraphic('whiteBG', 5000, 5000, 'FFFFFF')
		setScrollFactor('whiteBG', 0, 0)
		setObjectCamera('whiteBG', 'game')
		addLuaSprite('whiteBG', false)
		
		makeLuaSprite('tail', 'bgs/nic/tail', 200, 140);
		setProperty('tail.origin.y', 800)
		setScrollFactor('tail', 0.95, 0.95);
	
		setProperty('defaultCamZoom', 0.9)

		addLuaSprite('whiteBG', false);
		addLuaSprite('tail', false);
	end

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
