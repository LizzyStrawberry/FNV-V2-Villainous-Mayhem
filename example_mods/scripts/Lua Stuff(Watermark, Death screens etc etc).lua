local marcoNoteVars = {
	'marco',
	'marco-old',
	'marcophase2',
	'marcophase2_5',
	'marcophase3',
	'marcophase3_5',
	'marcoElectric',
	'marcoTofu',
	'aizeenPhase1',
	'aizeenPhase2',
	'marcussy',
	'MarcussyExcrete',
	'Spendthrift Marco',
	'marcx',
	'marcoshucks'
}

local marcoCCNoteVars = {
	'marcoCCP1',
	'marcoCCP2',
	'marcoCCP3',
	'kaizokuCCP1',
	'kaizokuCCP2',
	'debugGuyScaled'
}

local gfNoteVars = {
	'playablegf',
	'playablegf-old',
	'gfElectric',
	'd-side gf',
	'amongGF',
	'amongGFExcrete',
	'debugGF',
	'Spendthrift GF',
	'GFLibidinousness',
	'gfIniquitousP1',
	'gfIniquitousP2',
	'zuyu', 
	'cassettteGirl',
	'cassetteGoon',
	'cassetteGoonFlipped',
	'PicoFNV',
	'PicoFNVP2',
	'PicoCrimson',
	'd-sidePico',
	'd-sidePico-opposite',
	'lillie',
	'uzi',
	'gfshucks'
}

local lilyNoteVars = {
	'lilyIntroP1',
	'lilyIntroP2',
	'lilyP1',
	'lilyP2',
	'lilyP3',
	'lilyDebugP1',
	'lilyDebugP2',
	'managerChanP1'
}

