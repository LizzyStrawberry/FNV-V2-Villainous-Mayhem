local changeHud = false
local songStarted = false
function onCreate()
	-- background shit
	if not optimizationMode then
		addLuaScript("custom_events/Change Icon")
		
		makeLuaSprite('crossBG', 'bgs/cross/crossBG', -400, -200);
		setScrollFactor('crossBG', 0.9, 0.9);
		scaleObject("crossBG", 1.1, 1.1)
		
		makeLuaSprite('seerBG', 'bgs/cross/seerBG', -400, -200);
		setScrollFactor('seerBG', 0.9, 0.9);
		scaleObject("seerBG", 1.1, 1.1)

		addLuaSprite('crossBG', false);
		addLuaSprite('seerBG', false);
	end
	
	setProperty("defaultCamZoom", 0.75 * zoomMult)
end

function onCreatePost()
	if not optimizationMode then
		setScene("Cross")
	end
end

function onSongStart()
    songStarted = true
end

function setScene(char)
	if char == "Seer" then
		changeHud = true
		loadGraphic("iconPlayer", "healthBars/Cross/iconSlotP-Seer")
		loadGraphic("iconOpponent", "healthBars/Cross/iconSlotO-Seer")
		
		triggerEvent("Change Character", "bf", "Negotiation Aileen")
		triggerEvent('Change Icon', 'P2, negotiationSeer, 45ffd4')			
		
		setProperty("dad.visible", false)
		setProperty("gf.visible", true)
		
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/AsulNOTE_assets');
			setPropertyFromGroup('playerStrums', i, 'texture', 'notes/AileenNOTE_assets');
			setPropertyFromGroup('opponentStrums', i, 'scale.x', getPropertyFromGroup("opponentStrums", i, 'scale.x') / 1.75) 
			setPropertyFromGroup('opponentStrums', i, 'scale.y', getPropertyFromGroup("opponentStrums", i, 'scale.y') / 1.75) 
		end
		
		setProperty("crossBG.visible", false)
		setProperty("seerBG.visible", true)
		
		setGlobalFromScript("scripts/Camera Movement", "flipPlayerMovement", false)
		
		if shadersEnabled then
			triggerEvent('Set RTX Data', '0,0.5998481035357,0.65632196891041,0.50036498939054,0,0,0,0,0,0.73442539268737,0.80449281260709,0.50370234856818,257.36461488711,50', '')
		end
	elseif char == "Cross" then
		changeHud = false
		loadGraphic("iconPlayer", "healthBars/Cross/iconSlotP")
		loadGraphic("iconOpponent", "healthBars/Cross/iconSlotO")
		
		triggerEvent("Change Character", "bf", "Negotiation Marco")
		triggerEvent('Change Icon', 'P2, negotiationCross, ef000c')
		
		setProperty("dad.visible", true)
		setProperty("gf.visible", false)
		
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/CrossNOTE_assets');
			setPropertyFromGroup('playerStrums', i, 'texture', 'notes/MarcoNOTE_assets');
			if songStarted then
		    	setPropertyFromGroup('opponentStrums', i, 'scale.x', getPropertyFromGroup("opponentStrums", i, 'scale.x') / 1.75) 
		    	setPropertyFromGroup('opponentStrums', i, 'scale.y', getPropertyFromGroup("opponentStrums", i, 'scale.y') / 1.75) 
	        end 
	end
		
		setProperty("crossBG.visible", true)
		setProperty("seerBG.visible", false)
		
		setGlobalFromScript("scripts/Camera Movement", "flipPlayerMovement", true)
		
		if shadersEnabled then
			triggerEvent('Set RTX Data', '0.45025441837813,0.25038380635491,0,0.4542892069352,1,1,0,0.29255101241682,0.79576330681808,0.55026357687042,0,0.94223889982838,0,28.837188885895', '')
		end
	end
	
	setVar("changeHud", changeHud)
end
