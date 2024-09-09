local allowedSongs = {'Couple Clash', -- Tutorial

					  'Scrouge', 'Toxic Mishap', 'Paycheck', 'Villainy', -- Main Week
					  'Nunday Monday', 'Nunconventional', 'Point Blank', -- Week 2
					  'Forsaken', 'Lustality Remix', 'Toybox', 'Libidinousness', -- Week 3
					  'Spendthrift', 'Instrumentally Deranged', "Get Villain'd", -- Week Morky
					  'Cheap Skate (Legacy)', 'Toxic Mishap (Legacy)', 'Paycheck (Legacy)', -- Week Legacy
					  'Unpaid Catastrophe', 'Cheque', 'Get Gooned', -- Week D-sides
					  'Sussus Marcus', 'Villain In Board', 'Excrete', -- Week Sus
					  -- VS Iniquitous
					  'Iniquitous',
					  
					  -- Freeplay / Shop Songs
					  'Lustality', 'Lustality V1', 'Nunsational', 'Nunsational Simp', 'Tofu', 'Nunconventional Simp',
					  'Jerry', 'Fanfuck Forever', 'Slow.FLP', 'FNV', 'Rainy Daze', 'Marauder',
					  
					  -- Crossover Songs
					  'VGuy', 'Tactical Mishap', 'Fast Food Therapy','Breacher', 'Concert Chaos',
					  
					  -- Extras
					  "It's Kiana", "Get Pico'd", 'Forsaken (Picmixed)', 'Slow.FLP (Old)', 'Marauder (Old)', 'Partner', 'Shucks V2'
					}

function onCreate()
	if getPropertyFromClass('ClientPrefs', 'cinematicBars') == true then
		for i = 1, #(allowedSongs) do
			if songName == allowedSongs[i] then
				makeLuaSprite('bartop', '', -100, -660)
				makeGraphic('bartop', 1480, 720,'000000')
				setObjectCamera('bartop','hud')
				setScrollFactor('bartop', 0, 0)

				makeLuaSprite('barbot', '', -100, 660)
				makeGraphic('barbot', 1480, 120, '000000')
				setScrollFactor('barbot', 0, 0)
				setObjectCamera('barbot', 'hud')	
		
				addLuaSprite('barbot', false)
				addLuaSprite('bartop', false)
			end
		end
	end
end