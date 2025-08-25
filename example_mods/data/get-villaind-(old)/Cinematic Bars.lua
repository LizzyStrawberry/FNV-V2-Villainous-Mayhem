function onCreate()
	if getPropertyFromClass('ClientPrefs', 'cinematicBars') == true then
		makeLuaSprite('bartop1', '', -100, -750)
		makeGraphic('bartop1', screenWidth*1.25, 720,'000000')
		setObjectCamera('bartop1','other')
		setScrollFactor('bartop1', 0, 0)

		makeLuaSprite('barbot1', '', -100, 750)
		makeGraphic('barbot1', screenWidth*1.25, 120, '000000')
		setScrollFactor('barbot1', 0, 0)
		setObjectCamera('barbot1', 'other')	
		
		addLuaSprite('barbot1', false)
		addLuaSprite('bartop1', false)
	end
end

function onUpdate()
	if getPropertyFromClass('ClientPrefs', 'cinematicBars') == true then
		if curStep == 160 then
			doTweenY('barTop1', 'bartop1', -650, 0.6, 'cubeInOut')
			doTweenY('barbot1', 'barbot1', 650, 0.6, 'cubeInOut')
		end
		if curStep == 256 then
			doTweenY('barTop1', 'bartop1', -750, 0.6, 'cubeInOut')
			doTweenY('barbot1', 'barbot1', 750, 0.6, 'cubeInOut')
		end
	end
end