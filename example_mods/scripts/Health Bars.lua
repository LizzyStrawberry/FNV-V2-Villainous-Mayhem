local marcoSongs = {"Scrouge", "Cheap Skate (Legacy)", "Spendthrift", "Toxic Mishap", "Toxic Mishap (Legacy)",
"Villainy", "Iniquitous", "Couple Clash", "Shucks V2"} 

local hasDiffSlots = false
local pathToAssets = ""
local properties = {
	circleOffsX = 0, circleOffsY = 0, scale = 0.9, flipIcons = false
}
local iconP1X, iconP2X

function onCreatePost()
	if not optimizationMode then
		bfColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
		dadColor = rgbToHex(getProperty('dad.healthColorArray'))

		for i = 1, #(marcoSongs) do
			if songName == marcoSongs[i] then
				if songName == 'Spendthrift' then
					setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.6)
					setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.52)
				else
					setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
					setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.43)
				end
				
				pathToAssets = "marco/iconSlot"
				hasDiffSlots = false
			end
		end
		
		if songName == 'Paycheck' or songName == 'Paycheck (Legacy)' or songName == 'Tofu' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.44)
		
			pathToAssets = "aileen/iconSlot"
			hasDiffSlots = false
		end
		
		if songName == 'Nunconventional' or songName == 'Nunday Monday' or songName == 'Nunsational' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.49)

			pathToAssets = "aileen/iconSlot"
			hasDiffSlots = false
		end
		if songName == 'Point Blank' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.53)

			pathToAssets = "yaku/iconSlot"
			hasDiffSlots = false
		end
		
		if songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == "Partner" then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			
			pathToAssets = "dv/iconSlot"
			hasDiffSlots = false
		end
		
		if songName == 'Toybox' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 2)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			setProperty('healthBar.x', getProperty('healthBar.x') - 3)

			pathToAssets = "narrin/iconSlot"
			hasDiffSlots = true
			properties.circleOffsX = -4;
			properties.circleOffsY = -10;
			properties.scale = 1;
		end
		
		if songName == 'Lustality' or songName == 'Lustality Remix' or songName == 'Lustality V1'
		or songName == "Libidinousness" then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)

			pathToAssets = "kiana/iconSlot"
			hasDiffSlots = false
		end
		
		if songName == "Get Villain'd" or songName == "Get Villain'd (Old)" then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.475)
			setProperty('healthBar.x', getProperty('healthBar.x') - 4)

			pathToAssets = "morky/iconSlot"
			hasDiffSlots = false
		end
		
		if songName == 'Unpaid Catastrophe' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.445)

			pathToAssets = "aizeen/iconSlot"
			hasDiffSlots = false
		end
		
		if songName == 'Cheque' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.44)

			pathToAssets = "marcus/iconSlot"
			hasDiffSlots = false
		end
		
		if songName == "Get Pico'd" or songName == "Get Gooned" then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.52)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.478)

			pathToAssets = "aizi/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == 'Sussus Marcus' or songName == 'Villain In Board' or songName == 'Excrete' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.52)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.442)
	
			pathToAssets = "marcussy/iconSlot"
			hasDiffSlots = false
		end
		
		-- Bonus Songs		
		if songName == 'Marcochrome' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.445)

			pathToAssets = "michael/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == 'Marauder' or songName == 'Marauder (Old)' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.52)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.565)

			pathToAssets = "debug/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == 'Slow.FLP' or songName == 'Slow.FLP (Old)' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)

			pathToAssets = "nic/iconSlot"
			hasDiffSlots = false
		end
		
		if songName == 'Rainy Daze' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.5)

			pathToAssets = "lillie/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == 'FNV' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			
			pathToAssets = "fnv/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == 'Instrumentally Deranged' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)

			pathToAssets = "instDeranged/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == 'Fanfuck Forever' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.53)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.545)

			pathToAssets = "fangirl/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == 'Fast Food Therapy' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.56)

			pathToAssets = "kyu/iconSlot"
			hasDiffSlots = true
			properties.circleOffsX = -10
			properties.circleOffsY = -12
			properties.scale = 1
			properties.flipIcons = true
		end
		
		if songName == 'Jerry' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.40)

			pathToAssets = "00015/iconSlot"
			hasDiffSlots = false
		end
		
		if songName == 'VGuy' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.51)

			pathToAssets = "vguy/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == 'Tactical Mishap' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.52)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.47)

			pathToAssets = "tc/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == 'Breacher' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.55)

			pathToAssets = "uzi/iconSlot"
			hasDiffSlots = true
			properties.flipIcons = true
		end
		
		if songName == 'Concert Chaos' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.535)

			pathToAssets = "lily/iconSlot"
			hasDiffSlots = true
		end
		
		if songName == "It's Kiana" then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.445)
			setProperty('healthBarBG.scale.y', getProperty('healthBarBG.scale.x') - 0.15)
			setProperty('healthBarBG.scale.x', getProperty('healthBarBG.scale.x') + 0.15)

			pathToAssets = "asul/iconSlot"
			hasDiffSlots = false
		end

		makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
		scaleObject('coloredPlayerCircle', 0.9, 0.9)
		setObjectCamera('coloredPlayerCircle', 'hud')
		addLuaSprite('coloredPlayerCircle', true)
		
		makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
		scaleObject('coloredOpponentCircle', 0.9, 0.9)
		setObjectCamera('coloredOpponentCircle', 'hud')
		addLuaSprite('coloredOpponentCircle', true)
		
		-- Song specific
		if songName == "Libidinousness" then
			if downscroll then
				setProperty('coloredPlayerCircle.y', 20)
				setProperty('coloredOpponentCircle.y', 20)
			else
				setProperty('coloredPlayerCircle.y', 575)
				setProperty('coloredOpponentCircle.y', 575)
			end
		end
		
		if hasDiffSlots then
			makeLuaSprite('iconPlayer', 'healthBars/'..pathToAssets..'P', getProperty('coloredPlayerCircle.x') + properties.circleOffsX, getProperty('coloredPlayerCircle.y') + properties.circleOffsY);
		else
			makeLuaSprite('iconPlayer', 'healthBars/'..pathToAssets, getProperty('coloredPlayerCircle.x') + properties.circleOffsX, getProperty('coloredPlayerCircle.y') + properties.circleOffsY);
		end
		scaleObject('iconPlayer', properties.scale, properties.scale)
		setObjectCamera('iconPlayer', 'hud')
		addLuaSprite('iconPlayer', true)
		
		if hasDiffSlots then
			makeLuaSprite('iconOpponent', 'healthBars/'..pathToAssets.."O", getProperty('coloredOpponentCircle.x') + properties.circleOffsX, getProperty('coloredOpponentCircle.y') + properties.circleOffsY);
		else
			makeLuaSprite('iconOpponent', 'healthBars/'..pathToAssets, getProperty('coloredOpponentCircle.x') + properties.circleOffsX, getProperty('coloredOpponentCircle.y') + properties.circleOffsY);
		end
		scaleObject('iconOpponent', properties.scale, properties.scale)
		setObjectCamera('iconOpponent', 'hud')
		addLuaSprite('iconOpponent', true)
		
		if properties.flipIcons then
			local circX = {getProperty("iconPlayer.x"), getProperty("coloredPlayerCircle.x"), getProperty("iconOpponent.x"), getProperty("coloredOpponentCircle.x")}
			setProperty("iconPlayer.x", circX[3])
			setProperty("coloredPlayerCircle.x", circX[4])
			setProperty("iconOpponent.x", circX[1])
			setProperty("coloredOpponentCircle.x", circX[2])
			
			debugPrint("bitch")
		end
		
		setObjectOrder('healthBarBG', getObjectOrder('healthBar') + 1)
		setObjectOrder('iconP1', getObjectOrder('iconPlayer') + 1)
		setObjectOrder('iconP2', getObjectOrder('iconOpponent') + 1)
		setObjectOrder('scoreTxt', getObjectOrder('iconP2') + 1)
			
		iconP1X = getProperty('coloredPlayerCircle.x')
		iconP2X = getProperty('coloredOpponentCircle.x')
		
		if downscroll then
			setProperty('scoreTxt.y', getProperty('scoreTxt.y') - 100)
		end
		
		updatePadColors()
	end
