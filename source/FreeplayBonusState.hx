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

class FreeplayBonusState extends MusicBeatState
{
	var songs:Array<SongBonusMetadata> = [];

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

	var message1:FlxSprite;
	var message2:FlxSprite;
	var message3:FlxSprite;
	var message4:FlxSprite;
	var message5:FlxSprite;
	var blackOut:FlxSprite;
	var messageNumber:Int = 0;
	var seizureWarning:FlxText;

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
		DiscordClient.changePresence("In BONUS WEEKS Freeplay Mode", null);
		#end

		for (i in 0...WeekData.weeksList.length) {
			/*if(weekIsLocked(WeekData.weeksList[i])) continue;

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
			}*/
		}
		WeekData.loadTheFirstEnabledMod();
		
		//check if songs were found to be unlocked
		//Bonus Weeks Songs

		//Week Morky
		if (ClientPrefs.morkyWeekFound == true && ClientPrefs.morkyWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "MORK")
			addSong('Spendthrift', 3, 'mystery', FlxColor.fromRGB(40, 255, 53));
		if (ClientPrefs.morkyWeekFound == true && ClientPrefs.morkyWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "MORK")
			addSong('Spendthrift', 3, 'marco', FlxColor.fromRGB(40, 255, 53));

		if (ClientPrefs.morkyWeekFound == true && ClientPrefs.morkyWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "MORK")
			addSong('Instrumentally Deranged', 3, 'mystery', FlxColor.fromRGB(0, 113, 253));
		if (ClientPrefs.morkyWeekFound == true && ClientPrefs.morkyWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "MORK")
			addSong('Instrumentally Deranged', 3, 'dooglas', FlxColor.fromRGB(0, 113, 253));

		if (ClientPrefs.morkyWeekFound == true && ClientPrefs.morkyWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "MORK")
			addSong('Get Villaind', 3, 'mystery', FlxColor.fromRGB(66, 255, 153));
		if (ClientPrefs.morkyWeekFound == true && ClientPrefs.morkyWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "MORK")
			addSong('Get Villaind', 3, 'morky', FlxColor.fromRGB(66, 255, 153));
		
		//Week Legacy
		if (ClientPrefs.legacyWeekFound == true && ClientPrefs.legacyWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "LEGACY")
			addSong('Cheap Skate (Legacy)', 3, 'mystery', FlxColor.fromRGB(66, 255, 153));
		if (ClientPrefs.legacyWeekFound == true && ClientPrefs.legacyWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "LEGACY")
			addSong('Cheap Skate (Legacy)', 3, 'marco-old', FlxColor.fromRGB(66, 255, 153));

		if (ClientPrefs.legacyWeekFound == true && ClientPrefs.legacyWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "LEGACY")
			addSong('Toxic Mishap (Legacy)', 3, 'mystery', FlxColor.fromRGB(6, 155, 13));
		if (ClientPrefs.legacyWeekFound == true && ClientPrefs.legacyWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "LEGACY")
			addSong('Toxic Mishap (Legacy)', 3, 'marco-old', FlxColor.fromRGB(6, 155, 13));

		if (ClientPrefs.legacyWeekFound == true && ClientPrefs.legacyWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "LEGACY")
			addSong('Paycheck (Legacy)', 3, 'mystery', FlxColor.fromRGB(163, 187, 137));
		if (ClientPrefs.legacyWeekFound == true && ClientPrefs.legacyWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "LEGACY")
			addSong('Paycheck (Legacy)', 3, 'aileen-old', FlxColor.fromRGB(163, 187, 137));

		//Week Sus
		if (ClientPrefs.susWeekFound == true && ClientPrefs.susWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "SUS")
			addSong('Sussus Marcus', 3, 'mystery', FlxColor.fromRGB(80, 155, 80));
		if (ClientPrefs.susWeekFound == true && ClientPrefs.susWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "SUS")
			addSong('Sussus Marcus', 3, 'marcussy', FlxColor.fromRGB(80, 155, 80));

