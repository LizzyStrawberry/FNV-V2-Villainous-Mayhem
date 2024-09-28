package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxAxes;
import flixel.addons.display.FlxBackdrop;

import vlc.MP4Handler;
import flash.system.System;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var FNVVersion:String = '2.0 Work in Progress (97%+)'; //This is also used for Discord RPC
	public static var psychEngineVersion:String = '0.6.3 Modified'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var curStorySelected:Int = 0;
	public static var curBuffSelected:Int = 0;
	public static var curCharmSelected:Int = 0;
	var curDifficulty:Int = 1;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
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
		'concert-chaos',
		'nunsational',
		"its-kiana",
		"forsaken-(picmixed)",
		"get-picod",
		"marauder-(old)",
		"slowflp-(old)",
		"partner",
		"shucks-v2",
		"get-villaind-(old)"
	];

	var libidiWarning:FlxText;

	var lerpInjectedScore:Int = 0;
	var intendedInjectedScore:Int = 0;
	var lerpMayhemedScore:Int = 0;
	var intendedMayhemedScore:Int = 0;

	var menuItem:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var bg:FlxSprite;
	var bgChange:FlxSprite;
	var isShown:Bool = false;
	var number30:Int = 0;
	var bgBorder:FlxSprite;

	var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;
	var transparentButton:FlxSprite;

	var blackOut:FlxSprite;
	var blackOut2:FlxSprite;

	var discord:FlxSprite;
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

	var libidiPerformWarn:Bool = false;
	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		if (ClientPrefs.galleryUnlocked == false && Achievements.isAchievementUnlocked('WeekMarco_Beaten') && Achievements.isAchievementUnlocked('WeekNun_Beaten') && Achievements.isAchievementUnlocked('WeekKiana_Beaten'))
		{
			ClientPrefs.galleryUnlocked = true;
		}
		
		//resetting this rq
		ClientPrefs.ghostTapping = true;
		ClientPrefs.codeRegistered = '';
		ClientPrefs.onCrossSection = false;
		GameOverSubstate.injected = false;
		GameOverSubstate.mayhemed = false;
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

		persistentUpdate = persistentDraw = true;

		intendedInjectedScore = ClientPrefs.injectionEndScore;
		intendedMayhemedScore = ClientPrefs.mayhemEndTotalScore;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		number30 = FlxG.random.int(1, 59);

		if (ClientPrefs.performanceWarning == true)
		{
			libidiPerformWarn = true;
		}

		if (number30 == 30 && Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true
			&& ClientPrefs.kianaWeekPlayed == true)
		{
			bg = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-mork'));
			bg.frames = Paths.getSparrowAtlas('mainMenuBgs/menu-mork');//here put the name of the xml
			//bg.scale.set(0.9, 0.9);
			bg.animation.addByPrefix('idleMenu', 'mork mork0', 24, true);//on 'idle normal' change it to your xml one
			bg.animation.play('idleMenu');//you can rename the anim however you want to
			bg.scrollFactor.set();
			trace('MORK');	
		}
		else if (number30 == 2 && Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true
			&& ClientPrefs.kianaWeekPlayed == true)
		{
			isShown = true;
			bg = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-rare'));
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
			
			if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true
				&& ClientPrefs.kianaWeekPlayed == true)
			{
				bg = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 59)));
				trace('good job lmao, You beat Week 3, you can now have all the menu images!');
			}
			else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true)
			{
				bg = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 13)));
				trace('good job lmao, You beat Week 2');
			}
			else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten'))
			{
				bg = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 11)));
				trace('good job lmao, You beat Week 1');
			}
			else
			{
				bg = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 5)));
				trace('You have not unlocked any extra songs.');
			}
		}

		bg.scrollFactor.set(0, yScroll);
		bg.updateHitbox();
		bg.screenCenter(XY);
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		//making a secondary sprite so we can change each background after a few seconds or something lmao
		if(isShown == false)
		{	
			if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true && ClientPrefs.kianaWeekPlayed == true)
				bgChange = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 59)));
			else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true)
				bgChange = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 13)));
			else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten'))
				bgChange = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 11)));
			else
				bgChange = new FlxSprite(-80).loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 5)));
			bgChange.scrollFactor.set(0, yScroll);
			bgChange.setGraphicSize(Std.int(bgChange.width * 1.175));
			bgChange.updateHitbox();
			bgChange.screenCenter(XY);
			bgChange.alpha = 0;
			bgChange.x += 120;
			bgChange.antialiasing = ClientPrefs.globalAntialiasing;
			add(bgChange);
		}

		var bgTimer:FlxTimer = new FlxTimer().start(10, changeBg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);
		
		bgBorder = new FlxSprite(-80).loadGraphic(Paths.image('menuBorder'));
		bgBorder.scrollFactor.set(0, 0);
		bgBorder.setGraphicSize(Std.int(bgBorder.width * 1.175));
		bgBorder.updateHitbox();
		bgBorder.screenCenter();
		bgBorder.antialiasing = ClientPrefs.globalAntialiasing;
		add(bgBorder);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 0.8;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white0", 24);
			if (optionShit[i] == 'freeplay' && ClientPrefs.mainWeekBeaten == false)
			{
				menuItem.animation.addByPrefix('locked', optionShit[i] + " white locked", 24);
				menuItem.animation.play('locked');
			}
			else if (optionShit[i] == 'gallery' && ClientPrefs.galleryUnlocked == false)
			{
				menuItem.animation.addByPrefix('locked', optionShit[i] + " white locked", 24);
				menuItem.animation.play('locked');
			}
			else if (optionShit[i] == 'info' && ClientPrefs.mainWeekBeaten == false)
			{
				
				menuItem.animation.addByPrefix('locked', optionShit[i] + " white locked", 24);
				menuItem.animation.play('locked');
			}
			else
				menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItem.x -= 220;
			menuItem.screenCenter(Y);
			menuItem.y = 510;
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		menuItems.forEach(function(spr:FlxSprite)
			{
			if (curSelected != spr.ID)
				{
					spr.alpha = 0;
				} 
			else
				{
					spr.alpha = 1;
				}
			});

		transparentButton = new FlxSprite(0, 0);
		transparentButton.makeGraphic(480, 80, FlxColor.WHITE);
		transparentButton.screenCenter();
		transparentButton.x -= 290;
		transparentButton.alpha = 0;
		transparentButton.y += 230;
		add(transparentButton);

		//FlxG.camera.follow(camFollowPos, null, 1);

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

		// NG.core.calls.event.logEvent('swag').send();

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
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		exclamationMark = new FlxSprite(1190, 110).loadGraphic(Paths.image('exclamationMark'));
		exclamationMark.antialiasing = ClientPrefs.globalAntialiasing;
		exclamationMark.alpha = 0.5;
		exclamationMark.scale.set(0.5, 0.5);
		exclamationMark.updateHitbox();
		add(exclamationMark);
		if (ClientPrefs.firstTime == false)
		{
			NotificationAlert.showMessage(this, 'Tutorial');
			NotificationAlert.sendTutorialNotification = true;
			NotificationAlert.saveNotifications();

			ClientPrefs.firstTime = true;
			ClientPrefs.saveSettings();
		}
		if (NotificationAlert.sendTutorialNotification == true)
		{
			NotificationAlert.addNotification(this, exclamationMark, -10, 85);

			NotificationAlert.sendTutorialNotification = false;
			NotificationAlert.saveNotifications();
		}

		optionsButton = new FlxSprite(1168, 0).loadGraphic(Paths.image('optionsButton'));
		optionsButton.antialiasing = ClientPrefs.globalAntialiasing;
		optionsButton.alpha = 0.5;
		optionsButton.updateHitbox();
		add(optionsButton);
		if (NotificationAlert.sendOptionsNotification == true)
		{
			NotificationAlert.addNotification(this, optionsButton, -10, 85);

			NotificationAlert.sendOptionsNotification = false;
			NotificationAlert.saveNotifications();
		}

		inventoryButton = new FlxSprite(1168, 310).loadGraphic(Paths.image('inventoryButton'));
		inventoryButton.antialiasing = ClientPrefs.globalAntialiasing;
		inventoryButton.alpha = 0.5;
		inventoryButton.updateHitbox();
		add(inventoryButton);
		if (NotificationAlert.sendInventoryNotification == true)
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
		if (NotificationAlert.sendShopNotification == true)
		{
			NotificationAlert.addNotification(this, shopButton, 115, 100);

			NotificationAlert.sendShopNotification = false;
			NotificationAlert.saveNotifications();
		}
			
		var tokenShow:FlxText = new FlxText(780, 330, FlxG.width,
			"Tokens: <GR>" + ClientPrefs.tokens + "<GR>",
			32);
			if (ClientPrefs.tokens == 0)
				tokenShow.text = "Tokens: <R>" + ClientPrefs.tokens + "<R>";
			tokenShow.setFormat("VCR OSD Mono", 28, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
			tokenShow.screenCenter(XY);
			tokenShow.x = shopButton.x;
			tokenShow.y = shopButton.y + 130;
			tokenShow.borderSize = 1;

			CustomFontFormats.addMarkers(tokenShow);
		add(tokenShow);

		discord = new FlxSprite(1190, 210).loadGraphic(Paths.image('discord'));
		discord.antialiasing = ClientPrefs.globalAntialiasing;
		discord.alpha = 0.5;
		discord.scale.set(0.5, 0.5);
		discord.updateHitbox();
		add(discord);

		FlxG.mouse.visible = true;

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 0;
		add(blackOut);

		storyStuffs = new FlxTypedGroup<FlxSprite>();
		add(storyStuffs);

		for (i in 0...storyShit.length)
		{
			var storyStuff:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainmenu/story_' + storyShit[i]));
			storyStuff.ID = i;
			storyStuff.screenCenter(X);
			storyStuff.x += 1420;
			storyStuff.screenCenter(Y);
			storyStuffs.add(storyStuff);
			storyStuff.scrollFactor.set(0, 0);
			storyStuff.antialiasing = ClientPrefs.globalAntialiasing;
			storyStuff.updateHitbox();
			//trace(storyStuff.x);
		}

		storySelection = new Alphabet(2020, 320, "Test", true);
		storySelection.setAlignmentFromString('center');
		storySelection.alpha = 0.6;
		storySelection.scaleX = 0.8;
		storySelection.scaleY = 0.8;
		add(storySelection);

		storyText = new FlxText(30, 300, FlxG.width,
			"Test!",
			25);
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
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
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

		blackOut2 = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut2.alpha = 0;
		add(blackOut2);

		if (libidiPerformWarn == true)
		{
			libidiWarning = new FlxText(700, 100, 1000, "<R>Warning:<R>\n<DP>'Libidinousness'<DP> takes a lot of juice off of your PC.\nCan it handle it?\n<R>(It is recommended to atleast have a graphics card installed)<R>\n----------------------------
			\n<G>Y:<G> <G>Yes<G> | <r>N:<r> <r>No<r>", 32);
			libidiWarning.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, CENTER);
			libidiWarning.screenCenter(XY);
			libidiWarning.alpha = 0;

			CustomFontFormats.addMarkers(libidiWarning);

			add(libidiWarning);
		}

		BGchecker = new FlxBackdrop(Paths.image('promotion/BGgrid-' + FlxG.random.int(1, 8)), 0, 0, true, true); 
		BGchecker.updateHitbox(); 
		BGchecker.scrollFactor.set(0, 0); 
		BGchecker.alpha = 0; 
		BGchecker.screenCenter(X); 
		add(BGchecker);

		// Menu Inventory
		// Add the character to the selection
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
			buff.screenCenter();
			buff.x -= 50;
			buff.x += i * (buff.width + 50);
			buff.ID = i;

			switch(buff.ID)
			{
				case 1:
					if (ClientPrefs.buff1Unlocked == false)
						buff.loadGraphic(Paths.image('inventory/buffLocked'));
				case 2:
					if (ClientPrefs.buff2Unlocked == false)
						buff.loadGraphic(Paths.image('inventory/buffLocked'));
				case 3:
					if (ClientPrefs.buff3Unlocked == false)
						buff.loadGraphic(Paths.image('inventory/buffLocked'));
			}

			buff.y -= 70;
			buff.alpha = 0;
			buff.antialiasing = ClientPrefs.globalAntialiasing;
			buffItems.add(buff);
			add(buff);
		}

		buffSelected = new FlxSprite(0, 0).loadGraphic(Paths.image('inventory/buffSelected'));
		buffSelected.screenCenter();
		buffSelected.x = buffItems.members[curBuffSelected].x;
		buffSelected.y -= 70;
		buffSelected.alpha = 0;
		buffSelected.antialiasing = ClientPrefs.globalAntialiasing;
		add(buffSelected);

		inventoryTitle = new Alphabet(420, 10, "Inventory", true);
		inventoryTitle.alpha = 0;
		add(inventoryTitle);

		buffTitle = new Alphabet(1170, 200, "Buffs", true);
		buffTitle.scaleX = 0.7;
		buffTitle.scaleY = 0.7;
		buffTitle.alpha = 0;
		add(buffTitle);

		buffText = new FlxText(0, 0, FlxG.width,
			"Test!",
			25);
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
			charm.ID = i;

			switch(charm.ID)
			{
				case 0:
					if (ClientPrefs.resCharmCollected == false)
						charm.loadGraphic(Paths.image('inventory/buffLocked'));
				case 1:
					if (ClientPrefs.autoCharmCollected == false)
						charm.loadGraphic(Paths.image('inventory/buffLocked'));
				case 2:
					if (ClientPrefs.healCharmCollected == false)
						charm.loadGraphic(Paths.image('inventory/buffLocked'));
			}

			charm.y += 210;
			charm.alpha = 0;
			charm.antialiasing = ClientPrefs.globalAntialiasing;
			charmItems.add(charm);
			add(charm);
		}	

		charmTitle = new Alphabet(1120, 610, "Charms", true);
		charmTitle.scaleX = 0.7;
		charmTitle.scaleY = 0.7;
		charmTitle.alpha = 0;
		add(charmTitle);

		charmText = new FlxText(0, 0, FlxG.width,
			"Test!",
			25);
		charmText.screenCenter(XY);
		charmText.y += 300;
		charmText.x += 250;
		charmText.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, CENTER);
		charmText.alpha = 0;
		add(charmText);

		if (ClientPrefs.buff1Selected == true)
			curBuffSelected = 1;
		else if (ClientPrefs.buff2Selected == true)
			curBuffSelected = 2;
		else if (ClientPrefs.buff3Selected == true)
			curBuffSelected = 3;
		else
			curBuffSelected = 0;

		buffSelected.x = buffItems.members[curBuffSelected].x;

		if (ClientPrefs.inShop == true)
		{
			if (ClientPrefs.iniquitousWeekUnlocked == true && ClientPrefs.iniquitousWeekBeaten == false)
				FlxG.sound.playMusic(Paths.music('malumIctum'));
			else if (FlxG.random.int(1, 10) == 2)
				FlxG.sound.playMusic(Paths.music('AJDidThat'));
			else
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
			FlxG.sound.music.fadeIn(2.0);
			ClientPrefs.inShop = false;
			ClientPrefs.saveSettings();
		}

		if(Achievements.isAchievementUnlocked('Tutorial_Beaten')
			&& Achievements.isAchievementUnlocked('WeekMarco_Beaten') && Achievements.isAchievementUnlocked('WeekMarcoVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekMarcoIniquitous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekNun_Beaten') && Achievements.isAchievementUnlocked('WeekNunVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekNunIniquitous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekKiana_Beaten') && Achievements.isAchievementUnlocked('WeekKianaVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekKianaIniquitous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekMorky_Beaten') && Achievements.isAchievementUnlocked('WeekMorkyVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekSus_Beaten') && Achievements.isAchievementUnlocked('WeekSusVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekLegacy_Beaten') && Achievements.isAchievementUnlocked('WeekLegacyVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekDside_Beaten') && Achievements.isAchievementUnlocked('WeekDsideVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('weekIniquitous_Beaten')
			// Shop Songs
			&& Achievements.isAchievementUnlocked('tofu_Beaten') && Achievements.isAchievementUnlocked('marcochrome_Beaten') 
			&& Achievements.isAchievementUnlocked('lustality_Beaten') && Achievements.isAchievementUnlocked('lustalityV1_Beaten')
			&& Achievements.isAchievementUnlocked('nunsational_Beaten')
			&& Achievements.isAchievementUnlocked('FNV_Beaten') && Achievements.isAchievementUnlocked('short_Beaten')
			&& Achievements.isAchievementUnlocked('nic_Beaten') && Achievements.isAchievementUnlocked('fanfuck_Beaten')
			&& Achievements.isAchievementUnlocked('rainyDaze_Beaten') && Achievements.isAchievementUnlocked('marauder_Beaten')
			// Crossover Songs
			&& Achievements.isAchievementUnlocked('vGuy_Beaten') && Achievements.isAchievementUnlocked('fastFoodTherapy_Beaten')
			&& Achievements.isAchievementUnlocked('tacticalMishap_Beaten')
			&& Achievements.isAchievementUnlocked('breacher_Beaten') && Achievements.isAchievementUnlocked('concertChaos_Beaten')
			// Crossover Section
			&& Achievements.isAchievementUnlocked('crossover_Beaten')
			//Extras
			&& Achievements.isAchievementUnlocked('itsKiana_Beaten') && Achievements.isAchievementUnlocked('hermit_found')
			&& Achievements.isAchievementUnlocked('zeel_found')
			&& Achievements.isAchievementUnlocked('shop_completed') && Achievements.isAchievementUnlocked('flashbang')
			&& Achievements.isAchievementUnlocked('pervert') && Achievements.isAchievementUnlocked('pervertX25'))
			{
				var achieveAllID:Int = Achievements.getAchievementIndex('FNV_Completed');
				if((!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveAllID][2]))) {
					Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveAllID][2], true);
					giveAllAchievement();
					ClientPrefs.saveSettings();
				}
			}

		changeItem();

		//Notification alert
		//check if everything is unlocked for the crossover section, all weeks, all shop songs are beaten
		if (ClientPrefs.roadMapUnlocked == false && Achievements.isAchievementUnlocked('WeekMarco_Beaten')&& Achievements.isAchievementUnlocked('WeekNun_Beaten')
			&& Achievements.isAchievementUnlocked('WeekKiana_Beaten')&& Achievements.isAchievementUnlocked('WeekMorky_Beaten')
			&& Achievements.isAchievementUnlocked('WeekSus_Beaten')&& Achievements.isAchievementUnlocked('WeekLegacy_Beaten')
			&& Achievements.isAchievementUnlocked('WeekDside_Beaten')
			// Shop Songs
			&& ClientPrefs.tofuPlayed == true && ClientPrefs.lustalityPlayed == true && ClientPrefs.nunsationalPlayed == true && ClientPrefs.marcochromePlayed == true
			&& ClientPrefs.nicPlayed == true && Achievements.isAchievementUnlocked('short_Beaten') && ClientPrefs.debugPlayed == true && ClientPrefs.fnvPlayed == true
			&& ClientPrefs.infatuationPlayed == true && ClientPrefs.rainyDazePlayed == true
			&& ClientPrefs.crossoverUnlocked == false)
		{
			NotificationAlert.showMessage(this, 'Normal');
			NotificationAlert.sendCategoryNotification = true;
			NotificationAlert.saveNotifications();

			ClientPrefs.roadMapUnlocked = true;
			ClientPrefs.saveSettings();
		}

		// IF ALL SONGS ARE BEATEN, UNLOCK MAYHEM GAME MODE + NOTIFICATION
		if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && Achievements.isAchievementUnlocked('WeekNun_Beaten') && Achievements.isAchievementUnlocked('WeekKiana_Beaten')
			&& Achievements.isAchievementUnlocked('WeekMorky_Beaten') && Achievements.isAchievementUnlocked('WeekSus_Beaten') && Achievements.isAchievementUnlocked('WeekLegacy_Beaten')
			&& Achievements.isAchievementUnlocked('WeekDside_Beaten')
			// Shop Songs
			&& ClientPrefs.tofuPlayed == true && ClientPrefs.lustalityPlayed == true
			&& ClientPrefs.nunsationalPlayed == true && ClientPrefs.marcochromePlayed == true
			&& ClientPrefs.nicPlayed == true && Achievements.isAchievementUnlocked('short_Beaten')
			&& ClientPrefs.debugPlayed == true && ClientPrefs.fnvPlayed == true
			&& ClientPrefs.infatuationPlayed == true && ClientPrefs.rainyDazePlayed == true
			// Crossover Section
			&& Achievements.isAchievementUnlocked('crossover_Beaten'))
		{
			if (ClientPrefs.mayhemNotif == false)
			{
				ClientPrefs.mayhemNotif = true;
				NotificationAlert.showMessage(this, 'Mayhem');
				ClientPrefs.saveSettings();
			}
			allowMayhemGameMode = true;
		}

		// FOR INJECTION MODE
		if (ClientPrefs.weeksUnlocked >= 7 && ClientPrefs.injectionNotif == false)
		{
			ClientPrefs.injectionNotif = true;
			NotificationAlert.showMessage(this, 'Injection');
			ClientPrefs.saveSettings();
		}

		if (NotificationAlert.sendMessage == true)
		{
			NotificationAlert.showMessage(this, 'Normal');
			NotificationAlert.sendMessage = false;
			NotificationAlert.saveNotifications();
		}
		super.create();
	}

	// Unlocks "FNV_Completed" achievement
	function giveAllAchievement() {
		add(new AchievementObject('FNV_Completed', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "FNV_Completed"');
	}

	function changeBg(timer:FlxTimer)
		{
			if(isShown == false)
			{
				trace("Changing the Background");
				FlxTween.tween(bg, { alpha: 0 }, 3, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(bgChange, { alpha: 1 }, 3, {ease: FlxEase.cubeInOut, type: PERSIST});
				var bgTimerAgain:FlxTimer = new FlxTimer().start(10, changeBgAgain);
				new FlxTimer().start(4, function (tmr:FlxTimer) {
					if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true && ClientPrefs.kianaWeekPlayed == true)
						bg.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 59)));
					else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true)
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
			if(isShown == false)
			{
				trace("Changing the Background Again");
				FlxTween.tween(bg, { alpha: 1 }, 3, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(bgChange, { alpha: 0 }, 3, {ease: FlxEase.cubeInOut, type: PERSIST});
				var bgTimer:FlxTimer = new FlxTimer().start(10, changeBg);
				new FlxTimer().start(4, function (tmr:FlxTimer) {
					if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true && ClientPrefs.kianaWeekPlayed == true)
						bgChange.loadGraphic(Paths.image('mainMenuBgs/menu-' + FlxG.random.int(1, 59)));
					else if (Achievements.isAchievementUnlocked('WeekMarco_Beaten') && ClientPrefs.nunWeekPlayed == true)
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

	var tutorialNumber:Int = 0;
	var askedForInfo:Bool = false;
	var initializedVideo:Bool = false;
	
	var storySelected:Bool = false;
	var inventoryOpened:Bool = false;
	var openingShit:Bool = false;
	var applyStory:Bool = false;
	var allowInteraction:Bool = true;
	
	var warning:Bool = false;
	var warnMayhem:String = '';
	override function update(elapsed:Float)
	{
		BGchecker.x += 0.5*(elapsed/(1/120));
        BGchecker.y -= 0.16 / (ClientPrefs.framerate / 60); 

		lerpInjectedScore = Math.floor(FlxMath.lerp(lerpInjectedScore, intendedInjectedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedInjectedScore - lerpInjectedScore) < 10) lerpInjectedScore = intendedInjectedScore;

		lerpMayhemedScore = Math.floor(FlxMath.lerp(lerpMayhemedScore, intendedMayhemedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedMayhemedScore - lerpMayhemedScore) < 10) lerpMayhemedScore = intendedMayhemedScore;

		if (storyShit[curStorySelected] == 'injection')
			extraFinalScore.text = "SCORE: " + lerpInjectedScore;
		else
			extraFinalScore.text = "RECORD: " + ClientPrefs.mayhemEndScore + " Songs / Score" + lerpMayhemedScore;

	if (ClientPrefs.firstTime == true)
	{
		if(FlxG.mouse.overlaps(exclamationMark) && FlxG.mouse.justPressed)
		{
			MusicBeatState.switchState(new tutorial.TutorialState(), 'stickers');

			selectedSomethin = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));	
		}	

		//hover on things thing
		if (askedForInfo == false && (!selectedSomethin && !storySelected && !inventoryOpened))
		{
			if (FlxG.mouse.overlaps(shopButton))
				shopButton.alpha = 1;
			else
				shopButton.alpha = 0.5;
			if (FlxG.mouse.overlaps(discord))
				discord.alpha = 1;
			else
				discord.alpha = 0.5;
			if (FlxG.mouse.overlaps(exclamationMark))
				exclamationMark.alpha = 1;
			else
				exclamationMark.alpha = 0.5;
			if (FlxG.mouse.overlaps(optionsButton))
				optionsButton.alpha = 1;
			else
				optionsButton.alpha = 0.5;
			if (FlxG.mouse.overlaps(inventoryButton))
				inventoryButton.alpha = 1;
			else
				inventoryButton.alpha = 0.5;
		}

		if (FlxG.mouse.overlaps(discord) && FlxG.mouse.justPressed && askedForInfo == false && (!selectedSomethin && !storySelected && !inventoryOpened))
			//CoolUtil.browserLoad('https://discord.gg/7BvgW8RDuq'); Server doesn't exist at the moment.

		if (FlxG.mouse.overlaps(optionsButton) && FlxG.mouse.justPressed && askedForInfo == false && (!selectedSomethin && !storySelected && !inventoryOpened))
		{
			ClientPrefs.inMenu = true;
			selectedSomethin = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxFlicker.flicker(optionsButton, 1, 0.06, false, false, function(flick:FlxFlicker)
			{
				LoadingState.loadAndSwitchState(new options.OptionsState());
			});
		}

		if (FlxG.mouse.overlaps(leftArrow) && askedForInfo == false && selectedSomethin == false)
			FlxTween.tween(leftArrow, {x: getLeftArrowX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(leftArrow, {x: getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
	
		if (FlxG.mouse.overlaps(rightArrow) && askedForInfo == false && selectedSomethin == false)
			FlxTween.tween(rightArrow, {x: getRightArrowX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(rightArrow, {x: getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

		if ((controls.UI_RIGHT || (FlxG.mouse.overlaps(rightArrow) && FlxG.mouse.pressed)) && askedForInfo == false && storySelected == false)
			rightArrow.animation.play('press')
		else
			rightArrow.animation.play('idle');
	
		if ((controls.UI_LEFT || (FlxG.mouse.overlaps(leftArrow) && FlxG.mouse.pressed)) && askedForInfo == false && storySelected == false)
			leftArrow.animation.play('press');
		else
			leftArrow.animation.play('idle');
		
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if ((controls.UI_LEFT_P || (FlxG.mouse.overlaps(leftArrow) && FlxG.mouse.justPressed)) && askedForInfo == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
					
				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						spr.alpha = 0;
					} 
					else
					{
						spr.alpha = 1;
					}
				});
			}
	
			if ((controls.UI_RIGHT_P || (FlxG.mouse.overlaps(rightArrow) && FlxG.mouse.justPressed)) && askedForInfo == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						spr.alpha = 0;
					} 
					else
					{
						spr.alpha = 1;
					}
					});
			}

			if (controls.BACK || FlxG.mouse.justPressedRight)
			{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new TitleState());
			}

			if ((controls.ACCEPT || (FlxG.mouse.overlaps(transparentButton) && FlxG.mouse.justPressed)) && askedForInfo == false && allowInteraction == true)
			{
				if (optionShit[curSelected] == 'story_mode')
				{
					selectedSomethin = true;
					allowInteraction = false;
					storySelected = true;
					changeItem();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					storyStuffs.forEach(function(spr:FlxSprite)
					{
						FlxTween.tween(spr, {x: 597}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					});
					FlxTween.tween(blackOut, {alpha: 0.6}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(storySelection, {x: 1020}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(storyText, {alpha: 1}, 0.7, {ease: FlxEase.circOut, type: PERSIST, onComplete: function (twn:FlxTween) {
							allowInteraction = true;
						}
					});
					if (storyShit[curStorySelected] == 'injection')
					{
						FlxTween.tween(leftDiffArrow, {alpha: 1}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
						FlxTween.tween(sprDifficulty, {alpha: 1}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
						FlxTween.tween(rightDiffArrow, {alpha: 1}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					}
				}
				else if (optionShit[curSelected] == 'freeplay' && ClientPrefs.mainWeekBeaten == false)
				{
					FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (optionShit[curSelected] == 'gallery' && ClientPrefs.galleryUnlocked == false)
				{
					FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (optionShit[curSelected] == 'info' && ClientPrefs.mainWeekBeaten == false)
				{
					FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else
				{
					selectedSomethin = true;
					askedForInfo = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];
	
								switch (daChoice)
								{
									case 'story_mode':
										ClientPrefs.inMenu = false;
										MusicBeatState.switchState(new StoryMenuState());
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
					if (FlxG.keys.anyJustPressed(debugKeys))
						MusicBeatState.switchState(new MasterEditorMenu());
				#else
					if (FlxG.keys.anyJustPressed(debugKeys) && !initializedVideo)
					{
						selectedSomethin = true;
						if (FlxG.sound.music != null)
							FlxG.sound.music.stop();

						var achieveFlashBangID:Int = Achievements.getAchievementIndex('flashbang');
							if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveFlashBangID][2])) {
							Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveFlashBangID][2], true);
							giveFlashbangAchievement();
							ClientPrefs.saveSettings();
						}
			
						var video:MP4Handler = new MP4Handler();
						video.playVideo(Paths.video('thinkFastChucklenuts'));
						initializedVideo = true;
						video.finishCallback = function()
						{
							System.exit(0);
						};
					}
				#end
			#end
		}
		else
		{
			if (!applyStory && allowInteraction == true && inventoryOpened == false)
			{
				if (controls.BACK || FlxG.mouse.justPressedRight)
				{
					if (warning)
					{
						warning = false;
						FlxTween.tween(blackOut2, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
						FlxTween.tween(libidiWarning, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					}
					else if (storySelected)
					{
						allowInteraction = false;
						storySelected = false;
						selectedSomethin = false;
						FlxG.sound.play(Paths.sound('cancelMenu'));
						storyStuffs.forEach(function(spr:FlxSprite)
						{
							FlxTween.tween(spr, {x: 1697}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
						});
						FlxTween.tween(blackOut, {alpha: 0}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
						FlxTween.tween(storySelection, {x: 2020}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
						FlxTween.tween(storySelection, {alpha: 0.6}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
						FlxTween.tween(storyText, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST, onComplete: function (twn:FlxTween) {
								allowInteraction = true;
							}
						});
						FlxTween.tween(extraFinalScore, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
						FlxTween.tween(leftDiffArrow, {alpha: 0}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
						FlxTween.tween(sprDifficulty, {alpha: 0}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
						FlxTween.tween(rightDiffArrow, {alpha: 0}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
					}
				}
		
				if (!warning && askedForInfo == false)
				{
					if (controls.UI_LEFT_P)
					{
						changeItem(-1);
						FlxG.sound.play(Paths.sound('scrollMenu'));
					}
					if (controls.UI_RIGHT_P)
					{
						changeItem(1);
						FlxG.sound.play(Paths.sound('scrollMenu'));
					}

					if (storyShit[curStorySelected] == 'mayhem' && controls.RESET)
					{
						persistentUpdate = false;
						openSubState(new ResetScoreSubState('Mayhem Mode', -1, '', -1));
					}
					if (storyShit[curStorySelected] == 'injection' && controls.RESET)
					{
						persistentUpdate = false;
						openSubState(new ResetScoreSubState('Injection Mode', curDifficulty, '', -1));
					}

					if (storyShit[curStorySelected] == 'injection')
					{
						if ((FlxG.mouse.overlaps(rightDiffArrow) && FlxG.mouse.pressed))
							rightDiffArrow.animation.play('press');
						else
							rightDiffArrow.animation.play('idle');
						
						if ((FlxG.mouse.overlaps(leftDiffArrow) && FlxG.mouse.pressed))
							leftDiffArrow.animation.play('press');
						else
							leftDiffArrow.animation.play('idle');

						if ((FlxG.mouse.overlaps(rightDiffArrow) && FlxG.mouse.justPressed))
							changeDifficulty(1);
						
						if ((FlxG.mouse.overlaps(leftDiffArrow) && FlxG.mouse.justPressed))
							changeDifficulty(-1);
					}
				}

				if (FlxG.mouse.overlaps(storySelection) && askedForInfo == false)
					FlxTween.tween(storySelection, {alpha: 1}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
				else
					FlxTween.tween(storySelection, {alpha: 0.6}, 0.5, {ease: FlxEase.circOut, type: PERSIST});

				if ((controls.ACCEPT || (FlxG.mouse.overlaps(storySelection) && FlxG.mouse.justPressed)) && !warning && ((storyShit[curStorySelected] == 'injection' && curDifficulty == 1) || storyShit[curStorySelected] == 'mayhem'))
				{
					if (libidiPerformWarn == true)
					{
						warning = true;
						FlxG.sound.play(Paths.sound('scrollMenu'));
						trace('Loading Low Quality Warning!');
						
						FlxTween.tween(blackOut2, {alpha: 0.7}, 1.2, {ease: FlxEase.circOut, type: PERSIST});
						FlxTween.tween(libidiWarning, {alpha: 1}, 1.2, {ease: FlxEase.circOut, type: PERSIST});
					}
					else
					{
						loadExtraMode();
					}
				}
				else if (warning && ((storyShit[curStorySelected] == 'injection' && curDifficulty == 1) || storyShit[curStorySelected] == 'mayhem') && (FlxG.keys.justPressed.Y || FlxG.keys.justPressed.N))
				{
					loadExtraMode();
				}
				else if ((controls.ACCEPT || (FlxG.mouse.overlaps(storySelection) && FlxG.mouse.justPressed)) && askedForInfo == false 
					&& (storyShit[curStorySelected] == 'classic' || storyShit[curStorySelected] == 'iniquitous' || (storyShit[curStorySelected] == 'injection' && curDifficulty == 0)))
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
					else if (storyShit[curStorySelected] == 'mayhem' && (allowMayhemGameMode == false || warnMayhem != ''))
					{
						FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
						FlxG.sound.play(Paths.sound('accessDenied'));
					}
					else
					{
						ClientPrefs.lowQuality = false;
						if (storyShit[curStorySelected] == 'injection')
						{
							if (ClientPrefs.weeksUnlocked >= 7)
							{
								var songArray:Array<String> = [];
								for (i in 0...injectionSongs.length) {
									var injection:String = injectionSongs[i];
							
									if (curDifficulty == 0 && (injection != "villainy" && injection != "point-blank" && injection != "libidinousness" && injection != "excrete"))
										songArray.push(injection);
								}
								PlayState.injectionPlaylist = songArray;
							}
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
									ClientPrefs.resetStoryModeProgress(true);
									ClientPrefs.inMenu = false;
									PlayState.isInjectionMode = true;
									FlxG.mouse.visible = false;
	
									PlayState.injectionDifficulty = curDifficulty;
									PlayState.storyDifficulty = PlayState.injectionDifficulty;
									var diffic:String = CoolUtil.getDifficultyFilePath(curDifficulty);
									PlayState.SONG = Song.loadFromJson(PlayState.injectionPlaylist[0].toLowerCase() + diffic, PlayState.injectionPlaylist[0].toLowerCase());
									PlayState.campaignScore = 0;
									PlayState.campaignMisses = 0;
									
									PlayState.injectionRating = 0;
									PlayState.injectionScore = 0;
									PlayState.injectionMisses = 0;
									PlayState.injectionSongsPlayed = 0;
									PlayState.injectionPlaylistTotal = PlayState.injectionPlaylist.length;
	
									LoadingState.loadAndSwitchState(new PlayState(), true);
									FreeplayState.destroyFreeplayVocals();
							}
						});
					}
				}
			}	
		}

		if (controls.BACK || FlxG.mouse.justPressedRight)
		{
			if (inventoryOpened == true)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(BGchecker, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(blackOut, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(gfPocket, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				buffItems.forEach(function(buff:FlxSprite)
				{
					FlxTween.tween(buff, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				});
				FlxTween.tween(buffSelected, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(buffTitle, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(buffText, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(inventoryTitle, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				
				charmItems.forEach(function(charm:FlxSprite)
				{
					FlxTween.tween(charm, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				});
				FlxTween.tween(charmTitle, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(charmText, {alpha: 0}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				inventoryOpened = false;
				selectedSomethin = false;
			}
		}

		if ((FlxG.keys.pressed.I || (FlxG.mouse.overlaps(inventoryButton) && FlxG.mouse.justPressed)) && inventoryOpened == false && selectedSomethin == false)
		{
			openingShit = true;
			selectedSomethin = true;
			inventoryOpened = true;
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.6);
			FlxTween.tween(BGchecker, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});

			FlxTween.tween(blackOut, {alpha: 0.7}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(gfPocket, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			buffItems.forEach(function(buff:FlxSprite)
			{
				if (buff.ID == curBuffSelected)
					FlxTween.tween(buff, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				else
					FlxTween.tween(buff, {alpha: 0.2}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			});
			FlxTween.tween(buffSelected, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(buffTitle, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(buffText, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(inventoryTitle, {alpha: 0.7}, 0.6, {ease: FlxEase.circOut, type: PERSIST});

			charmItems.forEach(function(charm:FlxSprite)
			{
				if (charm.ID == curCharmSelected)
					FlxTween.tween(charm, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
				else
					FlxTween.tween(charm, {alpha: 0.2}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			});
			FlxTween.tween(charmTitle, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(charmText, {alpha: 1}, 0.6, {ease: FlxEase.circOut, type: PERSIST});

			new FlxTimer().start(0.6, function (tmr:FlxTimer) {
				openingShit = false;
			});

			switch(curBuffSelected)
			{
				case 0:
					buffText.text = "None";
					ClientPrefs.buff1Selected = false;
					ClientPrefs.buff2Selected = false;
					ClientPrefs.buff3Selected = false;
				case 1:
					buffText.text = "Health Regeneration";
					ClientPrefs.buff1Selected = true;
					ClientPrefs.buff2Selected = false;
					ClientPrefs.buff3Selected = false;
				case 2:
					buffText.text = "Second Chance";
					ClientPrefs.buff1Selected = false;
					ClientPrefs.buff2Selected = true;
					ClientPrefs.buff3Selected = false;
				case 3:
					buffText.text = "Immunity";
					ClientPrefs.buff1Selected = false;
					ClientPrefs.buff2Selected = false;
					ClientPrefs.buff3Selected = true;
			}
			ClientPrefs.saveSettings();
			switch(curCharmSelected)
			{
				case 0:
					if (ClientPrefs.resCharmCollected == false)
						charmText.text = "Locked";
					else
						charmText.text = "Resistance";
				case 1:
					if (ClientPrefs.autoCharmCollected == false)
						charmText.text = "Locked";
					else
						charmText.text = "Auto Dodge";
				case 2:
					if (ClientPrefs.healCharmCollected == false)
						charmText.text = "Locked";
					else
						charmText.text = "Healing";
			}
		}

		if (inventoryOpened == true && openingShit == false)
		{
			buffItems.forEach(function(buff:FlxSprite)
			{
				if (FlxG.mouse.overlaps(buff) && FlxG.mouse.justPressed && buff.ID == 0)
				{
					buffSelect(0);
				}
				if (FlxG.mouse.overlaps(buff) && FlxG.mouse.justPressed && buff.ID == 1)
				{
					if (ClientPrefs.buff1Unlocked == false)
						FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
					else
						buffSelect(1);
				}
				if (FlxG.mouse.overlaps(buff) && FlxG.mouse.justPressed && buff.ID == 2)
				{
					if (ClientPrefs.buff2Unlocked == false)
						FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
					else
						buffSelect(2);
				}
			if (FlxG.mouse.overlaps(buff) && FlxG.mouse.justPressed && buff.ID == 3)
				{
					if (ClientPrefs.buff3Unlocked == false)
						FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
					else
						buffSelect(3);
				}
			});

			charmItems.forEach(function(charm:FlxSprite)
				{
					if (FlxG.mouse.overlaps(charm) && FlxG.mouse.justPressed && charm.ID == 0)
					{
						if (ClientPrefs.resCharmCollected == false)
							FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
						else
							charmSelect(0);
					}
					if (FlxG.mouse.overlaps(charm) && FlxG.mouse.justPressed && charm.ID == 1)
					{
						if (ClientPrefs.autoCharmCollected == false)
							FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
						else
							charmSelect(1);
					}
					if (FlxG.mouse.overlaps(charm) && FlxG.mouse.justPressed && charm.ID == 2)
					{
						if (ClientPrefs.healCharmCollected == false)
							FlxG.sound.play(Paths.sound('cancelMenu'), 0.6);
						else
							charmSelect(2);
					}
				});
			
		}

		if (FlxG.mouse.overlaps(shopButton) && FlxG.mouse.justPressed && askedForInfo == false && ClientPrefs.inShop == false && (!selectedSomethin && !storySelected))
		{
			FlxG.sound.music.fadeOut(0.5);
			FlxG.sound.play(Paths.sound('scrollMenu'));
			ClientPrefs.inShop = true;
			MusicBeatState.switchState(new ShopState());
		}

		}
		super.update(elapsed);
	}

	function giveFlashbangAchievement() {
		add(new AchievementObject('flashbang', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "flashbang"');
	}

	function loadExtraMode()
	{
		if (storyShit[curStorySelected] == 'injection' && (ClientPrefs.weeksUnlocked < 7 || warnMayhem != ''))
		{
			FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
			FlxG.sound.play(Paths.sound('accessDenied'));
		}
		else if (storyShit[curStorySelected] == 'mayhem' && (allowMayhemGameMode == false || warnMayhem != ''))
		{
			FlxG.camera.shake(0.02, 0.5, null, false, FlxAxes.XY);
			FlxG.sound.play(Paths.sound('accessDenied'));
		}
		else
		{
			applyStory = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			if (FlxG.keys.justPressed.Y)
			{
				trace ('Low Quality Off!');
				ClientPrefs.lowQuality = false;
			}	
			else if (FlxG.keys.justPressed.N)
			{
				trace ('Low Quality On!');
				ClientPrefs.lowQuality = true;
			}
			ClientPrefs.saveSettings();

			FlxTween.tween(blackOut2, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			if (libidiPerformWarn == true)
				FlxTween.tween(libidiWarning, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

			if (storyShit[curStorySelected] == 'injection')
			{
				if (ClientPrefs.weeksUnlocked >= 7)
				{
					var songArray:Array<String> = [];
					for (i in 0...injectionSongs.length) {
						var injection:String = injectionSongs[i];

						if (curDifficulty == 1)
							songArray.push(injection);
					}
					PlayState.injectionPlaylist = songArray;
				}
			}
			if (storyShit[curStorySelected] == 'mayhem')
			{
				if (allowMayhemGameMode == true)
				{
					var songArray:Array<String> = [];
					for (i in 0...mayhemSongs.length) {
						var mayhem:String = mayhemSongs[i];
					
						songArray.push(mayhem);
					}
					PlayState.mayhemPlaylist = songArray;
				}
			}

			FlxFlicker.flicker(storySelection, 1, 0.06, false, false, function(flick:FlxFlicker)
			{
				switch(storyShit[curStorySelected])
				{
					case 'injection':
						ClientPrefs.resetStoryModeProgress(true);
						ClientPrefs.inMenu = false;
						PlayState.isInjectionMode = true;
						FlxG.mouse.visible = false;

						PlayState.injectionDifficulty = curDifficulty;
						PlayState.storyDifficulty = PlayState.injectionDifficulty;
						var diffic:String = CoolUtil.getDifficultyFilePath(curDifficulty);
						PlayState.SONG = Song.loadFromJson(PlayState.injectionPlaylist[0].toLowerCase() + diffic, PlayState.injectionPlaylist[0].toLowerCase());
						PlayState.campaignScore = 0;
						PlayState.campaignMisses = 0;
						
						PlayState.injectionRating = 0;
						PlayState.injectionScore = 0;
						PlayState.injectionMisses = 0;
						PlayState.injectionSongsPlayed = 0;
						PlayState.injectionPlaylistTotal = PlayState.injectionPlaylist.length;

						LoadingState.loadAndSwitchState(new PlayState(), true);
						FreeplayState.destroyFreeplayVocals();
					case 'mayhem':
						ClientPrefs.resetStoryModeProgress(true);
						ClientPrefs.inMenu = false;
						PlayState.isMayhemMode = true;
						PlayState.mayhemHealth = 150;
						PlayState.mayhemSongsPlayed = 0;
						PlayState.mayhemRating = 0;
						PlayState.mayhemScore = 0;
						PlayState.mayhemBestCombo = 0;
						PlayState.mayhemTotalChallenges = 0;
						FlxG.mouse.visible = false;

						CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();		
						curDifficulty = FlxG.random.int(0, 1);
						PlayState.mayhemDifficulty = curDifficulty;
						var diffic:String = CoolUtil.getDifficultyFilePath(curDifficulty);
									
						var songSelected:Int = FlxG.random.int(0, PlayState.mayhemPlaylist.length - 1);

						if (PlayState.mayhemPlaylist[songSelected] == 'toybox' || PlayState.mayhemPlaylist[songSelected] == "its-kiana" || PlayState.mayhemPlaylist[songSelected] == 'villainy' || PlayState.mayhemPlaylist[songSelected] == 'point-blank'
							|| PlayState.mayhemPlaylist[songSelected] == 'libidinousness' || PlayState.mayhemPlaylist[songSelected] == 'excrete' || PlayState.mayhemPlaylist[songSelected] == 'marauder' || PlayState.mayhemPlaylist[songSelected] == 'shucks-v2')
						{
							if (PlayState.mayhemPlaylist[songSelected] == 'libidinousness' && ClientPrefs.lowQuality == true)
								PlayState.SONG = Song.loadFromJson(PlayState.mayhemPlaylist[songSelected].toLowerCase() + '-villainousoptimized', PlayState.mayhemPlaylist[songSelected].toLowerCase());
							else if (PlayState.mayhemPlaylist[songSelected] == 'toybox' && ClientPrefs.mechanics == false)
								PlayState.SONG = Song.loadFromJson(PlayState.mayhemPlaylist[songSelected].toLowerCase() + '-villainousMechanicless', PlayState.mayhemPlaylist[songSelected].toLowerCase());
							else
								PlayState.SONG = Song.loadFromJson(PlayState.mayhemPlaylist[songSelected].toLowerCase() + '-villainous', PlayState.mayhemPlaylist[songSelected].toLowerCase());

							
							curDifficulty = 1;
							diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
						}
						else
						PlayState.SONG = Song.loadFromJson(PlayState.mayhemPlaylist[songSelected].toLowerCase() + diffic, PlayState.mayhemPlaylist[songSelected].toLowerCase());
						PlayState.campaignScore = 0;
						PlayState.campaignMisses = 0;

						if (PlayState.mayhemPlaylist[songSelected] == 'cheap-skate-(legacy)' || PlayState.mayhemPlaylist[songSelected] == 'toxic-mishap-(legacy)' || PlayState.mayhemPlaylist[songSelected] == 'paycheck-(legacy)') //Week Legacy
							PlayState.SONG.player1 = 'playablegf-old';
						if (PlayState.mayhemPlaylist[songSelected] == 'spendthrift') //Week Morky
							PlayState.SONG.player1 = 'Spendthrift GF';
						if (PlayState.mayhemPlaylist[songSelected] == 'its-kiana')
							PlayState.SONG.player1 = 'd-side gf';
							

						trace(Paths.formatToSongPath(PlayState.mayhemPlaylist[songSelected]) + diffic);

						LoadingState.loadAndSwitchState(new PlayState(), true);
						FreeplayState.destroyFreeplayVocals();
					}
				});
			}
	}

	var tweenDifficulty:FlxTween;
	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;
		if (Achievements.isAchievementUnlocked('weekIniquitous_Beaten')) // Allow EVERYTHING
		{
			if (curDifficulty < 0)
				curDifficulty = 1;
			if (curDifficulty > 1)
				curDifficulty = 0;
		}
		else
			curDifficulty = 0; //Uh oh! You didn't get the true ending to earn everything, you can only play in CASUAL for now!

		var diff:String = CoolUtil.difficulties[curDifficulty];
		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));
		//trace(Paths.currentModDirectory + ', menudifficulties/' + Paths.formatToSongPath(diff));
		
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

		if (curDifficulty == 1)
			intendedInjectedScore = ClientPrefs.injectionVilEndScore;
		else
			intendedInjectedScore = ClientPrefs.injectionEndScore;
	}

	function charmSelect(huh:Int = 0)
		{
			curCharmSelected = huh;
			charmItems.forEach(function(charm:FlxSprite)
			{
				if (curCharmSelected == charm.ID)
					charm.alpha = 1;
				else
					charm.alpha = 0.2;
	
				switch(curCharmSelected)
				{
					case 0:
						if (ClientPrefs.resCharmCollected == false)
							charmText.text = "Locked";
						else
							charmText.text = "Resistance";
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					case 1:
						if (ClientPrefs.resCharmCollected == false)
							charmText.text = "Locked";
						else
							charmText.text = "Auto Dodge";
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					case 2:
						if (ClientPrefs.resCharmCollected == false)
							charmText.text = "Locked";
						else
							charmText.text = "Healing";
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
				}
			});
		}

	function buffSelect(huh:Int = 0)
	{
		curBuffSelected = huh;
		buffItems.forEach(function(buff:FlxSprite)
		{
			if (curBuffSelected == buff.ID)
				buff.alpha = 1;
			else
				buff.alpha = 0.2;

			switch(curBuffSelected)
			{
				case 0:
					buffText.text = "None";
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					ClientPrefs.buff1Selected = false;
					ClientPrefs.buff2Selected = false;
					ClientPrefs.buff3Selected = false;
				case 1:
					buffText.text = "Health Regeneration";
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					ClientPrefs.buff1Selected = true;
					ClientPrefs.buff2Selected = false;
					ClientPrefs.buff3Selected = false;
				case 2:
					buffText.text = "Second Chance";
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					ClientPrefs.buff1Selected = false;
					ClientPrefs.buff2Selected = true;
					ClientPrefs.buff3Selected = false;
				case 3:
					buffText.text = "Immunity";
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
					ClientPrefs.buff1Selected = false;
					ClientPrefs.buff2Selected = false;
					ClientPrefs.buff3Selected = true;
			}
		});
			ClientPrefs.saveSettings();
		buffSelected.x = buffItems.members[curBuffSelected].x;
	}

	
	function changeItem(huh:Int = 0)
	{
		if (storySelected == false && inventoryOpened == false)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
	
			menuItems.forEach(function(spr:FlxSprite)
			{
				spr.animation.play('idle');
				spr.updateHitbox();
	
				if (spr.ID == curSelected)
				{
					if (optionShit[curSelected] == 'freeplay' && ClientPrefs.mainWeekBeaten == false)
						spr.animation.play('locked');
					else if (optionShit[curSelected] == 'gallery' && ClientPrefs.galleryUnlocked == false)
						spr.animation.play('locked');
					else if (optionShit[curSelected] == 'info' && ClientPrefs.mainWeekBeaten == false)
						spr.animation.play('locked');
					else
						spr.animation.play('selected');
					var add:Float = 0;
					if(menuItems.length > 4) {
						add = menuItems.length * 8;
					}
					camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
					spr.centerOffsets();
				}
			});
		}
		else
		{
			curStorySelected += huh;

			if (curStorySelected >= storyShit.length)
				curStorySelected = 0;
			if (curStorySelected < 0)
				curStorySelected = storyShit.length - 1;

			if (storyShit[curStorySelected] == 'injection')
				changeDifficulty();
			else
				intendedMayhemedScore = ClientPrefs.mayhemEndTotalScore;

			storySelection.text = storyShit[curStorySelected];
			if (storyShit[curStorySelected] == 'injection' || storyShit[curStorySelected] == 'mayhem')
				extraFinalScore.alpha = 1;
			else
				extraFinalScore.alpha = 0;

			switch (storyShit[curStorySelected])
			{
				case 'classic':
					storyText.text = "Experience FNV in all it's <G>glory<G>!\nPlay through various <R>w<R><GR>e<GR><Y>e<Y><B>k<B><DP>s<DP>,\nall packed with <G>juicy content!<G>";
					storyText.color = 0xFFffffff;
					storyText.y = 300;

					CustomFontFormats.addMarkers(storyText);

					sprDifficulty.alpha = 0;
					leftDiffArrow.alpha = 0;
					rightDiffArrow.alpha = 0;
				case 'iniquitous':
					if (Achievements.isAchievementUnlocked('weekIniquitous_Beaten') && Achievements.isAchievementUnlocked('WeekMarcoIniquitous_Beaten')
						&& Achievements.isAchievementUnlocked('WeekNunIniquitous_Beaten') && Achievements.isAchievementUnlocked('WeekKianaIniquitous_Beaten'))
						storyText.text = "Do you dare oppose your <DR_>wrath?<DR_>";
					else if (Achievements.isAchievementUnlocked('weekIniquitous_Beaten'))
						storyText.text = "Do you dare oppose his <DR_>wrath?<DR_>";
					else
						storyText.text = "Defeat <DR_>ME<DR_> first.";
					storyText.color = 0xFFff0000;
					storyText.y = 325;

					CustomFontFormats.addMarkers(storyText);

					sprDifficulty.alpha = 0;
					leftDiffArrow.alpha = 0;
					rightDiffArrow.alpha = 0;
				case 'injection':
					if (ClientPrefs.weeksUnlocked >= 7)
					{
						warnMayhem = ""; //Reset this every time!!! idk use this again to not make 2 variables bru
						if (ClientPrefs.getGameplaySetting('practice', false) || ClientPrefs.getGameplaySetting('botplay', false))
							warnMayhem += 'Botplay and/or Practice Mode\n';
						if (ClientPrefs.mechanics == false)
							warnMayhem += 'Mechanics\n';
						if (ClientPrefs.optimizationMode == true)
							warnMayhem += 'Optimization Mode';
						if (warnMayhem == '')
						{
							storyText.text = "Play through the Main Game\nin <GR>ONE attempt<GR>!!\n<P>Health<P> and <G>Score<G> gets saved\nalong the way!\nTry not to lose,\nor you <R_>lose your progress<R_>!";
							storyText.y = 265;

							CustomFontFormats.addMarkers(storyText);
						}
						else
						{
							storyText.text = "You can't access this mode.\nPlease disable the following: <R_>\n" + warnMayhem + "<R_>";
							storyText.y = 310;

							CustomFontFormats.addMarkers(storyText);
						} 
					}
					else
					{
						storyText.text = "Beat <G>ALL MAIN\nAND BONUS WEEKS<G> to\nunlock this mode!";
						storyText.y = 310;

						CustomFontFormats.addMarkers(storyText);
					}
					sprDifficulty.alpha = 1;
					leftDiffArrow.alpha = 1;
					rightDiffArrow.alpha = 1;
					storyText.color = 0xFFffffff;
					
				case 'mayhem':
					if (allowMayhemGameMode == true)
					{
						warnMayhem = ""; //Reset this every time!!!
						if (ClientPrefs.getGameplaySetting('practice', false) || ClientPrefs.getGameplaySetting('botplay', false))
							warnMayhem += 'Botplay and/or Practice Mode\n';
						if (ClientPrefs.mechanics == false)
							warnMayhem += 'Mechanics\n';
						if (ClientPrefs.optimizationMode == true)
							warnMayhem += 'Optimization Mode';

						if (warnMayhem == '')
						{
							storyText.text = "Go through as many\nsongs as you can with\na set amount of <P>health<P>!\nTry to last as long as you can,\nwhilst <R>challenges<R> are\nthrown at you!
							\n<G>TIP<G>: Press <GR>TAB<GR>\nto view your challenge(s)!";
							storyText.y = 200;

							CustomFontFormats.addMarkers(storyText);
						}
						else
						{
							storyText.text = "You can't access this mode.\nPlease disable the following: <R_>\n" + warnMayhem + "<R_>";
							storyText.y = 310;

							CustomFontFormats.addMarkers(storyText);
						}
					}	
					else
					{
						storyText.text = "Beat <G>ALL SONGS<G>\nto unlock this mode!";
						storyText.y = 310;

						CustomFontFormats.addMarkers(storyText);
					}
					sprDifficulty.alpha = 0;
					leftDiffArrow.alpha = 0;
					rightDiffArrow.alpha = 0;
					storyText.color = 0xFFffffff;
			}
			storyStuffs.forEach(function(spr:FlxSprite)
			{
				if (spr.ID == curStorySelected)
					spr.alpha = 1;
				else
					spr.alpha = 0;
			});
		}
	}
}
