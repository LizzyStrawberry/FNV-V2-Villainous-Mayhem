local iconP1X
local iconP2X

function onCreatePost()
	if not optimizationMode then
		bfColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
		dadColor = rgbToHex(getProperty('dad.healthColorArray'))

		if songName == 'Scrouge' or songName == 'Cheap Skate (Legacy)' or songName == 'Spendthrift'
		or songName == 'Toxic Mishap' or songName == 'Toxic Mishap (Legacy)' or songName == 'Villainy' or songName == 'Iniquitous'
		or songName == 'Couple Clash' or songName == 'Shucks V2' then
			if songName == 'Spendthrift' then
				setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.6)
				setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.52)
			else
				setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
				setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.43)
			end
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/marco/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/marco/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
			
			setObjectOrder('healthBarBG', getObjectOrder('healthBar') + 1)
			setObjectOrder('iconP1', getObjectOrder('iconPlayer') + 1)
			setObjectOrder('iconP2', getObjectOrder('iconOpponent') + 1)
			setObjectOrder('scoreTxt', getObjectOrder('iconP2') + 1)
		end
		
		if songName == 'Paycheck' or songName == 'Paycheck (Legacy)' or songName == 'Tofu' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.44)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/aileen/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/aileen/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Nunconventional' or songName == 'Nunconventional Simp'
		or songName == 'Nunday Monday'
		or songName == 'Nunsational' or songName == 'Nunsational Simp' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.49)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/aileen/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/aileen/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		if songName == 'Point Blank' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.53)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/yaku/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setProperty('iconPlayer.flipX', true)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/yaku/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' or songName == "Partner" then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/dv/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/dv/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Toybox' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 2)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			setProperty('healthBar.x', getProperty('healthBar.x') - 3)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/narrin/iconSlotP', getProperty('coloredPlayerCircle.x') - 4, getProperty('coloredPlayerCircle.y') - 10);
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/narrin/iconSlotO', getProperty('coloredOpponentCircle.x') - 4, getProperty('coloredOpponentCircle.y') - 10);
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Lustality' or songName == 'Lustality Remix' or songName == 'Lustality V1' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/kiana/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/kiana/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Libidinousness' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') + 220);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') + 220);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			if downscroll then
				setProperty('coloredPlayerCircle.y', 20)
				setProperty('coloredOpponentCircle.y', 20)
			end
			
			makeLuaSprite('iconPlayer', 'healthBars/kiana/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/kiana/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == "Get Villain'd" or songName == "Get Villain'd (Old)" then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.475)
			setProperty('healthBar.x', getProperty('healthBar.x') - 4)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/morky/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/morky/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Unpaid Catastrophe' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.445)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/aizeen/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/aizeen/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Cheque' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.44)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/marcus/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/marcus/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == "Get Pico'd" or songName == "Get Gooned" then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.52)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.478)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/aizi/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/aizi/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Sussus Marcus' or songName == 'Villain In Board' or songName == 'Excrete' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.52)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.442)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/marcussy/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/marcussy/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		-- Bonus Songs		
		if songName == 'Marcochrome' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.445)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/michael/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/michael/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Marauder' or songName == 'Marauder (Old)' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.52)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.565)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/debug/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/debug/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Slow.FLP' or songName == 'Slow.FLP (Old)' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/nic/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/nic/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Rainy Daze' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.5)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/lillie/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/lillie/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'FNV' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/fnv/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/fnv/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Instrumentally Deranged' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.45)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/instDeranged/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/instDeranged/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Fanfuck Forever' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.53)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.545)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/fangirl/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/fangirl/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Fast Food Therapy' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.56)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/kyu/iconSlotO', getProperty('coloredPlayerCircle.x') - 10, getProperty('coloredPlayerCircle.y') - 12);
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/kyu/iconSlotP', getProperty('coloredOpponentCircle.x') - 10, getProperty('coloredOpponentCircle.y') - 12);
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Jerry' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.40)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex('FFFFFF'))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/00015/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/00015/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'VGuy' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.51)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfcolor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/vguy/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/vguy/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Tactical Mishap' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.52)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.47)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfcolor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/tc/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/tc/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Breacher' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.55)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfcolor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/uzi/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/uzi/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == 'Concert Chaos' then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.535)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfcolor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/lily/iconSlotP', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/lily/iconSlotO', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
		end
		
		if songName == "It's Kiana" then
			setProperty('healthBar.scale.y', getProperty('healthBar.scale.y') + 1.5)
			setProperty('healthBar.scale.x', getProperty('healthBar.scale.x') - 0.445)
			setProperty('healthBarBG.scale.y', getProperty('healthBarBG.scale.x') - 0.15)
			setProperty('healthBarBG.scale.x', getProperty('healthBarBG.scale.x') + 0.15)
			
			makeLuaSprite('coloredPlayerCircle', 'healthBars/colorChangingSlot', 850, getProperty('healthBar.y') - 70);
			scaleObject('coloredPlayerCircle', 0.9, 0.9)
			setObjectCamera('coloredPlayerCircle', 'hud')
			setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
			addLuaSprite('coloredPlayerCircle', true)

			makeLuaSprite('coloredOpponentCircle', 'healthBars/colorChangingSlot', 280, getProperty('healthBar.y') - 70);
			scaleObject('coloredOpponentCircle', 0.9, 0.9)
			setObjectCamera('coloredOpponentCircle', 'hud')
			setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
			addLuaSprite('coloredOpponentCircle', true)
			
			makeLuaSprite('iconPlayer', 'healthBars/asul/iconSlot', getProperty('coloredPlayerCircle.x'), getProperty('coloredPlayerCircle.y'));
			scaleObject('iconPlayer', 0.9, 0.9)
			setObjectCamera('iconPlayer', 'hud')
			addLuaSprite('iconPlayer', true)
			
			makeLuaSprite('iconOpponent', 'healthBars/asul/iconSlot', getProperty('coloredOpponentCircle.x'), getProperty('coloredOpponentCircle.y'));
			scaleObject('iconOpponent', 0.9, 0.9)
			setObjectCamera('iconOpponent', 'hud')
			addLuaSprite('iconOpponent', true)
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
	end
end

function onUpdate()
	if not optimizationMode then
		setProperty('coloredPlayerCircle.color', getColorFromHex(bfColor))
		setProperty('coloredOpponentCircle.color', getColorFromHex(dadColor))
		setProperty('coloredPlayerCircle.alpha', getProperty('iconP1.alpha'))
		setProperty('iconPlayer.alpha', getProperty('iconP1.alpha'))
		setProperty('coloredOpponentCircle.alpha', getProperty('iconP2.alpha'))
		setProperty('iconOpponent.alpha', getProperty('iconP2.alpha'))
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
		if songName == 'Scrouge' or songName == 'Cheap Skate (Legacy)' or songName == 'Spendthrift'
		or songName == 'Toxic Mishap' or songName == 'Toxic Mishap (Legacy)' or songName == 'Villainy' or songName == 'Iniquitous'
		or songName == 'Couple Clash' or songName == 'Shucks V2' then
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
		
		if songName == 'Paycheck' or songName == 'Paycheck (Legacy)' or songName == 'Tofu' then
			loadGraphic('healthBarBG', 'healthBars/aileen/aileenBar')
			setProperty('healthBarBG.y', getProperty('healthBar.y') - 69)
			setProperty('healthBarBG.x', getProperty('healthBar.x') + 107)
		end
		
		if songName == 'Nunconventional' or songName == 'Nunconventional Simp'
		or songName == 'Nunday Monday'
		or songName == 'Nunsational' or songName == 'Nunsational Simp' then
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