		if (ClientPrefs.susWeekFound == true && ClientPrefs.susWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "SUS")
			addSong('Villain In Board', 3, 'mystery', FlxColor.fromRGB(22, 82, 22));
		if (ClientPrefs.susWeekFound == true && ClientPrefs.susWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "SUS")
			addSong('Villain In Board', 3, 'marcussy', FlxColor.fromRGB(22, 82, 22));

		if (ClientPrefs.susWeekFound == true && ClientPrefs.susWeekPlayed == true && ClientPrefs.excreteBeaten == true && FreeplayCategoryState.freeplayWeekName == "SUS")
			addSong('Excrete', 3, 'marcussyExcrete', FlxColor.fromRGB(0, 135, 0));

		//Week D-sides
		if (ClientPrefs.dsideWeekFound == true && ClientPrefs.dsideWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "DSIDES")
			addSong('Unpaid Catastrophe', 3, 'mystery', FlxColor.fromRGB(166, 53, 255));
		if (ClientPrefs.dsideWeekFound == true && ClientPrefs.dsideWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "DSIDES")
			addSong('Unpaid Catastrophe', 3, 'aizeenPhase2', FlxColor.fromRGB(166, 53, 255));

		if (ClientPrefs.dsideWeekFound == true && ClientPrefs.dsideWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "DSIDES")
			addSong('Cheque', 3, 'mystery', FlxColor.fromRGB(106, 233, 253));
		if (ClientPrefs.dsideWeekFound == true && ClientPrefs.dsideWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "DSIDES")
			addSong('Cheque', 3, 'marcus', FlxColor.fromRGB(106, 233, 253));

		if (ClientPrefs.dsideWeekFound == true && ClientPrefs.dsideWeekPlayed == false && FreeplayCategoryState.freeplayWeekName == "DSIDES")
			addSong("Get Gooned", 3, 'mystery', FlxColor.fromRGB(20, 153, 255));
		if (ClientPrefs.dsideWeekFound == true && ClientPrefs.dsideWeekPlayed == true && FreeplayCategoryState.freeplayWeekName == "DSIDES")
			addSong("Get Gooned", 3, 'aizi', FlxColor.fromRGB(20, 153, 255));

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

			if (songText.text == 'Get Villaind' && ClientPrefs.morkyWeekPlayed == false)
				songText.text = '??? ?????????';
			else if (songText.text == 'Get Villaind' && ClientPrefs.morkyWeekPlayed == true)
				songText.text = "Get Villain'd";

			if (songText.text == 'Spendthrift' && ClientPrefs.morkyWeekPlayed == false)
				songText.text = '???????????';

			if (songText.text == 'Instrumentally Deranged' && ClientPrefs.morkyWeekPlayed == false)
				songText.text = '????. ????????';


			if (songText.text == 'Cheap Skate (Legacy)' && ClientPrefs.legacyWeekPlayed == false)
				songText.text = '????? ????? (???)';

			if (songText.text == 'Toxic Mishap (Legacy)' && ClientPrefs.legacyWeekPlayed == false)
				songText.text = '????? ?????? (???)';

			if (songText.text == 'Paycheck (Legacy)' && ClientPrefs.legacyWeekPlayed == false)
				songText.text = '?????????? (???)';


			if (songText.text == 'Sussus Marcus' && ClientPrefs.susWeekPlayed == false)
				songText.text = '?????? ??????';

			if (songText.text == 'Villain In Board' && ClientPrefs.susWeekPlayed == false)
				songText.text = '??????? ?? ?????';

			if (songText.text == 'Excrete' && ClientPrefs.susWeekPlayed == false)
				songText.text = '???????';

			if (songText.text == 'Unpaid Catastrophe' && ClientPrefs.dsideWeekPlayed == false)
				songText.text = '?????? ???????????';

			if (songText.text == 'Cheque' && ClientPrefs.dsideWeekPlayed == false)
				songText.text = '??????';

