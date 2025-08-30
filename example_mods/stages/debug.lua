function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('bg', 'bgs/debug/background', -260, -80);
		setScrollFactor('bg', 0.9, 0.9);
		--scaleObject('bg', 0.95, 0.95)
		
		makeLuaSprite('headLeft', 'bgs/debug/headLeft', -300, 700);
		setScrollFactor('headLeft', 0.9, 0.9);
		scaleObject('headLeft', 0.9, 0.9)
		
		makeLuaSprite('headLeft2', 'bgs/debug/headLeft', -640, 440);
		setScrollFactor('headLeft2', 0.9, 0.9);
		
		makeLuaSprite('headRight', 'bgs/debug/headRight', 1280, 480);
		setScrollFactor('headRight', 0.9, 0.9);
		
		makeLuaSprite('headRight2', 'bgs/debug/headRight', 880, 700);
		setScrollFactor('headRight2', 0.9, 0.9);
		scaleObject('headRight2', 0.9, 0.9)
		
		makeLuaSprite('clones', 'bgs/debug/clones', -400, -80);
		setScrollFactor('clones', 0.9, 0.9);
		scaleObject('clones', 1.15, 1.15)
		setProperty('clones.origin.y', 600)
		
		makeLuaSprite('moreClones', 'bgs/debug/moreClones', -900, -170);
		setScrollFactor('moreClones', 0, 0);
		setProperty('moreClones.alpha', 0)
		scaleObject('moreClones', 1.7, 1.7)
	
		setProperty('defaultCamZoom', 0.5 * zoomMult)

		addLuaSprite('moreClones', false);
		addLuaSprite('clones', false);
		addLuaSprite('bg', false);
		--addLuaSprite('moreClones', false);
		addLuaSprite('headLeft2', true);
		addLuaSprite('headLeft', true);
		addLuaSprite('headRight', true);
		addLuaSprite('headRight2', true);
	end
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