function onCreate()	
	if not optimizationMode then
		-- Watermark
		local text = ""
		if isStoryMode then
			text = "Story Mode | " ..difficultyName
		elseif isInjectionMode then
			text = "Injection Mode | " ..difficultyName
		elseif isMayhemMode then
			text = "Mayhem Mode"
		elseif isCrossoverSection then
			text = "Crossover Mode | " ..difficultyName
		else
			text = "Freeplay | " ..difficultyName
		end
		makeLuaText('watermark', text, 1000, 0, 700)
		setTextSize('watermark', 17)
		setTextAlignment('watermark', 'LEFT')
		setScrollFactor('watermark', 0, 0)
		addLuaText('watermark')
	
		--Death Screens
		if boyfriendName == 'GFwav' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'GFwav')
		elseif boyfriendName == 'Spendthrift GF' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'Spendthrift GF')
		elseif boyfriendName == 'playablegf-old' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'playablegf-old')
		elseif boyfriendName == 'd-side gf' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'd-side gf')
		elseif boyfriendName == 'amongGF' or boyfriendName == 'amongGF' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'amongGF')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'amogusSplat')
		elseif boyfriendName == 'debugGF' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'debugGF')
		end

		-- Specified Death Screens + Music
		if songName == 'Iniquitous' then
			addCharacterToList('gfIniquitousDeath', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'gfIniquitousDeath')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'staticDeath')
		end
		
		if songName == 'Lustality' or songName == 'Lustality V1' or songName == 'Lustality Remix' then
			addCharacterToList('kianakillsyou', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'kianakillsyou')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'kianakilledyou')
		end
		
		if songName == 'Libidinousness' then
			addCharacterToList('GFLibidinousness', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'GFLibidinousness')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fatalDeath')
		end
		
		if songName == 'Point Blank' then
			addCharacterToList('gfyakudeath', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'gfyakudeath')
		end
		
		if songName == 'Breacher' then
			addCharacterToList('uziDeath', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'uziDeath')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'uziPowerOff')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', '');
		end
		
		if songName == 'Toybox' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'PicoCrimson')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'picoDeath'..getRandomInt(1,2))
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'picoDead')
			setPropertyFromClass('GameOverSubstate', 'endSoundName', 'picoFade')
		end
		
		if songName == 'Fast Food Therapy' then
			addCharacterToList('KyuDead', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'KyuDead')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'kyuDiesOMG')
			setPropertyFromClass('GameOverSubstate', 'endSoundName', 'kyuRev')
		end
		
		if songName == 'Fanfuck Forever' then
			addCharacterToList('marcoFFFDeath', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'marcoFFFDeath')
		end
		
		if songName == 'Tactical Mishap' then
			addCharacterToList('TCDead', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'TCDead')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'tcgotcrit')
			setPropertyFromClass('GameOverSubstate', 'endSoundName', 'tcjiggyget')
		end
		
		if songName == 'Forsaken (Picmixed)' or songName == 'Partner' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'PicoFNV')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', '')
		end
		
		if songName == 'Forsaken' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'cassettteGirl')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', '')
		end
		
		if songName == 'Excrete' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'amongGFExcrete')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'amogusSplat')
		end
		
		if songName == 'Unpaid Catastrophe' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'd-side gf')
		end
		
		if songName == 'Sussus Marcus' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'amongGF')
		end
		
		if songName == 'Marauder' then
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', '')
		end
		
		if songName == 'Slow.FLP' then
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', '')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', '')
		end
		
		if songName == 'VGuy' then
			addCharacterToList('ourpleDead', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'ourpleDead')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ourpleDead')
		end
		
		if songName == "Get Pico'd" then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'dicoDed')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'cassetteGoonEnd')
			setPropertyFromClass('GameOverSubstate', 'endSoundName', 'ReverseCassetteGoon')
		end
		
		if songName == "Get Gooned" then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'goonDed')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'cassetteGoonEnd')
			setPropertyFromClass('GameOverSubstate', 'endSoundName', 'ReverseCassetteGoon')
		end
		
		if songName == 'Jerry' then
			addCharacterToList('playablegf', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'playablegf')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', '')
		end
		
		if songName == 'Rainy Daze' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'lillie')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'splash')
		end
		
		if songName == 'Instrumentally Deranged' then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'porkchop')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'pop')
		end
		
		if songName == 'Negotiation' then
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', '')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', '')
		end
		
		if songName == 'Concert Chaos' then
			addCharacterToList('lilyDeath', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'lilyDeath')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'lilyDed')
		end
		
		if songName == 'Shuckle Fuckle' then
			addCharacterToList('gfshucksDeath', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'gfshucksDeath')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'staticDeath')
		end
	end
end

