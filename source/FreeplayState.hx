package;

#if desktop
import Discord.DiscordClient;
#end
import editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = '';

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var colorTween:FlxTween;

	var mechanicMessage:FlxSprite;
	var blackOut:FlxSprite;
	var messageNumber:Int = 0;

	var libidiWarning:FlxText;

	var newBG:FlxSprite;
	var intendedColor:Int;

	var unlockedSelection:FlxSprite;
	var placeholderSelection:FlxSprite;
	var lockedSelection:FlxSprite;

	var transparentButton:FlxSprite;

	var arrowSelectorLeft:FlxSprite;
	var arrowSelectorRight:FlxSprite;
	var selectionText:Alphabet;

	var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;

	var songText:Alphabet;
	var icon:HealthIcon;

	override function create()
	{
		if (CharSelector.isSelectinChar == false)
		{
			Paths.clearStoredMemory();
			Paths.clearUnusedMemory();
		}
		
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		FlxG.mouse.visible = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In MAIN WEEKS Freeplay Mode", null);
		#end

		if (FreeplayCategoryState.freeplayWeekName == "MAIN")
		{
			for (i in 0...WeekData.weeksList.length) {
				if(weekIsLocked(WeekData.weeksList[i])) continue;
	
				var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
				var leSongs:Array<String> = [];
				var leChars:Array<String> = [];
	
				for (j in 0...leWeek.songs.length)
				{
					leSongs.push(leWeek.songs[j][0]);
					leChars.push(leWeek.songs[j][1]);
				}
	
				WeekData.setDirectoryFromWeek(leWeek);
				for (song in leWeek.songs)
				{
					var colors:Array<Int> = song[2];
					if(colors == null || colors.length < 3)
					{
						colors = [146, 113, 253];
					}
					addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
				}
			}
			WeekData.loadTheFirstEnabledMod();
		}
		
		//check if songs were found to be unlocked
		//Story Mode Weeks
		//Week 1
		if (ClientPrefs.villainyBeaten == true && FreeplayCategoryState.freeplayWeekName == "MAIN")
			addSong('Villainy', 1, 'marcophase3', FlxColor.fromRGB(6, 155, 13));

		//Week 2
		if (ClientPrefs.nunWeekFound == true && ClientPrefs.nunWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "NUNS")
			addSong('Nunday Monday', 3, 'mystery', FlxColor.fromRGB(255, 84, 84));
		if (ClientPrefs.nunWeekFound == true && ClientPrefs.nunWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "NUNS")
			addSong('Nunday Monday', 3, 'beatrice', FlxColor.fromRGB(255, 84, 84));

		if (ClientPrefs.nunWeekFound == true && ClientPrefs.nunWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "NUNS")
			addSong('Nunconventional', 3, 'mystery', FlxColor.fromRGB(255, 0, 53));
		if (ClientPrefs.nunWeekFound == true && ClientPrefs.nunWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "NUNS")
			addSong('Nunconventional', 3, 'beatrice', FlxColor.fromRGB(255, 0, 53));

		if (ClientPrefs.nunWeekFound == true && ClientPrefs.nunWeekPlayed == true && ClientPrefs.pointBlankBeaten == true && FreeplayCategoryState.freeplayWeekName == "NUNS")
			addSong('Point Blank', 3, 'yaku', FlxColor.fromRGB(255, 255, 25));

		//Week 3
		if (ClientPrefs.kianaWeekFound == true && ClientPrefs.kianaWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "DEMONS")
			addSong('Forsaken', 3, 'mystery', FlxColor.fromRGB(39, 0, 87));
		if (ClientPrefs.kianaWeekFound == true && ClientPrefs.kianaWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "DEMONS")
			addSong('Forsaken', 3, 'dv', FlxColor.fromRGB(39, 0, 87));

		if (ClientPrefs.kianaWeekFound == true && ClientPrefs.kianaWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "DEMONS")
			addSong('Toybox', 3, 'mystery', FlxColor.fromRGB(213, 84, 192));
		if (ClientPrefs.kianaWeekFound == true && ClientPrefs.kianaWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "DEMONS")
			addSong('Toybox', 3, 'narrin', FlxColor.fromRGB(213, 84, 192));

		if (ClientPrefs.kianaWeekFound == true && ClientPrefs.kianaWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "DEMONS")
			addSong('Lustality Remix', 3, 'mystery', FlxColor.fromRGB(146, 0, 133));
		if (ClientPrefs.kianaWeekFound == true && ClientPrefs.kianaWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "DEMONS")
			addSong('Lustality Remix', 3, 'kiana', FlxColor.fromRGB(146, 0, 133));

		if (ClientPrefs.kianaWeekFound == true && ClientPrefs.kianaWeekPlayed == true && ClientPrefs.libidinousnessBeaten == true && FreeplayCategoryState.freeplayWeekName == "DEMONS")
			addSong('Libidinousness', 3, 'KianaFinalPhase', FlxColor.fromRGB(156, 0, 73));

		/*		//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

		var initSonglist = CoolUtil.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}*/
		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			songText= new Alphabet(90, 320, songs[i].songName, true);
			songText.isMenuItem = true;
			songText.targetY = i - curSelected;
			grpSongs.add(songText);

			var maxWidth = 980;
			if (songText.width > maxWidth)
			{
				songText.scaleX = maxWidth / songText.width;
			}
			songText.snapToPosition();

			Paths.currentModDirectory = songs[i].folder;
			icon= new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);

			if (songText.text == 'Nunday Monday' && ClientPrefs.nunWeekPlayed == false)
				songText.text = '?????? ??????';

			if (songText.text == 'Nunconventional' && ClientPrefs.nunWeekPlayed == false)
				songText.text = '???????????????';

			if (songText.text == 'Point Blank' && ClientPrefs.nunWeekPlayed == false)
				songText.text = '????? ?????';


			if (songText.text == 'Forsaken' && ClientPrefs.kianaWeekFound == false)
				songText.text = '????????';

			if (songText.text == 'Toybox' && ClientPrefs.kianaWeekFound == false)
				songText.text = '??????';

			if (songText.text == 'Lustality Remix' && ClientPrefs.kianaWeekFound == false)
				songText.text = '????????? ?????';

			if (songText.text == 'Libidinousness' && ClientPrefs.kianaWeekFound == false)
				songText.text = '??????????????';
		}
		WeekData.setDirectoryFromWeek();

		if(curSelected >= songs.length) curSelected = 0;

		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		newBG = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/Background'));
		newBG.antialiasing = ClientPrefs.globalAntialiasing;
		//newBG.alpha = 0.6;
		add(newBG);
		newBG.screenCenter();

		newBG.color = songs[curSelected].color;
		intendedColor = newBG.color;

		unlockedSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/selection_CheapSkate'));
		unlockedSelection.antialiasing = ClientPrefs.globalAntialiasing;
		unlockedSelection.screenCenter();
		unlockedSelection.y -= 65;
		//unlockedSelection.alpha = 0;
		add(unlockedSelection);

		lockedSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/selection_QuestionMark'));
		lockedSelection.antialiasing = ClientPrefs.globalAntialiasing;
		lockedSelection.screenCenter();
		lockedSelection.y -= 65;
		lockedSelection.alpha = 0;
		add(lockedSelection);

		placeholderSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/selection_Placeholder'));
		placeholderSelection.antialiasing = ClientPrefs.globalAntialiasing;
		placeholderSelection.screenCenter();
		placeholderSelection.y -= 65;
		placeholderSelection.alpha = 0;
		add(placeholderSelection);

		transparentButton = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/transparentButton'));
		transparentButton.antialiasing = ClientPrefs.globalAntialiasing;
		transparentButton.screenCenter();
		transparentButton.y -= 65;
		transparentButton.alpha = 0;
		add(transparentButton);

		selectionText = new Alphabet(640, 560, "This is a test", true);
		selectionText.setAlignmentFromString('center');
		add(selectionText);

		arrowSelectorLeft = new FlxSprite(lockedSelection.x - 130, 200).loadGraphic(Paths.image('freeplayStuff/arrowSelectorLeft'));
		arrowSelectorLeft.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorLeft.scale.set(0.5, 0.5);
		add(arrowSelectorLeft);

		arrowSelectorRight = new FlxSprite(lockedSelection.x + 700, 200).loadGraphic(Paths.image('freeplayStuff/arrowSelectorRight'));
		arrowSelectorRight.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorRight.scale.set(0.5, 0.5);
		add(arrowSelectorRight);

		getRightArrowX = arrowSelectorRight.x;
		getLeftArrowX = arrowSelectorLeft.x;

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);

		scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
		scoreBG.alpha = 0;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);

		var titleText:Alphabet = new Alphabet(75, 40, "Freeplay", true);
		titleText.scaleX = 0.6;
		titleText.scaleY = 0.6;
		titleText.alpha = 0.4;
		add(titleText);

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 0;
		add(blackOut);

		mechanicMessage = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/message1'));
		mechanicMessage.antialiasing = ClientPrefs.globalAntialiasing;
		mechanicMessage.alpha = 0;
		add(mechanicMessage);

		messageNumber = FlxG.random.int(1, 4);

		if (ClientPrefs.performanceWarning == true)
		{
			libidiWarning = new FlxText(700, 100, 1000, "<R>Warning:<R>\n<DP>'Libidinousness'<DP> takes a lot of juice off of your PC.\nCan it handle it?\n<R>(It is recommended to atleast have a graphics card installed)<R>\n----------------------------
			\n<G>Y:<G> <G>Yes<G> | <r>N:<r> <r>No<r>", 32);
			libidiWarning.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, CENTER);
			libidiWarning.screenCenter(XY);
			libidiWarning.alpha = 0;

			CustomFontFormats.addMarkers(libidiWarning);

			add(libidiWarning);
		}

		songSelector();
		
			var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
			textBG.alpha = 0.6;
			add(textBG);
	
			#if PRELOAD_ALL
			var leText:String = "Press SPACE to listen to the Song / Press TAB to go to Options / Press RESET to Reset your Score and Accuracy.";
			var size:Int = 16;
			#else
			var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
			var size:Int = 18;
			#end
			var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
			text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, RIGHT);
			text.scrollFactor.set();
			add(text);

		changeSelection();
		changeDiff();

		super.create();
	}

	override function closeSubState() {
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	function songSelector()
	{
		switch(songs[curSelected].songName)
		{
			//Tutorial
			case 'Couple Clash':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_CoupleClash'));	
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);	
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;	

				selectionText.text = "Couple Clash";
			}
			
			//main Week	
			case 'Scrouge':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_CheapSkateV3'));	
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);	
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;	

				selectionText.text = "Scrouge";
			}
			case 'Toxic Mishap':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_ToxicMishap'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Toxic Mishap";
			}
			case 'Paycheck':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_PaycheckV2'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Paycheck";
			}
			case 'Villainy':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Villainy'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Villainy";
			}

			//Week 2 - Nun Week
			case 'Nunday Monday' | '?????? ??????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_NundayMonday'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Nunday Monday";

				if (ClientPrefs.nunWeekPlayed == false)
				{
					selectionText.text = "?????? ??????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case 'Nunconventional' | '???????????????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Nunconventional'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Nunconventional";

				if (ClientPrefs.nunWeekPlayed == false)
				{
					selectionText.text = "???????????????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case 'Point Blank' | '????? ?????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_PointBlank'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Point Blank";

				if (ClientPrefs.nunWeekPlayed == false)
				{
					selectionText.text = "????? ?????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}

			//Week 3 - Unnamed Trinity
			case 'Forsaken' | '????????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Forsaken'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1.2, 1.2);
				unlockedSelection.screenCenter();
				unlockedSelection.x += 20;
				unlockedSelection.y -= 60;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Forsaken";

				if (ClientPrefs.kianaWeekPlayed == false)
				{
					selectionText.text = "????????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case 'Toybox' | '??????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Toybox'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Toybox";

				if (ClientPrefs.kianaWeekPlayed == false)
				{
					selectionText.text = "??????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case 'Lustality Remix' | '????????? ?????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_LustalityRemix'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Lustality Remix";

				if (ClientPrefs.kianaWeekPlayed == false)
				{
					selectionText.text = "????????? ?????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case 'Libidinousness' | '??????????????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Libidinousness'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Libidinousness";

				if (ClientPrefs.kianaWeekPlayed == false)
				{
					selectionText.text = "??????????????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}

			default:
			{
				lockedSelection.alpha = 1;
				placeholderSelection.alpha = 0;

				selectionText.text = "I love testing lmao";
			}
		}
	}

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	var holdTime:Float = 0;
	var warning:Bool = false;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, CoolUtil.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
		positionHighscore();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if (!warning)
		{
			if(songs.length > 1)
			{
				if (upP || (FlxG.mouse.overlaps(arrowSelectorLeft) && FlxG.mouse.justPressed))
				{
					changeSelection(-shiftMult);
					songSelector();
					changeDiff();
					holdTime = 0;
				}
				if (downP || (FlxG.mouse.overlaps(arrowSelectorRight) && FlxG.mouse.justPressed))
				{
					changeSelection(shiftMult);
					songSelector();
					changeDiff();
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
						songSelector();
						changeDiff();
					}
				}
			}

			if (FlxG.mouse.overlaps(arrowSelectorLeft))
				FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			else
				FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
	
			if (FlxG.mouse.overlaps(arrowSelectorRight))
				FlxTween.tween(arrowSelectorRight, {x: getRightArrowX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			else
				FlxTween.tween(arrowSelectorRight, {x: getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
	
			if (controls.UI_LEFT_P)
				changeDiff(-1);
			else if (controls.UI_RIGHT_P)
				changeDiff(1);
			else if (upP || downP) changeDiff();
		}

		if (controls.BACK || FlxG.mouse.justPressedRight)
		{
			if (warning)
			{
				warning = false;
				FlxTween.tween(blackOut, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				if (ClientPrefs.performanceWarning == true)
					FlxTween.tween(libidiWarning, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			}
			else
			{
				persistentUpdate = false;
				if(colorTween != null) {
					colorTween.cancel();
				}
				ClientPrefs.optionsFreeplay = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				if (ClientPrefs.inShop == true)
				{
					FlxG.sound.music.fadeOut(0.7); 
					MusicBeatState.switchState(new ShopState());
				}
				else
					MusicBeatState.switchState(new FreeplayCategoryState());
			}
		}
		if(FlxG.keys.justPressed.TAB)	
		{
			persistentUpdate = false;
			ClientPrefs.optionsFreeplay = true;
			ClientPrefs.inMenu = true;
			LoadingState.loadAndSwitchState(new options.OptionsState());
		}
		if(ctrl)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}
		else if(space)
		{
			if(instPlaying != curSelected)
			{
				#if PRELOAD_ALL
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				Paths.currentModDirectory = songs[curSelected].folder;
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				vocals = new FlxSound();

				FlxG.sound.list.add(vocals);
				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
				if (PlayState.playbackRateFreeplay == true)
					FlxG.sound.music.pitch = PlayState.instance.playbackRate;
				vocals.play();
				vocals.persist = true;
				vocals.looped = true;
				vocals.volume = 0.7;
				instPlaying = curSelected;
				#end
			}
		}
		else if ((accepted || (FlxG.mouse.overlaps(transparentButton) && FlxG.mouse.justPressed)) && !warning)
		{
			persistentUpdate = false;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
			/*#if MODS_ALLOWED
			if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
			#else
			if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
			#end
				poop = songLowercase;
				curDifficulty = 1;
				trace('Couldnt find file');
			}*/
			trace(poop);
			if (!ClientPrefs.mechanics && ((curDifficulty == 2 && (songs[curSelected].songName == 'Scrouge' || songs[curSelected].songName == 'Toxic Mishap' || songs[curSelected].songName == 'Paycheck'
				|| songs[curSelected].songName == 'Nunday Monday' || songs[curSelected].songName == 'Nunconventional' || songs[curSelected].songName == 'Forsaken'  || songs[curSelected].songName == 'Toybox'
				|| songs[curSelected].songName == 'Lustality Remix')) //NORMAL SONGS
				|| (curDifficulty == 1 && (songs[curSelected].songName == 'Villainy' || songs[curSelected].songName == 'Point Blank' || songs[curSelected].songName == 'Libidinousness'))))//BOSS SONGS
			{
				trace('IT WORKS LMAO, Go enable mechanics');
				FlxTween.tween(blackOut, {alpha: 0.6}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				ClientPrefs.inMenu = true;
				ClientPrefs.optionsFreeplay = true;

				mechanicMessage.loadGraphic(Paths.image('mainStoryMode/message' + messageNumber));
				FlxTween.tween(mechanicMessage, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new options.OptionsState());
					FreeplayState.destroyFreeplayVocals();
				});
				
				FlxG.sound.music.volume = 1;
			}
			else
			{
				ClientPrefs.resetStoryModeProgress(true);
				ClientPrefs.inMenu = false;
				ClientPrefs.lowQuality = false;
				PlayState.SONG = Song.loadFromJson(poop, songLowercase);
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;

				trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
				if(colorTween != null) {
					colorTween.cancel();
				}

				if (songs[curSelected].songName == 'Toxic Mishap')
				{
					if (!ClientPrefs.mechanics && curDifficulty == 1)
					{
						trace('I got loaded lol [Toxic Mishap], on villainous with no mechanics');
						PlayState.SONG = Song.loadFromJson('toxic-mishap-villainousMechanicless', 'toxic-mishap');
					}
				}

				if (songs[curSelected].songName == 'Villainy')
				{
					if (!ClientPrefs.mechanics && curDifficulty == 0)
					{
						trace('I got loaded lol [Villainy], on villainous with no mechanics');
						PlayState.SONG = Song.loadFromJson('villainy-villainousMechanicless', 'villainy');
					}
				}

				if (songs[curSelected].songName == 'Toybox')
				{
					if (!ClientPrefs.mechanics && curDifficulty == 0)
					{
						trace('I got loaded lol [Toybox], on casual with no mechanics');
						PlayState.SONG = Song.loadFromJson('toybox-casualMechanicless', 'toybox');
					}
					if (!ClientPrefs.mechanics && curDifficulty == 1)
					{
						trace('I got loaded lol [Toybox], on villainous with no mechanics');
						PlayState.SONG = Song.loadFromJson('toybox-villainousMechanicless', 'toybox');
					}
				}
				
				if (songs[curSelected].songName == 'Lustality Remix')
				{
					if (!ClientPrefs.mechanics && curDifficulty == 0)
					{
						trace('I got loaded lol [Lustality Remix], on casual with no mechanics');
						PlayState.SONG = Song.loadFromJson('lustality-remix-casualMechanicless', 'lustality-remix');
					}
					if (!ClientPrefs.mechanics && curDifficulty == 1)
					{
						trace('I got loaded lol [Lustality Remix], on villainous with no mechanics');
						PlayState.SONG = Song.loadFromJson('lustality-remix-villainousMechanicless', 'lustality-remix');
					}
				}

				if (songs[curSelected].songName == 'Libidinousness' && !ClientPrefs.optimizationMode && ClientPrefs.performanceWarning)
				{
					warning = true;
					FlxG.sound.play(Paths.sound('scrollMenu'));
					trace('Loading Low Quality Warning!');
					
					FlxTween.tween(blackOut, {alpha: 0.7}, 1.2, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(libidiWarning, {alpha: 1}, 1.2, {ease: FlxEase.circOut, type: PERSIST});
				}
				else if (FlxG.keys.pressed.SHIFT)
				{
					FlxG.mouse.visible = false;
					LoadingState.loadAndSwitchState(new ChartingState());
					FlxG.sound.music.volume = 0;
				}	
				else if (ClientPrefs.optimizationMode == false && (songs[curSelected].songName == 'Scrouge' || songs[curSelected].songName == 'Toxic Mishap' || songs[curSelected].songName == 'Paycheck' 
				    || songs[curSelected].songName == 'Nunday Monday' || songs[curSelected].songName == 'Nunconventional' || songs[curSelected].songName == 'Point Blank'
					|| songs[curSelected].songName == 'Lustality Remix'))
				{
					MusicBeatState.switchState(new CharSelector());
					FlxG.sound.music.volume = 1;
					FlxG.mouse.visible = true;
				}
				else
				{
					FlxG.mouse.visible = false;
					LoadingState.loadAndSwitchState(new PlayState());
					FlxG.sound.music.volume = 0;
				}
				
				unlockSong();
				destroyFreeplayVocals();
			}
		}
		else if(controls.RESET)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if (warning)
		{
			if (FlxG.keys.justPressed.Y)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				ClientPrefs.lowQuality = false;
				ClientPrefs.saveSettings();

				if (curDifficulty == 0)
					PlayState.SONG = Song.loadFromJson('libidinousness-villainous', 'libidinousness');
				else if (curDifficulty == 1)
					PlayState.SONG = Song.loadFromJson('libidinousness-iniquitous', 'libidinousness');
			}
			else if (FlxG.keys.justPressed.N)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				ClientPrefs.lowQuality = true;
				ClientPrefs.saveSettings();

				if (curDifficulty == 0)
					PlayState.SONG = Song.loadFromJson('libidinousness-villainousoptimized', 'libidinousness');
				else if (curDifficulty == 1)
					PlayState.SONG = Song.loadFromJson('libidinousness-iniquitousoptimized', 'libidinousness');
			}	
			FlxG.mouse.visible = false;
			LoadingState.loadAndSwitchState(new PlayState());
			FlxG.sound.music.volume = 0;
		}
		super.update(elapsed);
	}

	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (Achievements.isAchievementUnlocked('weekIniquitous_Beaten'))
		{
			if (curDifficulty < 0)
				curDifficulty = CoolUtil.difficulties.length-1;
			if (curDifficulty >= CoolUtil.difficulties.length)
				curDifficulty = 0;
		}
		else
		{
			if (CoolUtil.difficulties.contains(CoolUtil.bossFightDifficulty))
			{
				if (curDifficulty < 0)
					curDifficulty = CoolUtil.difficulties.length-2;
				if (curDifficulty >= CoolUtil.difficulties.length - 1)
					curDifficulty = 0;
			}
			else
			{
				if (curDifficulty < 0)
					curDifficulty = CoolUtil.difficulties.length-1;
				if (curDifficulty >= CoolUtil.difficulties.length)
					curDifficulty = 0;
			}
		}

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		diffText.text = '< ' + CoolUtil.difficultyString() + ' >';
		positionHighscore();
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;
			
		var newColor:Int = songs[curSelected].color;
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(newBG, 1, newBG.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
		
		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		//This if is used on songs which have the 'Iniquitous' difficulty on
		if (songs[curSelected].songName == 'Scrouge' || songs[curSelected].songName == 'Toxic Mishap' || songs[curSelected].songName == 'Paycheck' //Week 1
		|| songs[curSelected].songName == 'Nunday Monday' || songs[curSelected].songName == 'Nunconventional'//Week 2
		|| songs[curSelected].songName == 'Forsaken' || songs[curSelected].songName == 'Toybox' || songs[curSelected].songName == 'Lustality Remix' //Week 3
		)
		{	
			CoolUtil.difficulties = CoolUtil.mainWeekDifficulties.copy();
		
			if(CoolUtil.difficulties.contains(CoolUtil.mainWeekDifficulty))
			{
				if (Achievements.isAchievementUnlocked('weekIniquitous_Beaten'))
					curDifficulty = Math.round(Math.max(0, CoolUtil.mainWeekDifficulties.indexOf(CoolUtil.mainWeekDifficulty)));
				else
					curDifficulty = Math.round(Math.max(0, 1));
			}
			else
				curDifficulty = 0;
		}
		else
			CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();

		//Week Songs
		if (songs[curSelected].songName == 'Couple Clash')
			CoolUtil.difficulties = CoolUtil.tcDifficulties.copy();

		if (songs[curSelected].songName == 'Villainy' || songs[curSelected].songName == 'Point Blank' || songs[curSelected].songName == 'Libidinousness')
			CoolUtil.difficulties = CoolUtil.bossFightDifficulties.copy();


		if(CoolUtil.difficulties.contains(CoolUtil.bossFightDifficulty))
			curDifficulty = Math.round(Math.max(0, CoolUtil.bossFightDifficulties.indexOf(CoolUtil.bossFightDifficulty)));
		else if(CoolUtil.difficulties.contains(CoolUtil.tcDifficulty))
			curDifficulty = Math.round(Math.max(0, CoolUtil.tcDifficulties.indexOf(CoolUtil.tcDifficulty)));
		else if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
			curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		else
			curDifficulty = 0;

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
			curDifficulty = newPos;
	}

	private function positionHighscore() {
		scoreText.x = (FlxG.width - scoreText.width) / 2;

		scoreBG.x = scoreText.x - 6;
		scoreBG.scale.x = scoreText.width + 12;
		diffText.x = 640;
		diffText.x -= diffText.width / 2;
	}

	function unlockSong()
	{
		//To make songs have their right Icon after the 'mystery' thingy lmaooibwoaivbadv
		if (songs[curSelected].songName == 'Nunconventional' && ClientPrefs.nunWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Nunconventional!');
			ClientPrefs.nunWeekPlayed = true;
			ClientPrefs.saveSettings();
		}

		if (songs[curSelected].songName == 'Nunday Monday' && ClientPrefs.nunWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Nunday Monday!');
			ClientPrefs.nunWeekPlayed = true;
			ClientPrefs.saveSettings();
		}
			
		if (songs[curSelected].songName == 'Point Blank' && ClientPrefs.nunWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Point Blank!');
			ClientPrefs.nunWeekPlayed = true;
			ClientPrefs.saveSettings();
		}

		if (songs[curSelected].songName == 'Forsaken' && ClientPrefs.kianaWeekFound == false)
		{
			trace('I got loaded lol, Unlocking Forsaken!');
			ClientPrefs.kianaWeekFound = true;
			ClientPrefs.saveSettings();
		}

		if (songs[curSelected].songName == 'Toybox' && ClientPrefs.kianaWeekFound == false)
		{
			trace('I got loaded lol, Unlocking Toybox!');
			ClientPrefs.kianaWeekFound = true;
			ClientPrefs.saveSettings();
		}

		if (songs[curSelected].songName == 'Lustality Remix' && ClientPrefs.kianaWeekFound == false)
		{
			trace('I got loaded lol, Unlocking Lustality Remix!');
			ClientPrefs.kianaWeekFound = true;
			ClientPrefs.saveSettings();
		}
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}