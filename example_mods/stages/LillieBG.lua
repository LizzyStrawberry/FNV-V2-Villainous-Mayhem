function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('bg', 'bgs/lillie/background', -20, -70);
		setScrollFactor('bg', 0.9, 0.9);
		
		makeLuaSprite('bench', 'bgs/lillie/bench', -20, -70);
		setScrollFactor('bench', 0.9, 0.9);
		
		makeLuaSprite('waterOnWindow', 'bgs/lillie/water', -20, -140);
		setScrollFactor('waterOnWindow', 0.9, 0.9);
		--scaleObject('bg', 1.5, 1.5)

		addLuaSprite('bg', false);
		addLuaSprite('bench', false);
		addLuaSprite('waterOnWindow', false);
	end
	
	setProperty('defaultCamZoom', 1.3)
	
	runTimer('rainOnWindow', 6.4)
	doTweenY('waterOnWindowMove', 'waterOnWindow', -50, 9, 'easeIn')
end

function onTweenCompleted(tag)
	if tag == 'waterOnWindowMove' then
		setProperty("waterOnWindow.y", -140)
		doTweenY('waterOnWindowMove', 'waterOnWindow', -50, 9, 'easeIn')
		doTweenAlpha('waterOnWindowAlpha', 'waterOnWindow', 1, 1.3, 'easeIn')
		runTimer('rainOnWindow', 6.4)
	end
end

function onTimerCompleted(tag)
	if tag == 'rainOnWindow' then
		doTweenAlpha('waterOnWindowAlpha', 'waterOnWindow', 0, 1.3, 'easeIn')
	end
end