function onCreatePost()
	if not optimizationMode then
		-- Dad Characters
		for i = 1, #(marcoNoteVars) do
			if dadName == marcoNoteVars[i] then
				for note = 0, getProperty('unspawnNotes.length')-1 do
					if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
						if songName == 'Breacher' then
							if gfSection or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' then
								setPropertyFromGroup('unspawnNotes', note, 'texture', "notes/AileenNOTE_assets");
							else
								setPropertyFromGroup('unspawnNotes', note, 'texture', "notes/MarcoNOTE_assets");
							end
						else
							setPropertyFromGroup('unspawnNotes', note, 'texture', "notes/MarcoNOTE_assets");
						end
					end
				end
			end
		end
		
		for i = 1, #(marcoCCNoteVars) do
			if dadName == marcoCCNoteVars[i] then
				for note = 0, getProperty('unspawnNotes.length')-1 do
					if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') and
					(getPropertyFromGroup('unspawnNotes', note, 'noteType') ~= 'forceAileenNoteSkin' and getPropertyFromGroup('unspawnNotes', note, 'noteType') ~= 'yuri'
					 and getPropertyFromGroup('unspawnNotes', note, 'noteType') ~= 'protag') then
						setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/MarcoNOTE_assets');
					end
				end
			end
		end
		
		if dadName == 'marcoOurple' then	
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/ourpleNOTE_assets');
				end
			end
		end
		
		if dadName == 'beatricephase1' or dadName == 'beatricephase2'
		or dadName == 'BeatriceLegacyP1' or dadName == 'BeatriceLegacyP2' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					if isStoryMode and songName == "Point Blank" then
						setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/YakuNOTE_assets');
					else
						setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/BeatriceNOTE_assets');
					end
				end
			end
		end
		  
		if dadName == 'aileen' or dadName == 'aileen-old' then			
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/AileenNOTE_assets');
				end
			end
		end
		
		if dadName == 'kianaPhase3' or dadName == 'kianaPhase2' or dadName == 'kiana'
		or dadName == 'kianaAttack' or dadName == 'KianaFinalPhase' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/KianaNOTE_assets');
				end
			end
		end
		  
		if dadName == 'Morky' or dadName == 'MorkyMoist' or dadName == 'MorkyHypno'
		or dadName == 'MorkyHypnoAgain' or dadName == 'MorkyEgg' or dadName == 'MorkyHank' or dadName == 'Justky' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/MorkyNOTE_assets');
				end
			end
		end
		  
		if dadName == 'NicFLP' then				
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/NicNOTE_assets');
				end
			end
		end
		
		if dadName == 'DV Phase 0' or dadName == 'DV' or dadName == 'DVTurn' or dadName == 'DV Phase 2' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/dvNOTE_assets');
				end
			end
		end
		
		if dadName == 'FangirlIntro' or dadName == 'FangirlP1' or dadName == 'FangirlP2' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/FangirlNOTE_assets');
				end
			end
		end
		
		if dadName == 'fnv' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/FNVNOTE_assets');
				end
			end
		end
		
		if dadName == 'iniquitousP1' or dadName == 'iniquitousP2' or dadName == 'iniquitousP3' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/IniquitousNOTE_assets');
				end
			end
		end
		
		if dadName == 'AsulP1' or dadName == 'AsulP2' or dadName == 'AsulP3' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/AsulNOTE_assets');
				end
			end
		end
		
		if dadName == 'narrin' or dadName == 'Narrin Side' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/NarrinNOTE_assets');
				end
			end
		end
		
		if dadName == 'Yaku' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/YakuNOTE_assets');
				end
			end
		end
		
		if dadName == 'Negotiation Cross' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					if getPropertyFromGroup("unspawnNotes", note, "noteType") == "GF Sing" then
						setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/AsulNOTE_assets');
					else
						setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/CrossNOTE_assets');
					end
				end
			end
		end
		
		if boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/AileenNOTE_assets');
				end
			end
		end
		  
		if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/TCNOTE_assets');
				end
			end
		end
		  
		if boyfriendName == 'GFwav' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if getPropertyFromGroup('unspawnNotes', note, 'mustPress')
				and (getPropertyFromGroup('unspawnNotes', note, 'noteType') ~= 'Real Poison' and getPropertyFromGroup('unspawnNotes', note, 'noteType') ~= 'Static Notes'
				and getPropertyFromGroup('unspawnNotes', note, 'noteType') ~= 'Lust Notes') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/NicNOTE_assets');
				end
			end
		end
		  
		if boyfriendName == 'ourple' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/ourpleNOTE_assets');
				end
			end
		end
		
		if boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/KyuNOTE_assets');
				end
			end
		end
		
		if boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' or boyfriendName == "Negotiation Marco" then
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					if getPropertyFromGroup('unspawnNotes', note, 'noteType') == 'GF Sing' then
						setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/AileenNOTE_assets');
					else
						setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/MarcoNOTE_assets');
					end
				end
			end
		end
		
		for i = 1, #(lilyNoteVars) do
			if boyfriendName == lilyNoteVars[i] then
				for note = 0, getProperty('unspawnNotes.length')-1 do
					if getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
						setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/LilyNOTE_assets');
					end
				end
			end
			
		end
		
		if boyfriendName == 'gfIniquitousP1' or boyfriendName == 'gfIniquitousP2' then
			for i = 0, getProperty('playerStrums.length')-1 do
				setPropertyFromGroup('playerStrums', i, 'texture', 'notes/IniquitousMechanicNOTE_assets');
			end
				
			for note = 0, getProperty('unspawnNotes.length')-1 do
				if getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', note, 'texture', 'notes/IniquitousMechanicNOTE_assets');
				end
			end
		end
	end
