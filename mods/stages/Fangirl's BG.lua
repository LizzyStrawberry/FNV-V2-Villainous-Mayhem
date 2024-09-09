function onCreate()
	-- background shit
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then	
		makeLuaSprite('BGMemes', 'bgs/fangirl/memes', -290, -150)
		setScrollFactor('BGMemes', 0.9, 0.9)
		
		makeLuaSprite('BGP1', 'bgs/fangirl/BGP1', -290, -150)
		setScrollFactor('BGP1', 0.9, 0.9)
		
		makeLuaSprite('BGP2', 'bgs/fangirl/BGP2', -290, -150)
		setScrollFactor('BGP2', 0.9, 0.9)
		setProperty('BGP2.alpha', 0)
		
		makeLuaSprite('table', 'bgs/fangirl/table', -290, -150)
		setScrollFactor('table', 0.9, 0.9)

		addLuaSprite('BGMemes', false);
		addLuaSprite('BGP1', false);
		addLuaSprite('BGP2', false);
		addLuaSprite('table', true)
		setObjectOrder('table', getObjectOrder('dadGroup') - 1)
	end

	--setProperty('defaultCamZoom', 0.5)
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
