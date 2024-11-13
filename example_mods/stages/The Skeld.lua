function onCreate()
	-- background shit
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		if songName == 'Sussus Marcus' then
			makeLuaSprite('bg', 'bgs/marcussy/backgroundSky', -640, -150);
			setScrollFactor('bg', 0.9, 0.9);
			scaleObject('bg', 1.4, 1)
			
			makeLuaSprite('mg', 'bgs/marcussy/mainground', -240, -60);
			setScrollFactor('mg', 0.9, 0.9);
			--scaleObject('fg', 0.86, 0.86)
		
			makeLuaSprite('beef', 'bgs/marcussy/beef', 640, 300);
			setScrollFactor('beef', 0.95, 0.95);
			scaleObject('beef', 0.86, 0.86)
			
			addLuaSprite('bg', false);
			addLuaSprite('beef', false);
			addLuaSprite('mg', false);
		else
			makeLuaSprite('bg', 'bgs/marcussy/background', -640, -100);
			setScrollFactor('bg', 0.9, 0.9);
			scaleObject('bg', 1.4, 1)
			
			makeLuaSprite('mg', 'bgs/marcussy/mainground', -240, -60);
			setScrollFactor('mg', 0.9, 0.9);
			--scaleObject('fg', 0.86, 0.86)
		
			makeLuaSprite('beef', 'bgs/marcussy/beef', 640, 300);
			setScrollFactor('beef', 0.95, 0.95);
			scaleObject('beef', 0.86, 0.86)
			
			addLuaSprite('bg', false);
			addLuaSprite('beef', false);
			addLuaSprite('mg', false);
		end
		
		if songName == 'Excrete' then
			setProperty('beef.scale.x', 0.2)
			setProperty('beef.scale.y', 0.2)
			setObjectOrder('dadGroup', getObjectOrder('mg') - 1)
			setObjectOrder('beef', getObjectOrder('dadGroup') - 1)
			setProperty('defaultCamZoom', 1.04)
		end
	end
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
