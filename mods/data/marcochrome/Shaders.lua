function onCreate()
	if shadersEnabled then
		addVCREffect('game', 0.012, true, true, false)
		addVCREffect('other', 0.012, true, true, true)
		addVCREffect('hud', 0.017, true, true, false)
		addBloomEffect('hud', 0.35, 0.74)
		
		local var ShaderName = 'TVDistortion'
		makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        setSpriteShader('camShader', ShaderName)
        

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