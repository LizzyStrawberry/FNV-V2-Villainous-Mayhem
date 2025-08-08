function onCreate()
	if getPropertyFromClass('ClientPrefs', 'cinematicBars') then
		makeLuaSprite('bartop', '', mobileFix("X", -100, true), -660)
		makeGraphic('bartop', screenWidth * 1.25, 720,'000000')
		setObjectCamera('bartop','hud')
		setScrollFactor('bartop', 0, 0)

		makeLuaSprite('barbot', '', mobileFix("X", -100, true), mobileFix("Y", 660))
		makeGraphic('barbot', screenWidth * 1.25, 720, '000000')
		setScrollFactor('barbot', 0, 0)
		setObjectCamera('barbot', 'hud')	
		
		addLuaSprite('barbot', false)
		addLuaSprite('bartop', false)
	end
end