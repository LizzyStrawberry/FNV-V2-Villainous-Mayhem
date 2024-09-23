package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

class ClientPrefs {
	public static var downScroll:Bool = false;
	public static var middleScroll:Bool = false;
	public static var opponentStrums:Bool = true;
	public static var showFPS:Bool = true;
	public static var showMemPeak:Bool = true;
	public static var flashing:Bool = true;
	public static var globalAntialiasing:Bool = true;
	public static var noteSplashes:Bool = true;
	public static var lowQuality:Bool = false;

	public static var shaders:Bool = true;
	public static var gore:Bool = true;
	public static var optimizationMode:Bool = false;
	public static var comboPosition:String = 'Hud';
	public static var mechanics:Bool = true;
	public static var missRelatedCombos:Bool = true;
	public static var trampolineMode:Bool = false;
	public static var cinematicBars:Bool = true;
	public static var customRating:String = 'FNV';
	public static var noteSplashMode:String = 'Inwards';
	public static var timeBarFlash:String = 'All Enabled';
	public static var performanceWarning:Bool = true;

	public static var mainWeekBeaten:Bool = false;
	public static var gotWinMessage:Bool = false;

	//For Tutorial Section
	public static var coreMechTutUnlocked:Bool = false;
	public static var shopTutUnlocked:Bool = false;

	//For Cellar Shop
	public static var oldLoadScreensUnlocked:Bool = false;
	public static var adMechanicScreensUnlocked:Bool = false;
	public static var fanartScreensUnlocked:Bool = false;
	public static var randomArtScreensUnlocked:Bool = false;

	public static var galleryUnlocked:Bool = false;

	//For Results screen for Story Mode / Iniquitous Mode / Freeplay
	public static var campaignHighScore:Int = 0;
	public static var campaignBestCombo:Int = 0;
	public static var campaignRating:Float = 0;
	public static var campaignSongsPlayed:Int = 0;

	//hard++ difficulty unlock
	public static var iniquitousUnlocked:Bool = false;

	//crash and save measure
	public static var storyModeCrashMeasure:String = '';
	public static var storyModeCrashWeek:Int = -1;
	public static var storyModeCrashWeekName:String = '';
	public static var storyModeCrashDifficulty:String = '';
	public static var storyModeCrashDifficultyNum:Int = -1;
	public static var storyModeCrashScore:Int = 0;
	public static var storyModeCrashMisses:Int = 0;

	//TOKENS
	public static var tokens:Int = 0;
	public static var tokensAchieved:Int = 0;

	//Extra shit that make things work lmao
	public static var optionsFreeplay:Bool = false;
	public static var inMenu:Bool = false;
	public static var firstTime:Bool = false;

	//shop checks
	public static var shopUnlocked:Bool = false;
	public static var secretShopShowcased:Bool = false;
	public static var shopShowcased:Bool = false;
	public static var inShop:Bool = false;
	public static var luckSelected:Bool = false;
	public static var sellSelected:Bool = false;
	public static var choiceSelected:Bool = false;
	public static var charmsSelected:Bool = false;
	public static var itemInfo:Bool = false;
	public static var talkedToZeel:Bool = false;
	public static var talkedToHermit:Bool = false;
	public static var eggs:Int = 0;

	//Freeplay Category Unlocks
	public static var bonusUnlocked:Bool = false;
	public static var xtraUnlocked:Bool = false;
	public static var crossoverUnlocked:Bool = false;
	public static var xtraBonusUnlocked:Bool = false;

	//Charms
	/*
	There are 3 Charms in this mod that will be either won by you through Mimiko, or bought by Zeel:
	Charm 1: Resistant Charm (It helps reducing the amount of health drain occured by the enemy and/or health drain.)
	Charm 2: Auto Charm (It helps with mechanics such as dodging/attacking in various songs.)
	Charm 3: Healing Charm (It heals you up, having 10 uses of it. You cannot stack em on though.)

	You can use all 3 charms in the songs, BUT you cannot buy multiple of the same ones each time. You have to wait till they run out and/or are used before buying new ones.

	IMPORTANT: THESE VARIABLES ARE SET IN NUMBERS BECAUSE:
	2: Ready to Activate
	1: Activated
	0: Disabled
	*/
	public static var resistanceCharm:Int = 0;
	public static var autoCharm:Int = 0;
	public static var healingCharm:Int = -1;

	public static var resCharmCollected:Bool = false;
	public static var autoCharmCollected:Bool = false;
	public static var healCharmCollected:Bool = false;
	public static var charmsCollected:Int = 0;

	//Unlocking the 2 Game Modes
	public static var weeksUnlocked:Int  = 0;

	//unlocking weeks
	public static var mainWeekFound:Bool = false;
	public static var mainWeekPlayed:Bool = false;
	public static var villainyBeaten:Bool = false;
	public static var pointBlankBeaten:Bool = false;
	public static var libidinousnessBeaten:Bool = false;
	public static var excreteBeaten:Bool = false;
	public static var nunWeekFound:Bool = false;
	public static var nunWeekPlayed:Bool = false;
	public static var dsideWeekFound:Bool = false;
	public static var dsideWeekPlayed:Bool = false;
	public static var susWeekFound:Bool = false;
	public static var susWeekPlayed:Bool = false;
	public static var kianaWeekFound:Bool = false;
	public static var kianaWeekPlayed:Bool = false;
	public static var legacyWeekFound:Bool = false;
	public static var legacyWeekPlayed:Bool = false;
	public static var morkyWeekPlayed:Bool = false;
	public static var morkyWeekFound:Bool = false;
	public static var iniquitousWeekUnlocked:Bool = false;
	public static var iniquitousWeekBeaten:Bool = false;

	//unlocking songs
	public static var tofuFound:Bool = false;
	public static var tofuViewed:Bool = false;
	public static var tofuPlayed:Bool = false;
	public static var lustalityFound:Bool = false;
	public static var lustalityViewed:Bool = false;
	public static var lustalityPlayed:Bool = false;
	public static var marcochromePlayed:Bool = false;
	public static var marcochromeViewed:Bool = false;
	public static var marcochromeFound:Bool = false;
	public static var nunsationalPlayed:Bool = false;
	public static var nunsationalViewed:Bool = false;
	public static var nunsationalFound:Bool = false;
	public static var nicFound:Bool = false;
	public static var nicViewed:Bool = false;
	public static var nicPlayed:Bool = false;
	public static var debugFound:Bool = false;
	public static var debugViewed:Bool = false;
	public static var debugPlayed:Bool = false;
	public static var fnvFound:Bool = false;
	public static var fnvViewed:Bool = false;
	public static var fnvPlayed:Bool = false;
	public static var shortFound:Bool = false; //0.0015
	public static var shortViewed:Bool = false;
	public static var shortPlayed:Bool = false;
	public static var infatuationFound:Bool = false;
	public static var infatuationViewed:Bool = false;
	public static var infatuationPlayed:Bool = false;
	public static var rainyDazeFound:Bool = false;
	public static var rainyDazeViewed:Bool = false;
	public static var rainyDazePlayed:Bool = false;

	public static var ourpleFound:Bool = true;
	public static var ourplePlayed:Bool = false;
	public static var kyuFound:Bool = true;
	public static var kyuPlayed:Bool = false;
	public static var tacticalMishapFound:Bool = true;
	public static var tacticalMishapPlayed:Bool = false;
	public static var breacherFound:Bool = true;
	public static var breacherPlayed:Bool = false;
	public static var ccFound:Bool = true;
	public static var ccPlayed:Bool = false;

	//Fuck LoadSong() sometimes lmao
	public static var codeRegistered:String = '';

	//:smug:
	public static var zeelNakedPics:Bool = false;
	public static var trampolineUnlocked:Bool = false;

	//background thingies
	public static var songsUnlocked:Int = 0;

	//Crossover Section
	public static var crossSongsAllowed:Int = 0;
	public static var onCrossSection:Bool = false;
	public static var roadMapUnlocked:Bool = false;
	public static var itsameDsidesUnlocked:Bool = false;

	//Injection Mode System
	public static var injectionEndScore:Int = 0;
	public static var injectionVilEndScore:Int = 0;
	//Mayhem Mode System
	public static var mayhemEndScore:Int = 0;
	
	public static var mayhemNotif:Bool = false;
	public static var injectionNotif:Bool = false;

	//Buffs / Inventory
	public static var buff1Unlocked:Bool = false;
	public static var buff1Selected:Bool = false;
	public static var buff2Unlocked:Bool = false;
	public static var buff2Selected:Bool = false;
	public static var buff3Unlocked:Bool = false;
	public static var buff3Selected:Bool = false;
	public static var buff1Active:Bool = false;
	public static var buff2Active:Bool = false;
	public static var buff3Active:Bool = false;
	public static var charInventory:String = 'playablegf';

	//Lore Scrolls
	public static var numberOfScrolls:Int = 0;
	public static var marcoScroll:Bool = false;
	public static var aileenScroll:Bool = false;
	public static var beatriceScroll:Bool = false;
	public static var evelynScroll:Bool = false;
	public static var yakuScroll:Bool = false;
	public static var dvScroll:Bool = false;
	public static var kianaScroll:Bool = false;
	public static var narrinScroll:Bool = false;
	public static var morkyScroll:Bool = false;
	public static var kaizokuScroll:Bool = false;

