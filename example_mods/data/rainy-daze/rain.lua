function onCreate() 
    if shadersEnabled then  
        local ShaderName = 'rain'
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        scaleObject("camShader", 20.0, 20.0)
        setSpriteShader('camShader', ShaderName)
        

        runHaxeCode([[
            trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
            //FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
            game.camGame.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
        ]])

        function onUpdate(elapsed)
            setShaderFloat('camShader', 'iTime', os.clock())
            setShaderFloat('camShader', 'iIntensity', 0.1)
            setShaderFloat('camShader', 'iTimescale', 0.13)
        end
    end
end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end