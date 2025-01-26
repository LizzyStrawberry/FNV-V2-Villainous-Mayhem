function onCreate()
	if shadersEnabled then
		addBloomEffect('game', 0.25, 1.4)
		addBloomEffect('hud', 0.25, 1.4)
		addScanlineEffect('game', false)
		addScanlineEffect('hud', true)

		makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        setSpriteShader('camShader', "CRT")
		
        runHaxeCode([[
            trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
            FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
			game.camGame.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
			game.camHUD.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
        ]])
	end
end

function onUpdate(elapsed)
	setShaderFloat('camShader', 'iTime', os.clock())
	setShaderFloat('camGame', 'iTime', os.clock())
	setShaderFloat('camHUD', 'iTime', os.clock())
end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
            game.camGame.setFilters([]);
            game.camHUD.setFilters([]);
        ]])
    end
end