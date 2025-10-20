package;

import editors.ChartingState;
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;
import WeekData;

class FreeplayState extends MusicBeatState
{
	public static var songCategory:String = "";
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

	private var curPlaying:Bool = false;

	var colorTween:FlxTween;

	var mechanicMessage:FlxSprite;
	var blackOut:FlxSprite;
	var messageNumber:Int = 0;

	var newBG:FlxSprite;
	var intendedColor:Int;

	var unlockedSelection:FlxSprite;
	var lockedSelection:FlxSprite;

	var transparentButton:FlxSprite;

	var arrowSelectorLeft:FlxSprite;
	var arrowSelectorRight:FlxSprite;
	var selectionText:Alphabet;

	var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;

	var warnTxt:FlxText;

	public static var instance:FreeplayState;

	override function create()
	{
		instance = this;
		//Paths.clearStoredMemory();
		//Paths.clearUnusedMemory();
		
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence('In $songCategory Freeplay Mode', null);
		#end
		
		//check if songs were found to be unlocked
		setUpSongs(songCategory.toLowerCase());

		for (i in 0...songs.length)
			Paths.currentModDirectory = songs[i].folder;

		WeekData.setDirectoryFromWeek();

		if(curSelected >= songs.length) curSelected = 0;

		if(lastDifficultyName == '')
			lastDifficultyName = CoolUtil.defaultDifficulty;

		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));

		newBG = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/Background'));
		newBG.setGraphicSize(FlxG.width, FlxG.height);
		newBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(newBG);
		newBG.screenCenter();

		newBG.color = songs[curSelected].color;
		intendedColor = newBG.color;

		unlockedSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/selection_CheapSkate'));
		unlockedSelection.antialiasing = ClientPrefs.globalAntialiasing;
		unlockedSelection.screenCenter();
		unlockedSelection.y -= 65;
		add(unlockedSelection);

		lockedSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/selection_QuestionMark'));
		lockedSelection.antialiasing = ClientPrefs.globalAntialiasing;
		lockedSelection.screenCenter();
		lockedSelection.y -= 65;
		lockedSelection.alpha = 0;
		add(lockedSelection);

		transparentButton = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/transparentButton'));
		transparentButton.antialiasing = ClientPrefs.globalAntialiasing;
		transparentButton.screenCenter();
		transparentButton.y -= 65;
		transparentButton.alpha = 0;
		add(transparentButton);

		selectionText = new Alphabet(MobileUtil.fixX(640), MobileUtil.fixY(560), "Unknown Song", true);
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

		warnTxt = new FlxText(700, selectionText.y + 400, FlxG.width, "TEST WARNING!.", 16);
		warnTxt.setFormat("VCR OSD Mono", 20, FlxColor.RED, CENTER);
		warnTxt.screenCenter(XY);
		warnTxt.y += 290;
		warnTxt.visible = false;
		add(warnTxt);
		
		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);
	
		var leText:String = "Press S to listen to the Song / Press E to go to Options / Press C to open Gameplay Changers / Press R to Reset your Score and Accuracy.";
		var size:Int = 16;
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
		text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		add(text);

		changeSelection(0, false, false);
		changeDiff(0, false);
		songSelector();

		NotificationAlert.checkForNotifications(this);

		super.create();

		addTouchPad("RIGHT_LEFT", "FREEPLAY");
	}

	override function closeSubState() {
		changeSelection(0, false, false);
		persistentUpdate = true;

		removeTouchPad();
		addTouchPad('RIGHT_LEFT', 'FREEPLAY');

		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, color:Int)
		songs.push(new SongMetadata(songName, weekNum, color));

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	function setUpSongs(category:String)
	{
		switch(category)
		{
			case "main":
				for (i in 0...WeekData.weeksList.length) {
					if(weekIsLocked(WeekData.weeksList[i])) continue;
		
					var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
		
					WeekData.setDirectoryFromWeek(leWeek);
					for (song in leWeek.songs)
					{
						var colors:Array<Int> = song[2];
						if(colors == null || colors.length < 3)
						{
							colors = [146, 113, 253];
						}
						addSong(song[0], i, FlxColor.fromRGB(colors[0], colors[1], colors[2]));
					}
				}
				WeekData.loadTheFirstEnabledMod();

				if (ClientPrefs.villainyBeaten) addSong('Villainy', 1, FlxColor.fromRGB(6, 155, 13));

			case "nuns":
				//Week 2	
				if (ClientPrefs.nunWeekFound) 
				{
					addSong('Nunday Monday', 3, FlxColor.fromRGB(255, 84, 84));
					addSong('Nunconventional', 3, FlxColor.fromRGB(255, 0, 53));
					if (ClientPrefs.pointBlankBeaten) addSong('Point Blank', 3, FlxColor.fromRGB(255, 255, 25));
				}

			case "demons":
				//Week 3
				if (ClientPrefs.kianaWeekFound)
				{
					addSong('Forsaken', 3, FlxColor.fromRGB(39, 0, 87));
					addSong('Toybox', 3, FlxColor.fromRGB(213, 84, 192));
					addSong('Lustality Remix', 3, FlxColor.fromRGB(146, 0, 133));
					if (ClientPrefs.libidinousnessBeaten) addSong('Libidinousness', 3, FlxColor.fromRGB(156, 0, 73));
				}

			case "mork":
				//Week Morky
				if (ClientPrefs.morkyWeekFound)
				{
					addSong('Spendthrift', 3, FlxColor.fromRGB(40, 255, 53));
					addSong('Instrumentally Deranged', 3, FlxColor.fromRGB(0, 113, 253));
					addSong('Get Villaind', 3, FlxColor.fromRGB(66, 255, 153));
				}

			case "legacy":
				//Week Legacy
				if (ClientPrefs.legacyWeekFound)
				{
					addSong('Cheap Skate (Legacy)', 3, FlxColor.fromRGB(66, 255, 153));
					addSong('Toxic Mishap (Legacy)', 3, FlxColor.fromRGB(6, 155, 13));
					addSong('Paycheck (Legacy)', 3, FlxColor.fromRGB(163, 187, 137));
				}

			case "sus":
				//Week Sus
				if (ClientPrefs.susWeekFound)
				{
					addSong('Sussus Marcus', 3, FlxColor.fromRGB(80, 155, 80));
					addSong('Villain In Board', 3, FlxColor.fromRGB(22, 82, 22));
					if (ClientPrefs.excreteBeaten) addSong('Excrete', 3, FlxColor.fromRGB(0, 135, 0));
				}

			case "dsides":
				//Week D-sides
				if (ClientPrefs.dsideWeekFound)
				{
					addSong('Unpaid Catastrophe', 3, FlxColor.fromRGB(166, 53, 255));
					addSong('Cheque', 3, FlxColor.fromRGB(106, 233, 253));
					addSong("Get Gooned", 3, FlxColor.fromRGB(20, 153, 255));
				}

			case "xtrashop":
				// Freeplay | Shop Exclusive Songs
				if (ClientPrefs.nunsationalFound) addSong('Nunsational', 3, FlxColor.fromRGB(255, 0, 53));
				if (ClientPrefs.lustalityFound) addSong('Lustality', 3, FlxColor.fromRGB(195, 0, 153));		
				if (ClientPrefs.tofuFound) addSong('Tofu', 3, FlxColor.fromRGB(255, 235, 0));
				if (ClientPrefs.marcochromeFound) addSong('Marcochrome', 3, FlxColor.fromRGB(0, 75, 0));
				if (ClientPrefs.nicFound) addSong('Slow.FLP', 3, FlxColor.fromRGB(255, 255, 255));
				if (ClientPrefs.debugFound) addSong('Marauder', 3, FlxColor.fromRGB(0 , 0, 0));
				if (ClientPrefs.fnvFound) addSong('FNV', 3, FlxColor.fromRGB(147, 0, 151));
				if (ClientPrefs.rainyDazeFound) addSong('Rainy Daze', 3, FlxColor.fromRGB(230, 0, 255));
				if (ClientPrefs.shortFound) addSong('Jerry', 3, FlxColor.fromRGB(255, 255, 255));
				if (ClientPrefs.infatuationFound) addSong('Fanfuck Forever', 3, FlxColor.fromRGB(230, 0, 255));

			case "xtracrossover":
				if (ClientPrefs.ourpleFound) addSong('VGuy', 3, FlxColor.fromRGB(115, 13, 255));
				if (ClientPrefs.kyuFound) addSong('Fast Food Therapy', 3, FlxColor.fromRGB(255, 239, 11));
				if (ClientPrefs.tacticalMishapFound) addSong('Tactical Mishap', 3, FlxColor.fromRGB(255, 73, 155));
				if (ClientPrefs.breacherFound) addSong('Breacher', 3, FlxColor.fromRGB(122, 49, 137));
				if (ClientPrefs.negotiationFound) addSong('Negotiation', 3, FlxColor.fromRGB(239, 0, 31));
				if (ClientPrefs.ccFound) addSong('Concert Chaos', 3, FlxColor.fromRGB(155,0,206));

			case "xtrabonus":
				if (ClientPrefs.itsameDsidesUnlocked) addSong("It's Kiana", 3, FlxColor.fromRGB(59, 229, 255));
				addSong('Slow.FLP (Old)', 3, FlxColor.fromRGB(255, 255, 255));
				addSong('Marauder (Old)', 3, FlxColor.fromRGB(0 ,0, 0));
				addSong('Get Villaind (Old)', 3, FlxColor.fromRGB(66, 255, 153));
				addSong("Get Pico'd", 3, FlxColor.fromRGB(20, 153, 255));
				addSong('Partner', 3, FlxColor.fromRGB(39, 0, 87));
				addSong('Shuckle Fuckle', 3, FlxColor.fromRGB(0 ,0, 0));
		}
	}

	function songSelector()
	{
		var customPosition:Bool = false;
		var songName = songs[curSelected].songName;
		selectionText.text = songs[curSelected].songName;

		switch(selectionText.text)
		{
			//Tutorial
			case 'Couple Clash': unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_CoupleClash'));	
			
			//main Week	
			case 'Scrouge': unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_CheapSkateV3'));	
			case 'Toxic Mishap': unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_ToxicMishap'));
			case 'Paycheck': unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_PaycheckV2'));
			case 'Villainy': unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Villainy'));

			//Week 2 - Nun Week
			case 'Nunday Monday':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_NundayMonday'));
				if (!ClientPrefs.nunWeekPlayed)
				{
					selectionText.text = "?????? ??????";
					lockedSelection.alpha = 1;
				}
			case 'Nunconventional':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Nunconventional'));
				if (!ClientPrefs.nunWeekPlayed)
				{
					selectionText.text = "???????????????";
					lockedSelection.alpha = 1;
				}
			case 'Point Blank':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_PointBlank'));
				if (!ClientPrefs.nunWeekPlayed)
				{
					selectionText.text = "????? ?????";
					lockedSelection.alpha = 1;
				}

			//Week 3 - Unnamed Trinity
			case 'Forsaken':
				customPosition = true;
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Forsaken'));
				unlockedSelection.scale.set(1.2, 1.2);
				unlockedSelection.screenCenter();
				unlockedSelection.x += 20;
				unlockedSelection.y -= 60;

				if (!ClientPrefs.kianaWeekPlayed)
				{
					selectionText.text = "????????";
					lockedSelection.alpha = 1;
				}
			case 'Toybox':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Toybox'));
				if (!ClientPrefs.kianaWeekPlayed)
				{
					selectionText.text = "??????";
					lockedSelection.alpha = 1;
				}
			case 'Lustality Remix':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_LustalityRemix'));
				if (!ClientPrefs.kianaWeekPlayed)
				{
					selectionText.text = "????????? ?????";
					lockedSelection.alpha = 1;
				}
			case 'Libidinousness':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Libidinousness'));
				if (!ClientPrefs.kianaWeekPlayed)
				{
					selectionText.text = "??????????????";
					lockedSelection.alpha = 1;
				}

			//Week Morky
			case 'Spendthrift':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Spendthrift'));
				if (!ClientPrefs.morkyWeekPlayed)
				{
					selectionText.text = "???????????";
					lockedSelection.alpha = 1;
				}
			case 'Instrumentally Deranged':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_InstrumentallyDeranged'));
				if (!ClientPrefs.morkyWeekPlayed)
				{
					selectionText.text = "????. ????????";
					lockedSelection.alpha = 1;
				}
			case 'Get Villaind':
				customPosition = true;
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_GetVillaind'));
				unlockedSelection.frames = Paths.getSparrowAtlas('freeplayStuff/selection_GetVillaind');
				unlockedSelection.animation.addByPrefix('idle', "mork mork0", 24);
				unlockedSelection.scale.set(0.68, 0.657);
				unlockedSelection.x = MobileUtil.fixX(115);
				unlockedSelection.y -= 107;
				unlockedSelection.animation.play('idle');

				selectionText.text = songName = "Get Villain'd";
				if (!ClientPrefs.morkyWeekPlayed)
				{
					selectionText.text = "??? ?????????";
					lockedSelection.alpha = 1;
				}

			//Week Sus
			case 'Sussus Marcus':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_SussusMarcus'));
				if (!ClientPrefs.susWeekPlayed)
				{
					selectionText.text = "?????? ??????";
					lockedSelection.alpha = 1;
				}
			case 'Villain In Board':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_VillainInBoard'));
				if (!ClientPrefs.susWeekPlayed)
				{
					selectionText.text = "??????? ?? ?????";
					lockedSelection.alpha = 1;
				}
			case 'Excrete':
				customPosition = true;
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Excrete'));
				unlockedSelection.scale.set(1.15, 1.15);
				unlockedSelection.screenCenter();
				unlockedSelection.x += 15;
				unlockedSelection.y -= 65;

				if (!ClientPrefs.susWeekPlayed)
				{
					selectionText.text = "???????";
					lockedSelection.alpha = 1;
				}

			//week Legacy
			case 'Cheap Skate (Legacy)':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_CheapSkate'));
				if (!ClientPrefs.legacyWeekPlayed)
				{
					selectionText.text = "????? ????? (???)";
					lockedSelection.alpha = 1;
				}

			case 'Toxic Mishap (Legacy)':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_ToxicMishap'));
				if (!ClientPrefs.legacyWeekPlayed)
				{
					selectionText.text = "????? ?????? (???)";
					lockedSelection.alpha = 1;
				}

			case 'Paycheck (Legacy)':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_PaycheckClassic'));
				if (!ClientPrefs.legacyWeekPlayed)
				{
					selectionText.text = "?????????? (???)";
					lockedSelection.alpha = 1;
				}

			//Week D-sides
			case 'Unpaid Catastrophe':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_UnpaidCatastrophe'));
				if (!ClientPrefs.dsideWeekPlayed)
				{
					selectionText.text = "?????? ???????????";
					lockedSelection.alpha = 1;
				}
			case 'Cheque':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Cheque'));
				if (!ClientPrefs.dsideWeekPlayed)
				{
					selectionText.text = "??????";
					lockedSelection.alpha = 1;
				}
			case "Get Gooned":
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_GetGooned'));
				if (!ClientPrefs.dsideWeekPlayed)
				{
					selectionText.text = "??? ??????";
					lockedSelection.alpha = 1;
				}

			// Freeplay | Shop Exclusives
			case 'Nunsational' :
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Nunsational'));
				if (!ClientPrefs.nunsationalViewed)
				{
					selectionText.text = "???????????";
					lockedSelection.alpha = 1;
				}
			case 'Marcochrome':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Marcochrome'));
				if (!ClientPrefs.marcochromeViewed)
				{
					selectionText.text = "?????????????";
					lockedSelection.alpha = 1;
				}
			case 'Tofu':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Tofu'));
				if (!ClientPrefs.tofuViewed)
				{
					selectionText.text = "????";
					lockedSelection.alpha = 1;
				}
			case 'Lustality':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Lustality'));
				if (!ClientPrefs.lustalityViewed)
				{
					selectionText.text = "????????? ??";
					lockedSelection.alpha = 1;
				}
			case 'Slow.FLP':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_SlowFLP'));
				if (!ClientPrefs.nicViewed)
				{
					selectionText.text = "????.???";
					lockedSelection.alpha = 1;
				}
			case 'Marauder':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Marauder'));
				if (!ClientPrefs.debugViewed)
				{
					selectionText.text = "????????";
					lockedSelection.alpha = 1;
				}
			case 'FNV':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_FNV'));
				if (!ClientPrefs.fnvViewed)
				{
					selectionText.text = "???";
					lockedSelection.alpha = 1;
				}
			case 'Rainy Daze':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_RainyDaze'));
				if (!ClientPrefs.rainyDazeViewed)
				{
					selectionText.text = "????? ????";
					lockedSelection.alpha = 1;
				}
			case 'Jerry':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_00015'));
				if (!ClientPrefs.shortViewed)
				{
					selectionText.text = "?.????";
					lockedSelection.alpha = 1;
				}
			case 'Fanfuck Forever':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_FanfuckForever'));
				if (!ClientPrefs.infatuationViewed)
				{
					selectionText.text = "????????????";
					lockedSelection.alpha = 1;
				}

			// Crossovers
			case 'Tactical Mishap':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_TacticalMishap'));
				if (!ClientPrefs.tacticalMishapPlayed)
				{
					selectionText.text = "???????? ??????";
					lockedSelection.alpha = 1;
				}
			case 'VGuy':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_VGuy'));
				if (!ClientPrefs.ourplePlayed)
				{
					selectionText.text = "????";
					lockedSelection.alpha = 1;
				}
			case 'Fast Food Therapy':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_FastFoodTherapy'));
				if (!ClientPrefs.kyuPlayed)
				{
					selectionText.text = "???? ???? ???????";
					lockedSelection.alpha = 1;
				}
			case 'Breacher':
				customPosition = true;
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Breacher'));
				unlockedSelection.screenCenter();
				unlockedSelection.y -= 60;
				unlockedSelection.scale.set(1.12, 1.12);

				if (!ClientPrefs.breacherPlayed)
				{
					selectionText.text = "????????";
					lockedSelection.alpha = 1;
				}
			case 'Negotiation':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Negotiation'));
				if (!ClientPrefs.negotiationPlayed)
				{
					selectionText.text = "???????????";
					lockedSelection.alpha = 1;
				}
			case 'Concert Chaos':
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_ConcertChaos'));
				if (!ClientPrefs.ccPlayed)
				{
					selectionText.text = "??????? ?????";
					lockedSelection.alpha = 1;
				}

			// Bonuses
			case 'Slow.FLP (Old)': unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_SlowFLP'));
			case 'Marauder (Old)': unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Marauder'));
			case 'Get Villaind (Old)':
				customPosition = true;
				selectionText.text = songName = "Get Villain'd (Old)";
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_GetVillaind'));
				unlockedSelection.frames = Paths.getSparrowAtlas('freeplayStuff/selection_GetVillaind');
				unlockedSelection.animation.addByPrefix('idle', "mork mork0", 24);
				unlockedSelection.scale.set(0.68, 0.657);
				unlockedSelection.x = MobileUtil.fixX(115);
				unlockedSelection.y -= 107;
				unlockedSelection.animation.play('idle');

			case "Get Pico'd": unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_GetGooned'));

			case "It's Kiana": unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_ItsKiana'));
			case "Partner":
				customPosition = true;
				unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_Forsaken'));
				unlockedSelection.scale.set(1.2, 1.2);
				unlockedSelection.screenCenter();
				unlockedSelection.x += 20;
				unlockedSelection.y -= 60;
				
			case "Shuckle Fuckle": unlockedSelection.loadGraphic(Paths.image('freeplayStuff/selection_ShucksV2'));

			default:
				lockedSelection.alpha = 1;
				selectionText.text = "Unknown Song";
		}

		if (selectionText.text != songName)
		{
			unlockedSelection.alpha = 0;
			lockedSelection.alpha = 1;

			return;
		}

		if (!customPosition)
		{
			unlockedSelection.alpha = 1;
			unlockedSelection.scale.set(1, 1);
			unlockedSelection.screenCenter();
			unlockedSelection.y -= 65;
			lockedSelection.alpha = 0;
		}
	}

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7) FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

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

		var upP = controls.UI_UP_P || TouchUtil.pressAction(arrowSelectorLeft);
		var downP = controls.UI_DOWN_P || TouchUtil.pressAction(arrowSelectorRight);
		var accepted = controls.ACCEPT || TouchUtil.pressAction(transparentButton);
		var space = FlxG.keys.justPressed.SPACE || touchPad.buttonS.justPressed;
		var ctrl = FlxG.keys.justPressed.CONTROL || touchPad.buttonC.justPressed;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if(songs.length > 1)
		{
			if (!accepted) checkForWarning(songs[curSelected].songName);

			if (upP)
			{
				changeSelection(-shiftMult);
				changeDiff(0, false);
				holdTime = 0;
			}
			if (downP)
			{
				changeSelection(shiftMult);
				changeDiff(0, false);
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
					changeDiff(0, false);
				}
			}

			if (TouchUtil.overlaps(arrowSelectorLeft))
				FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			else
				FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
	
			if (TouchUtil.overlaps(arrowSelectorRight))
				FlxTween.tween(arrowSelectorRight, {x: getRightArrowX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			else
				FlxTween.tween(arrowSelectorRight, {x: getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
	
			if (controls.UI_LEFT_P) changeDiff(-1);
			else if (controls.UI_RIGHT_P) changeDiff(1);
			else if (upP || downP) changeDiff(0, false);
		}

		if (controls.BACK #if mobile || FlxG.android.justReleased.BACK #end)
		{
			persistentUpdate = false;
			if(colorTween != null) colorTween.cancel();
			ClientPrefs.optionsFreeplay = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if (ClientPrefs.inShop)
			{
				FlxG.sound.music.fadeOut(0.7); 
				MusicBeatState.switchState(new ShopState());
			}
			else
			{
				if (songCategory.toLowerCase().startsWith("xtra"))
					MusicBeatState.switchState(new FreeplayCategoryXtraState(), "stickers");
				else
					MusicBeatState.switchState(new FreeplayCategoryState(), "stickers");
			}
		}
		if(FlxG.keys.justPressed.TAB || touchPad.buttonE.justPressed)	
		{
			persistentUpdate = false;
			ClientPrefs.optionsFreeplay = true;
			ClientPrefs.inMenu = true;
			MusicBeatState.switchState(new options.OptionsState(), "stickers");
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
		else if (accepted || TouchUtil.pressAction(transparentButton))
		{
			persistentUpdate = false;
			if (songs[curSelected].songName == 'Slow.FLP')
			{
				FlxG.sound.play(Paths.sound('sonicWarp'));
				FlxG.camera.fade(FlxColor.WHITE, 0.3, false, false);
			}
			else
				FlxG.sound.play(Paths.sound('confirmMenu'));
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);

			var showMechWarn:Bool = false;
			var mechSongs:Array<String> = ['Scrouge', 'Toxic Mishap', 'Paycheck', 'Nunday Monday', 'Nunconventional', 'Forsaken', 'Toybox', 'Lustality Remix', 'Partner'];
			var bossMechSongs:Array<String> = ['Villainy', 'Point Blank', 'Libidinousness'];

			for (i in 0...mechSongs.length)
				if(!ClientPrefs.mechanics && curDifficulty == 2 && songs[curSelected].songName == mechSongs[i])
					showMechWarn = true;

			for (i in 0...bossMechSongs.length)
				if(!ClientPrefs.mechanics && curDifficulty == 1 && songs[curSelected].songName == bossMechSongs[i])
					showMechWarn = true;

			if (showMechWarn)
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
				if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
				ClientPrefs.resetProgress(true);
				ClientPrefs.inMenu = ClientPrefs.lowQuality = PlayState.isStoryMode = false;
				PlayState.SONG = Song.loadFromJson(poop, songLowercase);
				PlayState.storyDifficulty = curDifficulty;

				trace('Loaded $poop');

				if(colorTween != null)
					colorTween.cancel();

				var appliedChanges:Bool = false;
				var diff:String = CoolUtil.getDifficultyFilePath(curDifficulty);
		
				appliedChanges = PlayState.checkSongBeforeSwitching("LowQuality", songLowercase, diff);
				if (!appliedChanges) appliedChanges = PlayState.checkSongBeforeSwitching("Optimization", songLowercase, diff);
				if (!appliedChanges) appliedChanges = PlayState.checkSongBeforeSwitching("Mechanics", songLowercase, diff);

				if (appliedChanges) trace("Song has been modified successfully.");
				else trace("No modifications needed. -> " + Paths.formatToSongPath(songs[curSelected].songName) + diff);

				var loadCharSelector:Bool = checkForCharSelector(songs[curSelected].songName);

				if (loadCharSelector)
				{
					MusicBeatState.switchState(new CharSelector());
					FlxG.sound.music.volume = 1;
				}
				else
				{
					LoadingState.loadAndSwitchState(new PlayState());
					FlxG.sound.music.volume = 0;
				}
				
				unlockSong();
				destroyFreeplayVocals();
			}
		}
		else if(controls.RESET || touchPad.buttonR.justPressed)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty));
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

	private function checkForWarning(songName:String)
	{
		if (ClientPrefs.optimizationMode) return;
			
		switch(songName)
		{
			case "Get Villaind" | "Get Villaind (Old)":
				warnTxt.text = "WARNING: This song contains shaders and flashing imagery that could potentially trigger sensitive people.\nIf you experience seizures, please disable both mechanics and shaders through the options menu.";
				warnTxt.visible = true;

			case "marauder" | "marauder-(old)":
				warnTxt.text = "WARNING: This song can alter some PC changes such as your background\nIf you do not wish for that, disable PC Change Permanance through the options menu.";
				warnTxt.visible = true;
			
			case "Libidinousness":
				warnTxt.text = "WARNING: This song can potentially fail to load certain sprites on lower-end hardware due to sprite sizes.\nIt is recommended to enable the \"Performance Warning\" Version through the options menu, unless you have decent+ hardware.";
				warnTxt.visible = true;

			default:
				warnTxt.visible = false;
		}
	}

	private function checkForCharSelector(songName:String)
	{
		if (ClientPrefs.optimizationMode) return false;
		var charSelectorSongs:Array<String> = ['Scrouge','Toxic Mishap', 'Paycheck', 'Nunday Monday', 'Nunconventional', 'Point Blank', 'Lustality Remix',
		'Get Villaind', 'Spendthrift', 'Cheap Skate (Legacy)', 'Toxic Mishap (Legacy)', 'Paycheck (Legacy)', 'Lustality',
		'Nunsational', 'FNV', "It's Kiana", "Get Villaind (Old)"];

		for (i in 0...charSelectorSongs.length)
			if (songName == charSelectorSongs[i])
				return true;

		return false;
	}

	function changeDiff(change:Int = 0, ?allowHaptics:Bool = true)
	{
		if (ClientPrefs.haptics && allowHaptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		curDifficulty += change;

		if (curDifficulty < 0) curDifficulty = CoolUtil.difficulties.length-1;
		if (curDifficulty >= CoolUtil.difficulties.length) curDifficulty = 0;

		lastDifficultyName = CoolUtil.difficulties[curDifficulty];

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		PlayState.storyDifficulty = curDifficulty;
		diffText.text = '< ' + CoolUtil.difficultyString() + ' >';
		positionHighscore();
	}

	function changeSelection(change:Int = 0, playSound:Bool = true, ?allowHaptics:Bool = true)
	{
		if (ClientPrefs.haptics && allowHaptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		var lastSelected = curSelected;
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

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end
		
		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		//This if is used on songs which have the 'Iniquitous' difficulty on
		var songName:String = songs[curSelected].songName;
		switch (songName)
		{
			case 'Scrouge', 'Toxic Mishap', 'Paycheck', 'Nunday Monday', 'Nunconventional', 'Forsaken', 'Toybox', 'Lustality Remix', "Partner":
				var iniquitousEnabled:Bool = Achievements.isAchievementUnlocked('weekIniquitous_Beaten');
				CoolUtil.difficulties = (iniquitousEnabled) ? CoolUtil.mainWeekDifficulties.copy() : CoolUtil.defaultDifficulties.copy();
				if(CoolUtil.difficulties.contains((iniquitousEnabled) ?CoolUtil.mainWeekDifficulty : CoolUtil.defaultDifficulty))
				{
					var maxVal:Int = (iniquitousEnabled) ? CoolUtil.mainWeekDifficulties.indexOf(CoolUtil.mainWeekDifficulty) : CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty);
					curDifficulty = Math.round(Math.max(0, maxVal));
				}

			case "Couple Clash", "Excrete", "FNV", "Rainy Daze", "Jerry", "Marauder", "It's Kiana", "Shuckle Fuckle":
				CoolUtil.difficulties = CoolUtil.tcDifficulties.copy();
				if(CoolUtil.difficulties.contains(CoolUtil.tcDifficulty)) curDifficulty = Math.round(Math.max(0, CoolUtil.tcDifficulties.indexOf(CoolUtil.tcDifficulty)));
				else curDifficulty = 0;
			
			case "Villainy", "Point Blank", "Libidinousness":
				CoolUtil.difficulties = CoolUtil.bossFightDifficulties.copy();
				if(CoolUtil.difficulties.contains(CoolUtil.bossFightDifficulty)) curDifficulty = Math.round(Math.max(0, CoolUtil.bossFightDifficulties.indexOf(CoolUtil.bossFightDifficulty)));
				else curDifficulty = 0;

			default:
				CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
				if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty)) curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
				else curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1) curDifficulty = newPos;

		if (curSelected != lastSelected)
			songSelector();
	}

	private function positionHighscore() {
		scoreText.x = (FlxG.width - scoreText.width) / 2;

		scoreBG.x = scoreText.x - 6;
		scoreBG.scale.x = scoreText.width + 12;
		diffText.x = MobileUtil.fixX(640);
		diffText.x -= diffText.width / 2;
	}

	function unlockSong()
	{
		//To make songs have their right Icon after the 'mystery' thingy lmaooibwoaivbadv
		if (songs[curSelected].songName == 'Nunconventional' && ClientPrefs.nunWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Nunconventional!');
			ClientPrefs.nunWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Nunday Monday' && ClientPrefs.nunWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Nunday Monday!');
			ClientPrefs.nunWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Point Blank' && ClientPrefs.nunWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Point Blank!');
			ClientPrefs.nunWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Forsaken' && ClientPrefs.kianaWeekFound == false)
		{
			trace('I got loaded lol, Unlocking Forsaken!');
			ClientPrefs.kianaWeekFound = true;

		}
		else if (songs[curSelected].songName == 'Toybox' && ClientPrefs.kianaWeekFound == false)
		{
			trace('I got loaded lol, Unlocking Toybox!');
			ClientPrefs.kianaWeekFound = true;
		}
		else if (songs[curSelected].songName == 'Lustality Remix' && ClientPrefs.kianaWeekFound == false)
		{
			trace('I got loaded lol, Unlocking Lustality Remix!');
			ClientPrefs.kianaWeekFound = true;
		}
		else if (songs[curSelected].songName == 'Spendthrift' && ClientPrefs.morkyWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Spendthrift!');
			ClientPrefs.morkyWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Instrumentally Deranged' && ClientPrefs.morkyWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Instrumentally Deranged!');
			ClientPrefs.morkyWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Get Villaind' && ClientPrefs.morkyWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Get Villain\'d!');
			ClientPrefs.morkyWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Cheap Skate (Legacy)' && ClientPrefs.legacyWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Cheap Skate (Legacy)!');
			ClientPrefs.legacyWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Toxic Mishap (Legacy)' && ClientPrefs.legacyWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Toxic Mishap (Legacy)!');
			ClientPrefs.legacyWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Paycheck (Legacy)' && ClientPrefs.legacyWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Paycheck (Legacy)!');
			ClientPrefs.legacyWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Sussus Marcus' && ClientPrefs.susWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Sussus Marcus!');
			ClientPrefs.susWeekPlayed = true;		
		}
		else if (songs[curSelected].songName == 'Villain In Board' && ClientPrefs.susWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Villain In Board!');
			ClientPrefs.susWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Excrete' && ClientPrefs.susWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Excrete!');
			ClientPrefs.susWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Unpaid Catastrophe' && ClientPrefs.dsideWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Unpaid Catastrophe!');
			ClientPrefs.dsideWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Cheque' && ClientPrefs.dsideWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Cheque!');
			ClientPrefs.dsideWeekPlayed = true;
		}
		else if (songs[curSelected].songName == "Get Gooned" && ClientPrefs.dsideWeekPlayed == false)
		{
			trace('I got loaded lol, Unlocking Get Gooned!');
			ClientPrefs.dsideWeekPlayed = true;
		}
		else if (songs[curSelected].songName == 'Nunsational' && ClientPrefs.nunsationalViewed == false)
		{
			trace('I got loaded lol, Unlocking Nunsational!');
			ClientPrefs.nunsationalViewed = true;
		}
		else if (songs[curSelected].songName == 'Marcochrome' && ClientPrefs.marcochromeViewed == false)
		{
			trace('I got loaded lol, Unlocking Marcochrome!');
			ClientPrefs.marcochromeViewed = true;
		}
		else if (songs[curSelected].songName == 'Tofu' && ClientPrefs.tofuViewed == false)
		{
			trace('I got loaded lol, Unlocking Tofu!');
			ClientPrefs.tofuViewed = true;
		}
		else if (songs[curSelected].songName == 'Tofu' && ClientPrefs.tofuViewed == false)
		{
			trace('I got loaded lol, Unlocking Tofu!');
			ClientPrefs.tofuViewed = true;
		}
		else if (songs[curSelected].songName == 'Lustality' && ClientPrefs.lustalityViewed == false)
		{
			trace('I got loaded lol, Unlocking Lustality!');
			ClientPrefs.lustalityViewed = true;
		}
		else if (songs[curSelected].songName == 'Slow.FLP' && ClientPrefs.nicViewed == false)
		{
			trace('I got loaded lol, Unlocking Slow.FLP!');
			ClientPrefs.nicViewed = true;
		}
		else if (songs[curSelected].songName == 'Marauder' && ClientPrefs.debugViewed == false)
		{
			trace('I got loaded lol, Unlocking Marauder!');
			ClientPrefs.debugViewed = true;
		}
		else if (songs[curSelected].songName == 'FNV' && ClientPrefs.fnvViewed == false)
		{
			trace('I got loaded lol, Unlocking FNV!');
			ClientPrefs.fnvViewed = true;
		}
		else if (songs[curSelected].songName == 'Rainy Daze' && ClientPrefs.rainyDazeViewed == false)
		{
			trace('I got loaded lol, Unlocking Rainy Daze!');
			ClientPrefs.rainyDazeViewed = true;
		}
		else if (songs[curSelected].songName == 'Jerry' && ClientPrefs.shortViewed == false)
		{
			trace('I got loaded lol, Unlocking Jerry!');
			ClientPrefs.shortViewed = true;
		}
		else if (songs[curSelected].songName == 'Fanfuck Forever' && ClientPrefs.infatuationViewed == false)
		{
			trace('I got loaded lol, Unlocking Fanfuck Forever!');
			ClientPrefs.infatuationViewed = true;
		}
		else if (songs[curSelected].songName == 'VGuy' && ClientPrefs.ourplePlayed == false)
		{
			trace('I got loaded lol, Unlocking VGuy!');
			ClientPrefs.ourplePlayed = true;
		}
		else if (songs[curSelected].songName == 'Fast Food Therapy' && ClientPrefs.kyuPlayed == false)
		{
			trace('I got loaded lol, Unlocking Fast Food Therapy!');
			ClientPrefs.kyuPlayed = true;
		}
		else if (songs[curSelected].songName == 'Tactical Mishap' && ClientPrefs.tacticalMishapPlayed == false)
		{
			trace('I got loaded lol, Unlocking Tactical Mishap!');
			ClientPrefs.tacticalMishapFound = true;
			ClientPrefs.tacticalMishapPlayed = true;
		}		
		else if (songs[curSelected].songName == 'Breacher' && ClientPrefs.breacherPlayed == false)
		{
			trace('I got loaded lol, Unlocking Breacher!');
			ClientPrefs.breacherPlayed = true;
		}
		else if (songs[curSelected].songName == 'Negotiation' && ClientPrefs.negotiationPlayed == false)
		{
			trace('I got loaded lol, Unlocking Negotiation!');
			ClientPrefs.negotiationPlayed = true;
		}
		else if (songs[curSelected].songName == 'Concert Chaos' && ClientPrefs.ccPlayed == false)
		{
			trace('I got loaded lol, Unlocking Concert Chaos!');
			ClientPrefs.ccPlayed = true;
		}
		ClientPrefs.saveSettings();
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}