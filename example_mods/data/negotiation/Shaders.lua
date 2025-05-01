local start = false
local pxSize = 10

function onCreatePost()
	if shadersEnabled then
		triggerEvent('Set RTX Data', '0.45025441837813,0.25038380635491,0,0.4542892069352,1,1,0,0.29255101241682,0.79576330681808,0.55026357687042,0,0.94223889982838,0,28.837188885895', '')
	
		runHaxeCode([[
			game.initLuaShader('pixel');

			shader0 = game.createRuntimeShader('pixel');
			shader0.setFloat('pxSize',]]..pxSize..[[);

			game.camGame.setFilters([new ShaderFilter(shader0)]);
			game.camHUD.setFilters([new ShaderFilter(shader0)]);
		]])
	end
end

function onSongStart()
	if shadersEnabled then
		start = true
	end
end

function onUpdate(elapsed)
	if shadersEnabled then
		if curBeat == 368 then
			start = true
		end
			
		if start then
			if curBeat <= 32 then
				if pxSize > 0 then
					pxSize = pxSize - (1.25 * elapsed) * playbackRate
				else
					pxSize = 0.01
					start = false
				end
			end
			if curBeat >= 368 then
				if pxSize < 10 then
					pxSize = pxSize + (0.75 * elapsed) * playbackRate
				else
					pxSize = 10
					start = false
				end
			end
			
			runHaxeCode([[
				shader0.setFloat("pxSize","]]..pxSize..[[");
			]])
		end
	end
end