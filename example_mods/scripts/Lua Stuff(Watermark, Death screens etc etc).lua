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
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		--Watermark
		makeLuaText('watermark', "Friday Night Villainy", 1000, 0, 690)
		if isStoryMode then
			makeLuaText('watermark2', "Story Mode | " ..difficultyName, 1000, 0, 660)
		elseif isInjectionMode then
			makeLuaText('watermark2', "Injection Mode | " ..difficultyName, 1000, 0, 660)
		elseif isMayhemMode then
			makeLuaText('watermark2', "Mayhem Mode", 1000, 0, 660)
		else
			makeLuaText('watermark2', "Freeplay | " ..difficultyName, 1000, 0, 660)
		end
		setTextSize('watermark', 17)
		setTextSize('watermark2', 17)
		
		setTextAlignment('watermark', 'LEFT')
		setTextAlignment('watermark2', 'LEFT')
		
		setScrollFactor('watermark', 0, 0)
		setScrollFactor('watermark2', 0, 0)
		
		addLuaText('watermark')
		addLuaText('watermark2')
	
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
		
		-- Setting the default death music
		setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'haha you died');
		
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
		
		if songName == 'Concert Chaos' then
			addCharacterToList('lilyDeath', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'lilyDeath')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'lilyDed')
		end
		
		if songName == 'Shucks V2' then
			addCharacterToList('gfshucksDeath', 'boyfriend')
			setPropertyFromClass('GameOverSubstate', 'characterName', 'gfshucksDeath')
			setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'staticDeath')
		end
	end
end

