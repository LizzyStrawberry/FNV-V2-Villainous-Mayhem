function onCreatePost()
	if shadersEnabled then
		triggerEvent('Set RTX Data', '0.45,0.14693698199611,0,0.73984069904636,0,0,0,0,0.50535529939004,0.4888692479833,0,0.83333333333333,213.74111478708,40.795747278957')
	
		initLuaShader('RGBPinchusionSplit')
		
		makeLuaSprite('camShader', nil)
		makeGraphic('camShader', screenWidth, screenHeight)
	end
end

function onUpdate(elapsed)
	if curStep == 2528 then
		if shadersEnabled then
			triggerEvent('Set RTX Data', '0,0.1875,0,0.55,0,0.33878313343135,0,0.40625,0,0.5875,0,0.83333333333333,213.74111478708,40.795747278957')
		end
	end
	if curStep == 2656 then
		if shadersEnabled then
			triggerEvent('Set RTX Data', '0.45,0.14693698199611,0,0.73984069904636,0,0,0,0,0.50535529939004,0.4888692479833,0,0.83333333333333,213.74111478708,40.795747278957')
		end
	end
	if curStep == 3424 then
		if shadersEnabled then
			triggerEvent('Set RTX Data', '0.44,0,0,0.53,0.43,0,0,0.28270049005976,0.72,0,0,0.83333333333333,213.74111478708,38.210880339982')
			setSpriteShader('camShader', "RGBPinchusionSplit")
			setShaderFloat("camShader", 'amount', 0);
			runHaxeCode([[
				trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!'); 
				FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
			]]);
		end
	end
end

local e
function lerp(a, b, c, d)
  e = 1 - math.pow(1 - (d / c), 5)
  return a + (b - a) * e;
end

function onUpdatePost(elapsed)
	if shadersEnabled then
		setShaderFloat("camShader", 'amount', lerp(getShaderFloat('camShader', 'amount'), 0, (0.4 + (stepCrochet * 0.004)) / playbackRate, elapsed));
	end
end

function onBeatHit()
	if curBeat >= 856 and curBeat <= 984 and getShaderFloat("camShader", 'amount') > -0.0425 then
		setShaderFloat("camShader", 'amount', -0.0425)
	end
end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end