end

local characterChanged = false
function onUpdatePost(elapsed)
	-- For Iniquitous Specifically
	if dadName == 'iniquitousP3' and not characterChanged then
		for i = 0, 3 do
			if songName == 'Iniquitous' and curBeat == 608 then
				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/IniquitousMechanicNOTE_assets');
				characterChanged = true
			end
		end
				
		for note = 0, getProperty('unspawnNotes.length') - 1 do
			if not getPropertyFromGroup('unspawnNotes', note, 'mustPress') then
				if songName == 'Iniquitous' and curBeat == 608 then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/IniquitousMechanicNOTE_assets');
				end
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote, noteData)
	if getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled' or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only' then
		if boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt'
		or boyfriendName == "Negotiation Aileen" then
			if direction == 0 then
				setTimeBarColors('dcdcdc', ' ')
			end
			if direction == 1 then
				setTimeBarColors('729576', ' ')
			end
			if direction == 2 then
				setTimeBarColors('729576', ' ')
			end
			if direction == 3 then
				setTimeBarColors('565656', ' ')
			end
		end
		
		if boyfriendName == 'GFwav' then
			if direction == 0 then
				setTimeBarColors('FFFFFF', ' ')
			end
			if direction == 1 then
				setTimeBarColors('FFFFFF', ' ')
			end
			if direction == 2 then
				setTimeBarColors('FFFFFF', ' ')
			end
			if direction == 3 then
				setTimeBarColors('FFFFFF', ' ')
			end
		end
		
		for i = 1, #(gfNoteVars) do
			if boyfriendName == gfNoteVars[i] then
				if direction == 0 then
					setTimeBarColors('9700FF', ' ')
				end
				if direction == 1 then
					setTimeBarColors('00FFFF', ' ')
				end
				if direction == 2 then
					setTimeBarColors('00FF00', ' ')
				end
				if direction == 3 then
					setTimeBarColors('FF0000', ' ')
				end
			end
		end
		
		for i = 1, #(lilyNoteVars) do
			if boyfriendName == lilyNoteVars[i] then
				if direction == 0 then
					setTimeBarColors('9700FF', ' ')
				end
				if direction == 1 then
					setTimeBarColors('00FFFF', ' ')
				end
				if direction == 2 then
					setTimeBarColors('00FF00', ' ')
				end
				if direction == 3 then
					setTimeBarColors('FF0000', ' ')
				end
			end
		end
		
		if boyfriendName == 'ourple' then
			if direction == 0 then
				setTimeBarColors('fff31d', ' ')
			end
			if direction == 1 then
				setTimeBarColors('327dff', ' ')
			end
			if direction == 2 then
				setTimeBarColors('32ffab', ' ')
			end
			if direction == 3 then
				setTimeBarColors('ff1dc0', ' ')
			end
		end
		
		if boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
			if direction == 0 then
				setTimeBarColors('d2fffb', ' ')
			end
			if direction == 1 then
				setTimeBarColors('3bc2b2', ' ')
			end
			if direction == 2 then
				setTimeBarColors('d2fffb', ' ')
			end
			if direction == 3 then
				setTimeBarColors('3bc2b2', ' ')
			end
		end
		
		if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
			if direction == 0 then
				setTimeBarColors('f65215', ' ')
			end
			if direction == 1 then
				setTimeBarColors('f4cabb', ' ')
			end
			if direction == 2 then
				setTimeBarColors('edbeec', ' ')
			end
			if direction == 3 then
				setTimeBarColors('ee25e8', ' ')
			end
		end
		
		if boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' or boyfriendName == "Negotiation Marco" then
			if direction == 0 then
				setTimeBarColors('4c9e64', ' ')
			end
			if direction == 1 then
				setTimeBarColors('288543', ' ')
			end
			if direction == 2 then
				setTimeBarColors('8bbd99', ' ')
			end
			if direction == 3 then
				setTimeBarColors('23743a', ' ')
			end
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote, noteData)
	if getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled' or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only' then
		for i = 1, #(marcoNoteVars) do
			if dadName == marcoNoteVars[i] then
				if direction == 0 then
					setTimeBarColors('4c9e64', ' ')
				end
				if direction == 1 then
					setTimeBarColors('288543', ' ')
				end
				if direction == 2 then
					setTimeBarColors('8bbd99', ' ')
				end
				if direction == 3 then
					setTimeBarColors('23743a', ' ')
				end
			end
		end
		
		for i = 1, #(marcoCCNoteVars) do
			if dadName == marcoCCNoteVars[i] then
				if direction == 0 then
					setTimeBarColors('4c9e64', ' ')
				end
				if direction == 1 then
					setTimeBarColors('288543', ' ')
				end
				if direction == 2 then
					setTimeBarColors('8bbd99', ' ')
				end
				if direction == 3 then
					setTimeBarColors('23743a', ' ')
				end
			end
		end
		
		if dadName == 'beatricephase1' or dadName == 'beatricephase2' 
		or dadName == 'BeatriceLegacyP1' or dadName == 'BeatriceLegacyP2' then
			if direction == 0 then
				setTimeBarColors('f43123', ' ')
			end
			if direction == 1 then
				setTimeBarColors('87d1f4', ' ')
			end
			if direction == 2 then
				setTimeBarColors('f43123', ' ')
			end
			if direction == 3 then
				setTimeBarColors('87d1f4', ' ')
			end
		end
		
		if dadName == 'kianaPhase3' or dadName == 'kianaPhase2' or dadName == 'kiana' or dadName == 'kianaAttack' 
		or dadName == 'KianaFinalPhase' then
			if direction == 0 then
				setTimeBarColors('3c2727', ' ')
			end
			if direction == 1 then
				setTimeBarColors('eca9a9', ' ')
			end
			if direction == 2 then
				setTimeBarColors('ffffff', ' ')
			end
			if direction == 3 then
				setTimeBarColors('414141', ' ')
			end
		end
		
		if dadName == 'aileen' or dadName == 'aileen-old' 
		or dadName == 'aileenCCP1' or gfName == 'aileenFFF' then
			if direction == 0 then
				setTimeBarColors('dcdcdc', ' ')
			end
			if direction == 1 then
				setTimeBarColors('729576', ' ')
			end
			if direction == 2 then
				setTimeBarColors('729576', ' ')
			end
			if direction == 3 then
				setTimeBarColors('565656', ' ')
			end
		end
		
		if dadName == 'marcoOurple' then
			if direction == 0 then
				setTimeBarColors('fff31d', ' ')
			end
			if direction == 1 then
				setTimeBarColors('327dff', ' ')
			end
			if direction == 2 then
				setTimeBarColors('32ffab', ' ')
			end
			if direction == 3 then
				setTimeBarColors('ff1dc0', ' ')
			end
		end
		
		if dadName == 'FangirlIntro' or dadName == 'FangirlP1' or dadName == 'FangirlP2' then
			if direction == 0 then
				setTimeBarColors('49a02d', ' ')
			end
			if direction == 1 then
				setTimeBarColors('f1a0ed', ' ')
			end
			if direction == 2 then
				setTimeBarColors('49a02d', ' ')
			end
			if direction == 3 then
				setTimeBarColors('f1a0ed', ' ')
			end
		end
		
		if dadName == 'fnv' then
			if direction == 0 then
				setTimeBarColors('930096', ' ')
			end
			if direction == 1 then
				setTimeBarColors('7e00ff', ' ')
			end
			if direction == 2 then
				setTimeBarColors('5e5347', ' ')
			end
			if direction == 3 then
				setTimeBarColors('c60300', ' ')
			end
		end
		
		if dadName == 'iniquitousP1' or dadName == 'iniquitousP2' or dadName == 'iniquitousP3' then
			if direction == 0 then
				setTimeBarColors('FF0000', ' ')
			end
			if direction == 1 then
				setTimeBarColors('000000', ' ')
			end
			if direction == 2 then
				setTimeBarColors('FF0000', ' ')
			end
			if direction == 3 then
				setTimeBarColors('000000', ' ')
			end
		end
		
		if dadName == 'Negotiation Cross' then
			if noteType == "GF Sing" then
				if direction == 0 then
					setTimeBarColors('00b4ff', ' ')
				end
				if direction == 1 then
					setTimeBarColors('7e97aa', ' ')
				end
				if direction == 2 then
					setTimeBarColors('83dbff', ' ')
				end
				if direction == 3 then
					setTimeBarColors('485e6f', ' ')
				end
			else
				if direction == 0 then
					setTimeBarColors('ff283c', ' ')
				end
				if direction == 1 then
					setTimeBarColors('c71d29', ' ')
				end
				if direction == 2 then
					setTimeBarColors('af161f', ' ')
				end
				if direction == 3 then
					setTimeBarColors('930404', ' ')
				end
			end
		end
		
		if dadName == 'AsulP1' or dadName == 'AsulP2' or dadName == 'AsulP3' then
			if direction == 0 then
				setTimeBarColors('00b4ff', ' ')
			end
			if direction == 1 then
				setTimeBarColors('7e97aa', ' ')
			end
			if direction == 2 then
				setTimeBarColors('83dbff', ' ')
			end
			if direction == 3 then
				setTimeBarColors('485e6f', ' ')
			end
		end
		
		if dadName == 'narrin' or dadName == 'Narrin Side' then
			if direction == 0 then
				setTimeBarColors('51216f', ' ')
			end
			if direction == 1 then
				setTimeBarColors('6a3f84', ' ')
			end
			if direction == 2 then
				setTimeBarColors('461d61', ' ')
			end
			if direction == 3 then
				setTimeBarColors('8d739e', ' ')
			end
		end
		
		if dadName == 'Yaku' then
			if direction == 0 then
				setTimeBarColors('bb0007', ' ')
			end
			if direction == 1 then
				setTimeBarColors('ba0006', ' ')
			end
			if direction == 2 then
				setTimeBarColors('67060a', ' ')
			end
			if direction == 3 then
				setTimeBarColors('de0008', ' ')
			end
		end
		
		if dadName == 'DV Phase 0' or dadName == 'DV' or dadName == 'DVTurn' or dadName == 'DV Phase 2' then
			if direction == 0 then
				setTimeBarColors('000000', ' ')
			end
			if direction == 1 then
				setTimeBarColors('FFFFFF', ' ')
			end
			if direction == 2 then
				setTimeBarColors('000000', ' ')
			end
			if direction == 3 then
				setTimeBarColors('FFFFFF', ' ')
			end
		end
		
		if dadName == 'Marcus' or dadName == 'debugGuy'
		or dadName == 'MichaelFA' or dadName == 'MichaelFAalt'
		or dadName == 'aizi' or dadName == 'd-sideMorky' then -- Default colors
			if direction == 0 then
				setTimeBarColors('9700FF', ' ')
			end
			if direction == 1 then
				setTimeBarColors('00FFFF', ' ')
			end
			if direction == 2 then
				setTimeBarColors('00FF00', ' ')
			end
			if direction == 3 then
				setTimeBarColors('FF0000', ' ')
			end
		end
	end
end