	public static var framerate:Int = 120;
	public static var cursing:Bool = true;
	public static var violence:Bool = true;
	public static var camZooms:Bool = true;
	public static var hideHud:Bool = false;
	public static var noteOffset:Int = 0;
	public static var arrowHSV:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
	public static var ghostTapping:Bool = true;
	public static var timeBarType:String = 'Time Left';
	public static var scoreZoom:Bool = true;
	public static var noReset:Bool = false;
	public static var healthBarAlpha:Float = 1;
	public static var controllerMode:Bool = false;
	public static var hitsoundVolume:Float = 0;
	public static var pauseMusic:String = 'Interstellar';
	public static var checkForUpdates:Bool = true;
	public static var comboStacking = true;
	public static var gameplaySettings:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative', 
		// anyone reading this, amod is multiplicative speed mod, cmod is constant speed mod, and xmod is bpm based speed mod.
		// an amod example would be chartSpeed * multiplier
		// cmod would just be constantSpeed = chartSpeed
		// and xmod basically works by basing the speed on the bpm.
		// iirc (beatsPerSecond * (conductorToNoteDifference / 1000)) * noteSize (110 or something like that depending on it, prolly just use note.height)
		// bps is calculated by bpm / 60
		// oh yeah and you'd have to actually convert the difference to seconds which I already do, because this is based on beats and stuff. but it should work
		// just fine. but I wont implement it because I don't know how you handle sustains and other stuff like that.
		// oh yeah when you calculate the bps divide it by the songSpeed or rate because it wont scroll correctly when speeds exist.
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => false,
		'botplay' => false,
		'opponentplay' => false
	];
	public static var gameplaySettingsBackUp:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative', 
		// anyone reading this, amod is multiplicative speed mod, cmod is constant speed mod, and xmod is bpm based speed mod.
		// an amod example would be chartSpeed * multiplier
		// cmod would just be constantSpeed = chartSpeed
		// and xmod basically works by basing the speed on the bpm.
		// iirc (beatsPerSecond * (conductorToNoteDifference / 1000)) * noteSize (110 or something like that depending on it, prolly just use note.height)
		// bps is calculated by bpm / 60
		// oh yeah and you'd have to actually convert the difference to seconds which I already do, because this is based on beats and stuff. but it should work
		// just fine. but I wont implement it because I don't know how you handle sustains and other stuff like that.
		// oh yeah when you calculate the bps divide it by the songSpeed or rate because it wont scroll correctly when speeds exist.
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => false,
		'botplay' => false,
		'opponentplay' => false
	];

	public static var comboOffset:Array<Int> = [621, -339, 754, -272];
	public static var ratingOffset:Int = 0;
	public static var sickWindow:Int = 45;
	public static var goodWindow:Int = 90;
	public static var badWindow:Int = 135;
	public static var safeFrames:Float = 10;

	//Every key has two binds, add your key bind down here and then add your control on options/ControlsSubState.hx and Controls.hx
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		//Key Bind, Name for ControlsSubState
		'note_left'		=> [A, LEFT],
		'note_down'		=> [S, DOWN],
		'note_up'		=> [W, UP],
		'note_right'	=> [D, RIGHT],

		'dodge'			=> [SPACE, NONE],
		'attack'		=> [SHIFT, NONE],
		'mayhem'		=> [ALT, NONE],
		'charm1'		=> [ONE, NONE],
		'charm2'		=> [TWO, NONE],
		'charm3'		=> [THREE, NONE],
		
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_up'			=> [W, UP],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R, NONE],
		
		'volume_mute'	=> [ZERO, NONE],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN, NONE],
		'debug_2'		=> [EIGHT, NONE]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static function loadDefaultKeys() {
		defaultKeys = keyBinds.copy();
		//trace(defaultKeys);
	}

	public static function saveSettings() {
		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.middleScroll = middleScroll;
		FlxG.save.data.opponentStrums = opponentStrums;
		FlxG.save.data.showFPS = showFPS;
		FlxG.save.data.showMemPeak = showMemPeak;
		FlxG.save.data.flashing = flashing;
		FlxG.save.data.globalAntialiasing = globalAntialiasing;
		FlxG.save.data.noteSplashes = noteSplashes;
		FlxG.save.data.lowQuality = lowQuality;
		FlxG.save.data.framerate = framerate;
		//FlxG.save.data.cursing = cursing;
		//FlxG.save.data.violence = violence;
		FlxG.save.data.camZooms = camZooms;
		FlxG.save.data.noteOffset = noteOffset;
		FlxG.save.data.hideHud = hideHud;
		FlxG.save.data.arrowHSV = arrowHSV;
		FlxG.save.data.ghostTapping = ghostTapping;
		FlxG.save.data.timeBarType = timeBarType;
		FlxG.save.data.scoreZoom = scoreZoom;
		FlxG.save.data.noReset = noReset;
		FlxG.save.data.healthBarAlpha = healthBarAlpha;
		FlxG.save.data.comboOffset = comboOffset;
		FlxG.save.data.achievementsMap = Achievements.achievementsMap;
		FlxG.save.data.henchmenDeath = Achievements.henchmenDeath;

		FlxG.save.data.tokens = tokens;
		FlxG.save.data.tokensAchieved = tokensAchieved;

		FlxG.save.data.optimizationMode = optimizationMode;
		FlxG.save.data.comboPosition = comboPosition;
		FlxG.save.data.gore = gore;
		FlxG.save.data.shaders = shaders;
		FlxG.save.data.mechanics = mechanics;
		FlxG.save.data.missRelatedCombos = missRelatedCombos;
		FlxG.save.data.trampolineMode = trampolineMode;
		FlxG.save.data.cinematicBars = cinematicBars;
		FlxG.save.data.customRating = customRating;
		FlxG.save.data.noteSplashMode = noteSplashMode;
		FlxG.save.data.timeBarFlash = timeBarFlash;
		FlxG.save.data.performanceWarning = performanceWarning;

		FlxG.save.data.mainWeekBeaten = mainWeekBeaten;
		FlxG.save.data.gotWinMessage = gotWinMessage;

		FlxG.save.data.coreMechTutUnlocked = coreMechTutUnlocked;
		FlxG.save.data.shopTutUnlocked = shopTutUnlocked;

		FlxG.save.data.oldLoadScreensUnlocked = oldLoadScreensUnlocked;
		FlxG.save.data.adMechanicScreensUnlocked = adMechanicScreensUnlocked;
		FlxG.save.data.fanartScreensUnlocked = fanartScreensUnlocked;
		FlxG.save.data.randomArtScreensUnlocked = randomArtScreensUnlocked;

		FlxG.save.data.galleryUnlocked = galleryUnlocked;

		FlxG.save.data.campaignHighScore = campaignHighScore;
		FlxG.save.data.campaignBestCombo = campaignBestCombo;
		FlxG.save.data.campaignRating = campaignRating;
		FlxG.save.data.campaignSongsPlayed = campaignSongsPlayed;

		FlxG.save.data.iniquitousUnlocked = iniquitousUnlocked;

		FlxG.save.data.storyModeCrashMeasure = storyModeCrashMeasure;
		FlxG.save.data.storyModeCrashWeek = storyModeCrashWeek;
		FlxG.save.data.storyModeCrashWeekName = storyModeCrashWeekName;
		FlxG.save.data.storyModeCrashDifficulty = storyModeCrashDifficulty;
		FlxG.save.data.storyModeCrashDifficultyNum = storyModeCrashDifficultyNum;
		FlxG.save.data.storyModeCrashScore = storyModeCrashScore;
		FlxG.save.data.storyModeCrashMisses = storyModeCrashMisses;

		FlxG.save.data.optionsFreeplay = optionsFreeplay;
		FlxG.save.data.inMenu = inMenu;
		FlxG.save.data.firstTime = firstTime;

		FlxG.save.data.shopUnlocked = shopUnlocked;
		FlxG.save.data.secretShopShowcased = secretShopShowcased;
		FlxG.save.data.shopShowcased = shopShowcased;
		FlxG.save.data.inShop = inShop;
		FlxG.save.data.itemInfo = itemInfo;
		FlxG.save.data.luckSelected = luckSelected;
		FlxG.save.data.sellSelected = sellSelected;
		FlxG.save.data.choiceSelected = choiceSelected;
		FlxG.save.data.charmsSelected = charmsSelected;
		FlxG.save.data.talkedToZeel = talkedToZeel;
		FlxG.save.data.talkedToHermit = talkedToHermit;
		FlxG.save.data.eggs = eggs;

		FlxG.save.data.bonusUnlocked = bonusUnlocked;
		FlxG.save.data.xtraUnlocked = xtraUnlocked;
		FlxG.save.data.crossoverUnlocked = crossoverUnlocked;
		FlxG.save.data.xtraBonusUnlocked = xtraBonusUnlocked;

		FlxG.save.data.resistanceCharm = resistanceCharm;
		FlxG.save.data.autoCharm = autoCharm;
		FlxG.save.data.healingCharm = healingCharm;

		FlxG.save.data.resCharmCollected = resCharmCollected;
		FlxG.save.data.autoCharmCollected = autoCharmCollected;
		FlxG.save.data.healCharmCollected = healCharmCollected;
		FlxG.save.data.charmsCollected = charmsCollected;

		FlxG.save.data.weeksUnlocked = weeksUnlocked;

		FlxG.save.data.mainWeekFound = mainWeekFound;
		FlxG.save.data.mainWeekPlayed = mainWeekPlayed;
		FlxG.save.data.villainyBeaten = villainyBeaten;
		FlxG.save.data.pointBlankBeaten = pointBlankBeaten;
		FlxG.save.data.libidinousnessBeaten = libidinousnessBeaten;
		FlxG.save.data.excreteBeaten = excreteBeaten;
		FlxG.save.data.nunWeekFound = nunWeekFound;
		FlxG.save.data.nunWeekPlayed = nunWeekPlayed;
		FlxG.save.data.dsideWeekFound = dsideWeekFound;
		FlxG.save.data.dsideWeekPlayed = dsideWeekPlayed;
		FlxG.save.data.susWeekFound = susWeekFound;
		FlxG.save.data.susWeekPlayed = susWeekPlayed;
		FlxG.save.data.kianaWeekFound = kianaWeekFound;
		FlxG.save.data.kianaWeekPlayed = kianaWeekPlayed;
		FlxG.save.data.legacyWeekFound = legacyWeekFound;
		FlxG.save.data.legacyWeekPlayed = legacyWeekPlayed;
		FlxG.save.data.morkyWeekPlayed = morkyWeekPlayed;
		FlxG.save.data.morkyWeekFound = morkyWeekFound;
		FlxG.save.data.iniquitousWeekUnlocked = iniquitousWeekUnlocked;
		FlxG.save.data.iniquitousWeekBeaten = iniquitousWeekBeaten;

		FlxG.save.data.tofuFound = tofuFound;
		FlxG.save.data.tofuViewed = tofuViewed;
		FlxG.save.data.tofuPlayed = tofuPlayed;
		FlxG.save.data.lustalityPlayed = lustalityPlayed;
		FlxG.save.data.lustalityViewed = lustalityViewed;
		FlxG.save.data.lustalityFound = lustalityFound;
		FlxG.save.data.marcochromePlayed = marcochromePlayed;
		FlxG.save.data.marcochromeViewed = marcochromeViewed;
		FlxG.save.data.marcochromeFound = marcochromeFound;
		FlxG.save.data.nunsationalPlayed = nunsationalPlayed;
		FlxG.save.data.nunsationalViewed = nunsationalViewed;
		FlxG.save.data.nunsationalFound = nunsationalFound;
		FlxG.save.data.nicFound = nicFound;
		FlxG.save.data.nicViewed = nicViewed;
		FlxG.save.data.nicPlayed = nicPlayed;
		FlxG.save.data.debugFound = debugFound;
		FlxG.save.data.debugViewed = debugViewed;
		FlxG.save.data.debugPlayed = debugPlayed;
		FlxG.save.data.fnvFound = fnvFound;
		FlxG.save.data.fnvViewed = fnvViewed;
		FlxG.save.data.fnvPlayed = fnvPlayed;
		FlxG.save.data.shortFound = shortFound;
		FlxG.save.data.shortViewed = shortViewed;
		FlxG.save.data.shortPlayed = shortPlayed;
		FlxG.save.data.infatuationFound = infatuationFound;
		FlxG.save.data.infatuationViewed = infatuationViewed;
		FlxG.save.data.infatuationPlayed = infatuationPlayed;
		FlxG.save.data.rainyDazeFound = rainyDazeFound;
		FlxG.save.data.rainyDazeViewed = rainyDazeViewed;
		FlxG.save.data.rainyDazePlayed = rainyDazePlayed;

		FlxG.save.data.ourpleFound = ourpleFound;
		FlxG.save.data.ourplePlayed = ourplePlayed;
		FlxG.save.data.tacticalMishapFound = tacticalMishapFound;
		FlxG.save.data.tacticalMishapPlayed = tacticalMishapPlayed;
		FlxG.save.data.kyuFound = kyuFound;
		FlxG.save.data.kyuPlayed = kyuPlayed;
		FlxG.save.data.breacherFound = breacherFound;
		FlxG.save.data.breacherPlayed = breacherPlayed;
		FlxG.save.data.ccFound = ccFound;
		FlxG.save.data.ccPlayed = ccPlayed;

		FlxG.save.data.codeRegistered = codeRegistered;

		FlxG.save.data.zeelNakedPics = zeelNakedPics;
		FlxG.save.data.trampolineUnlocked = trampolineUnlocked;

		FlxG.save.data.songsUnlocked = songsUnlocked;

		FlxG.save.data.crossSongsAllowed = crossSongsAllowed;
		FlxG.save.data.onCrossSection = onCrossSection;
		FlxG.save.data.roadMapUnlocked = roadMapUnlocked;
		FlxG.save.data.itsameDsidesUnlocked = itsameDsidesUnlocked;

		FlxG.save.data.injectionEndScore = injectionEndScore;
		FlxG.save.data.injectionVilEndScore = injectionVilEndScore;
		FlxG.save.data.mayhemEndScore = mayhemEndScore;

		FlxG.save.data.mayhemNotif = mayhemNotif;
		FlxG.save.data.injectionNotif = injectionNotif;

		FlxG.save.data.buff1Unlocked = buff1Unlocked;
		FlxG.save.data.buff1Selected = buff1Selected;
		FlxG.save.data.buff2Unlocked = buff2Unlocked;
		FlxG.save.data.buff2Selected = buff2Selected;
		FlxG.save.data.buff3Unlocked = buff3Unlocked;
		FlxG.save.data.buff3Selected = buff3Selected;
		FlxG.save.data.buff1Active = buff1Active;
		FlxG.save.data.buff2Active = buff2Active;
		FlxG.save.data.buff3Active = buff3Active;
		FlxG.save.data.charInventory = charInventory;

		FlxG.save.data.numberOfScrolls = numberOfScrolls;
		FlxG.save.data.marcoScroll = marcoScroll;
		FlxG.save.data.aileenScroll = aileenScroll;
		FlxG.save.data.beatriceScroll = beatriceScroll;
		FlxG.save.data.evelynScroll = evelynScroll;
		FlxG.save.data.yakuScroll = yakuScroll;
		FlxG.save.data.dvScroll = dvScroll;
		FlxG.save.data.kianaScroll = kianaScroll;
		FlxG.save.data.narrinScroll = narrinScroll;
		FlxG.save.data.morkyScroll = morkyScroll;
		FlxG.save.data.kaizokuScroll = kaizokuScroll;

		FlxG.save.data.ratingOffset = ratingOffset;
		FlxG.save.data.sickWindow = sickWindow;
		FlxG.save.data.goodWindow = goodWindow;
		FlxG.save.data.badWindow = badWindow;
		FlxG.save.data.safeFrames = safeFrames;
		FlxG.save.data.gameplaySettings = gameplaySettings;
		FlxG.save.data.controllerMode = controllerMode;
		FlxG.save.data.hitsoundVolume = hitsoundVolume;
		FlxG.save.data.pauseMusic = pauseMusic;
		FlxG.save.data.checkForUpdates = checkForUpdates;
		FlxG.save.data.comboStacking = comboStacking;
	
		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99'); //Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function resetSettings() {
		FlashingState.leftState = false;

		Highscore.resetAllWeeks();
		Highscore.resetAllSongs();
		Highscore.load();
		FlxG.save.data.downScroll = false;
		FlxG.save.data.middleScroll = false;
		FlxG.save.data.opponentStrums = true;
		FlxG.save.data.showFPS = true;
		FlxG.save.data.showMemPeak = true;
		FlxG.save.data.flashing = null;
		FlxG.save.data.globalAntialiasing = true;
		FlxG.save.data.noteSplashes = true;
		FlxG.save.data.lowQuality = false;
		FlxG.save.data.framerate = 120;
		FlxG.save.data.camZooms = true;
		FlxG.save.data.noteOffset = 0;
		FlxG.save.data.hideHud = false;
		FlxG.save.data.arrowHSV = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
		FlxG.save.data.ghostTapping = true;
		FlxG.save.data.timeBarType = 'Time Left';
		FlxG.save.data.scoreZoom = true;
		FlxG.save.data.noReset = false;
		FlxG.save.data.healthBarAlpha = 1;
		FlxG.save.data.comboOffset = [621, -339, 754, -272];
		FlxG.save.data.achievementsMap = Achievements.achievementsMapBackUp;
		FlxG.save.data.henchmenDeath = 0;

		FlxG.save.data.tokens = 0;
		FlxG.save.data.tokensAchieved = 0;

		FlxG.save.data.optimizationMode = false;
		FlxG.save.data.comboPosition = 'Hud';
		FlxG.save.data.gore = true;
		FlxG.save.data.shaders = true;
		FlxG.save.data.mechanics = true;
		FlxG.save.data.missRelatedCombos = true;
		FlxG.save.data.trampolineMode = false;
		FlxG.save.data.cinematicBars = true;
		FlxG.save.data.customRating = 'FNV';
		FlxG.save.data.noteSplashMode = 'Inwards';
		FlxG.save.data.timeBarFlash = 'All Enabled';
		FlxG.save.data.performanceWarning = true;

		FlxG.save.data.mainWeekBeaten = false;
		FlxG.save.data.gotWinMessage = false;

		FlxG.save.data.coreMechTutUnlocked = false;
		FlxG.save.data.shopTutUnlocked = false;

		FlxG.save.data.oldLoadScreensUnlocked = false;
		FlxG.save.data.adMechanicScreensUnlocked = false;
		FlxG.save.data.fanartScreensUnlocked = false;
		FlxG.save.data.randomArtScreensUnlocked = false;

		FlxG.save.data.galleryUnlocked = false;

		FlxG.save.data.campaignHighScore = 0;
		FlxG.save.data.campaignBestCombo = 0;
		FlxG.save.data.campaignRating = 0;
		FlxG.save.data.campaignSongsPlayed = 0;

		FlxG.save.data.iniquitousUnlocked = false;

		FlxG.save.data.storyModeCrashMeasure = '';
		FlxG.save.data.storyModeCrashWeek = -1;
		FlxG.save.data.storyModeCrashWeekName = '';
		FlxG.save.data.storyModeCrashDifficulty = '';
		FlxG.save.data.storyModeCrashDifficultyNum = -1;
		FlxG.save.data.storyModeCrashScore = 0;
		FlxG.save.data.storyModeCrashMisses = 0;

		FlxG.save.data.optionsFreeplay = false;
		FlxG.save.data.inMenu = false;
		FlxG.save.data.firstTime = false;

		FlxG.save.data.shopUnlocked = false;
		FlxG.save.data.secretShopShowcased = false;
		FlxG.save.data.shopShowcased = false;
		FlxG.save.data.inShop = false;
		FlxG.save.data.itemInfo = false;
		FlxG.save.data.luckSelected = false;
		FlxG.save.data.sellSelected = false;
		FlxG.save.data.choiceSelected = false;
		FlxG.save.data.charmsSelected = false;
		FlxG.save.data.talkedToZeel = false;
		FlxG.save.data.talkedToHermit = false;
		FlxG.save.data.eggs = 0;

		FlxG.save.data.bonusUnlocked = false;
		FlxG.save.data.xtraUnlocked = false;
		FlxG.save.data.crossoverUnlocked = false;
		FlxG.save.data.xtraBonusUnlocked = false;

		FlxG.save.data.resistanceCharm = 0;
		FlxG.save.data.autoCharm = 0;
		FlxG.save.data.healingCharm = 0;

		FlxG.save.data.resCharmCollected = false;
		FlxG.save.data.autoCharmCollected = false;
		FlxG.save.data.healCharmCollected = false;
		FlxG.save.data.charmsCollected = 0;

		FlxG.save.data.weeksUnlocked = 0;

		FlxG.save.data.mainWeekFound = false;
		FlxG.save.data.mainWeekPlayed = false;
		FlxG.save.data.villainyBeaten = false;
		FlxG.save.data.pointBlankBeaten = false;
		FlxG.save.data.libidinousnessBeaten = false;
		FlxG.save.data.excreteBeaten = false;
		FlxG.save.data.nunWeekFound = false;
		FlxG.save.data.nunWeekPlayed = false;
		FlxG.save.data.dsideWeekFound = false;
		FlxG.save.data.dsideWeekPlayed = false;
		FlxG.save.data.susWeekFound = false;
		FlxG.save.data.susWeekPlayed = false;
		FlxG.save.data.kianaWeekFound = false;
		FlxG.save.data.kianaWeekPlayed = false;
		FlxG.save.data.legacyWeekFound = false;
		FlxG.save.data.legacyWeekPlayed = false;
		FlxG.save.data.morkyWeekPlayed = false;
		FlxG.save.data.morkyWeekFound = false;
		FlxG.save.data.iniquitousWeekUnlocked = false;
		FlxG.save.data.iniquitousWeekBeaten = false;

		FlxG.save.data.tofuFound = false;
		FlxG.save.data.tofuViewed = false;
		FlxG.save.data.tofuPlayed = false;
		FlxG.save.data.lustalityPlayed = false;
		FlxG.save.data.lustalityViewed = false;
		FlxG.save.data.lustalityFound = false;
		FlxG.save.data.marcochromePlayed = false;
		FlxG.save.data.marcochromeViewed = false;
		FlxG.save.data.marcochromeFound = false;
		FlxG.save.data.nunsationalPlayed = false;
		FlxG.save.data.nunsationalViewed = false;
		FlxG.save.data.nunsationalFound = false;
		FlxG.save.data.nicFound = false;
		FlxG.save.data.nicViewed = false;
		FlxG.save.data.nicPlayed = false;
		FlxG.save.data.debugFound = false;
		FlxG.save.data.debugViewed = false;
		FlxG.save.data.debugPlayed = false;
		FlxG.save.data.fnvFound = false;
		FlxG.save.data.fnvViewed = false;
		FlxG.save.data.fnvPlayed = false;
		FlxG.save.data.shortFound = false;
		FlxG.save.data.shortViewed = false;
		FlxG.save.data.shortPlayed = false;
		FlxG.save.data.infatuationFound = false;
		FlxG.save.data.infatuationViewed = false;
		FlxG.save.data.infatuationPlayed = false;
		FlxG.save.data.rainyDazeFound = false;
		FlxG.save.data.rainyDazeViewed = false;
		FlxG.save.data.rainyDazePlayed = false;

		FlxG.save.data.ourpleFound = true;
		FlxG.save.data.ourplePlayed = false;
		FlxG.save.data.tacticalMishapFound = true;
		FlxG.save.data.tacticalMishapPlayed = false;
		FlxG.save.data.kyuFound = true;
		FlxG.save.data.kyuPlayed = false;
		FlxG.save.data.breacherFound = true;
		FlxG.save.data.breacherPlayed = false;
		FlxG.save.data.ccFound = true;
		FlxG.save.data.ccPlayed = false;

		FlxG.save.data.codeRegistered = '';

		FlxG.save.data.zeelNakedPics = false;
		FlxG.save.data.trampolineUnlocked = false;

		FlxG.save.data.songsUnlocked = 0;

		FlxG.save.data.crossSongsAllowed = 0;
		FlxG.save.data.onCrossSection = false;
		FlxG.save.data.roadMapUnlocked = false;
		FlxG.save.data.itsameDsidesUnlocked = false;

		FlxG.save.data.injectionEndScore = 0;
		FlxG.save.data.injectionVilEndScore = 0;
		FlxG.save.data.mayhemEndScore = 0;

		FlxG.save.data.mayhemNotif = false;
		FlxG.save.data.injectionNotif = false;

		FlxG.save.data.buff1Unlocked = false;
		FlxG.save.data.buff1Selected = false;
		FlxG.save.data.buff2Unlocked = false;
		FlxG.save.data.buff2Selected = false;
		FlxG.save.data.buff3Unlocked = false;
		FlxG.save.data.buff3Selected = false;
		FlxG.save.data.buff1Active = false;
		FlxG.save.data.buff2Active = false;
		FlxG.save.data.buff3Active = false;
		FlxG.save.data.charInventory = 'playablegf';

		FlxG.save.data.numberOfScrolls = 0;
		FlxG.save.data.marcoScroll = false;
		FlxG.save.data.aileenScroll = false;
		FlxG.save.data.beatriceScroll = false;
		FlxG.save.data.evelynScroll = false;
		FlxG.save.data.yakuScroll = false;
		FlxG.save.data.dvScroll = false;
		FlxG.save.data.kianaScroll = false;
		FlxG.save.data.narrinScroll = false;
		FlxG.save.data.morkyScroll = false;
		FlxG.save.data.kaizokuScroll = false;

		FlxG.save.data.ratingOffset = 0;
		FlxG.save.data.sickWindow = 45;
		FlxG.save.data.goodWindow = 90;
		FlxG.save.data.badWindow = 135;
		FlxG.save.data.safeFrames = 10;
		var savedMap:Map<String, Dynamic> = ClientPrefs.gameplaySettingsBackUp;
		for (name => value in savedMap)
		{
			gameplaySettings.set(name, value);
		}
		FlxG.save.data.controllerMode = false;
		FlxG.save.data.hitsoundVolume = 0;
		FlxG.save.data.pauseMusic = 'Interstellar';
		FlxG.save.data.checkForUpdates = true;
		FlxG.save.data.comboStacking = true;

		downScroll = false;
		middleScroll = false;
		opponentStrums = true;
		showFPS = true;
		showMemPeak = true;
		flashing = true;
		globalAntialiasing = true;
		noteSplashes = true;
		lowQuality = false;
		framerate = 120;
		camZooms = true;
		noteOffset = 0;
		hideHud = false;
		arrowHSV = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
		ghostTapping = true;
		timeBarType = 'Time Left';
		scoreZoom = true;
		noReset = false;
		healthBarAlpha = 1;
		comboOffset = [621, -339, 754, -272];
		Achievements.achievementsMap = Achievements.achievementsMapBackUp;

		tokens = 0;
		tokensAchieved = 0;

		optimizationMode = false;
		comboPosition = 'Hud';
		gore = true;
		shaders = true;
		mechanics = true;
		missRelatedCombos = true;
		trampolineMode = false;
		cinematicBars = true;
		customRating = 'FNV';
		noteSplashMode = 'Inwards';
		timeBarFlash = 'All Enabled';
		performanceWarning = true;

		mainWeekBeaten = false;
		gotWinMessage = false;

		coreMechTutUnlocked = false;
		shopTutUnlocked = false;

		oldLoadScreensUnlocked = false;
		adMechanicScreensUnlocked = false;
		fanartScreensUnlocked = false;
		randomArtScreensUnlocked = false;

		galleryUnlocked = false;

		campaignHighScore = 0;
		campaignBestCombo = 0;
		campaignRating = 0;
		campaignSongsPlayed = 0;

		iniquitousUnlocked = false;

		storyModeCrashMeasure = '';
		storyModeCrashWeek = -1;
		storyModeCrashWeekName = '';
		storyModeCrashDifficulty = '';
		storyModeCrashDifficultyNum = -1;
		storyModeCrashScore = 0;
		storyModeCrashMisses = 0;

		optionsFreeplay = false;
		inMenu = false;
		firstTime = false;

		shopUnlocked = false;
		secretShopShowcased = false;
		shopShowcased = false;
		inShop = false;
		itemInfo = false;
		luckSelected = false;
		sellSelected = false;
		choiceSelected = false;
		charmsSelected = false;
		talkedToZeel = false;
		talkedToHermit = false;
		eggs = 0;

		bonusUnlocked = false;
		xtraUnlocked = false;
		crossoverUnlocked = false;
		xtraBonusUnlocked = false;

		resistanceCharm = 0;
		autoCharm = 0;
		healingCharm = 0;

		resCharmCollected = false;
		autoCharmCollected = false;
		healCharmCollected = false;
		charmsCollected = 0;

		weeksUnlocked = 0;

		mainWeekFound = false;
		mainWeekPlayed = false;
		villainyBeaten = false;
		pointBlankBeaten = false;
		libidinousnessBeaten = false;
		excreteBeaten = false;
		nunWeekFound = false;
		nunWeekPlayed = false;
		dsideWeekFound = false;
		dsideWeekPlayed = false;
		susWeekFound = false;
		susWeekPlayed = false;
		kianaWeekFound = false;
		kianaWeekPlayed = false;
		legacyWeekFound = false;
		legacyWeekPlayed = false;
		morkyWeekPlayed = false;
		morkyWeekFound = false;
		iniquitousWeekUnlocked = false;
		iniquitousWeekBeaten = false;

		tofuFound = false;
		tofuViewed = false;
		tofuPlayed = false;
		lustalityPlayed = false;
		lustalityViewed = false;
		lustalityFound = false;
		marcochromePlayed = false;
		marcochromeViewed = false;
		marcochromeFound = false;
		nunsationalPlayed = false;
		nunsationalViewed = false;
		nunsationalFound = false;
		nicFound = false;
		nicViewed = false;
		nicPlayed = false;
		debugViewed = false;
		tofuFound = false;
		fnvFound = false;
		fnvViewed = false;
		fnvPlayed = false;
		shortFound = false;
		shortViewed = false;
		shortPlayed = false;
		infatuationFound = false;
		infatuationViewed = false;
		infatuationPlayed = false;
		rainyDazeFound = false;
		rainyDazeViewed = false;
		rainyDazePlayed = false;

		ourpleFound = true;
		ourplePlayed = false;
		tacticalMishapFound = true;
		tacticalMishapPlayed = false;
		kyuFound = true;
		kyuPlayed = false;
		breacherFound = true;
		breacherPlayed = false;
		ccFound = true;
		ccPlayed = false;

		codeRegistered = '';

		zeelNakedPics = false;
		trampolineUnlocked = false;

		songsUnlocked = 0;

		crossSongsAllowed = 0;
		onCrossSection = false;
		roadMapUnlocked = false;
		itsameDsidesUnlocked = false;

		injectionEndScore = 0;
		injectionVilEndScore = 0;
		mayhemEndScore = 0;

		mayhemNotif = false;
		injectionNotif = false;

		buff1Unlocked = false;
		buff1Selected = false;
		buff2Unlocked = false;
		buff2Selected = false;
		buff3Unlocked = false;
		buff3Selected = false;
		buff1Active = false;
		buff2Active = false;
		buff3Active = false;
		charInventory = 'playablegf';

		numberOfScrolls = 0;
		marcoScroll = false;
		aileenScroll = false;
		beatriceScroll = false;
		evelynScroll = false;
		yakuScroll = false;
		dvScroll = false;
		kianaScroll = false;
		narrinScroll = false;
		morkyScroll = false;
		kaizokuScroll = false;

		ratingOffset = 0;
		sickWindow = 45;
		goodWindow = 90;
		badWindow = 135;
		safeFrames = 10;
		controllerMode = false;
		hitsoundVolume = 0;
		pauseMusic = 'Interstellar';
		checkForUpdates = true;
		comboStacking = true;

		Achievements.loadAchievements();
	
		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99'); //Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = defaultKeys;
		save.flush();
		trace("Settings Resetted!");
	}

	public static function debugComplete() {
		tokens = 999;

		mainWeekBeaten = true;
		gotWinMessage = true;

		coreMechTutUnlocked = true;
		shopTutUnlocked = true;

		oldLoadScreensUnlocked = true;
		adMechanicScreensUnlocked = true;
		fanartScreensUnlocked = true;
		randomArtScreensUnlocked = true;

		galleryUnlocked = true;
		iniquitousUnlocked = true;
		firstTime = true;

		shopUnlocked = true;
		secretShopShowcased = true;
		shopShowcased = true;
		talkedToZeel = true;
		talkedToHermit = true;
		eggs = 999;

		bonusUnlocked = true;
		xtraUnlocked = true;
		crossoverUnlocked = true;
		xtraBonusUnlocked = true;

		resistanceCharm = 2;
		autoCharm = 2;
		healingCharm = 2;

		resCharmCollected = true;
		autoCharmCollected = true;
		healCharmCollected = true;
		charmsCollected = 3;

		weeksUnlocked = 99;

		mainWeekFound = true;
		mainWeekPlayed = true;
		villainyBeaten = true;
		pointBlankBeaten = true;
		libidinousnessBeaten = true;
		excreteBeaten = true;
		nunWeekFound = true;
		nunWeekPlayed = true;
		dsideWeekFound = true;
		dsideWeekPlayed = true;
		susWeekFound = true;
		susWeekPlayed = true;
		kianaWeekFound = true;
		kianaWeekPlayed = true;
		legacyWeekFound = true;
		legacyWeekPlayed = true;
		morkyWeekPlayed = true;
		morkyWeekFound = true;
		iniquitousWeekUnlocked = true;
		iniquitousWeekBeaten = true;

		tofuFound = true;
		tofuViewed = true;
		tofuPlayed = true;
		lustalityPlayed = true;
		lustalityViewed = true;
		lustalityFound = true;
		marcochromePlayed = true;
		marcochromeViewed = true;
		marcochromeFound = true;
		nunsationalPlayed = true;
		nunsationalViewed = true;
		nunsationalFound = true;
		nicFound = true;
		nicViewed = true;
		nicPlayed = true;
		debugViewed = true;
		tofuFound = true;
		fnvFound = true;
		fnvViewed = true;
		fnvPlayed = true;
		shortFound = true;
		shortViewed = true;
		shortPlayed = true;
		infatuationFound = true;
		infatuationViewed = true;
		infatuationPlayed = true;
		rainyDazeFound = true;
		rainyDazeViewed = true;
		rainyDazePlayed = true;

		ourpleFound = true;
		ourplePlayed = true;
		tacticalMishapFound = true;
		tacticalMishapPlayed = true;
		kyuFound = true;
		kyuPlayed = true;
		breacherFound = true;
		breacherPlayed = true;
		ccFound = true;
		ccPlayed = true;

		codeRegistered = '';

		zeelNakedPics = true;
		trampolineUnlocked = true;

		songsUnlocked = 99;

		crossSongsAllowed = 5;
		onCrossSection = false;
		roadMapUnlocked = false;
		itsameDsidesUnlocked = true;

		buff1Unlocked = true;
		buff2Unlocked = true;
		buff3Unlocked = true;

		numberOfScrolls = 10;
		marcoScroll = true;
		aileenScroll = true;
		beatriceScroll = true;
		evelynScroll = true;
		yakuScroll = true;
		dvScroll = true;
		kianaScroll = true;
		narrinScroll = true;
		morkyScroll = true;
		kaizokuScroll = true;

		Achievements.debugUnlock();
		trace("Settings Saved!");
	}

	public static function loadPrefs() {
		if(FlxG.save.data.downScroll != null) {
			downScroll = FlxG.save.data.downScroll;
		}
		if(FlxG.save.data.middleScroll != null) {
			middleScroll = FlxG.save.data.middleScroll;
		}
		if(FlxG.save.data.opponentStrums != null) {
			opponentStrums = FlxG.save.data.opponentStrums;
		}
		if(FlxG.save.data.showFPS != null) {
			showFPS = FlxG.save.data.showFPS;
			if(Main.fpsVar != null) {
				Main.fpsVar.visible = showFPS;
			}
		}
		if(FlxG.save.data.showMemPeak != null) {
			showMemPeak = FlxG.save.data.showMemPeak;
		}
		if(FlxG.save.data.flashing != null) {
			flashing = FlxG.save.data.flashing;
		}
		if(FlxG.save.data.globalAntialiasing != null) {
			globalAntialiasing = FlxG.save.data.globalAntialiasing;
		}
		if(FlxG.save.data.noteSplashes != null) {
			noteSplashes = FlxG.save.data.noteSplashes;
		}
		if(FlxG.save.data.lowQuality != null) {
			lowQuality = FlxG.save.data.lowQuality;
		}

		if(FlxG.save.data.tokens != null) {
			tokens = FlxG.save.data.tokens;
		}
		if(FlxG.save.data.tokensAchieved != null) {
			tokensAchieved = FlxG.save.data.tokensAchieved;
		}

		if(FlxG.save.data.optimizationMode != null) {
			optimizationMode = FlxG.save.data.optimizationMode;
		}
		if(FlxG.save.data.comboPosition != null) {
			comboPosition = FlxG.save.data.comboPosition;
		}
		if(FlxG.save.data.gore != null) {
			gore = FlxG.save.data.gore;
		}
		if(FlxG.save.data.shaders != null) {
			shaders = FlxG.save.data.shaders;
		}
		if(FlxG.save.data.mechanics != null) {
			mechanics = FlxG.save.data.mechanics;
		}
		if(FlxG.save.data.missRelatedCombos != null) {
			missRelatedCombos = FlxG.save.data.missRelatedCombos;
		}
		if(FlxG.save.data.trampolineMode != null) {
			trampolineMode = FlxG.save.data.trampolineMode;
		}
		if(FlxG.save.data.cinematicBars != null) {
			cinematicBars = FlxG.save.data.cinematicBars;
		}
		if(FlxG.save.data.customRating != null) {
			customRating = FlxG.save.data.customRating;
		}
		if(FlxG.save.data.noteSplashMode != null) {
			noteSplashMode = FlxG.save.data.noteSplashMode;
		}
		if(FlxG.save.data.timeBarFlash != null) {
			timeBarFlash = FlxG.save.data.timeBarFlash;
		}
		if(FlxG.save.data.performanceWarning != null) {
			performanceWarning = FlxG.save.data.performanceWarning;
		}

		if(FlxG.save.data.mainWeekBeaten != null) {
			mainWeekBeaten = FlxG.save.data.mainWeekBeaten;
		}
		if(FlxG.save.data.gotWinMessage != null) {
			gotWinMessage = FlxG.save.data.gotWinMessage;
		}

		if(FlxG.save.data.coreMechTutUnlocked != null) {
			coreMechTutUnlocked = FlxG.save.data.coreMechTutUnlocked;
		}
		if(FlxG.save.data.shopTutUnlocked != null) {
			shopTutUnlocked = FlxG.save.data.shopTutUnlocked;
		}

		if(FlxG.save.data.oldLoadScreensUnlocked != null) {
			oldLoadScreensUnlocked = FlxG.save.data.oldLoadScreensUnlocked;
		}
		if(FlxG.save.data.adMechanicScreensUnlocked != null) {
			adMechanicScreensUnlocked = FlxG.save.data.adMechanicScreensUnlocked;
		}
		if(FlxG.save.data.fanartScreensUnlocked != null) {
			fanartScreensUnlocked = FlxG.save.data.fanartScreensUnlocked;
		}
		if(FlxG.save.data.randomArtScreensUnlocked != null) {
			randomArtScreensUnlocked = FlxG.save.data.randomArtScreensUnlocked;
		}

		if(FlxG.save.data.galleryUnlocked != null) {
			galleryUnlocked = FlxG.save.data.galleryUnlocked;
		}

		if(FlxG.save.data.iniquitousUnlocked != null) {
			iniquitousUnlocked = FlxG.save.data.iniquitousUnlocked;
		}

		if(FlxG.save.data.campaignHighScore != null) {
			campaignHighScore = FlxG.save.data.campaignHighScore;
		}
		if(FlxG.save.data.campaignBestCombo != null) {
			campaignBestCombo = FlxG.save.data.campaignBestCombo;
		}
		if(FlxG.save.data.campaignRating != null) {
			campaignRating = FlxG.save.data.campaignRating;
		}
		if(FlxG.save.data.campaignSongsPlayed != null) {
			campaignSongsPlayed = FlxG.save.data.campaignSongsPlayed;
		}
		
		if(FlxG.save.data.storyModeCrashMeasure != null) {
			storyModeCrashMeasure = FlxG.save.data.storyModeCrashMeasure;
		}
		if(FlxG.save.data.storyModeCrashWeek != null) {
			storyModeCrashWeek = FlxG.save.data.storyModeCrashWeek;
		}
		if(FlxG.save.data.storyModeCrashWeekName != null) {
			storyModeCrashWeekName = FlxG.save.data.storyModeCrashWeekName;
		}
		if(FlxG.save.data.storyModeCrashDifficulty != null) {
			storyModeCrashDifficulty = FlxG.save.data.storyModeCrashDifficulty;
		}
		if(FlxG.save.data.storyModeCrashDifficultyNum != null) {
			storyModeCrashDifficultyNum = FlxG.save.data.storyModeCrashDifficultyNum;
		}
		if(FlxG.save.data.storyModeCrashScore != null) {
			storyModeCrashScore = FlxG.save.data.storyModeCrashScore;
		}
		if(FlxG.save.data.storyModeCrashMisses != null) {
			storyModeCrashMisses = FlxG.save.data.storyModeCrashMisses;
		}
		
		
		if(FlxG.save.data.optionsFreeplay != null) {
			optionsFreeplay = FlxG.save.data.optionsFreeplay;
		}

		if(FlxG.save.data.inMenu != null) {
			inMenu = FlxG.save.data.inMenu;
		}
		if(FlxG.save.data.firstTime != null) {
			firstTime = FlxG.save.data.firstTime;
		}

		if(FlxG.save.data.shopUnlocked != null) {
			shopUnlocked = FlxG.save.data.shopUnlocked;
		}
		if(FlxG.save.data.secretShopShowcased != null) {
			secretShopShowcased = FlxG.save.data.secretShopShowcased;
		}
		if(FlxG.save.data.shopShowcased != null) {
			shopShowcased = FlxG.save.data.shopShowcased;
		}
		if(FlxG.save.data.inShop != null) {
			inShop = FlxG.save.data.inShop;
		}
		if(FlxG.save.data.itemInfo != null) {
			itemInfo = FlxG.save.data.itemInfo;
		}
		if(FlxG.save.data.luckSelected != null) {
			luckSelected = FlxG.save.data.luckSelected;
		}
		if(FlxG.save.data.sellSelected != null) {
			sellSelected = FlxG.save.data.sellSelected;
		}
		if(FlxG.save.data.choiceSelected != null) {
			choiceSelected = FlxG.save.data.choiceSelected;
		}
		if(FlxG.save.data.charmsSelected != null) {
			charmsSelected = FlxG.save.data.charmsSelected;
		}
		if(FlxG.save.data.talkedToZeel != null) {
			talkedToZeel = FlxG.save.data.talkedToZeel;
		}
		if(FlxG.save.data.talkedToHermit != null) {
			talkedToHermit = FlxG.save.data.talkedToHermit;
		}
		if(FlxG.save.data.eggs != null) {
			eggs = FlxG.save.data.eggs;
		}

		if(FlxG.save.data.bonusUnlocked != null) {
			bonusUnlocked = FlxG.save.data.bonusUnlocked;
		}
		if(FlxG.save.data.xtraUnlocked != null) {
			xtraUnlocked = FlxG.save.data.xtraUnlocked;
		}
		if(FlxG.save.data.crossoverUnlocked != null) {
			crossoverUnlocked = FlxG.save.data.crossoverUnlocked;
		}
		if(FlxG.save.data.xtraBonusUnlocked != null) {
			xtraBonusUnlocked = FlxG.save.data.xtraBonusUnlocked;
		}

		if(FlxG.save.data.resistanceCharm != null) {
			resistanceCharm = FlxG.save.data.resistanceCharm;
		}
		if(FlxG.save.data.autoCharm != null) {
			autoCharm = FlxG.save.data.autoCharm;
		}
		if(FlxG.save.data.healingCharm != null) {
			healingCharm = FlxG.save.data.healingCharm;
		}

		if(FlxG.save.data.resCharmCollected != null) {
			resCharmCollected = FlxG.save.data.resCharmCollected;
		}
		if(FlxG.save.data.autoCharmCollected != null) {
			autoCharmCollected = FlxG.save.data.autoCharmCollected;
		}
		if(FlxG.save.data.healCharmCollected != null) {
			healCharmCollected = FlxG.save.data.healCharmCollected;
		}
		if(FlxG.save.data.charmsCollected != null) {
			charmsCollected = FlxG.save.data.charmsCollected;
		}

		if(FlxG.save.data.weeksUnlocked != null) {
			weeksUnlocked = FlxG.save.data.weeksUnlocked;
		}

		if(FlxG.save.data.mainWeekFound != null) {
			mainWeekFound = FlxG.save.data.mainWeekFound;
		}
		if(FlxG.save.data.mainWeekPlayed != null) {
			mainWeekPlayed = FlxG.save.data.mainWeekPlayed;
		}
		if(FlxG.save.data.villainyBeaten != null) {
			villainyBeaten = FlxG.save.data.villainyBeaten;
		}
		if(FlxG.save.data.pointBlankBeaten != null) {
			pointBlankBeaten = FlxG.save.data.pointBlankBeaten;
		}
		if(FlxG.save.data.libidinousnessBeaten != null) {
			libidinousnessBeaten = FlxG.save.data.libidinousnessBeaten;
		}
		if(FlxG.save.data.excreteBeaten != null) {
			excreteBeaten = FlxG.save.data.excreteBeaten;
		}
		if(FlxG.save.data.nunWeekFound != null) {
			nunWeekFound = FlxG.save.data.nunWeekFound;
		}
		if(FlxG.save.data.nunWeekPlayed != null) {
			nunWeekPlayed = FlxG.save.data.nunWeekPlayed;
		}
		if(FlxG.save.data.dsideWeekFound != null) {
			dsideWeekFound = FlxG.save.data.dsideWeekFound;
		}
		if(FlxG.save.data.dsideWeekPlayed != null) {
			dsideWeekPlayed = FlxG.save.data.dsideWeekPlayed;
		}
		if(FlxG.save.data.susWeekFound != null) {
			susWeekFound = FlxG.save.data.susWeekFound;
		}
		if(FlxG.save.data.susWeekPlayed != null) {
			susWeekPlayed = FlxG.save.data.susWeekPlayed;
		}
		if(FlxG.save.data.kianaWeekFound != null) {
			kianaWeekFound = FlxG.save.data.kianaWeekFound;
		}
		if(FlxG.save.data.kianaWeekPlayed != null) {
			kianaWeekPlayed = FlxG.save.data.kianaWeekPlayed;
		}
		if(FlxG.save.data.legacyWeekFound != null) {
			legacyWeekFound = FlxG.save.data.legacyWeekFound;
		}
		if(FlxG.save.data.legacyWeekPlayed != null) {
			legacyWeekPlayed = FlxG.save.data.legacyWeekPlayed;
		}
		if(FlxG.save.data.morkyWeekFound != null) {
			morkyWeekFound = FlxG.save.data.morkyWeekFound;
		}
		if(FlxG.save.data.morkyWeekPlayed != null) {
			morkyWeekPlayed = FlxG.save.data.morkyWeekPlayed;
		}
		if(FlxG.save.data.iniquitousWeekUnlocked != null) {
			iniquitousWeekUnlocked = FlxG.save.data.iniquitousWeekUnlocked;
		}
		if(FlxG.save.data.iniquitousWeekBeaten != null) {
			iniquitousWeekBeaten = FlxG.save.data.iniquitousWeekBeaten;
		}

		if(FlxG.save.data.tofuFound != null) {
			tofuFound = FlxG.save.data.tofuFound;
		}
		if(FlxG.save.data.tofuViewed != null) {
			tofuViewed = FlxG.save.data.tofuViewed;
		}
		if(FlxG.save.data.tofuPlayed != null) {
			tofuPlayed = FlxG.save.data.tofuPlayed;
		}
		if(FlxG.save.data.lustalityFound != null) {
			lustalityFound = FlxG.save.data.lustalityFound;
		}
		if(FlxG.save.data.lustalityViewed != null) {
			lustalityViewed = FlxG.save.data.lustalityViewed;
		}
		if(FlxG.save.data.lustalityPlayed != null) {
			lustalityPlayed = FlxG.save.data.lustalityPlayed;
		}
		if(FlxG.save.data.marcochromeFound != null) {
			marcochromeFound = FlxG.save.data.marcochromeFound;
		}
		if(FlxG.save.data.marcochromeViewed != null) {
			marcochromeViewed = FlxG.save.data.marcochromeViewed;
		}
		if(FlxG.save.data.marcochromePlayed != null) {
			marcochromePlayed = FlxG.save.data.marcochromePlayed;
		}
		if(FlxG.save.data.nunsationalFound != null) {
			nunsationalFound = FlxG.save.data.nunsationalFound;
		}
		if(FlxG.save.data.nunsationalViewed != null) {
			nunsationalViewed = FlxG.save.data.nunsationalViewed;
		}
		if(FlxG.save.data.nunsationalPlayed != null) {
			nunsationalPlayed = FlxG.save.data.nunsationalPlayed;
		}
		if(FlxG.save.data.nicFound != null) {
			nicFound = FlxG.save.data.nicFound;
		}
		if(FlxG.save.data.nicViewed != null) {
			nicViewed = FlxG.save.data.nicViewed;
		}
		if(FlxG.save.data.nicPlayed != null) {
			nicPlayed = FlxG.save.data.nicPlayed;
		}
		if(FlxG.save.data.debugFound != null) {
			debugFound = FlxG.save.data.debugFound;
		}
		if(FlxG.save.data.debugViewed != null) {
			debugViewed = FlxG.save.data.debugViewed;
		}
		if(FlxG.save.data.debugPlayed != null) {
			debugPlayed = FlxG.save.data.debugPlayed;
		}
		if(FlxG.save.data.fnvFound != null) {
			fnvFound = FlxG.save.data.fnvFound;
		}
		if(FlxG.save.data.fnvViewed != null) {
			fnvViewed = FlxG.save.data.fnvViewed;
		}
		if(FlxG.save.data.fnvPlayed != null) {
			fnvPlayed = FlxG.save.data.fnvPlayed;
		}
		if(FlxG.save.data.shortFound != null) {
			shortFound = FlxG.save.data.shortFound;
		}
		if(FlxG.save.data.shortViewed != null) {
			shortViewed = FlxG.save.data.shortViewed;
		}
		if(FlxG.save.data.shortPlayed != null) {
			shortPlayed = FlxG.save.data.shortPlayed;
		}
		if(FlxG.save.data.infatuationFound != null) {
			infatuationFound = FlxG.save.data.infatuationFound;
		}
		if(FlxG.save.data.infatuationPlayed != null) {
			infatuationPlayed = FlxG.save.data.infatuationPlayed;
		}
		if(FlxG.save.data.infatuationViewed != null) {
			infatuationViewed = FlxG.save.data.infatuationViewed;
		}
		if(FlxG.save.data.rainyDazeFound != null) {
			rainyDazeFound = FlxG.save.data.rainyDazeFound;
		}
		if(FlxG.save.data.rainyDazeViewed != null) {
			rainyDazeViewed = FlxG.save.data.rainyDazeViewed;
		}
		if(FlxG.save.data.rainyDazePlayed != null) {
			rainyDazePlayed = FlxG.save.data.rainyDazePlayed;
		}

		if(FlxG.save.data.ourpleFound != null) {
			ourpleFound = FlxG.save.data.ourpleFound;
		}
		if(FlxG.save.data.ourplePlayed != null) {
			ourplePlayed = FlxG.save.data.ourplePlayed;
		}
		if(FlxG.save.data.tacticalMishapFound != null) {
			tacticalMishapFound = FlxG.save.data.tacticalMishapFound;
		}
		if(FlxG.save.data.tacticalMishapPlayed != null) {
			tacticalMishapPlayed = FlxG.save.data.tacticalMishapPlayed;
		}
		if(FlxG.save.data.kyuFound != null) {
			kyuFound = FlxG.save.data.kyuFound;
		}
		if(FlxG.save.data.kyuPlayed != null) {
			kyuPlayed = FlxG.save.data.kyuPlayed;
		}
		if(FlxG.save.data.breacherFound != null) {
			breacherFound = FlxG.save.data.breacherFound;
		}
		if(FlxG.save.data.breacherPlayed != null) {
			breacherPlayed = FlxG.save.data.breacherPlayed;
		}
		if(FlxG.save.data.ccFound != null) {
			ccFound = FlxG.save.data.ccFound;
		}
		if(FlxG.save.data.ccPlayed != null) {
			ccPlayed = FlxG.save.data.ccPlayed;
		}

		if(FlxG.save.data.codeRegistered != null) {
			codeRegistered = FlxG.save.data.codeRegistered;
		}


		if(FlxG.save.data.zeelNakedPics != null) {
			zeelNakedPics = FlxG.save.data.zeelNakedPics;
		}
		if(FlxG.save.data.trampolineUnlocked != null) {
			trampolineUnlocked = FlxG.save.data.trampolineUnlocked;
		}

		if(FlxG.save.data.songsUnlocked != null) {
			songsUnlocked = FlxG.save.data.songsUnlocked;
		}

		if(FlxG.save.data.crossSongsAllowed != null) {
			crossSongsAllowed = FlxG.save.data.crossSongsAllowed;
		}
		if(FlxG.save.data.onCrossSection != null) {
			onCrossSection = FlxG.save.data.onCrossSection;
		}
		if(FlxG.save.data.roadMapUnlocked != null) {
			roadMapUnlocked = FlxG.save.data.roadMapUnlocked;
		}
		if(FlxG.save.data.itsameDsidesUnlocked!= null) {
			itsameDsidesUnlocked = FlxG.save.data.itsameDsidesUnlocked;
		}

		if(FlxG.save.data.injectionEndScore != null) {
			injectionEndScore = FlxG.save.data.injectionEndScore;
		}
		if(FlxG.save.data.injectionVilEndScore != null) {
			injectionVilEndScore = FlxG.save.data.injectionVilEndScore;
		}
		if(FlxG.save.data.mayhemEndScore != null) {
			mayhemEndScore = FlxG.save.data.mayhemEndScore;
		}

		if(FlxG.save.data.mayhemNotif != null) {
			mayhemNotif = FlxG.save.data.mayhemNotif;
		}
		if(FlxG.save.data.injectionNotif != null) {
			injectionNotif = FlxG.save.data.injectionNotif;
		}

		if(FlxG.save.data.buff1Unlocked != null) {
			buff1Unlocked = FlxG.save.data.buff1Unlocked;
		}
		if(FlxG.save.data.buff1Selected != null) {
			buff1Selected = FlxG.save.data.buff1Selected;
		}
		if(FlxG.save.data.buff2Unlocked != null) {
			buff2Unlocked = FlxG.save.data.buff2Unlocked;
		}
		if(FlxG.save.data.buff2Selected != null) {
			buff2Selected = FlxG.save.data.buff2Selected;
		}
		if(FlxG.save.data.buff3Unlocked != null) {
			buff3Unlocked = FlxG.save.data.buff3Unlocked;
		}
		if(FlxG.save.data.buff3Selected != null) {
			buff3Selected = FlxG.save.data.buff3Selected;
		}
		if(FlxG.save.data.buff1Active != null) {
			buff1Active = FlxG.save.data.buff1Active;
		}
		if(FlxG.save.data.buff2Active != null) {
			buff2Active = FlxG.save.data.buff2Active;
		}
		if(FlxG.save.data.buff3Active != null) {
			buff3Active = FlxG.save.data.buff3Active;
		}
		if(FlxG.save.data.charInventory != null) {
			charInventory = FlxG.save.data.charInventory;
		}

		if(FlxG.save.data.numberOfScrolls != null) {
			numberOfScrolls = FlxG.save.data.numberOfScrolls;
		}
		if(FlxG.save.data.marcoScroll != null) {
			marcoScroll = FlxG.save.data.marcoScroll;
		}
		if(FlxG.save.data.aileenScroll != null) {
			aileenScroll = FlxG.save.data.aileenScroll;
		}
		if(FlxG.save.data.beatriceScroll != null) {
			beatriceScroll = FlxG.save.data.beatriceScroll;
		}
		if(FlxG.save.data.evelynScroll != null) {
			evelynScroll = FlxG.save.data.evelynScroll;
		}
		if(FlxG.save.data.yakuScroll != null) {
			yakuScroll = FlxG.save.data.yakuScroll;
		}
		if(FlxG.save.data.dvScroll != null) {
			dvScroll = FlxG.save.data.dvScroll;
		}
		if(FlxG.save.data.kianaScroll != null) {
			kianaScroll = FlxG.save.data.kianaScroll;
		}
		if(FlxG.save.data.narrinScroll != null) {
			narrinScroll = FlxG.save.data.narrinScroll;
		}
		if(FlxG.save.data.morkyScroll != null) {
			morkyScroll = FlxG.save.data.morkyScroll;
		}
		if(FlxG.save.data.kaizokuScroll != null) {
			kaizokuScroll = FlxG.save.data.kaizokuScroll;
		}

		if(FlxG.save.data.framerate != null) {
			framerate = FlxG.save.data.framerate;
			if(framerate > FlxG.drawFramerate) {
				FlxG.updateFramerate = framerate;
				FlxG.drawFramerate = framerate;
			} else {
				FlxG.drawFramerate = framerate;
				FlxG.updateFramerate = framerate;
			}
		}
		/*if(FlxG.save.data.cursing != null) {
			cursing = FlxG.save.data.cursing;
		}
		if(FlxG.save.data.violence != null) {
			violence = FlxG.save.data.violence;
		}*/
		if(FlxG.save.data.camZooms != null) {
			camZooms = FlxG.save.data.camZooms;
		}
		if(FlxG.save.data.hideHud != null) {
			hideHud = FlxG.save.data.hideHud;
		}
		if(FlxG.save.data.noteOffset != null) {
			noteOffset = FlxG.save.data.noteOffset;
		}
		if(FlxG.save.data.arrowHSV != null) {
			arrowHSV = FlxG.save.data.arrowHSV;
		}
		if(FlxG.save.data.ghostTapping != null) {
			ghostTapping = FlxG.save.data.ghostTapping;
		}
		if(FlxG.save.data.timeBarType != null) {
			timeBarType = FlxG.save.data.timeBarType;
		}
		if(FlxG.save.data.scoreZoom != null) {
			scoreZoom = FlxG.save.data.scoreZoom;
		}
		if(FlxG.save.data.noReset != null) {
			noReset = FlxG.save.data.noReset;
		}
		if(FlxG.save.data.healthBarAlpha != null) {
			healthBarAlpha = FlxG.save.data.healthBarAlpha;
		}
		if(FlxG.save.data.comboOffset != null) {
			comboOffset = FlxG.save.data.comboOffset;
		}
		
		if(FlxG.save.data.ratingOffset != null) {
			ratingOffset = FlxG.save.data.ratingOffset;
		}
		if(FlxG.save.data.sickWindow != null) {
			sickWindow = FlxG.save.data.sickWindow;
		}
		if(FlxG.save.data.goodWindow != null) {
			goodWindow = FlxG.save.data.goodWindow;
		}
		if(FlxG.save.data.badWindow != null) {
			badWindow = FlxG.save.data.badWindow;
		}
		if(FlxG.save.data.safeFrames != null) {
			safeFrames = FlxG.save.data.safeFrames;
		}
		if(FlxG.save.data.controllerMode != null) {
			controllerMode = FlxG.save.data.controllerMode;
		}
		if(FlxG.save.data.hitsoundVolume != null) {
			hitsoundVolume = FlxG.save.data.hitsoundVolume;
		}
		if(FlxG.save.data.pauseMusic != null) {
			pauseMusic = FlxG.save.data.pauseMusic;
		}
		if(FlxG.save.data.gameplaySettings != null)
		{
			var savedMap:Map<String, Dynamic> = FlxG.save.data.gameplaySettings;
			for (name => value in savedMap)
			{
				gameplaySettings.set(name, value);
			}
		}
		//THIS IS THE SUPPOSED TO FIX ON GETTNG ACHIEVEMENTS TO BE SAVED WTF WHY DOESN'T BASE PSYCH ENGINE HAVE THISHIFQAJUOIVHAEDOVIHBNAOVIHBPOA
		if(FlxG.save.data.achievementsMap != null) {
			Achievements.achievementsMap = FlxG.save.data.achievementsMap;
		}
		
		// flixel automatically saves your volume!
		if(FlxG.save.data.volume != null)
		{
			FlxG.sound.volume = FlxG.save.data.volume;
		}
		if (FlxG.save.data.mute != null)
		{
			FlxG.sound.muted = FlxG.save.data.mute;
		}
		if (FlxG.save.data.checkForUpdates != null)
		{
			checkForUpdates = FlxG.save.data.checkForUpdates;
		}
		if (FlxG.save.data.comboStacking != null)
			comboStacking = FlxG.save.data.comboStacking;

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99');
		if(save != null && save.data.customControls != null) {
			var loadedControls:Map<String, Array<FlxKey>> = save.data.customControls;
			for (control => keys in loadedControls) {
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
	}

	public static function resetStoryModeProgress(resetTokens:Bool = false)
	{
		ClientPrefs.storyModeCrashMeasure = ''; // Song
		ClientPrefs.storyModeCrashWeek = -1; // Week Number
		ClientPrefs.storyModeCrashWeekName = ''; //Week Name
		ClientPrefs.storyModeCrashScore = 0; // Score
		ClientPrefs.storyModeCrashMisses = 0; // Misses
		ClientPrefs.storyModeCrashDifficulty = ''; // Difficulty Name
		ClientPrefs.storyModeCrashDifficultyNum = -1; // Difficulty Number

		trace('Story Mode Settings:');
		trace('Saved Score :' + ClientPrefs.storyModeCrashScore);
		trace('Saved Misses: ' + ClientPrefs.storyModeCrashMisses);
		trace('Saved Week: ' + ClientPrefs.storyModeCrashWeek);
		trace('Saved Week Name: ' + ClientPrefs.storyModeCrashWeekName);
		trace('Saved Song: ' + ClientPrefs.storyModeCrashMeasure);
		trace('Saved Difficulty: ' + ClientPrefs.storyModeCrashDifficulty + " - " + ClientPrefs.storyModeCrashDifficultyNum);

		if (resetTokens)
		{
			ClientPrefs.tokensAchieved = 0;
			trace('Saved Tokens Achieved: ' + ClientPrefs.tokensAchieved);
		}

		ClientPrefs.saveSettings();
	}

	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic):Dynamic {
		return /*PlayState.isStoryMode ? defaultValue : */ (gameplaySettings.exists(name) ? gameplaySettings.get(name) : defaultValue);
	}

	public static function reloadControls() {
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);

		TitleState.muteKeys = copyKey(keyBinds.get('volume_mute'));
		TitleState.volumeDownKeys = copyKey(keyBinds.get('volume_down'));
		TitleState.volumeUpKeys = copyKey(keyBinds.get('volume_up'));
		FlxG.sound.muteKeys = TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
	}
	public static function copyKey(arrayToCopy:Array<FlxKey>):Array<FlxKey> {
		var copiedArray:Array<FlxKey> = arrayToCopy.copy();
		var i:Int = 0;
		var len:Int = copiedArray.length;

		while (i < len) {
			if(copiedArray[i] == NONE) {
				copiedArray.remove(NONE);
				--i;
			}
			i++;
			len = copiedArray.length;
		}
		return copiedArray;
	}
}
