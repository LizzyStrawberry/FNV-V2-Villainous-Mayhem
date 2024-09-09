function onCreate()
	if shadersEnabled then
		addChromaticAbberationEffect('game', 0.003)
		addChromaticAbberationEffect('hud', 0.003)
		addChromaticAbberationEffect('other', 0.003)
		addBloomEffect('game', 0.15, 1.0)
		addBloomEffect('hud', 0.15, 1.0)
		addScanlineEffect('game', false)
		addScanlineEffect('hud', true)

		makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        setSpriteShader('camShader', "VHSTape")
        
        runHaxeCode([[
            trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
            FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
        ]])
	end
end

function onUpdate(elapsed)
	setShaderFloat('camShader', 'iTime', os.clock())
end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end