function onUpdatePost(elapsed)
	if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
		-- Dad Characters
		for i = 1, #(marcoNoteVars) do
			if dadName == marcoNoteVars[i] then
				for i = 0, getProperty('opponentStrums.length')-1 do

					setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/MarcoNOTE_assets');

					if not getPropertyFromGroup('notes', i, 'mustPress')
						and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
						or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
						if songName == 'Breacher' then
							if gfSection or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing' then
								setPropertyFromGroup('notes', i, 'texture', 'notes/AileenNOTE_assets');
							else
								setPropertyFromGroup('notes', i, 'texture', 'notes/MarcoNOTE_assets');
							end
						else
							setPropertyFromGroup('notes', i, 'texture', 'notes/MarcoNOTE_assets');
						end
						
					end
				end
			end
		end
		
		for i = 1, #(marcoCCNoteVars) do
			if dadName == marcoCCNoteVars[i] then
				for i = 0, 3 do
					setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/MarcoNOTE_assets');

					if not getPropertyFromGroup('notes', i, 'mustPress')
						and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
						or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation') then
						setPropertyFromGroup('notes', i, 'texture', 'notes/MarcoNOTE_assets');
					end
				end
			end
		end
		
		if dadName == 'marcoOurple' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/ourpleNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/ourpleNOTE_assets');
				end
			end
		end
		
		if dadName == 'beatricephase1' or dadName == 'beatricephase2' 
		or dadName == 'BeatriceLegacyP1' or dadName == 'BeatriceLegacyP2' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/BeatriceNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/BeatriceNOTE_assets');
				end
			end
		end
		  
		if dadName == 'aileen' or dadName == 'aileen-old' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/AileenNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/AileenNOTE_assets');
				end
			end
		end
		if dadName == 'aileenCCP1' then
			for i = 0, 3 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/AileenNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/AileenNOTE_assets');
				end
			end
		end
		
		if dadName == 'kianaPhase3' or dadName == 'kianaPhase2' or dadName == 'kiana' or dadName == 'kianaAttack' 
		or dadName == 'KianaFinalPhase' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/KianaNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/KianaNOTE_assets');
				end

			end
		end
		  
		if dadName == 'Morky' or dadName == 'MorkyMoist' or dadName == 'MorkyHypno' or dadName == 'MorkyHypnoAgain' or dadName == 'MorkyEgg'
		or dadName == 'MorkyHank' or dadName == 'Justky' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/MorkyNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/MorkyNOTE_assets');
				end

			end
		end
		  
		if dadName == 'NicFLP' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/NicNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/NicNOTE_assets');
				end

			end
		end
		
		if dadName == 'DV Phase 0' or dadName == 'DV' or dadName == 'DVTurn' or dadName == 'DV Phase 2' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/dvNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/dvNOTE_assets');
				end

			end
		end
		
		if dadName == 'FangirlIntro' or dadName == 'FangirlP1' or dadName == 'FangirlP2' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/FangirlNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/FangirlNOTE_assets');
				end

			end
		end
		
		if dadName == 'fnv' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/FNVNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'notes/FNVNOTE_assets');
				end

			end
		end
		
		if dadName == 'iniquitousP1' or dadName == 'iniquitousP2' or dadName == 'iniquitousP3' then
			for i = 0, getProperty('opponentStrums.length')-1 do
				
				if songName == 'Iniquitous' and curBeat >= 608 then
					setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/IniquitousMechanicNOTE_assets');
				else
					setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/IniquitousNOTE_assets');
				end

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					if songName == 'Iniquitous' and curBeat >= 608 then
						setPropertyFromGroup('notes', i, 'texture', 'notes/IniquitousMechanicNOTE_assets');
					else
						setPropertyFromGroup('notes', i, 'texture', 'notes/IniquitousNOTE_assets');
					end
				end

			end
		end
		
		if boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
		   for i = 0, getProperty('playerStrums.length')-1 do

				setPropertyFromGroup('playerStrums', i, 'texture', 'notes/AileenNOTE_assets');

				if (getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Hey!'
				or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/AileenNOTE_assets');
					if getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Inwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Inwards/AileenNoteSplashesInwards');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Diamonds' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Diamonds/AileenNoteSplashesDiamond');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Sparkles' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Sparkles/AileenNoteSplashesSparkle');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Outwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Normal/AileenNoteSplashes');
					end
				end

			end
		end
		  
		if boyfriendName == 'TC' or boyfriendName == 'TCAlt' then
		   for i = 0, getProperty('playerStrums.length')-1 do

				setPropertyFromGroup('playerStrums', i, 'texture', 'notes/TCNOTE_assets');

				if (getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Hey!'
				or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/TCNOTE_assets');
					if getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Inwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Inwards/TCnoteSplashesInwards');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Diamonds' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Diamonds/TCnoteSplashesDiamond');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Sparkles' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Sparkles/TCnoteSplashesSparkle');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Outwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Normal/TCnoteSplashes');
					end
				end

			end
		end
		  
		if boyfriendName == 'GFwav' then
			for i = 0, getProperty('playerStrums.length')-1 do

				setPropertyFromGroup('playerStrums', i, 'texture', 'notes/NicNOTE_assets');

				if (getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Hey!'
				or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/NicNOTE_assets');
					if getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Inwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Inwards/NicNoteSplashesInwards');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Diamonds' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Diamonds/NicNoteSplashesDiamond');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Sparkles' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Sparkles/NicNoteSplashesSparkle');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Outwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Normal/NicNoteSplashes');
					end
				end
			end
		end
		  
		if boyfriendName == 'ourple' then
			for i = 0, getProperty('playerStrums.length')-1 do

				setPropertyFromGroup('playerStrums', i, 'texture', 'notes/ourpleNOTE_assets');

				if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/ourpleNOTE_assets');
					if getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Inwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Inwards/ourpleNoteSplashesInwards');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Diamonds' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Diamonds/ourpleNoteSplashesDiamond');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Sparkles' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Sparkles/ourpleNoteSplashesSparkle');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Outwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Normal/ourpleNoteSplashes');
					end
				end
			end
		end
		
		if boyfriendName == 'Kyu' or boyfriendName == 'KyuAlt' then
			for i = 0, getProperty('playerStrums.length')-1 do

				setPropertyFromGroup('playerStrums', i, 'texture', 'notes/KyuNOTE_assets');

				if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/KyuNOTE_assets');
					if getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Inwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Inwards/kyuNoteSplashesInwards');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Diamonds' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Diamonds/kyuNoteSplashesDiamond');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Sparkles' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Sparkles/kyuNoteSplashesSparkle');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Outwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Normal/kyuNoteSplashes');
					end
				end
			end
			for i = 0, getProperty('opponentStrums.length')-1 do
				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'NOTE_assets');
				end
			end
		end
		
		if boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
			for i = 0, getProperty('playerStrums.length')-1 do

				setPropertyFromGroup('playerStrums', i, 'texture', 'notes/MarcoNOTE_assets');

				if (getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Hey!'
				or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation') then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/MarcoNOTE_assets');
					if getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Inwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Inwards/MarcoNoteSplashesInwards');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Diamonds' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Diamonds/MarcoNoteSplashesDiamond');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Sparkles' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Sparkles/MarcoNoteSplashesSparkle');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Outwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Normal/MarcoNoteSplashes');
					end
				end
				if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing' then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/AileenNOTE_assets');
					if getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Inwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Inwards/AileenNoteSplashesInwards');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Diamonds' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Diamonds/AileenNoteSplashesDiamond');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Sparkles' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Sparkles/AileenNoteSplashesSparkle');
					elseif getPropertyFromClass('ClientPrefs', 'noteSplashMode') == 'Outwards' then
						setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'noteSplashes/Normal/AileenNoteSplashes');
					end
				end
			end
		end
		
		for i = 1, #(lilyNoteVars) do
			if boyfriendName == lilyNoteVars[i] then
				for i = 0, getProperty('playerStrums.length')-1 do

					setPropertyFromGroup('playerStrums', i, 'texture', 'notes/LilyNOTE_assets');

					if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' then
						setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/LilyNOTE_assets');
					end
				end
			end
		end
		
		if boyfriendName == 'gfIniquitousP1' or boyfriendName == 'gfIniquitousP2' then
			for i = 0, getProperty('playerStrums.length')-1 do
			
				setPropertyFromGroup('playerStrums', i, 'texture', 'notes/IniquitousMechanicNOTE_assets');

				if (getPropertyFromGroup('unspawnNotes', i, 'noteType') == '' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Hey!'
				or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Sing') then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/IniquitousMechanicNOTE_assets');
				end
			end
		end
		
		if dadName == 'AsulP1' or dadName == 'AsulP2' or dadName == 'AsulP3' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/AsulNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
						setPropertyFromGroup('notes', i, 'texture', 'notes/AsulNOTE_assets');
				end
			end
		end
		
		if dadName == 'narrin' or dadName == 'Narrin Side' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/NarrinNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
						setPropertyFromGroup('notes', i, 'texture', 'notes/NarrinNOTE_assets');
				end
			end
		end
		
		if dadName == 'Yaku' then
			for i = 0, getProperty('opponentStrums.length')-1 do

				setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/YakuNOTE_assets');

				if not getPropertyFromGroup('notes', i, 'mustPress')
					and (getPropertyFromGroup('notes', i, 'noteType') == '' or getPropertyFromGroup('notes', i, 'noteType') == 'Hey!'
					or getPropertyFromGroup('notes', i, 'noteType') == 'No Animation' or getPropertyFromGroup('notes', i, 'noteType') == 'GF Sing') then
						setPropertyFromGroup('notes', i, 'texture', 'notes/YakuNOTE_assets');
				end
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote, noteData)
	if getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled' or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only' then
		if boyfriendName == 'aileenTofu' or boyfriendName == 'aileenTofuAlt' then
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
		
		if boyfriendName == 'marcoFFFP1' or boyfriendName == 'marcoFFFP2' then
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