function onCreate()
	-- background shit
	if optimizationMode then return end

	makeLuaSprite('whiteBG')
	makeGraphic('whiteBG', screenWidth, screenHeight, 'FFFFFF')
	scaleObject('whiteBG', 5, 5)
	screenCenter('whiteBG', 'X')
	setScrollFactor('whiteBG', 0, 0)
	addLuaSprite('whiteBG', false)
	
	makeLuaSprite('funnyMan', 'effects/funnyMan', 0, 0)
	setScrollFactor('funnyMan', 0.9, 0.9)
	addLuaSprite('funnyMan', false)

	addLuaSprite('whiteBG', false);
	addLuaSprite('funnyMan', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
