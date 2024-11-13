function onCreatePost()
	--optimization mode
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == true then
		setProperty('camGame.visible', false)
		removeLuaScript('mods/scripts/Charms');
		removeLuaSprite('charmSocket', true)
		removeLuaScript('mods/scripts/Health Bars');
		removeLuaScript('mods/scripts/OpeningCards');
		removeLuaScript('mods/scripts/CinematicBars');
		removeLuaScript('mods/scripts/Lua Stuff(Watermark, Death screens etc etc)');
		clearUnusedMemory();
		clearStoredMemory();
		
		--luaDebugMode = true
		-- Tutorial
		if songName == 'Couple Clash' then
			removeLuaScript('mods/data/couple-clash/Events');
			removeLuaScript('mods/data/couple-clash/Death Lines');
		end
		
		-- Week 1
		if songName == 'Scrouge' then
			removeLuaScript('mods/data/scrouge/Events');
			removeLuaScript('mods/data/scrouge/Cam Movement');
			removeLuaScript('mods/data/scrouge/Death Lines');
			removeLuaScript('mods/data/scrouge/Toggle Trail');
			removeLuaScript('mods/data/scrouge/Dialogue Script');
		end
		if songName == 'Toxic Mishap' then
			removeLuaScript('mods/data/toxic-mishap/Events Script');
			removeLuaScript('mods/data/toxic-mishap/Cam Movement');
			removeLuaScript('mods/data/toxic-mishap/Death Lines');
			removeLuaScript('mods/data/toxic-mishap/Dialogue and Instructions Script');
		end
		if songName == 'Paycheck' then
			removeLuaScript('mods/data/paycheck/Events Script');
			removeLuaScript('mods/data/paycheck/Cam Movement');
			removeLuaScript('mods/data/paycheck/Death Lines');
			removeLuaScript('mods/data/paycheck/Dialogue and Instructions Script with Video');
			removeLuaScript('mods/data/paycheck/Stun Mechanic');
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('iconP2.alpha', 1)
			setProperty('scoreTxt.alpha', 1)
		end
		if songName == 'Villainy' then
			removeLuaScript('mods/data/villainy/Cutscene and Instructions Script with video');
			removeLuaScript('mods/data/villainy/Scroll Speed Mechanic');
			removeLuaScript('mods/data/villainy/Events');
			removeLuaScript('mods/data/villainy/rtxLighting');
			removeLuaScript('mods/data/villainy/Cam Movement');
		end
		
		-- Week 2
		if songName == 'Nunday Monday' then
			removeLuaScript('mods/data/nunconventional/Events');
			removeLuaScript('mods/data/nunconventional/Dialogue Script');
			removeLuaScript('mods/data/nunconventional/Cam Movement');
		end
		if songName == 'Nunconventional' then
			removeLuaScript('mods/data/nunconventional/Events');
			removeLuaScript('mods/data/nunconventional/Dialogue and Instructions Script');
			removeLuaScript('mods/data/nunconventional/Cam Movement');
		end
		if songName == 'Nunconventional Simp' then
			removeLuaScript('mods/data/nunconventional-simp/Events');
			removeLuaScript('mods/data/nunconventional-simp/Instructions Script');
			removeLuaScript('mods/data/nunconventional-simp/Cam Movement');
		end
		if songName == 'Point Blank' then
			removeLuaScript('mods/data/point-blank/Cam Movement + Dodge Mechanic');
			removeLuaScript('mods/data/point-blank/Dialogue and Instructions Script with Video');
			removeLuaScript('mods/data/point-blank/Events');
			removeLuaScript('mods/data/point-blank/Toggle Trail');
		end
		
		-- Week 3
		if songName == 'Forsaken' then
			removeLuaScript('mods/data/forsaken/Events');
			removeLuaScript('mods/data/forsaken/Cam Movement');
			removeLuaScript('mods/data/forsaken/Cutscene and Instructions Script');
			removeLuaScript('mods/data/forsaken/Faith Bar Mechanic');
			removeLuaScript("mods/data/forsaken/You're dead");
			removeLuaScript("mods/data/forsaken/Shaders");
			removeLuaScript("mods/data/forsaken/Note Shaking");
			clearEffects('game')
			clearEffects('hud')
			clearEffects('other')
		end
		if songName == 'Toybox' then
			removeLuaScript('mods/data/toybox/Events');
			removeLuaScript('mods/data/toybox/Cam Movement');
			removeLuaScript('mods/data/toybox/Instructions Script');
			removeLuaScript('mods/data/toybox/Narrin Mechanic');
			removeLuaScript("mods/data/toybox/Death");
		end
		if songName == 'Lustality Remix' then
			removeLuaScript('mods/data/lustality-remix/Events');
			removeLuaScript('mods/data/lustality-remix/Tail Attack and Lust Bar');
			removeLuaScript('mods/data/lustality-remix/Cutscene and Instructions Script');
			removeLuaScript('mods/data/lustality-remix/Death Lines');
			removeLuaScript('mods/data/lustality-remix/Cam Movement');
			removeLuaScript('mods/data/lustality-remix/She killed you');
		end
		if songName == 'Libidinousness' then
			setProperty('iconP2.alpha', 1)
			removeLuaScript('mods/data/libidinousness/Events');
			removeLuaScript('mods/data/libidinousness/Crystal Spike Mechanic');
			removeLuaScript('mods/data/libidinousness/Cutscene and Instructions Script');
			removeLuaScript('mods/data/libidinousness/Death');
			removeLuaScript('mods/data/libidinousness/Cam Movement');
			removeLuaScript('mods/data/libidinousness/HealthBar Flip');
		end
		
		-- Week Legacy
		if songName == 'Cheap Skate (Legacy)' then
			removeLuaScript('mods/data/cheap-skate-(legacy)/Events');
			removeLuaScript('mods/data/cheap-skate-(legacy)/Cam Movement');
			removeLuaScript('mods/data/cheap-skate-(legacy)/Death Lines');
			removeLuaScript('mods/data/cheap-skate-(legacy)/Cutscene Script');
		end
		if songName == 'Toxic Mishap (Legacy)' then
			removeLuaScript('mods/data/toxic-mishap-(legacy)/Events Script');
			removeLuaScript('mods/data/toxic-mishap-(legacy)/Cam Movement');
			removeLuaScript('mods/data/toxic-mishap-(legacy)/Cutscene and Instructions Script');
			removeLuaScript('mods/data/toxic-mishap-(legacy)/Scroll Speed Mechanic');
			removeLuaScript('mods/data/toxic-mishap-(legacy)/Death Lines');
		end
		if songName == 'Paycheck (Legacy)' then
			removeLuaScript('mods/data/paycheck-(legacy)/Events Script');
			removeLuaScript('mods/data/paycheck-(legacy)/Cam Movement');
			removeLuaScript('mods/data/paycheck-(legacy)/Cutscene and Instructions Script');
			removeLuaScript('mods/data/paycheck-(legacy)/Stun Mechanic');
			removeLuaScript('mods/data/paycheck-(legacy)/Death Lines');
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('iconP2.alpha', 1)
			setProperty('scoreTxt.alpha', 1)
		end
		
		-- Week Sus
		if songName == 'Sussus Marcus' then
			removeLuaScript('mods/data/sussus-marcus/Events');
			removeLuaScript('mods/data/sussus-marcus/Cam Movement');
			removeLuaScript('mods/data/sussus-marcus/Amogleen');
		end	
		if songName == 'Villain In Board' then
			removeLuaScript('mods/data/villain-in-board/Events');
			removeLuaScript('mods/data/villain-in-board/Instructions Script');
			removeLuaScript('mods/data/villain-in-board/Cam Movement');
			removeLuaScript('mods/data/villain-in-board/Amogleen');
			removeLuaScript('mods/data/villain-in-board/Sabotage Mechanic');
		end
		if songName == 'Excrete' then
			removeLuaScript('mods/data/excrete/Events');
			removeLuaScript('mods/data/excrete/Instructions Script');
			removeLuaScript('mods/data/excrete/Cam Movement');
			removeLuaScript('mods/data/excrete/Sabotage Mechanic');
			clearEffects('game')
			clearEffects('hud')
		end
		
		-- Week Morky
		if songName == 'Spendthrift' then
			removeLuaScript('mods/data/spendthrift/Events');
			removeLuaScript('mods/data/spendthrift/Cam Movement');
			removeLuaScript('mods/data/spendthrift/Death Lines');
		end
		if songName == 'Instrumentally Deranged' then
			removeLuaScript('mods/data/instrumentally-deranged/Cam Movement');
		end
		if songName == "Get Villain'd" then
			removeLuaScript('mods/data/get-villaind/Events');
			removeLuaScript('mods/data/get-villaind/Cam Movement');
			removeLuaScript('mods/data/get-villaind/Cinematic Bars');
			removeLuaScript('mods/data/get-villaind/Instructions Script');
		end
		
		if songName == "Get Villain'd (Old)" then
			removeLuaScript('mods/data/get-villaind-(old)/Events');
			removeLuaScript('mods/data/get-villaind-(old)/Cam Movement');
			removeLuaScript('mods/data/get-villaind-(old)/Cinematic Bars');
			removeLuaScript('mods/data/get-villaind-(old)/Instructions Script');
		end
		
		-- Week D-sides
		if songName == 'Unpaid Catastrophe' then
			removeLuaScript('mods/data/unpaid-catastrophe/Events Script');
			removeLuaScript('mods/data/unpaid-catastrophe/Cam Movement');
			removeLuaScript('mods/data/unpaid-catastrophe/Instructions Script');
		end
		if songName == 'Cheque' then
			removeLuaScript('mods/data/cheque/Events Script');
			removeLuaScript('mods/data/cheque/Cam Movement');
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('iconP2.alpha', 1)
			setProperty('scoreTxt.alpha', 1)
		end
		if songName == "Get Gooned" then
			removeLuaScript('mods/data/get-gooned/Cam Movement');
			removeLuaScript('mods/data/get-gooned/Events');
			removeLuaScript('mods/data/get-gooned/Note Swap');
		end
		
		--Freeplay Songs
		if songName == 'Lustality' then
			removeLuaScript('mods/data/lustality/Events');
			removeLuaScript('mods/data/lustality/Tail Attack and Lust Bar');
			removeLuaScript('mods/data/lustality/Instructions Script');
			removeLuaScript('mods/data/lustality/Death Lines');
			removeLuaScript('mods/data/lustality/She killed you');
			removeLuaScript('mods/data/lustality/Cam Movement');
		end
		if songName == 'Lustality V1' then
			removeLuaScript('mods/data/lustality-v1/Tail Attack and Lust Bar');
			removeLuaScript('mods/data/lustality-v1/Instructions Script');
			removeLuaScript('mods/data/lustality-v1/Events');
			removeLuaScript('mods/data/lustality-v1/Death Lines');
			removeLuaScript('mods/data/lustality-v1/She killed you');
			removeLuaScript('mods/data/lustality-v1/Cam Movement');
		end
		if songName == 'Nunsational' then
			removeLuaScript('mods/data/nunsational/Events');
			removeLuaScript('mods/data/nunsational/Cam Movement');
			removeLuaScript('mods/data/nunsational/Instructions Script');
		end
		if songName == 'Nunsational Simp' then
			removeLuaScript('mods/data/nunsational-simp/Events');
			removeLuaScript('mods/data/nunsational-simp/Cam Movement');
			removeLuaScript('mods/data/nunsational-simp/Instructions Script');
		end
		if songName == 'Tofu' then
			removeLuaScript('mods/data/tofu/Events');
			removeLuaScript('mods/data/tofu/Cam Movement');
		end		
		if songName == 'Marcochrome' then
			removeLuaScript('mods/data/marcochrome/Events');
			removeLuaScript('mods/data/marcochrome/Cam Movement');
			removeLuaScript('mods/data/marcochrome/Shaders');
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('iconP2.alpha', 1)
			setProperty('scoreTxt.alpha', 1)
			clearEffects('game')
			clearEffects('hud')
			clearEffects('other')
		end
		if songName == 'Rainy Daze' then
			removeLuaScript('mods/data/rainy-daze/Events');
			removeLuaScript('mods/data/rainy-daze/Cam Movement');
			removeLuaScript('mods/data/rainy-daze/rain');
		end
		if songName == 'Fanfuck Forever' then
			removeLuaScript('mods/data/fanfuck-forever/Cam Movement');
			removeLuaScript('mods/data/fanfuck-forever/Events');
			removeLuaScript('mods/data/fanfuck-forever/Death');
		end
		if songName == 'FNV' then
			removeLuaScript('mods/data/fnv/Events');
			removeLuaScript('mods/data/fnv/Toggle Trail');
			removeLuaScript('mods/data/fnv/Cam Movement');
		end
		if songName == 'Slow.FLP' then
			removeLuaScript('mods/data/slowflp/Funny Event');
			removeLuaScript('mods/data/slowflp/Cam Movement');
		end
		if songName == 'Marauder' then
			removeLuaScript('mods/data/marauder/Events');
			removeLuaScript('mods/data/marauder/Shaders');
			removeLuaScript('mods/data/marauder/Cam Movement');
			removeLuaScript('mods/data/marauder/Instructions Script');
			removeLuaScript('mods/data/marauder/Mechanics');
			removeLuaScript('mods/data/marauder/Death');
			clearEffects('game')
			clearEffects('hud')
			runHaxeCode([[
				FlxG.game.setFilters([]);
			]])
		end
		
		-- Crossover Songs
		if songName == 'VGuy' then
			removeLuaScript('mods/data/vguy/Cam Movement');
			removeLuaScript('mods/data/vguy/Ourple Takeover');
		end
		if songName == 'Tactical Mishap' then
			removeLuaScript('mods/data/tactical-mishap/Events Script');
			removeLuaScript('mods/data/tactical-mishap/Cam Movement');
			removeLuaScript('mods/data/tactical-mishap/Dialogue Script');
			removeLuaScript('mods/data/tactical-mishap/Silhouette');
			removeLuaScript('mods/data/tactical-mishap/Toggle Trail');
			removeLuaScript('mods/data/tactical-mishap/Death Lines');
		end
		if songName == 'Fast Food Therapy' then
			removeLuaScript('mods/data/fast-food-therapy/Cam Movement');
			removeLuaScript('mods/data/fast-food-therapy/Events');
			removeLuaScript('mods/data/fast-food-therapy/Note Swap');
		end
		if songName == 'Breacher' then
			removeLuaScript('mods/data/breacher/Cam Movement');
			removeLuaScript('mods/data/breacher/Events');
			removeLuaScript('mods/data/breacher/Instructions Script');
			removeLuaScript('mods/data/breacher/Shaders');
			removeLuaScript('mods/data/breacher/Note Swap');
			removeLuaScript('mods/data/breacher/Dodging Mechanic');
			clearEffects('game')
			clearEffects('hud')
			clearEffects('other')
		end
		if songName == "Concert Chaos" then
			removeLuaScript('mods/data/concert-chaos/Events');
			removeLuaScript('mods/data/concert-chaos/VS Sustain');
			removeLuaScript('mods/data/concert-chaos/Yuri');
			removeLuaScript('mods/data/concert-chaos/Cam Movement');
			removeLuaScript('mods/data/concert-chaos/Protag');
			removeLuaScript('mods/data/concert-chaos/health drain');
			removeLuaScript('mods/data/concert-chaos/Death');
			setProperty('healthBar.alpha', 1)
			setProperty('healthBarBG.alpha', 1)
			setProperty('iconP1.alpha', 1)
			setProperty('iconP2.alpha', 1)
		end
		
		-- Extras
		if songName == 'Marauder (Old)' then
			removeLuaScript('mods/data/marauder-(old)/Events');
			removeLuaScript('mods/data/marauder-(old)/Death');
			removeLuaScript('mods/data/marauder-(old)/Cam Movement');
			removeLuaScript('mods/data/marauder-(old)/Mechanics');
			removeLuaScript('mods/data/marauder-(old)/Instructions Script');
			clearEffects('game')
			clearEffects('hud')
		end
		if songName == 'Slow.FLP (Old)' then
			removeLuaScript('mods/data/slowflp-(old)/Funny Event');
			removeLuaScript('mods/data/slowflp-(old)/Cam Movement');
		end
		if songName == "It's Kiana" then
			removeLuaScript('mods/data/its-kiana/Events');
			removeLuaScript('mods/data/its-kiana/Cam Movement');
		end
		if songName == 'Forsaken (Picmixed)' then
			removeLuaScript('mods/data/forsaken-(picmixed)/Events');
			removeLuaScript('mods/data/forsaken-(picmixed)/Cam Movement');
			removeLuaScript('mods/data/forsaken-(picmixed)/Instructions Script');
			removeLuaScript('mods/data/forsaken-(picmixed)/Faith Bar Mechanic');
			removeLuaScript("mods/data/forsaken-(picmixed)/You're dead");
			removeLuaScript("mods/data/forsaken-(picmixed)/Note Shaking");
			removeLuaScript("mods/data/forsaken-(picmixed)/Shaders");
			clearEffects('game')
			clearEffects('hud')
			clearEffects('other')
		end
		if songName == "Get Pico'd" then
			removeLuaScript('mods/data/get-picod/Cam Movement');
			removeLuaScript('mods/data/get-picod/Events');
			removeLuaScript('mods/data/get-picod/Note Swap');
		end
		if songName == 'Partner' then
			removeLuaScript('mods/data/partner/Events');
			removeLuaScript('mods/data/partner/Cam Movement');
			removeLuaScript('mods/data/partner/Instructions Script');
			removeLuaScript('mods/data/partner/Faith Bar Mechanic');
			removeLuaScript("mods/data/partner/You're dead");
			removeLuaScript("mods/data/partner/Note Shaking");
			removeLuaScript("mods/data/partner/Shaders");
			clearEffects('game')
			clearEffects('hud')
			clearEffects('other')
		end
		if songName == 'Shucks V2' then
			removeLuaScript('mods/data/shucks-v2/Events');
			removeLuaScript('mods/data/shucks-v2/Cam Movement');
			removeLuaScript('mods/data/shucks-v2/Shaders');
			removeLuaScript('mods/data/shucks-v2/rtxLighting');
			removeLuaScript('mods/data/shucks-v2/Death');
		end
	end
end