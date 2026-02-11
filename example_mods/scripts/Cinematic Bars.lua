function onCreate()
	if getPropertyFromClass('ClientPrefs', 'cinematicBars') then
		makeLuaSprite('bartop', '', -100, -660)
		makeGraphic('bartop', screenWidth + 200, screenHeight,'000000')
		setObjectCamera('bartop','hud')
		setScrollFactor('bartop', 0, 0)

		makeLuaSprite('barbot', '', -100, 660)
		makeGraphic('barbot', screenWidth + 200, screenHeight, '000000')
		setScrollFactor('barbot', 0, 0)
		setObjectCamera('barbot', 'hud')	
		
		addLuaSprite('barbot', false)
		addLuaSprite('bartop', false)
	end
end