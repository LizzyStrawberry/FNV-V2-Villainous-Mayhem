function onCreate()
	-- background shit
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		if songName == 'Scrouge' or songName == 'Toxic Mishap Remix' or songName == 'Paycheck V2' then
			makeLuaSprite('bg', 'bgs/marco/background-new', -240, -100);
			setScrollFactor('bg', 0.9, 0.9);
			--scaleObject('bg', 0.95, 0.95)
		
			makeLuaSprite('fg', 'bgs/marco/foreground-new', -240, -100);
			setScrollFactor('fg', 0.9, 0.9);
			--scaleObject('fg', 0.86, 0.86)
		elseif songName == 'Villainy' then
			makeLuaSprite('bg', 'bgs/marco/background-villainy', -240, -100);
			setScrollFactor('bg', 0.9, 0.9);
			--scaleObject('bg', 0.95, 0.95)
		
			makeLuaSprite('fg', 'bgs/marco/foreground-new', -240, -100);
			setScrollFactor('fg', 0.9, 0.9);
			--scaleObject('fg', 0.86, 0.86)
		elseif songName == 'Spendthrift' then
			makeLuaSprite('bg', 'bgs/spendthrift/background', -240, -100);
			setScrollFactor('bg', 0.9, 0.9);
			--scaleObject('bg', 0.95, 0.95)
		
			makeLuaSprite('fg', 'bgs/spendthrift/foreground', -240, -100);
			setScrollFactor('fg', 0.9, 0.9);
			--scaleObject('fg', 0.86, 0.86)
		elseif songName == 'Shucks V2' then
			makeLuaSprite('bg', 'bgs/marco/background', -240, -100);
			setScrollFactor('bg', 0.9, 0.9);
			--scaleObject('bg', 0.95, 0.95)
		
			makeLuaSprite('fg', 'bgs/marco/foreground-shucks', -240, -100);
			setScrollFactor('fg', 0.9, 0.9);
			--scaleObject('fg', 0.86, 0.86)
			
			makeLuaSprite('ded', 'bgs/marco/plankthingy', -950, -520);
			setScrollFactor('ded', 1, 1);
			setObjectOrder('ded', getObjectOrder('fg') - 1)
			scaleObject('ded', 1.6, 1.6)
			updateHitbox('ded')
		else
			makeLuaSprite('bg', 'bgs/marco/background', -240, -100);
			setScrollFactor('bg', 0.9, 0.9);
			--scaleObject('bg', 0.95, 0.95)
		
			makeLuaSprite('fg', 'bgs/marco/foreground', -240, -100);
			setScrollFactor('fg', 0.9, 0.9);
			--scaleObject('fg', 0.86, 0.86)
		end
		
		setProperty('defaultCamZoom', 0.9)

		addLuaSprite('bg', false);
		addLuaSprite('fg', false);
		if songName == 'Shucks V2' then
			setProperty('defaultCamZoom', 2)
			addLuaSprite('ded', false);
		end
	end

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
