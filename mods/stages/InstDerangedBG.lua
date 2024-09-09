function onCreate()
	-- background shit
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		makeLuaSprite('bgNormal', 'bgs/instDeranged/backgroundNormal', -550, -180);
		setScrollFactor('bgNormal', 0.9, 0.9);
		scaleObject('bgNormal', 1.1, 1.1)
		
		makeLuaSprite('bgSpook', 'bgs/instDeranged/backgroundHorror', -1440, -650);
		setScrollFactor('bgSpook', 0.9, 0.9);
		scaleObject('bgSpook', 2.2, 2.2)
		
		makeAnimatedLuaSprite('eyes1', 'bgs/instDeranged/eyes1', 2500, -100)
		scaleObject('eyes1', 1.7, 1.7)
		luaSpriteAddAnimationByPrefix('eyes1', 'twitch', 'eye1');
		luaSpritePlayAnimation('eyes1', 'twitch');
		setLuaSpriteScrollFactor('eyes1', 0.95, 0.98);
		
		makeAnimatedLuaSprite('eyes2', 'bgs/instDeranged/eyes2', 900, -700)
		scaleObject('eyes2', 2, 1.75)
		luaSpriteAddAnimationByPrefix('eyes2', 'twitch', 'eyes2');
		luaSpritePlayAnimation('eyes2', 'twitch');
		setLuaSpriteScrollFactor('eyes2', 0.95, 0.98);
		
		makeAnimatedLuaSprite('eyes3', 'bgs/instDeranged/eyes3', 0, -600)
		scaleObject('eyes3', 2, 1.75)
		luaSpriteAddAnimationByPrefix('eyes3', 'twitch', 'eyes3');
		luaSpritePlayAnimation('eyes3', 'twitch');
		setLuaSpriteScrollFactor('eyes3', 0.95, 0.98);
		
		makeAnimatedLuaSprite('MML', 'bgs/instDeranged/monsterMiddleLeft', -1500, 700)
		scaleObject('MML', 2, 1.75)
		luaSpriteAddAnimationByPrefix('MML', 'twitch', 'monsterMiddleLeft');
		luaSpritePlayAnimation('MML', 'twitch');
		setLuaSpriteScrollFactor('MML', 0.95, 0.98);
		
		makeAnimatedLuaSprite('MMR', 'bgs/instDeranged/monsterMiddleRight', 2300, 400)
		scaleObject('MMR', 2, 1.75)
		luaSpriteAddAnimationByPrefix('MMR', 'twitch', 'monsterMiddleRight');
		luaSpritePlayAnimation('MMR', 'twitch');
		setLuaSpriteScrollFactor('MMR', 0.95, 0.98);
		
		makeAnimatedLuaSprite('MDL', 'bgs/instDeranged/monsterDownLeft', -1350, 1250)
		scaleObject('MDL', 2, 1.75)
		luaSpriteAddAnimationByPrefix('MDL', 'twitch', 'monsterDownLeft');
		luaSpritePlayAnimation('MDL', 'twitch');
		setLuaSpriteScrollFactor('MDL', 0.95, 0.98);
		
		setProperty('defaultCamZoom', 0.9)

		addLuaSprite('bgSpook', false);
		addLuaSprite('eyes1', false);
		addLuaSprite('eyes2', false);
		addLuaSprite('eyes3', false);
		addLuaSprite('MML', false);
		addLuaSprite('MMR', false);
		addLuaSprite('MDL', false);
		addLuaSprite('bgNormal', false);
	end
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
