-- VERY WARNING: USES PSYCH ENGINE 0.6.1 AND LATER
-- WARNING: if script enabled, edits from chart editor not saves! (chart will always be overwritten to "song_placeholder".json)

-- Author: TheLeerName
-- Source: https://gamebanana.com/tools/10192
-- Description: script does randomizing notes by current seed
-- Version: 5 - Fixed normal difficulty
-- Heavily Modified by Strawberry! Had to make it compatible with how this mod works! Thanks again for the script!
local NR_currentSeed
local NR_enabled = false
function onCreate()
	--luaDebugMode = true
	if isMayhemMode and getPropertyFromClass('PlayState', 'mayhemNRMode') == 'Random' then
		NR_enabled = true
	else
		NR_enabled = false
	end
	if NR_enabled then
		NR_currentSeed = ''..os.time()
		print('[Note Randomizer] Seed: '..NR_currentSeed..' (system time)')

		addHaxeLibrary('FlxRandom', 'flixel.math')
		addHaxeLibrary('String')
		addHaxeLibrary('Sys')
		addHaxeLibrary('Song')
		addHaxeLibrary('Paths')
		addHaxeLibrary('CoolUtil')
		-- rewritten from js to haxe https://stackoverflow.com/a/8076436
		runHaxeCode([[
			var song = Paths.formatToSongPath(PlayState.SONG.song);
			var folder = song;
			if (Paths.formatToSongPath(CoolUtil.difficulties[PlayState.storyDifficulty]) != 'normal')
				song += '-' + Paths.formatToSongPath(CoolUtil.difficulties[PlayState.storyDifficulty]);
			PlayState.SONG = Song.loadFromJson(song, folder);
			//trace('loaded: data/' + folder + '/' + song + '.json');
			var seed_pr = "]]..NR_currentSeed..[[";
			var seed = 0;
	
			for (i in 0...seed_pr.length)
			{
				var code = seed_pr.charCodeAt(i);
				seed += (seed << 5) + code;
				//trace(code + ' -> ' + seed_pr.charAt(i) + ' = ' + seed);
			}
			//Sys.println('[Note Randomizer] Seed: ' + seed_pr);
			Sys.println('[Note Randomizer] Hash: ' + seed);
			var noterandomizer = new FlxRandom(seed);

			for (section in PlayState.SONG.notes)
				for (songNotes in section.sectionNotes)
				{
					if (songNotes[1] >= 0 && songNotes[1] <= 3)
						songNotes[1] = noterandomizer.int(1, 4) - 1;
					else if (songNotes[1] >= 4 && songNotes[1] <= 7)
						songNotes[1] = noterandomizer.int(5, 8) - 1;
				}
			var overlaps = 0;
			var or = false;
			while (or == false)
			{
				or = true;
				for (i in 0...PlayState.SONG.notes.length)
				{
					PlayState.SONG.notes[i].sectionNotes.sort((a, b) -> a[0] - b[0]);
					PlayState.SONG.notes[i].sectionNotes.sort((a, b) -> a[1] - b[1]);
					for (i1 in 0...PlayState.SONG.notes[i].sectionNotes.length)
					{
						if (i1 > 0)
						{
							//trace(PlayState.SONG.notes[i].sectionNotes[i1][0] + ' | ' + PlayState.SONG.notes[i].sectionNotes[i1][1]);
							if ((PlayState.SONG.notes[i].sectionNotes[i1 - 1][0] == PlayState.SONG.notes[i].sectionNotes[i1][0]) && (PlayState.SONG.notes[i].sectionNotes[i1 - 1][1] == PlayState.SONG.notes[i].sectionNotes[i1][1]))
							{
								if (PlayState.SONG.notes[i].sectionNotes[i1][1] >= 0 && PlayState.SONG.notes[i].sectionNotes[i1][1] <= 3)
									PlayState.SONG.notes[i].sectionNotes[i1][1] = noterandomizer.int(1, 4, [ PlayState.SONG.notes[i].sectionNotes[i1][1] + 1 ]) - 1;
								else if (PlayState.SONG.notes[i].sectionNotes[i1][1] >= 4 && PlayState.SONG.notes[i].sectionNotes[i1][1] <= 7)
									PlayState.SONG.notes[i].sectionNotes[i1][1] = noterandomizer.int(5, 8, [ PlayState.SONG.notes[i].sectionNotes[i1][1] + 1 ]) - 1;
								overlaps++;
								or = false;
							}
						}
					}
				}
			}
			if (overlaps > 0)
				Sys.println('[Note Randomizer] Fixed ' + overlaps + ' overlapped notes!')
		]])
	end
end