end

function onUpdate()
	if not optimizationMode then
		setProperty('coloredPlayerCircle.alpha', getProperty('iconP1.alpha'))
		setProperty('iconPlayer.alpha', getProperty('iconP1.alpha'))
		setProperty('coloredOpponentCircle.alpha', getProperty('iconP2.alpha'))
		setProperty('iconOpponent.alpha', getProperty('iconP2.alpha'))
	end
end

function updatePadColors(colorDad, colorBeef)
	if not optimizationMode then
		if colorDad == nil then
			dadColor = rgbToHex(getProperty('dad.healthColorArray'))
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
		else
			setProperty('coloredOpponentCircle.color', getColorFromHex(colorDad))
		end
		
		if colorBeef == nil then
			bfColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
		else
			setProperty('coloredPlayerCircle.color', getColorFromHex(colorBeef))
		end
	end
end

function onEvent(name, v1, v2)
	if name == "Change Character" then
		updatePadColors()
	end
end

function onUpdatePost()
	if not optimizationMode then
		-- Set up Icons:
		bfColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
		dadColor = rgbToHex(getProperty('dad.healthColorArray'))

		if getProperty('health') >= 1.625 then
			setProperty('iconP1.x', iconP1X - 8)
			setProperty('iconP2.x', iconP2X - 4)
		elseif getProperty('health') <= 0.399 then
			setProperty('iconP1.x', iconP1X - 8)
			setProperty('iconP2.x', iconP2X - 8)
		else
			setProperty('iconP1.x', iconP1X)
			setProperty('iconP2.x', iconP2X - 8)
		end
		
		-- More HealthBar Shit lmao
		for i = 1, #(marcoSongs) do
			if songName == marcoSongs[i] then
				if songName == 'Spendthrift' then
					loadGraphic('healthBarBG', 'healthBars/marco/marcoSpendthriftBar')
					setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
					setProperty('healthBarBG.x', getProperty('healthBar.x') + 108)
				else
					loadGraphic('healthBarBG', 'healthBars/marco/marcoBar')
					setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
					setProperty('healthBarBG.x', getProperty('healthBar.x') + 106)
				end
			end
		end
		
		if songName == 'Paycheck' or songName == 'Paycheck (Legacy)' or songName == 'Tofu' then
			loadGraphic('healthBarBG', 'healthBars/aileen/aileenBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'Nunconventional' or songName == 'Nunday Monday' or songName == 'Nunsational' then
			loadGraphic('healthBarBG', 'healthBars/beatrice/beatriceBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		if songName == 'Point Blank' then
			loadGraphic('healthBarBG', 'healthBars/yaku/yakuBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == "Partner" then
			loadGraphic('healthBarBG', 'healthBars/dv/dvBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 106)
		end
		
		if songName == 'Toybox' then
			loadGraphic('healthBarBG', 'healthBars/narrin/narrinBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'Lustality' or songName == 'Lustality Remix' or songName == 'Lustality V1' then
			loadGraphic('healthBarBG', 'healthBars/kiana/kianaBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 79)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'Libidinousness' then
			loadGraphic('healthBarBG', 'healthBars/kiana/kianaBarLibidinousness')
			setProperty('healthBarBG.scale.x', 1.25)
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 96)
		end

		if songName == "Get Villain'd" or songName == "Get Villain'd (Old)" then
			loadGraphic('healthBarBG', 'healthBars/morky/morkyBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 67)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 106)
		end
		
		if songName == 'Unpaid Catastrophe' then
			loadGraphic('healthBarBG', 'healthBars/aizeen/aizeenBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'Cheque' then
			loadGraphic('healthBarBG', 'healthBars/marcus/marcusBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 68)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 106)
		end
		
		if songName == "Get Pico'd" or songName == "Get Gooned" then
			loadGraphic('healthBarBG', 'healthBars/aizi/aiziBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 67)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 108)
		end
		
		if songName == 'Sussus Marcus' or songName == 'Villain In Board' or songName == 'Excrete' then
			loadGraphic('healthBarBG', 'healthBars/marcussy/marcussyBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 106)
		end
		
		-- Bonus Songs
		if songName == 'Marcochrome' then
			loadGraphic('healthBarBG', 'healthBars/michael/michaelBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'Marauder' or songName == 'Marauder (Old)' then
			loadGraphic('healthBarBG', 'healthBars/debug/debugBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'Slow.FLP' or songName == 'Slow.FLP (Old)' then
			loadGraphic('healthBarBG', 'healthBars/nic/nicBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 68)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 105)
		end
		
		if songName == 'Rainy Daze' then
			loadGraphic('healthBarBG', 'healthBars/lillie/lillieBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'FNV' then
			loadGraphic('healthBarBG', 'healthBars/fnv/fnvBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 108)
		end
		
		if songName == 'Instrumentally Deranged' then
			loadGraphic('healthBarBG', 'healthBars/instDeranged/instDerangedBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 105)
		end
		
		if songName == 'Fanfuck Forever' then
			loadGraphic('healthBarBG', 'healthBars/fangirl/fangirlBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 109)
		end
		
		if songName == 'Fast Food Therapy' then
			loadGraphic('healthBarBG', 'healthBars/kyu/kyuBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 68)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 108)
		end
		
		if songName == 'Jerry' then
			loadGraphic('healthBarBG', 'healthBars/00015/shortBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 68)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 106)
		end
		
		if songName == 'VGuy' then
			loadGraphic('healthBarBG', 'healthBars/vguy/vBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 68)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 108)
		end
		
		if songName == 'Tactical Mishap' then
			loadGraphic('healthBarBG', 'healthBars/tc/tcBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'Breacher' then
			loadGraphic('healthBarBG', 'healthBars/uzi/uziBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 115)
		end
		
		if songName == 'Concert Chaos' then
			loadGraphic('healthBarBG', 'healthBars/lily/lilyBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 108)
		end
		
		if songName == "It's Kiana" then
			loadGraphic('healthBarBG', 'healthBars/asul/asulBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
	end
end

function rgbToHex(rgb) -- https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
    return string.format('%02x%02x%02x', math.floor(rgb[1]), math.floor(rgb[2]), math.floor(rgb[3]))
end