			if (songText.text == "Get Gooned" && ClientPrefs.dsideWeekPlayed == false)
				songText.text = '??? ??????';
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
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, LEFT);

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

		message1 = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/message1'));
		message1.antialiasing = ClientPrefs.globalAntialiasing;
		message1.alpha = 0;
		add(message1);

		message2 = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/message2'));
		message2.antialiasing = ClientPrefs.globalAntialiasing;
		message2.alpha = 0;
		add(message2);

		message3 = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/message3'));
		message3.antialiasing = ClientPrefs.globalAntialiasing;
		message3.alpha = 0;
		add(message3);

		message4 = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/message4'));
		message4.antialiasing = ClientPrefs.globalAntialiasing;
		message4.alpha = 0;
		add(message4);

		seizureWarning = new FlxText(700, selectionText.y + 400, FlxG.width, "WARNING: This song has scripted events that could make some people uncomfortable. We made them weak, but if you're REALLY sensitive, make sure you go to options, and disable mechanics.", 16);
		seizureWarning.setFormat("VCR OSD Mono", 20, FlxColor.RED, CENTER);
		seizureWarning.screenCenter(XY);
		seizureWarning.y += 290;
		seizureWarning.alpha = 0;
		add(seizureWarning);

		messageNumber = FlxG.random.int(1, 4);

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
		songs.push(new SongBonusMetadata(songName, weekNum, songCharacter, color));
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
			//Week Morky
			case 'Spendthrift' | "???????????":
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Spendthrift'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;
	
				placeholderSelection.alpha = 0;
	
				selectionText.text = "Spendthrift";
	
				if (ClientPrefs.morkyWeekPlayed == false)
				{
					selectionText.text = "???????????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case 'Instrumentally Deranged' | "????. ????????":
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_InstrumentallyDeranged'));
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				unlockedSelection.scale.set(1, 1);
				lockedSelection.alpha = 0;
	
				placeholderSelection.alpha = 0;
	
				selectionText.text = "Instrumentally Deranged";

				if (ClientPrefs.morkyWeekPlayed == false)
				{
					selectionText.text = "????. ????????";
					lockedSelection.alpha = 1;
				}
			}
			case 'Get Villaind' | "??? ?????????":
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_GetVillaind'));
				unlockedSelection.frames = Paths.getSparrowAtlas('freeplayStuff/selection_GetVillaind');
				unlockedSelection.animation.addByPrefix('idle', "mork mork0", 24);
				unlockedSelection.scale.set(0.68, 0.657);
				unlockedSelection.x = 115;
				unlockedSelection.y -= 107;
				unlockedSelection.animation.play('idle');
				lockedSelection.alpha = 0;
				unlockedSelection.alpha = 1;
	
				placeholderSelection.alpha = 0;
	
				selectionText.text = "Get Villain'd";
	
				if (ClientPrefs.morkyWeekPlayed == false)
				{
					selectionText.text = "??? ?????????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}

			//Week Sus
			case 'Sussus Marcus' | '?????? ??????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_SussusMarcus'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Sussus Marcus";

				if (ClientPrefs.susWeekPlayed == false)
				{
					selectionText.text = "?????? ??????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case 'Villain In Board' | '??????? ?? ?????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_VillainInBoard'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Villain In Board";

				if (ClientPrefs.susWeekPlayed == false)
				{
					selectionText.text = "??????? ?? ?????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case 'Excrete' | '???????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Excrete'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1.15, 1.15);
				unlockedSelection.screenCenter();
				unlockedSelection.x += 15;
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Excrete";

				if (ClientPrefs.susWeekPlayed == false)
				{
					selectionText.text = "???????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}

			//week Legacy
			case 'Cheap Skate (Legacy)' | '????? ????? (???)':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_CheapSkate'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Cheap Skate (Legacy)";

				if (ClientPrefs.legacyWeekPlayed == false)
				{
					selectionText.text = "????? ????? (???)";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}

			case 'Toxic Mishap (Legacy)' | '????? ?????? (???)':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_ToxicMishap'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Toxic Mishap (Legacy)";

				if (ClientPrefs.legacyWeekPlayed == false)
				{
					selectionText.text = "????? ?????? (???)";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}

			case 'Paycheck (Legacy)' | '?????????? (???)':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_PaycheckClassic'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Paycheck (Legacy)";

				if (ClientPrefs.legacyWeekPlayed == false)
				{
					selectionText.text = "?????????? (???)";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}

			//Week D-sides
			case 'Unpaid Catastrophe' | '?????? ???????????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_UnpaidCatastrophe'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Unpaid Catastrophe";

				if (ClientPrefs.dsideWeekPlayed == false)
				{
					selectionText.text = "?????? ???????????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case 'Cheque' | '??????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Cheque'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Cheque";

				if (ClientPrefs.dsideWeekPlayed == false)
				{
					selectionText.text = "??????";
					lockedSelection.alpha = 1;
					unlockedSelection.alpha = 0;
				}
			}
			case "Get Gooned" | '??? ??????':
			{
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_GetGooned'));
				unlockedSelection.alpha = 1;
				unlockedSelection.scale.set(1, 1);
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 65;
				lockedSelection.alpha = 0;

				placeholderSelection.alpha = 0;

				selectionText.text = "Get Gooned";

				if (ClientPrefs.dsideWeekPlayed == false)
				{
					selectionText.text = "??? ??????";
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

		if (controls.BACK || FlxG.mouse.justPressedRight)
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
		if(FlxG.keys.justPressed.TAB)	
		{
			persistentUpdate = false;
			ClientPrefs.optionsFreeplay = true;
			ClientPrefs.inMenu = true;
			LoadingState.loadAndSwitchState(new options.OptionsState());
		}
		if (songs[curSelected].songName == "Get Villaind" && ClientPrefs.shaders == true)
			FlxTween.tween(seizureWarning, {alpha: 1}, 1.2, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(seizureWarning, {alpha: 0}, 1.2, {ease: FlxEase.circOut, type: PERSIST});
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
				if (PlayState.SONG.needsVoices)
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
		else if (accepted || (FlxG.mouse.overlaps(transparentButton) && FlxG.mouse.justPressed))
		{
			ClientPrefs.lowQuality = false;
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

			ClientPrefs.resetStoryModeProgress(true);
			ClientPrefs.inMenu = false;
			PlayState.SONG = Song.loadFromJson(poop, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			if(colorTween != null) {
				colorTween.cancel();
			}

			if (songs[curSelected].songName == 'Toxic Mishap (Legacy)')
			{
				if (ClientPrefs.mechanics == false && curDifficulty == 0)
				{
					trace('omg Toxic Mishap (Legacy) in Casual Mode without mechanics');
					PlayState.SONG = Song.loadFromJson('toxic-mishap-(legacy)-casualMechanicless', 'toxic-mishap-(legacy)');
					LoadingState.loadAndSwitchState(new PlayState());
				}
				if (ClientPrefs.mechanics == false && curDifficulty == 1)
				{
					trace('omg Toxic Mishap (Legacy) in Villainous Mode without mechanics');
					PlayState.SONG = Song.loadFromJson('toxic-mishap-(legacy)-villainousMechanicless', 'toxic-mishap-(legacy)');
					LoadingState.loadAndSwitchState(new PlayState());
				}
			}

			if (FlxG.keys.pressed.SHIFT)
			{
				FlxG.mouse.visible = false;
				LoadingState.loadAndSwitchState(new ChartingState());
				FlxG.sound.music.volume = 0;
			}	
			else if (ClientPrefs.optimizationMode == false && (songs[curSelected].songName == 'Get Villaind' || songs[curSelected].songName == 'Spendthrift'
					|| songs[curSelected].songName == 'Cheap Skate (Legacy)' || songs[curSelected].songName == 'Toxic Mishap (Legacy)' || songs[curSelected].songName == 'Paycheck (Legacy)'))
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

			if (songs[curSelected].songName == 'Spendthrift' && ClientPrefs.morkyWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Spendthrift!');
					ClientPrefs.morkyWeekPlayed = true;
					ClientPrefs.saveSettings();
				}
			if (songs[curSelected].songName == 'Get Villaind' && ClientPrefs.morkyWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Get Villained!');
					ClientPrefs.morkyWeekPlayed = true;
					ClientPrefs.saveSettings();
				}

			if (songs[curSelected].songName == 'Cheap Skate (Legacy)' && ClientPrefs.legacyWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Cheap Skate (Legacy)!');
					ClientPrefs.legacyWeekPlayed = true;
					ClientPrefs.saveSettings();
				}
			if (songs[curSelected].songName == 'Toxic Mishap (Legacy)' && ClientPrefs.legacyWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Toxic Mishap (Legacy)!');
					ClientPrefs.legacyWeekPlayed = true;
					ClientPrefs.saveSettings();
				}

			if (songs[curSelected].songName == 'Paycheck (Legacy)' && ClientPrefs.legacyWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Paycheck (Legacy)!');
					ClientPrefs.legacyWeekPlayed = true;
					ClientPrefs.saveSettings();
				}

			if (songs[curSelected].songName == 'Sussus Marcus' && ClientPrefs.susWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Sussus Marcus!');
					ClientPrefs.susWeekPlayed = true;
					ClientPrefs.saveSettings();
				}

			if (songs[curSelected].songName == 'Villain In Board' && ClientPrefs.susWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Villain In Board!');
					ClientPrefs.susWeekPlayed = true;
					ClientPrefs.saveSettings();
				}

			if (songs[curSelected].songName == 'Excrete' && ClientPrefs.susWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Excrete!');
					ClientPrefs.susWeekPlayed = true;
					ClientPrefs.saveSettings();
				}

			if (songs[curSelected].songName == 'Unpaid Catastrophe' && ClientPrefs.dsideWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Unpaid Catastrophe!');
					ClientPrefs.dsideWeekPlayed = true;
					ClientPrefs.saveSettings();
				}

			if (songs[curSelected].songName == 'Cheque' && ClientPrefs.dsideWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Cheque!');
					ClientPrefs.dsideWeekPlayed = true;
					ClientPrefs.saveSettings();
				}

			if (songs[curSelected].songName == "Get Gooned" && ClientPrefs.dsideWeekPlayed == false)
				{
					trace('I got loaded lol, Unlocking Get Gooned!');
					ClientPrefs.dsideWeekPlayed = true;
					ClientPrefs.saveSettings();
				}
				
				destroyFreeplayVocals();
			}
			else if(controls.RESET)
				{
					persistentUpdate = false;
					openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
					FlxG.sound.play(Paths.sound('scrollMenu'));
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

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length)
			curDifficulty = 0;

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

		if (songs[curSelected].songName == 'Scrouge' || songs[curSelected].songName == 'Toxic Mishap' || songs[curSelected].songName == 'Paycheck' //Week 1
			|| songs[curSelected].songName == 'Nunday Monday' //Week 2
			|| songs[curSelected].songName == 'Forsaken' || songs[curSelected].songName == 'Lustality Remix' //Week 3
			)
		{	
			CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
			/*var diffStr:String = WeekData.getCurrentWeek().difficulties;
			if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

			if(diffStr != null && diffStr.length > 0)
			{
				var diffs:Array<String> = diffStr.split(',');
				var i:Int = diffs.length - 1;
				while (i > 0)
				{
					if(diffs[i] != null)
					{
						diffs[i] = diffs[i].trim();
						if(diffs[i].length < 1) diffs.remove(diffs[i]);
					}
					--i;
				}

				if(diffs.length > 0 && diffs[0].length > 0)
				{
					CoolUtil.difficulties = diffs;
				}
			}*/
		
			if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty))
			{
				curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
			}
			else
			{
				curDifficulty = 0;
			}
		}
		else
			CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();

		if (songs[curSelected].songName == 'Excrete')
		{
			CoolUtil.difficulties = CoolUtil.tcDifficulties.copy();
		}
			

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
		{
			curDifficulty = newPos;
		}
	}

	private function positionHighscore() {
		scoreText.x = FlxG.width - scoreText.width - 406;

		scoreBG.scale.x = FlxG.width - scoreText.x + 6;
		scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
		diffText.x = 640;
		diffText.x -= diffText.width / 2;
	}
}

class SongBonusMetadata
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