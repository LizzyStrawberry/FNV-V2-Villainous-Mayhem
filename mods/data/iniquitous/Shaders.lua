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
function onStepHit()
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
			setSpriteShader("coloredPlayerCircle", "glitch")
			setSpriteShader("iconPlayer", "glitch")
			setSpriteShader("iconP1", "glitch")
			setSpriteShader("timeTxt", "glitch")
			setSpriteShader("timeBar", "glitch")
			runHaxeCode('for (strum in game.playerStrums) strum.shader = game.iconP1.shader;')
			if redShaderOn == false then
				setSpriteShader('camShader', "redOverlay")
				runHaxeCode([[
					trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
					FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
				]])
				redShaderOn = true;
			end
		end
		if curBeat == 744 then
			runHaxeCode([[
				FlxG.game.setFilters([]);
			]])
			removeSpriteShader("coloredPlayerCircle")
			removeSpriteShader("iconPlayer")
			removeSpriteShader("iconP1")
			removeSpriteShader("dad")
			removeSpriteShader("iconOpponent")
			removeSpriteShader("coloredOpponentCircle")
			removeSpriteShader("iconP2")
			removeSpriteShader("timeTxt")
			removeSpriteShader("timeBar")
		end
	end
end

function onUpdate(elapsed)
	if shadersEnabled then
		setShaderFloat("iconP2", "iTime", os.clock())
		setShaderFloat("iconP1", "iTime", os.clock())
		setShaderFloat("coloredPlayerCircle", "iTime", os.clock())
		setShaderFloat("dad", "iTime", os.clock())
		setShaderFloat("coloredOpponentCircle", "iTime", os.clock())
		setShaderFloat("iconOpponent", "iTime", os.clock())
		setShaderFloat("iconPlayer", "iTime", os.clock())
		setShaderFloat("timeTxt", "iTime", os.clock())
		setShaderFloat("timeBar", "iTime", os.clock())
	end
end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end
