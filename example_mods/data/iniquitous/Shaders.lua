function onCreate()
	if shadersEnabled then
		addChromaticAbberationEffect('game', 0.002)
		addChromaticAbberationEffect('hud', 0.003)
		addChromaticAbberationEffect('other', 0.003)
		initLuaShader('glitch')
		
		makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
	end
end

local redShaderOn = false
function onUpdatePost()
	if shadersEnabled then
		if curStep == 1344 then
			setSpriteShader("iconP2", "glitch")
			setSpriteShader("coloredOpponentCircle", "glitch")
			setSpriteShader("iconOpponent", "glitch")
			runHaxeCode('for (strum in game.opponentStrums) strum.shader = game.iconP2.shader;')
		end
		if curStep == 1352 then
			setSpriteShader("dad", "glitch")
		end
		if curStep == 2432 then
			removeSpriteShader("dad")
			
			setSpriteShader("dad", "glitch")
			setSpriteShader("boyfriend", "glitch")
			if redShaderOn == false then
				setSpriteShader('camShader', "redOverlay")
				runHaxeCode([[
					trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
					FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
					game.camHUD.setFilters([new ShaderFilter(game.iconP2.shader)]);
				]])
				redShaderOn = true;
			end
		end
		if curBeat == 744 then
			runHaxeCode([[
				FlxG.game.setFilters([]);
				game.camHUD.setFilters([]);
			]])
			removeSpriteShader("boyfriend")
			removeSpriteShader("dad")
			removeSpriteShader("iconOpponent")
			removeSpriteShader("coloredOpponentCircle")
			removeSpriteShader("iconP2")
		end
	end
end

function onUpdate(elapsed)
	if shadersEnabled then
		setShaderFloat("iconP2", "iTime", os.clock())
		setShaderFloat("coloredPlayerCircle", "iTime", os.clock())
		setShaderFloat("dad", "iTime", os.clock())
		setShaderFloat("boyfriend", "iTime", os.clock())
		setShaderFloat("coloredOpponentCircle", "iTime", os.clock())
		setShaderFloat("iconOpponent", "iTime", os.clock())
	end
end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end
