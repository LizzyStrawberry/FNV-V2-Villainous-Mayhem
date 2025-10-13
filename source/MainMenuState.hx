package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.addons.display.FlxBackdrop;

import flash.system.System;

class MainMenuState extends MusicBeatState
{
	public static var FNVVersion:String = '2.0'; //This is also used for Discord RPC
	public static var psychEngineVersion:String = '0.6.3 Modified'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var curStorySelected:Int = 0;
	public static var curBuffSelected:Int = 0;
	public static var curCharmSelected:Int = 0;
	var curDifficulty:Int = 1;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	public static var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'gallery',
		'info',
		'promotion',
		'credits',
	];

	var storyStuffs:FlxTypedGroup<FlxSprite>;
	var storySelection:Alphabet;
	var extraFinalScore:FlxText;
	var storyShit:Array<String> = [
		'classic',
		'iniquitous',
		'injection',
		'mayhem'
	];
	var storyText:FlxText;

	public static var injectionSongs:Array<String> = [
		"scrouge",
		"toxic-mishap",
		"paycheck",
		"villainy",

		"nunday-monday",
		"nunconventional",
		"point-blank",

		"forsaken",
		"toybox",
		"lustality-remix",
		'libidinousness',

		"sussus-marcus",
		"villain-in-board",
		"excrete",

		"unpaid-catastrophe",
		"cheque",
		"get-gooned",

		"spendthrift",
		"instrumentally-deranged",
		"get-villaind",
		
		"cheap-skate-(legacy)",
		"toxic-mishap-(legacy)",
		"paycheck-(legacy)",

		"iniquitous"
	];

	private static var lastDifficultyName:String = '';
	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftDiffArrow:FlxSprite;
	var rightDiffArrow:FlxSprite;

	public static var mayhemSongs:Array<String> = [
		"scrouge",
		"toxic-mishap",
		"paycheck",
		'villainy',

		"nunday-monday",
		"nunconventional",
		"point-blank",

		"forsaken",
		"toybox",
		"lustality-remix",
		'libidinousness',

		"sussus-marcus",
		"villain-in-board",
		"excrete",

		"unpaid-catastrophe",
		"cheque",
		"get-gooned",

		"spendthrift",
		"get-villaind",
		
		"cheap-skate-(legacy)",
		"toxic-mishap-(legacy)",
		"paycheck-(legacy)",

		'tofu',
		'marcochrome',
		'marauder',
		'slowflp',
		'lustality',
		'fnv',
		'fanfuck-forever',
		'rainy-daze',
		'vguy',
		'tactical-mishap',
		'fast-food-therapy',
		'breacher',
		'negotiation',
		'concert-chaos',
		'nunsational',
		"its-kiana",
		"forsaken-(picmixed)",
		"get-picod",
		"marauder-(old)",
		"slowflp-(old)",
		"partner",
		"shuckle-fuckle",
		"get-villaind-(old)"
	];

	var lerpInjectedScore:Int = 0;
	var intendedInjectedScore:Int = 0;
	var lerpMayhemedScore:Int = 0;
	var intendedMayhemedScore:Int = 0;

	var debugKeys:Array<FlxKey>;

	var bg:FlxSprite;
	var bgChange:FlxSprite;
	var secretBG:Bool = false;
	var number30:Int = 0;
	var bgBorder:FlxSprite;

	var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;

	var blackOut:FlxSprite;

	var exclamationMark:FlxSprite;
	var optionsButton:FlxSprite;
	var shopButton:FlxSprite;
	var inventoryButton:FlxSprite;
	var numImage:Int = 0;

	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var menuSelectors:FlxGroup;

	// Menu Inventory
	var inventoryTitle:Alphabet;
	private var gfPocket:FlxSprite;
	var BGchecker:FlxBackdrop;

	var buffItems:FlxTypedGroup<FlxSprite>;
	var buffTitle:Alphabet;
	var buffText:FlxText;
	var buffSelected:FlxSprite;

	var charmItems:FlxTypedGroup<FlxSprite>;
	var charmTitle:Alphabet;
	var charmText:FlxText;
	var charmSelected:FlxSprite;

	var allowMayhemGameMode:Bool = false;
	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		FlxG.mouse.visible = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		if (!ClientPrefs.galleryUnlocked && Achievements.isAchievementUnlocked('WeekMarco_Beaten') 
			&& Achievements.isAchievementUnlocked('WeekNun_Beaten') && Achievements.isAchievementUnlocked('WeekKiana_Beaten'))
			ClientPrefs.galleryUnlocked = true;
		
		// Resetting this rq
		ClientPrefs.ghostTapping = true;
		ClientPrefs.codeRegistered = '';
		ClientPrefs.onCrossSection = GameOverSubstate.injected = GameOverSubstate.mayhemed = false;
		ClientPrefs.saveSettings();

		ClientPrefs.inMenu = true;
		ClientPrefs.optionsFreeplay = false;

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		//persistentUpdate = persistentDraw = true;

		intendedInjectedScore = ClientPrefs.injectionEndScore;
		intendedMayhemedScore = ClientPrefs.mayhemEndTotalScore;

		bg = new FlxSprite(-80);
		number30 = FlxG.random.int(1, 59);
		if (number30 == 30 && Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed && ClientPrefs.kianaWeekPlayed)
		{
			bg.loadGraphic(Paths.image('mainMenuBgs/menu-mork'));
			bg.frames = Paths.getSparrowAtlas('mainMenuBgs/menu-mork');
			bg.animation.addByPrefix('idleMenu', 'mork mork0', 24, true);
			bg.animation.play('idleMenu');
			bg.scrollFactor.set();
			trace('MORK');	
		}
		else if (number30 == 2 && Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed && ClientPrefs.kianaWeekPlayed)
		{
			secretBG = true;
			bg.loadGraphic(Paths.image('mainMenuBgs/menu-rare'));
			FlxG.sound.music.fadeOut(1.0);
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxG.sound.playMusic(Paths.music('malumIctum'), 0);
				FlxG.sound.music.fadeIn(4, 0, 1);
				trace('Song changed to the rare one! + fadeout!');	
				giveAnotherAchievement();
				ClientPrefs.saveSettings();				
			});
		}
		else
		{
			trace('No fadeout needed bitch');
			trace('the number is: ' + number30);

			var maxNum:Int = 5;
			
			if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed && ClientPrefs.kianaWeekPlayed) maxNum = 59;
			else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed) maxNum = 13;
			else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten')) maxNum = 11;

			bg.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, maxNum)));
		}
		bg.scrollFactor.set(0, 0);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter(XY);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		// Making a secondary sprite so we can change each background after a few seconds or something lmao
		if(!secretBG)
		{	
			var maxNum:Int = 5;
			
			if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed && ClientPrefs.kianaWeekPlayed) maxNum = 59;
			else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed) maxNum = 13;
			else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten')) maxNum = 11;

			bgChange = bg;
			bgChange.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, maxNum)));
			bgChange.alpha = 0;
			add(bgChange);
		}

		var bgTimer:FlxTimer = new FlxTimer().start(10, changeBg);
		
		bgBorder = new FlxSprite(-80).loadGraphic(Paths.image('menuBorder'));
		bgBorder.scrollFactor.set(0, 0);
		bgBorder.setGraphicSize(Std.int(bgBorder.width * 1.175));
		bgBorder.updateHitbox();
		bgBorder.screenCenter();
		bgBorder.antialiasing = ClientPrefs.globalAntialiasing;
		add(bgBorder);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var isLocked:Bool = (optionShit[i] == 'freeplay' && !ClientPrefs.mainWeekBeaten) || (optionShit[i] == 'gallery' && !ClientPrefs.galleryUnlocked) || (optionShit[i] == 'info' && !ClientPrefs.mainWeekBeaten);
			var imagePath:FlxGraphic = Paths.image('mainmenu/menu_' + optionShit[i] + ((isLocked) ? "Locked" : ""));
			var menuItem:FlxSprite = new FlxSprite(0, 0).loadGraphic(imagePath);
			menuItem.ID = i;
			menuItem.screenCenter(XY);
			menuItem.x -= 300;
			menuItem.y = 520;
			menuItems.add(menuItem);

			menuItem.scrollFactor.set();
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.updateHitbox();

			menuItem.alpha = (curSelected != menuItem.ID) ? 0 : 1;

			FlxTween.tween(menuItem, {"scale.x": 1.05, "scale.y": 1.05}, 1.5, {ease: FlxEase.cubeInOut, type: PINGPONG});
		}

		var versionShit:FlxText = new FlxText(12, FlxG.height - 64, 0, "Friday Night Villainy v" + FNVVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		menuSelectors = new FlxGroup();
		add(menuSelectors);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		leftArrow = new FlxSprite(FlxG.width - 1250, 550);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.updateHitbox();
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
		menuSelectors.add(leftArrow);
		
		rightArrow = new FlxSprite(leftArrow.x + 586, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.updateHitbox();
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
		menuSelectors.add(rightArrow);

		getRightArrowX = rightArrow.x;
		getLeftArrowX = leftArrow.x;

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
		{
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) 
			{
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		exclamationMark = new FlxSprite(FlxG.width - 90, 110).loadGraphic(Paths.image('exclamationMark'));
		exclamationMark.antialiasing = ClientPrefs.globalAntialiasing;
		exclamationMark.alpha = 0.5;
		exclamationMark.scale.set(0.5, 0.5);
		exclamationMark.updateHitbox();
		add(exclamationMark);
		if (!ClientPrefs.firstTime)
		{
			NotificationAlert.showMessage(this, 'Tutorial');
			NotificationAlert.sendTutorialNotification = true;
			NotificationAlert.saveNotifications();

			ClientPrefs.firstTime = true;
			ClientPrefs.saveSettings();
		}
		if (NotificationAlert.sendTutorialNotification)
		{
			NotificationAlert.addNotification(this, exclamationMark, -10, 85);

			NotificationAlert.sendTutorialNotification = false;
			NotificationAlert.saveNotifications();
		}

		optionsButton = new FlxSprite(FlxG.width - 112, 0).loadGraphic(Paths.image('optionsButton'));
		optionsButton.antialiasing = ClientPrefs.globalAntialiasing;
		optionsButton.alpha = 0.5;
		optionsButton.updateHitbox();
		add(optionsButton);
		if (NotificationAlert.sendOptionsNotification)
		{
			NotificationAlert.addNotification(this, optionsButton, -10, 85);

			NotificationAlert.sendOptionsNotification = false;
			NotificationAlert.saveNotifications();
		}

		inventoryButton = new FlxSprite(optionsButton.x, 230).loadGraphic(Paths.image('inventoryButton'));
		inventoryButton.antialiasing = ClientPrefs.globalAntialiasing;
		inventoryButton.alpha = 0.5;
		inventoryButton.updateHitbox();
		add(inventoryButton);
		if (NotificationAlert.sendInventoryNotification)
		{
			NotificationAlert.addNotification(this, inventoryButton, -10, 85);

			NotificationAlert.sendInventoryNotification = false;
			NotificationAlert.saveNotifications();
		}

		shopButton = new FlxSprite(0, 0).loadGraphic(Paths.image('shopButton'));
		shopButton.antialiasing = ClientPrefs.globalAntialiasing;
		shopButton.alpha = 0.5;
		shopButton.updateHitbox();
		add(shopButton);
		if (NotificationAlert.sendShopNotification)
		{
			NotificationAlert.addNotification(this, shopButton, 115, 100);

			NotificationAlert.sendShopNotification = false;
			NotificationAlert.saveNotifications();
		}
		
		var markType:String = (ClientPrefs.tokens == 0) ? "<R>" : "<GR>";
		var tokenShow:FlxText = new FlxText(shopButton.x, shopButton.y + 130, FlxG.width, 'Tokens: $markType ${ClientPrefs.tokens} $markType');
		tokenShow.setFormat("VCR OSD Mono", 28, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
		tokenShow.borderSize = 1;
		CustomFontFormats.addMarkers(tokenShow);
		add(tokenShow);

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 0;
		add(blackOut);

		storyStuffs = new FlxTypedGroup<FlxSprite>();
		add(storyStuffs);

		for (i in 0...storyShit.length)
		{
			var storyStuff:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/story_' + storyShit[i]));
			storyStuff.ID = i;
			storyStuff.screenCenter(XY);
			storyStuff.x += 1420;
			storyStuff.scrollFactor.set(0, 0);
			storyStuff.antialiasing = ClientPrefs.globalAntialiasing;
			storyStuff.updateHitbox();
			storyStuffs.add(storyStuff);
		}

		storySelection = new Alphabet(FlxG.width + 740, 320, "Test", true);
		storySelection.setAlignmentFromString('center');
		storySelection.alpha = 0.6;
		storySelection.scaleX = 0.8;
		storySelection.scaleY = 0.8;
		add(storySelection);

		storyText = new FlxText(30, 300, FlxG.width, "Test!");
		storyText.setFormat("VCR OSD Mono", 40, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
		storyText.alpha = 0;
		storyText.borderSize = 3;
		CustomFontFormats.addMarkers(storyText);
		add(storyText);

		extraFinalScore = new FlxText(10, 665, 0, "RECORD: 49324858", 36);
		extraFinalScore.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
		extraFinalScore.alpha = 0;
		extraFinalScore.borderSize = 3;
		add(extraFinalScore); 

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftDiffArrow = new FlxSprite(810, 410);
		leftDiffArrow.frames = ui_tex;
		leftDiffArrow.animation.addByPrefix('idle', "arrow left");
		leftDiffArrow.animation.addByPrefix('press', "arrow push left");
		leftDiffArrow.animation.play('idle');
		leftDiffArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(leftDiffArrow);

		sprDifficulty = new FlxSprite(0, leftDiffArrow.y);
		sprDifficulty.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(sprDifficulty);

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		if(lastDifficultyName == '')lastDifficultyName = CoolUtil.defaultDifficulty;
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));

		rightDiffArrow = new FlxSprite(leftDiffArrow.x + 376, leftDiffArrow.y);
		rightDiffArrow.frames = ui_tex;
		rightDiffArrow.animation.addByPrefix('idle', 'arrow right');
		rightDiffArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightDiffArrow.animation.play('idle');
		rightDiffArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(rightDiffArrow);

		sprDifficulty.alpha = 0;
		leftDiffArrow.alpha = 0;
		rightDiffArrow.alpha = 0;

		BGchecker = new FlxBackdrop(Paths.image('promotion/BGgrid-' + FlxG.random.int(1, 8)), FlxAxes.XY, 0, 0); 
		BGchecker.updateHitbox(); 
		BGchecker.scrollFactor.set(0, 0); 
		BGchecker.alpha = 0; 
		BGchecker.screenCenter(X); 
		add(BGchecker);

		// Menu Inventory
		createInventory();

		if (ClientPrefs.inShop)
		{
			if (ClientPrefs.iniquitousWeekUnlocked && ClientPrefs.iniquitousWeekBeaten) FlxG.sound.playMusic(Paths.music('malumIctum'));
			else if (FlxG.random.int(1, 10) == 2) FlxG.sound.playMusic(Paths.music('AJDidThat'));
			else FlxG.sound.playMusic(Paths.music('freakyMenu'));

			FlxG.sound.music.fadeIn(2.0);
			ClientPrefs.inShop = false;
			ClientPrefs.saveSettings();
		}

		changeItem();

		//Notification alert
		NotificationAlert.checkForNotifications(this);

		allowMayhemGameMode = (ClientPrefs.mayhemNotif) ? true : false;

		// FOR INJECTION MODE
		if (ClientPrefs.weeksUnlocked >= 7 && !ClientPrefs.injectionNotif)
		{
			ClientPrefs.injectionNotif = true;
			NotificationAlert.showMessage(this, 'Injection');
			ClientPrefs.saveSettings();
		}

		if (NotificationAlert.sendMessage)
		{
			NotificationAlert.showMessage(this, 'Normal');
			NotificationAlert.sendMessage = false;
			NotificationAlert.saveNotifications();
		}
		super.create();
	}

	function createInventory()
	{
		inventoryTitle = new Alphabet(FlxG.width - 860, 10, "Inventory", true);
		inventoryTitle.alpha = 0;
		add(inventoryTitle);
	
		gfPocket = new FlxSprite(0, 0).loadGraphic(Paths.image('inventoryChars/gf'));
		gfPocket.screenCenter(XY);
		gfPocket.x -= 340;
		gfPocket.y += 40;
		gfPocket.alpha = 0;
		gfPocket.updateHitbox();
		add(gfPocket);

		switch (ClientPrefs.charInventory)
		{
			case 'playablegf' | 'playablegf-old':
				gfPocket.loadGraphic(Paths.image('inventoryChars/gf'));
			case 'gfIniquitousP1' | 'GFLibidinousness':
				gfPocket.loadGraphic(Paths.image('inventoryChars/gfdemon'));
			case 'd-side gf':
				gfPocket.loadGraphic(Paths.image('inventoryChars/oldgf'));
			case 'GFwav':
				gfPocket.loadGraphic(Paths.image('inventoryChars/gfwav'));
			case 'amongGF':
				gfPocket.loadGraphic(Paths.image('inventoryChars/amonggf'));
			case 'debugGF':
				gfPocket.loadGraphic(Paths.image('inventoryChars/debuggf'));
			case 'Spendthrift GF':
				gfPocket.loadGraphic(Paths.image('inventoryChars/spendthriftgf'));
			case 'PicoCrimson' | 'PicoFNV' | 'PicoFNVP2':
				gfPocket.loadGraphic(Paths.image('inventoryChars/pico'));
			case 'd-sidePico':
				gfPocket.loadGraphic(Paths.image('inventoryChars/dico'));
			case 'porkchop':
				gfPocket.loadGraphic(Paths.image('inventoryChars/porkchop'));
			case 'lillie':
				gfPocket.loadGraphic(Paths.image('inventoryChars/lillie'));
			case 'aileenTofu':
				gfPocket.loadGraphic(Paths.image('inventoryChars/aileentofu'));
			case 'marcoFFFP1':
				gfPocket.loadGraphic(Paths.image('inventoryChars/marcofff'));
			case 'lilyIntroP1':
				gfPocket.loadGraphic(Paths.image('inventoryChars/lily'));
			case 'kyu':
				gfPocket.loadGraphic(Paths.image('characterInfo/KyuInfo'));
			case 'TC':
				gfPocket.loadGraphic(Paths.image('inventoryChars/tc'));
			case 'ourple':
				gfPocket.loadGraphic(Paths.image('inventoryChars/ourple'));
			case 'uzi':
				gfPocket.loadGraphic(Paths.image('inventoryChars/uzi'));
				
			default:
				gfPocket.loadGraphic(Paths.image('inventoryChars/gf'));
		}

		buffItems = new FlxTypedGroup<FlxSprite>();
		add(buffItems);
		for (i in 0...4)
		{
			var buff = new FlxSprite(0, 0).loadGraphic(Paths.image('inventory/buffN' + i));
			var reflectedBuff = Reflect.field(ClientPrefs, 'buff${buff.ID}selected');
			if (!reflectedBuff) buff.loadGraphic(Paths.image('inventory/buffLocked'));

			buff.screenCenter();
			buff.x -= 50;
			buff.x += i * (buff.width + 50);
			buff.y -= 70;
			buff.ID = i;

			buff.alpha = 0;
			buff.antialiasing = ClientPrefs.globalAntialiasing;
			buffItems.add(buff);
		}

		buffSelected = new FlxSprite(0, 0).loadGraphic(Paths.image('inventory/buffSelected'));
		buffSelected.screenCenter();
		buffSelected.x = buffItems.members[curBuffSelected].x;
		buffSelected.y -= 70;
		buffSelected.alpha = 0;
		buffSelected.antialiasing = ClientPrefs.globalAntialiasing;
		add(buffSelected);

		buffTitle = new Alphabet(FlxG.width - 110, 200, "Buffs", true);
		buffTitle.scaleX = 0.7;
		buffTitle.scaleY = 0.7;
		buffTitle.alpha = 0;
		add(buffTitle);

		buffText = new FlxText(0, 0, FlxG.width, "Test!");
		buffText.screenCenter(XY);
		buffText.y += 20;
		buffText.x += 250;
		buffText.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, CENTER);
		buffText.alpha = 0;
		add(buffText);

		charmItems = new FlxTypedGroup<FlxSprite>();
		add(charmItems);
		for (i in 0...3)
		{
			var charm = new FlxSprite(0, 0).loadGraphic(Paths.image('inventory/charmN' + i));
			charm.screenCenter();
			charm.x += 50;
			charm.x += i * (charm.width + 50);
			charm.y += 210;
			charm.ID = i;

			switch(charm.ID)
			{
				case 0:
					if (!ClientPrefs.resCharmCollected) charm.loadGraphic(Paths.image('inventory/buffLocked'));
				case 1:
					if (!ClientPrefs.autoCharmCollected) charm.loadGraphic(Paths.image('inventory/buffLocked'));
				case 2:
					if (!ClientPrefs.healCharmCollected) charm.loadGraphic(Paths.image('inventory/buffLocked'));
			}
			charm.alpha = 0;
			charm.antialiasing = ClientPrefs.globalAntialiasing;
			charmItems.add(charm);
		}	

		charmTitle = new Alphabet(FlxG.width - 160, 610, "Charms", true);
		charmTitle.scaleX = 0.7;
		charmTitle.scaleY = 0.7;
		charmTitle.alpha = 0;
		add(charmTitle);

		charmText = new FlxText(0, 0, FlxG.width, "Test!");
		charmText.screenCenter(XY);
		charmText.y += 300;
		charmText.x += 250;
		charmText.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, CENTER);
		charmText.alpha = 0;
		add(charmText);

		if (ClientPrefs.buff1Selected) curBuffSelected = 1;
		else if (ClientPrefs.buff2Selected) curBuffSelected = 2;
		else if (ClientPrefs.buff3Selected) curBuffSelected = 3;
		else curBuffSelected = 0;

		buffSelected.x = buffItems.members[curBuffSelected].x;
	}

	function changeBg(timer:FlxTimer)
	{
		if(!secretBG)
		{
			trace("Changing the Background");
			FlxTween.tween(bg, { alpha: 0 }, 3, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(bgChange, { alpha: 1 }, 3, {ease: FlxEase.cubeInOut, type: PERSIST});
			var bgTimerAgain:FlxTimer = new FlxTimer().start(10, changeBgAgain);
			new FlxTimer().start(4, function (tmr:FlxTimer) {
				if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed && ClientPrefs.kianaWeekPlayed)
					bg.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 59)));
				else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed)
					bg.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 13)));
				else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten'))
					bg.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 59)));
				else
					bg.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 5)));
			});
		}
	}

	function changeBgAgain(timer:FlxTimer)
	{
		if(!secretBG)
		{
			trace("Changing the Background Again");
			FlxTween.tween(bg, { alpha: 1 }, 3, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(bgChange, { alpha: 0 }, 3, {ease: FlxEase.cubeInOut, type: PERSIST});
			var bgTimer:FlxTimer = new FlxTimer().start(10, changeBg);
			new FlxTimer().start(4, function (tmr:FlxTimer) {
				if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed && ClientPrefs.kianaWeekPlayed)
					bgChange.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 59)));
				else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed)
					bgChange.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 13)));
				else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten'))
					bgChange.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 11)));
				else
					bgChange.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 5)));
			});
		}
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}

	function giveAnotherAchievement() {
		add(new AchievementObject('secret', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "secret"');
	}
	#end

	var selectedSomethin:Bool = false;
	var storySelected:Bool = false;
	var inventoryOpened:Bool = false;
	var applyStory:Bool = false;
	var warnMayhem:String = '';

	function lerpScore(elapsed:Float)
	{
		intendedMayhemedScore = ClientPrefs.mayhemEndTotalScore;

		lerpInjectedScore = Math.floor(FlxMath.lerp(lerpInjectedScore, intendedInjectedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedInjectedScore - lerpInjectedScore) < 10) lerpInjectedScore = intendedInjectedScore;

		lerpMayhemedScore = Math.floor(FlxMath.lerp(lerpMayhemedScore, intendedMayhemedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedMayhemedScore - lerpMayhemedScore) < 10) lerpMayhemedScore = intendedMayhemedScore;

		if (storyShit[curStorySelected] == 'injection') extraFinalScore.text = "SCORE: " + lerpInjectedScore;
		else extraFinalScore.text = "RECORD: " + ClientPrefs.mayhemEndScore + " Songs / Score: " + lerpMayhemedScore;
	}

	function cancelTweens(part:String)
	{
		switch(part.toLowerCase())
		{
			case "inventory":
				FlxTween.cancelTweensOf(BGchecker);	
				FlxTween.cancelTweensOf(buffSelected);	
				FlxTween.cancelTweensOf(buffTitle);	
				FlxTween.cancelTweensOf(buffText);	
				FlxTween.cancelTweensOf(charmTitle);
				FlxTween.cancelTweensOf(charmText);
				FlxTween.cancelTweensOf(gfPocket);
				FlxTween.cancelTweensOf(blackOut);

			case "story":
				FlxTween.cancelTweensOf(blackOut);
				FlxTween.cancelTweensOf(storySelection);
				FlxTween.cancelTweensOf(storyText);
				FlxTween.cancelTweensOf(extraFinalScore);
				FlxTween.cancelTweensOf(sprDifficulty);
		}
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		// Alpha and Position Checks
		leftDiffArrow.x = storySelection.x;
		leftDiffArrow.alpha = rightDiffArrow.alpha = sprDifficulty.alpha;
		BGchecker.alpha = buffSelected.alpha = buffTitle.alpha = buffText.alpha = charmTitle.alpha = charmText.alpha = gfPocket.alpha;
		
		// Backdrop Functionality
		BGchecker.x += 0.5 * (elapsed / (1 / 120));
        BGchecker.y -= 0.16 / (ClientPrefs.framerate / 60); 

		lerpScore(elapsed);

		if (controls.BACK || FlxG.mouse.justPressedRight)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if (inventoryOpened)
			{
				cancelTweens("inventory");
				FlxTween.tween(blackOut, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(gfPocket, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				buffItems.forEach(function(buff:FlxSprite)
				{
					FlxTween.cancelTweensOf(buff);
					FlxTween.tween(buff, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				});
					
				charmItems.forEach(function(charm:FlxSprite)
				{
					FlxTween.cancelTweensOf(charm);
					FlxTween.tween(charm, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				});
			}
			else if (storySelected)
			{
				storySelected = false;
				cancelTweens("story");
				storyStuffs.forEach(function(spr:FlxSprite)
				{
					FlxTween.cancelTweensOf(spr);
					FlxTween.tween(spr, {x: FlxG.width + 417}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
				});
				FlxTween.tween(blackOut, {alpha: 0}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
				FlxTween.tween(storySelection, {x: FlxG.width + 740, alpha: 0.6}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
				FlxTween.tween(storyText, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(extraFinalScore, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(sprDifficulty, {alpha: 0}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
			}
			else
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}
		}

		// If nothing is selected, do this code
		var nothingSelected:Bool = (!storySelected && !inventoryOpened);
		if (!selectedSomethin)
		{
			if(FlxG.mouse.overlaps(exclamationMark) && FlxG.mouse.justPressed)
			{
				MusicBeatState.switchState(new tutorial.TutorialState(), 'stickers');

				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));	
			}	

			if (nothingSelected)
			{
				// Mess with Alpha Values
				shopButton.alpha = (FlxG.mouse.overlaps(shopButton)) ? 1 : 0.5;
				exclamationMark.alpha = (FlxG.mouse.overlaps(exclamationMark)) ? 1 : 0.5;
				optionsButton.alpha = (FlxG.mouse.overlaps(optionsButton)) ? 1 : 0.5;
				inventoryButton.alpha = (FlxG.mouse.overlaps(inventoryButton)) ? 1 : 0.5;

				// Options Button Functionality
				if (FlxG.mouse.overlaps(optionsButton) && FlxG.mouse.justPressed && nothingSelected)
				{
					ClientPrefs.inMenu = selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(optionsButton, 1, 0.06, false, false, function(flick:FlxFlicker)
					{
						LoadingState.loadAndSwitchState(new options.OptionsState());
					});
				}

				// Arrow position
				FlxTween.tween(leftArrow, {x: FlxG.mouse.overlaps(leftArrow) ? getLeftArrowX - 2 : getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});	
				FlxTween.tween(rightArrow, {x: FlxG.mouse.overlaps(leftArrow) ? getRightArrowX + 2 : getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

				// Arrow Functionality (Main Part)
				if (controls.UI_RIGHT || (FlxG.mouse.overlaps(rightArrow) && FlxG.mouse.pressed)) rightArrow.animation.play('press')
				else rightArrow.animation.play('idle');
				if (controls.UI_LEFT || (FlxG.mouse.overlaps(leftArrow) && FlxG.mouse.pressed)) leftArrow.animation.play('press');
				else leftArrow.animation.play('idle');

				if (controls.UI_LEFT_P || (FlxG.mouse.overlaps(leftArrow) && FlxG.mouse.justPressed)) changeItem(-1, true);
				if (controls.UI_RIGHT_P || (FlxG.mouse.overlaps(rightArrow) && FlxG.mouse.justPressed)) changeItem(1, true);

				var accepted:Bool = controls.ACCEPT || (FlxG.mouse.overlaps(menuItems.members[curSelected]) && FlxG.mouse.justPressed);
				if (accepted)
				{
					if (optionShit[curSelected] == 'story_mode')
					{
						storySelected = true;
						cancelTweens("story");
						changeItem();
						FlxG.sound.play(Paths.sound('confirmMenu'));
						storyStuffs.forEach(function(spr:FlxSprite)
						{
							FlxTween.tween(spr, {x: FlxG.width - 683}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
						});
						FlxTween.tween(storySelection, {x: FlxG.width - 260}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
						FlxTween.tween(blackOut, {alpha: 0.6}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
						FlxTween.tween(storyText, {alpha: 1}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
						if (storyShit[curStorySelected] == 'injection') FlxTween.tween(sprDifficulty, {alpha: 1}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					}
					else if ((optionShit[curSelected] == 'freeplay' && !ClientPrefs.mainWeekBeaten)
					 	 || (optionShit[curSelected] == 'gallery' && !ClientPrefs.galleryUnlocked)
					 	 || (optionShit[curSelected] == 'info' && !ClientPrefs.mainWeekBeaten))
					{
						FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
						FlxG.sound.play(Paths.sound('accessDenied'));
					}
					else
					{
						selectedSomethin = true;
						FlxG.sound.play(Paths.sound('confirmMenu'));

						menuItems.forEach(function(spr:FlxSprite)
						{
							if (curSelected != spr.ID) spr.kill();
							else
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									var daChoice:String = optionShit[curSelected];
		
									switch (daChoice)
									{
										case 'freeplay':
											ClientPrefs.inMenu = false;
											MusicBeatState.switchState(new FreeplayCategoryState(), 'stickers');
										case 'info':
											MusicBeatState.switchState(new InfoState(), 'stickers');
										case 'promotion':
											MusicBeatState.switchState(new PromotionState(), 'stickers');
										case 'gallery':
											ClientPrefs.inMenu = false;
											MusicBeatState.switchState(new GalleryState(), 'stickers');
										case 'credits':
											ClientPrefs.inMenu = false;
											MusicBeatState.switchState(new CreditsState(), 'stickers');
									}
								});
							}
						});
					}
				}
				#if desktop
					#if DEBUG_ALLOWED
						if (FlxG.keys.anyJustPressed(debugKeys)) MusicBeatState.switchState(new MasterEditorMenu());				
					#else
						if (FlxG.keys.anyJustPressed(debugKeys))
						{
							selectedSomethin = true;
							if (FlxG.sound.music != null) FlxG.sound.music.stop();

							var achieveFlashBangID:Int = Achievements.getAchievementIndex('flashbang');
								if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveFlashBangID][2])) {
								Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveFlashBangID][2], true);
								giveFlashbangAchievement();
								ClientPrefs.saveSettings();
							}
				
							CppAPI.setOld();
							CppAPI.setWallpaper(FileSystem.absolutePath("assets\\images\\thinkFastBitch.png"));
							var video:VideoSprite = new VideoSprite(Paths.video('thinkFastChucklenuts'), false, false, false);
							add(video);
							video.play();
							video.finishCallback = function()
							{
								if (!ClientPrefs.allowPCChange && Wallpaper.oldWallpaper != null) CppAPI.setWallpaper("old");
								System.exit(0);
							};
						}
					#end
				#end
			}
			else
			{
				if (storySelected && !applyStory)
				{
					FlxTween.tween(storySelection, {alpha: FlxG.mouse.overlaps(storySelection) ? 1 : 0.6}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
			
					if (controls.UI_LEFT_P) changeItem(-1, true);
					if (controls.UI_RIGHT_P) changeItem(1, true);

					// Mayhem Code
					if (storyShit[curStorySelected] == 'mayhem' && controls.RESET)
					{
						persistentUpdate = false;
						openSubState(new ResetScoreSubState('Mayhem Mode', -1, -1));
					}

					// Injection Code
					if (storyShit[curStorySelected] == 'injection')
					{
						if (controls.RESET)
						{
							persistentUpdate = false;
							openSubState(new ResetScoreSubState('Injection Mode', curDifficulty, -1));
						}

						if ((FlxG.mouse.overlaps(rightDiffArrow) && FlxG.mouse.pressed)) rightDiffArrow.animation.play('press');
						else rightDiffArrow.animation.play('idle');
							
						if ((FlxG.mouse.overlaps(leftDiffArrow) && FlxG.mouse.pressed)) leftDiffArrow.animation.play('press'); 
						else leftDiffArrow.animation.play('idle');

						if ((FlxG.mouse.overlaps(rightDiffArrow) && FlxG.mouse.justPressed)) changeDifficulty(1);					
						if ((FlxG.mouse.overlaps(leftDiffArrow) && FlxG.mouse.justPressed)) changeDifficulty(-1);
					}

					var accept:Bool = controls.ACCEPT || (FlxG.mouse.overlaps(storySelection) && FlxG.mouse.justPressed);
					if (accept)
					{
						if (storyShit[curStorySelected] == 'iniquitous' && (!Achievements.isAchievementUnlocked('weekIniquitous_Beaten')))
						{
							FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
							FlxG.sound.play(Paths.sound('accessDenied'));
						}
						else if (storyShit[curStorySelected] == 'injection' && (ClientPrefs.weeksUnlocked < 7 || warnMayhem != ''))
						{
							FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
							FlxG.sound.play(Paths.sound('accessDenied'));
						}
						else if (storyShit[curStorySelected] == 'mayhem' && (!allowMayhemGameMode || warnMayhem != ''))
						{
							FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
							FlxG.sound.play(Paths.sound('accessDenied'));
						}
						else
						{
							trace ('Low Quality (For Libidinousness) has been turned ' + ((ClientPrefs.performanceWarning) ? "On!" : "Off!"));

							ClientPrefs.saveSettings();

							if (storyShit[curStorySelected] == 'injection')
							{
								var songArray:Array<String> = [];
								for (i in 0...injectionSongs.length) 
								{
									var casualCheck:Bool = curDifficulty == 0 && (injectionSongs[i] != "villainy" && injectionSongs[i] != "point-blank" && injectionSongs[i] != "libidinousness" && injectionSongs[i] != "excrete" && injectionSongs[i] != "iniquitous");
									if (casualCheck || curDifficulty == 1) songArray.push(injectionSongs[i]);
								}
								
								PlayState.injectionPlaylist = songArray;
							}
							
							if (storyShit[curStorySelected] == 'mayhem')
							{
								var songArray:Array<String> = [];
								for (i in 0...mayhemSongs.length) songArray.push(mayhemSongs[i]);
								PlayState.mayhemPlaylist = songArray;
							}

							applyStory = true;
							FlxG.sound.play(Paths.sound('confirmMenu'));
							FlxFlicker.flicker(storySelection, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								switch(storyShit[curStorySelected])
								{
									case 'classic':
										ClientPrefs.inMenu = false;
										MusicBeatState.switchState(new StoryMenuState(), 'stickers');
									case 'iniquitous':
										ClientPrefs.inMenu = false;
										MusicBeatState.switchState(new IniquitousMenuState(), 'stickers');
									case 'injection':
										ClientPrefs.resetProgress(true, true);
										ClientPrefs.inMenu = FlxG.mouse.visible = false;
										PlayState.isInjectionMode = true;

										PlayState.injectionDifficulty = PlayState.storyDifficulty = curDifficulty;
										var diffic:String = CoolUtil.getDifficultyFilePath(curDifficulty);
										PlayState.SONG = Song.loadFromJson(PlayState.injectionPlaylist[0].toLowerCase() + diffic, PlayState.injectionPlaylist[0].toLowerCase());
					
										PlayState.campaignScore = PlayState.campaignMisses = 0;		
										PlayState.injectionRating = PlayState.injectionScore = PlayState.injectionMisses = PlayState.injectionSongsPlayed = 0;
										PlayState.injectionPlaylistTotal = PlayState.injectionPlaylist.length;

										LoadingState.loadAndSwitchState(new PlayState(), true);
										FreeplayState.destroyFreeplayVocals();
									case 'mayhem':
										ClientPrefs.resetProgress(true, true);
										ClientPrefs.inMenu = FlxG.mouse.visible = false;
										PlayState.isMayhemMode = true;
										PlayState.mayhemHealth = 150;
										PlayState.mayhemSongsPlayed = PlayState.mayhemScore = PlayState.mayhemBestCombo = PlayState.mayhemTotalChallenges = 0;
										PlayState.mayhemRating = 0;

										CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();		
													
										var appliedChanges:Bool = false;
										var songSelected:Int = FlxG.random.int(0, PlayState.mayhemPlaylist.length - 1);
										var song:String = PlayState.mayhemPlaylist[songSelected];
										switch(song)
										{
											case "toybox", "it's-kiana", "villainy", "point-blank", "libidinousness", "excrete", "shuckle-fuckle": curDifficulty = 1;
											default: curDifficulty = FlxG.random.int(0, 1);
										}
										var diff:String = CoolUtil.getDifficultyFilePath(curDifficulty);
								
										appliedChanges = PlayState.checkSongBeforeSwitching("LowQuality", song, diff);
										if (!appliedChanges) appliedChanges = PlayState.checkSongBeforeSwitching("Optimization", song, diff);
										if (!appliedChanges) appliedChanges = PlayState.checkSongBeforeSwitching("Mechanics", song, diff);

										if (appliedChanges) trace("Song has been modified successfully.");
										else trace("No modifications needed. -> " + Paths.formatToSongPath(song) + diff);

										PlayState.SONG = Song.loadFromJson(song + diff, song);

										PlayState.campaignScore = PlayState.campaignMisses = 0;
										PlayState.mayhemDifficulty = curDifficulty;

										switch(PlayState.mayhemPlaylist[songSelected])
										{
											case "cheap-skate-(legacy)", "toxic-mishap-(legacy)", "paycheck-(legacy)": PlayState.SONG.player1 = 'playablegf-old';
											case "spendthrift": PlayState.SONG.player1 = 'Spendthrift GF';
											case "its-kiana": PlayState.SONG.player1 = 'd-side gf';
										}
											
										// Unlock Secret Song
										if (!ClientPrefs.shucksUnlocked && PlayState.mayhemPlaylist[songSelected] == "shuckle-fuckle") ClientPrefs.shucksUnlocked = true;
										
										trace(Paths.formatToSongPath(song) + diff);

										LoadingState.loadAndSwitchState(new PlayState(), true);
										FreeplayState.destroyFreeplayVocals();
								}
							});
						}
					}
				}
				else if (inventoryOpened)
				{
					buffItems.forEach(function(buff:FlxSprite)
					{
						if (FlxG.mouse.overlaps(buff) && FlxG.mouse.justPressed) buffSelect(buff.ID);
					});

					charmItems.forEach(function(charm:FlxSprite)
					{
						if (FlxG.mouse.overlaps(charm) && FlxG.mouse.justPressed) charmSelect(charm.ID);
					});		
				}
			}
		}

		// Activate Inventory
		if (FlxG.keys.pressed.I || (FlxG.mouse.overlaps(inventoryButton) && FlxG.mouse.justPressed) && nothingSelected)
		{
			inventoryOpened = true;
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.6);
			cancelTweens("inventory");
			FlxTween.tween(blackOut, {alpha: 0.7}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(gfPocket, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			buffItems.forEach(function(buff:FlxSprite)
			{
				FlxTween.tween(buff, {alpha: (buff.ID == curBuffSelected) ? 1 : 0.6}, 0.2, {ease: FlxEase.circOut, type: PERSIST});
			});
			FlxTween.tween(inventoryTitle, {alpha: 0.7}, 0.6, {ease: FlxEase.circOut, type: PERSIST});

			charmItems.forEach(function(charm:FlxSprite)
			{
				FlxTween.tween(charm, {alpha: (charm.ID == curCharmSelected) ? 1 : 0.2}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			});

			buffSelect(curBuffSelected);
			charmSelect(curCharmSelected);
			ClientPrefs.saveSettings();
		}

		if (FlxG.mouse.overlaps(shopButton) && FlxG.mouse.justPressed && !ClientPrefs.inShop && nothingSelected)
		{
			FlxG.sound.music.fadeOut(0.5);
			FlxG.sound.play(Paths.sound('scrollMenu'));
			ClientPrefs.inShop = true;
			MusicBeatState.switchState(new ShopState());
		}
		super.update(elapsed);
	}

	function giveFlashbangAchievement()
	{
		add(new AchievementObject('flashbang', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "flashbang"');
	}

	var tweenDifficulty:FlxTween;
	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;
		if (Achievements.isAchievementUnlocked('weekIniquitous_Beaten')) // Allow EVERYTHING
		{
			if (curDifficulty < 0) curDifficulty = 1;
			if (curDifficulty > 1) curDifficulty = 0;
		}
		else
			curDifficulty = 0; //Uh oh! You didn't get the true ending to earn everything, you can only play in CASUAL for now!

		var diff:String = CoolUtil.difficulties[curDifficulty];
		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));
		
		if(sprDifficulty.graphic != newImage)
		{
			sprDifficulty.loadGraphic(newImage);
			sprDifficulty.x = leftDiffArrow.x + 60;
			sprDifficulty.x += (308 - sprDifficulty.width) / 3;
			sprDifficulty.alpha = 0;
			sprDifficulty.y = leftDiffArrow.y - 15;

			if(tweenDifficulty != null) tweenDifficulty.cancel();
			tweenDifficulty = FlxTween.tween(sprDifficulty, {y: leftDiffArrow.y + 15, alpha: 1}, 0.07, {onComplete: function(twn:FlxTween)
			{
				tweenDifficulty = null;
			}});
		}
		lastDifficultyName = diff;

		intendedInjectedScore = (curDifficulty == 1) ? ClientPrefs.injectionVilEndScore : ClientPrefs.injectionEndScore;
	}

	function charmSelect(huh:Int = 0)
	{
		curCharmSelected = huh;
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
		charmItems.forEach(function(charm:FlxSprite)
		{
			charm.alpha = (curCharmSelected == charm.ID) ? 1 : 0.2;
	
			switch(curCharmSelected)
			{
				case 0: charmText.text = (!ClientPrefs.resCharmCollected) ? "Locked" : "Resistance";
				case 1: charmText.text = (!ClientPrefs.autoCharmCollected) ? "Locked" : "Auto Dodge";
				case 2: charmText.text = (!ClientPrefs.healCharmCollected) ? "Locked" : "Healing";
			}
		});
	}

	function buffSelect(huh:Int = 0)
	{
		curBuffSelected = huh;
		var reflectedBuff = Reflect.field(ClientPrefs, 'buff${curBuffSelected}selected');
		var buffArray:Array<String> = ["None", "Health Regeneration", "Second Chance", "Immunity"];
		if (!reflectedBuff && huh != 0)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
			return;
		}

		buffText.text = buffArray[curBuffSelected];
		buffSelected.x = buffItems.members[curBuffSelected].x;
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);

		buffItems.forEach(function(buff:FlxSprite)
		{
			buff.alpha = (curBuffSelected == buff.ID) ? 1 : 0.2;
		});
		ClientPrefs.buff1Selected = (curBuffSelected == 1);
		ClientPrefs.buff2Selected = (curBuffSelected == 2);
		ClientPrefs.buff3Selected = (curBuffSelected == 3);
		ClientPrefs.saveSettings();
	}
	
	function changeItem(huh:Int = 0, ?playSound:Bool = false)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'));

		if (!storySelected && !inventoryOpened)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length) curSelected = 0;
			if (curSelected < 0) curSelected = menuItems.length - 1;
	
			menuItems.forEach(function(spr:FlxSprite)
			{
				spr.alpha = (spr.ID == curSelected) ? 1 : 0;
			});
		}
		else
		{
			curStorySelected += huh;

			if (curStorySelected >= storyShit.length) curStorySelected = 0;
			if (curStorySelected < 0) curStorySelected = storyShit.length - 1;

			if (storyShit[curStorySelected] == 'injection') changeDifficulty();
			else intendedMayhemedScore = ClientPrefs.mayhemEndTotalScore;

			storySelection.text = storyShit[curStorySelected];
			extraFinalScore.alpha = (storyShit[curStorySelected] == 'injection' || storyShit[curStorySelected] == 'mayhem') ? 1 : 0;
			sprDifficulty.alpha = (storyShit[curStorySelected] == 'injection' || storyShit[curStorySelected] == 'mayhem') ? 1 : 0;

			switch (storyShit[curStorySelected])
			{
				case 'classic':
					storyText.text = "Experience FNV in all it's <G>glory<G>!\nPlay through various <R>w<R><GR>e<GR><Y>e<Y><B>k<B><DP>s<DP>,\nall packed with <G>juicy content!<G>";
					storyText.color = 0xFFffffff;
					storyText.y = 300;
				case 'iniquitous':
					if (Achievements.isAchievementUnlocked('weekIniquitous_Beaten') && Achievements.isAchievementUnlocked('WeekMarcoIniquitous_Beaten')
						&& Achievements.isAchievementUnlocked('WeekNunIniquitous_Beaten') && Achievements.isAchievementUnlocked('WeekKianaIniquitous_Beaten'))
						storyText.text = "Do you dare oppose your <DR>wrath?<DR>";
					else if (Achievements.isAchievementUnlocked('weekIniquitous_Beaten'))
						storyText.text = "Do you dare oppose his <DR>wrath?<DR>";
					else
						storyText.text = "Defeat <DR>ME<DR> first.";
					storyText.color = 0xFFff0000;
					storyText.y = 325;
				case 'injection':
					if (ClientPrefs.weeksUnlocked >= 7)
					{
						warnMayhem = ""; //Reset this every time!!! idk use this again to not make 2 variables bru
						if (ClientPrefs.getGameplaySetting('practice', false) || ClientPrefs.getGameplaySetting('botplay', false))
							warnMayhem += 'Botplay and/or Practice Mode\n';
						if (!ClientPrefs.mechanics) warnMayhem += 'Mechanics\n';
						if (ClientPrefs.optimizationMode) warnMayhem += 'Optimization Mode';
						if (warnMayhem == '')
						{
							storyText.text = "Play through the Main Game\nin <GR>ONE attempt<GR>!!\n<P>Health<P> and <G>Score<G> gets saved\nalong the way!\nTry not to lose,\nor you <R>lose your progress<R>!";
							storyText.y = 265;
						}
						else
						{
							storyText.text = "You can't access this mode.\nPlease disable the following: <R>\n" + warnMayhem + "<R>";
							storyText.y = 310;
						} 
					}
					else
					{
						storyText.text = "Beat <G>ALL MAIN\nAND BONUS WEEKS<G> to\nunlock this mode!";
						storyText.y = 310;
					}
					storyText.color = 0xFFffffff;
					
				case 'mayhem':
					if (allowMayhemGameMode)
					{
						warnMayhem = ""; //Reset this every time!!!
						if (ClientPrefs.getGameplaySetting('practice', false) || ClientPrefs.getGameplaySetting('botplay', false))
							warnMayhem += 'Botplay and/or Practice Mode\n';
						if (!ClientPrefs.mechanics) warnMayhem += 'Mechanics\n';
						if (ClientPrefs.optimizationMode) warnMayhem += 'Optimization Mode';

						if (warnMayhem == '')
						{
							storyText.text = "Go through as many\nsongs as you can with\na set amount of <P>health<P>!\nTry to last as long as you can,\nwhilst <R>challenges<R> are\nthrown at you!
							\n<G>TIP<G>: Press <GR>TAB<GR>\nto view your challenge(s)!";
							storyText.y = 200;
						}
						else
						{
							storyText.text = "You can't access this mode.\nPlease disable the following: <R>\n" + warnMayhem + "<R>";
							storyText.y = 310;
						}
					}	
					else
					{
						storyText.text = "Beat <G>ALL SONGS<G>\nto unlock this mode!";
						storyText.y = 310;
					}
					storyText.color = 0xFFffffff;
			}

			storyStuffs.forEach(function(spr:FlxSprite)
			{
				spr.alpha = (spr.ID == curStorySelected) ? 1 : 0;
			});

			CustomFontFormats.addMarkers(storyText);
		}
	}
}
