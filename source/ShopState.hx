package;

import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.text.FlxTypeText;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;

import editors.ChartingState;
import flixel.addons.display.FlxGridOverlay;
import openfl.utils.Assets as OpenFlAssets;
import Achievements;
import WeekData;

import flash.system.System;

class ShopState extends MusicBeatState
{
	private var camAchievement:FlxCamera;

	//NORMAL SHOP ASSETS
	//Initial things
	var bg:FlxSprite;
	var background:FlxSprite;
	var closedShop:FlxSprite;
	var bulb:FlxSprite;
	var transitionOoooOo:FlxSprite;
	var showcaseDialogue:FlxTypeText;
	var showcaseSecretDialogue:FlxTypeText;
	var firstTime:Bool = false;
	var pressedEnter:Int = 0;
	var blackOut:FlxSprite;

	var luckOptionSlots:FlxTypedGroup<FlxSprite>;

	//Dialogue
	var dialogueNumber:Int = 0;
	var dialogueText:FlxText;
	var merchantDialogue:FlxTypeText;
	var assistant:FlxSprite;
	var assistNum:Int = 0;

	//Items
	var prizeSelected:Int = -1;
	var prizeSlots:FlxTypedGroup<FlxSprite>;
	var prizeBoard:Array<Dynamic> = // X, Y, Name
	[
		[50, 160, "prize_1"], // Prize 1 (Legacy Week)
		[250, 160, "prize_2"], // Prize 2 (Nunsational)
		[450, 160, "prize_3"], // Prize 3 (Lustalities)
		[650, 160, "prize_4"], // Prize 4 (Tofu)
		[850, 160, "prize_5"], // Prize 5 (Marcochrome)
		[1050, 160, "prize_8"], // Prize 6 (Joke Week)
		[50, 160, "prize_9"], // Prize 7 (FNV)
		[250, 160, "prize_10"], // Prize 8 (Jerry)
		[450, 160, "prize_11"], // Prize 9 (Slow.FLP)
		[650, 160, "prize_14"], // Prize 10 (FanFuck Forever)
		[850, 160, "prize_15"], // Prize 11 (Rainy Daze)
		[50, 260, "prize_16"], // Prize 12 (Marauder)
		[250, 260, "prize_17"], // Prize 13 (Sus Week)
		[450, 260, "prize_18"], // Prize 14 (D-sides Week)
		[650, 260, "prize_Zeel"], // Prize 15 (Zeel)
		[850, 260, "prize_Trampoline"], // Prize 16 (Trampoline)
		[1050, 260, "prize_Egg"], // Prize 17 (Egg)
		[50, 315, "prize_7"], // Prize 18 (R.Charm) -> Number 7
		[1050, 160, "prize_12"], // Prize 19 (A.Charm) -> Number 12
		[1050, 160, "prize_19"], // Prize 20 (H.Charm) -> Number 19
	];

	//Pool Section Assets
	var infoText:FlxText;
	var infoTitle:FlxText;
	var lights:FlxSprite;

	//Test Your Luck Assets
	var testYourLuckBG:FlxSprite;
	var tokenShow:FlxText;
	var choice:FlxSprite;
	var spaceText:FlxSprite;
	var testLuckButton:FlxSprite;
	var notEnoughTokensText:FlxSprite;
	var flickerTween:FlxTween;


	//SECRET SHOP ASSETS
	//Initial things
	var backgroundSecret:FlxSprite;
	var sellSlots:FlxTypedGroup<FlxSprite>;
	var booba:FlxSprite;
	var assistantSecret:FlxSprite;

	//Dialogue
	var dialogueNumberSecret:Int = 0;
	var dialogueTextSecret:FlxText;
	var secretMerchantDialogue:FlxTypeText;

	//Purchasable Items Section
	var buyItemsBG:FlxSprite;
	var buy:FlxSprite;
	var equipped:FlxSprite;

	//Video Sprites
	var videoDone:Bool = false;
	var initializedVideo:Bool = false;

	var mobilePositions:Array<Float> = [];

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Inside the Shops", null);
		#end

		ClientPrefs.choiceSelected = false;
		ClientPrefs.luckSelected = false;
		ClientPrefs.sellSelected = false;
		ClientPrefs.itemInfo = false;

		//testing purposes
	    
		//Weeks
		/*
		ClientPrefs.nunWeekFound = false;
		ClientPrefs.nunWeekPlayed = false;
		ClientPrefs.kianaWeekFound = false;
		ClientPrefs.kianaWeekPlayed = false;
		ClientPrefs.morkyWeekPlayed = false;
		ClientPrefs.morkyWeekFound = false;
		ClientPrefs.susWeekFound = false;
		ClientPrefs.susWeekPlayed = false;
		ClientPrefs.dsideWeekFound = false;
		ClientPrefs.dsideWeekPlayed = false;
		ClientPrefs.legacyWeekFound = false;
		ClientPrefs.legacyWeekPlayed = false;

		//Songs
		ClientPrefs.nunsationalPlayed = false;
		ClientPrefs.nunsationalFound = false;
		ClientPrefs.lustalityFound = false;
		ClientPrefs.lustalityPlayed = false;
		ClientPrefs.tofuFound = false;
		ClientPrefs.tofuPlayed = false;
		ClientPrefs.marcochromePlayed = false;
		ClientPrefs.marcochromeFound = false;
		ClientPrefs.fnvFound = false;
		ClientPrefs.fnvPlayed = false;
		ClientPrefs.shortFound = false;
		ClientPrefs.shortPlayed = false;
		ClientPrefs.nicFound = false;
		ClientPrefs.nicPlayed = false;
		ClientPrefs.infatuationFound = false;
		ClientPrefs.infatuationPlayed = false;
		ClientPrefs.rainyDazeFound = false;
		ClientPrefs.rainyDazePlayed = false;
		ClientPrefs.debugFound = false;
		ClientPrefs.debugPlayed = false;
		
		
		//Shop First time Showcases
		ClientPrefs.zeelNakedPics = false;
		ClientPrefs.shopShowcased = false;
		ClientPrefs.secretShopShowcased = false;
		ClientPrefs.talkedToZeel = false;
		ClientPrefs.saveSettings();
		*/

		FlxG.sound.playMusic(Paths.music('shopTheme'), 0);
		FlxG.sound.music.fadeIn(3.0); 

		for (i in 0...prizeBoard.length)
		{
			prizeBoard[i][0] = MobileUtil.fixX(prizeBoard[i][0]);
			prizeBoard[i][1] = MobileUtil.fixY(prizeBoard[i][1]);
		}

		if(!ClientPrefs.shopUnlocked)
		{
			closedShop = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/shopClosed'));
			closedShop.antialiasing = ClientPrefs.globalAntialiasing;
			closedShop.setGraphicSize(FlxG.width, FlxG.height);
			closedShop.screenCenter(X);
			add(closedShop);
		}
		else
		{
			FlxG.sound.play(Paths.sound('shop/shopEnter'), 0.7);
			dialogueNumber = FlxG.random.int(1, 8);

			//persistentUpdate = persistentDraw = true;
			bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
			bg.screenCenter();
			add(bg);

			transitionOoooOo = new FlxSprite(MobileUtil.fixX(-1370), 0).loadGraphic(Paths.image('shop/transition'));
			transitionOoooOo.antialiasing = ClientPrefs.globalAntialiasing;
			transitionOoooOo.scale.x = 1.5;
			add(transitionOoooOo);
			
			background = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/Background'));
			background.setGraphicSize(FlxG.width, FlxG.height);
			background.screenCenter(X);
			background.antialiasing = ClientPrefs.globalAntialiasing;
			add(background);

			luckOptionSlots = new FlxTypedGroup<FlxSprite>();
			add(luckOptionSlots);

			for (i in 0...3)
			{
				var button:FlxSprite = new FlxSprite(MobileUtil.fixX(0), MobileUtil.fixY(0)).loadGraphic(Paths.image('shop/Buttons'));
				button.frames = Paths.getSparrowAtlas('shop/Buttons');
				button.antialiasing = ClientPrefs.globalAntialiasing;
				button.ID = i;
				button.animation.addByPrefix('shine', 'slot ' + (i + 1), 24, true);
				if (i > 0)
					button.animation.addByPrefix('locked', 'locked slot ' + (i + 1), 24, true);
				
				button.screenCenter();
				button.updateHitbox();
				luckOptionSlots.add(button);
				switch(i)
				{
					case 0:
						button.animation.play('shine');
						button.x += 350;
						button.y -= 200;
					case 1:
						if (ClientPrefs.nunWeekPlayed)
						{	
							button.animation.play('shine');
							button.x += 350;
						}
						else
						{
							button.animation.play('locked');
							button.x += 355;
						}	
						button.y -= 10;	
					
					case 2:
						if (ClientPrefs.kianaWeekPlayed)
						{
							button.animation.play('shine');
							button.x += 350;
						}
						else
						{
							button.animation.play('locked');
							button.x += 355;
						}
						button.y += 180;		
				}
			}

			assistNum = FlxG.random.int(1, 3);
			assistant = new FlxSprite(0, 110).loadGraphic(Paths.image('shop/Mimiko Merchant'));//put your cords and image here
			assistant.frames = Paths.getSparrowAtlas('shop/Mimiko Merchant');//here put the name of the xml
			assistant.animation.addByPrefix('idleMain', 'mimiko idle ' + assistNum + '0', 24, true);//on 'idle normal' change it to your xml one
			assistant.animation.addByPrefix('talkMain', 'mimiko talk ' + assistNum + '0', 24, true);//on 'idle normal' change it to your xml one
			assistant.animation.play('talkMain');//you can rename the anim however you want to
			switch (assistNum)
			{
				case 1:
					assistant.offset.set(96, 3); //Talk 1
				case 2:
					assistant.offset.set(8, -1); //Talk 2
				case 3:
					assistant.offset.set(0, 5); //Talk 3
			}
			assistant.scrollFactor.set();
			assistant.antialiasing = ClientPrefs.globalAntialiasing;
			add(assistant);

			bulb = new FlxSprite(-430, -10).loadGraphic(Paths.image('shop/bulb'));//put your cords and image here
			bulb.frames = Paths.getSparrowAtlas('shop/bulb');//here put the name of the xml
			bulb.animation.addByPrefix('swing', 'swing', 13, true);//on 'idle normal' change it to your xml one
			bulb.animation.play('swing');//you can rename the anim however you want to
			bulb.scrollFactor.set();
			bulb.antialiasing = ClientPrefs.globalAntialiasing;
			add(bulb);

			//dialogue
			dialogueText = new FlxText(0, 0, FlxG.width, "", 32);

			merchantDialogue = new FlxTypeText(0, 0, 600, "Hey there, Welcome to my shop.", 32, true);
			merchantDialogue.font = 'VCR OSD Mono';
			merchantDialogue.color = FlxColor.WHITE;
			merchantDialogue.alignment = CENTER;
			merchantDialogue.borderStyle = OUTLINE;
			merchantDialogue.borderColor = FlxColor.BLACK;
			merchantDialogue.borderSize = 3;
			merchantDialogue.setTypingVariation(0.55, true);
			merchantDialogue.sounds = [FlxG.sound.load(Paths.sound('shopDialogue'), 0.6)];
			add(merchantDialogue);

			//All Prizes
			prizeSlots = new FlxTypedGroup<FlxSprite>();

			for (i in 0...20)
			{
				var prize:FlxSprite = new FlxSprite(prizeBoard[i][0], prizeBoard[i][1] + 1010).loadGraphic(Paths.image('shop/prizes/' + prizeBoard[i][2]));
				prize.antialiasing = ClientPrefs.globalAntialiasing;
				prize.ID = i;
				prizeSlots.add(prize);	
			}

			infoTitle = new FlxText(-10, 130, FlxG.width,
				"A",
				32);
			infoTitle.setFormat("VCR OSD Mono", 60, FlxColor.WHITE, CENTER);
			infoTitle.alpha = 0;

			infoText = new FlxText(250, 280, FlxG.width- 200,
				"testing lmao",
				25);
			infoText.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, LEFT);
			infoText.alpha = 0;

	
			//Test Your Luck Assets preparation
			testYourLuckBG = new FlxSprite(MobileUtil.fixX(1600), 0).loadGraphic(Paths.image('shop/testYourLuckBG1'));
			testYourLuckBG.antialiasing = ClientPrefs.globalAntialiasing;
			testYourLuckBG.scale.x = 1.1;
			mobilePositions.push(testYourLuckBG.x);
			add(testYourLuckBG);
			

			tokenShow = new FlxText(MobileUtil.fixX(820), 335, FlxG.width,
				"Tokens: " + ClientPrefs.tokens,
				32);
			tokenShow.setFormat("VCR OSD Mono", 60, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
			tokenShow.x += 1900;
			tokenShow.borderSize = 5;
			mobilePositions.push(tokenShow.x);
			CustomFontFormats.addMarkers(tokenShow);
			add(tokenShow);

			mobilePositions.push(background.x);

			choice = new FlxSprite(MobileUtil.fixX(460), 280).loadGraphic(Paths.image('shop/prizes/prize_' + FlxG.random.int(1, 14)));
			choice.antialiasing = ClientPrefs.globalAntialiasing;
			choice.scale.x = 2.1;
			choice.scale.y = 2.1;
			choice.x += 1400;
			add(choice);

			lights = new FlxSprite(MobileUtil.fixX(1580), 180).loadGraphic(Paths.image('shop/lights'));//put your cords and image here
			lights.frames = Paths.getSparrowAtlas('shop/lights');//here put the name of the xml
			//lights.scale.set(1.1, 1.1);
			lights.animation.addByPrefix('redlightsFlash', 'redLights0', 24, true);//on 'idle normal' change it to your xml one
			lights.animation.addByPrefix('greenlightsFlash', 'greenLights0', 24, true);
			lights.animation.addByPrefix('bluelightsFlash', 'blueLights0', 24, true);
			lights.animation.play('redlightsFlash');//you can rename the anim however you want to
			lights.scrollFactor.set();
			lights.antialiasing = ClientPrefs.globalAntialiasing;
			add(lights);
		
			testLuckButton = new FlxSprite(MobileUtil.fixX(330), 550).loadGraphic(Paths.image('shop/testLuckButton'));
			testLuckButton.antialiasing = ClientPrefs.globalAntialiasing;
			testLuckButton.x += 1400;
			add(testLuckButton);

			spaceText = new FlxSprite(MobileUtil.fixX(630), 550).loadGraphic(Paths.image('shop/pressSpace'));
			spaceText.antialiasing = ClientPrefs.globalAntialiasing;
			spaceText.alpha = 0;
			spaceText.x += 1400;
			add(spaceText);

			notEnoughTokensText = new FlxSprite(MobileUtil.fixX(630), 550).loadGraphic(Paths.image('shop/notEnoughTokens'));
			notEnoughTokensText.antialiasing = ClientPrefs.globalAntialiasing;
			notEnoughTokensText.alpha = 0;
			notEnoughTokensText.x += 1400;
			add(notEnoughTokensText);
			
		//SECRET SHOP ASSETS
		backgroundSecret = new FlxSprite(MobileUtil.fixX(0), 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		backgroundSecret.antialiasing = ClientPrefs.globalAntialiasing;
		backgroundSecret.x -= 2000;
		add(backgroundSecret);

		assistantSecret = new FlxSprite(MobileUtil.fixX(0), 205).loadGraphic(Paths.image('shop/Liz Shopper'));//put your cords and image here
		assistantSecret.frames = Paths.getSparrowAtlas('shop/Liz Shopper');//here put the name of the xml
		assistantSecret.scale.set(1.2, 1.2);
		assistantSecret.x -= 2000;
		assistantSecret.animation.addByPrefix('liz', 'Liz idle0', 24, true);//on 'idle normal' change it to your xml one
		assistantSecret.animation.addByPrefix('talking', 'Liz talk0', 24, true);//on 'idle normal' change it to your xml one
		assistantSecret.animation.addByPrefix('whyutouchbooba', 'Liz pissed0', 24, true);//on 'idle normal' change it to your xml one
		assistantSecret.scrollFactor.set();
		assistantSecret.updateHitbox();
		assistantSecret.antialiasing = ClientPrefs.globalAntialiasing;
		add(assistantSecret);

		endingSecret();

		booba = new FlxSprite(MobileUtil.fixX(0), 0).loadGraphic(Paths.image('shop/thatBoobaHitbox'));
		booba.screenCenter();
		booba.scale.set(1.25, 1.25);
		booba.alpha = 0;
		booba.x -= 2130;
		booba.y += 160;
		booba.updateHitbox();
		add(booba);

		sellSlots = new FlxTypedGroup<FlxSprite>();
		add(sellSlots);

		for (i in 0...3)
		{
			var locked:Bool = false;
			if ((i == 1 && !ClientPrefs.nunWeekPlayed) || (i == 2 && !ClientPrefs.kianaWeekPlayed))
				locked = true;

			var button:FlxSprite = new FlxSprite(MobileUtil.fixX(0), 0).loadGraphic(Paths.image('shop/sellOption' + (i + 1) + ((locked) ? "locked" : "")));
			button.antialiasing = ClientPrefs.globalAntialiasing;
			button.ID = i;
			button.scale.set(0.6, 0.6);
			button.screenCenter();
			button.updateHitbox();
			sellSlots.add(button);
			button.x -= 2620;

			switch(i)
			{
				case 0:
					button.y -= 80;
				case 1:
					button.y += 80;
				case 2:
					button.y += 250;		
			}
		}

		//dialogue
		dialogueTextSecret = new FlxText(0, 0, FlxG.width, "", 32);

		if (ClientPrefs.secretShopShowcased == false)
			secretMerchantDialogue = new FlxTypeText(-130, 30, 600, "Oh hello there! [Tap To Continue]", 32, true);
		else
			secretMerchantDialogue = new FlxTypeText(-130, 30, 800, "Hey there, looks like you have finally found your way here!", 32, true);
		secretMerchantDialogue.font = 'VCR OSD Mono';
		secretMerchantDialogue.color = FlxColor.WHITE;
		secretMerchantDialogue.alignment = CENTER;
		secretMerchantDialogue.x -= 2000;
		secretMerchantDialogue.setTypingVariation(0.55, true);
		secretMerchantDialogue.sounds = [FlxG.sound.load(Paths.sound('shopDialogue'), 0.6)];
		add(secretMerchantDialogue);

		if (ClientPrefs.secretShopShowcased == false)
			showcaseSecretDialogue = new FlxTypeText(-130, 30, 600, "Oh hello there! [Tap To Continue]", 32, true);
		else
			showcaseSecretDialogue = new FlxTypeText(-130, 30, 800, "Hey there, looks like you have finally found your way here!", 32, true);
		showcaseSecretDialogue.font = 'VCR OSD Mono';
		showcaseSecretDialogue.color = FlxColor.WHITE;
		showcaseSecretDialogue.alignment = CENTER;
		showcaseSecretDialogue.x -= 2000;
		showcaseSecretDialogue.setTypingVariation(0.55, true);
		showcaseSecretDialogue.sounds = [FlxG.sound.load(Paths.sound('shopDialogue'), 0.6)];
		add(showcaseSecretDialogue);

		//buy Items Asset Preparation
		buyItemsBG = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/buyItemsBG'));
		buyItemsBG.antialiasing = ClientPrefs.globalAntialiasing;
		buyItemsBG.setGraphicSize(FlxG.width, FlxG.height);
		buyItemsBG.screenCenter(X);
		buyItemsBG.y += 800;
		add(buyItemsBG);

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 0;
		add(blackOut);

		buy = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/buy'));
		buy.antialiasing = ClientPrefs.globalAntialiasing;
		buy.screenCenter(X);
		buy.x -= 50;
		buy.y += 820;
		buy.scale.set(1.3, 1.3);
		buy.updateHitbox();

		equipped = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/equipped'));
		equipped.antialiasing = ClientPrefs.globalAntialiasing;
		equipped.screenCenter(X);
		equipped.x -= 50;
		equipped.y += 820;
		equipped.scale.set(1.3, 1.3);
		equipped.updateHitbox();

		add(prizeSlots);
		add(infoTitle);	
		add(infoText);
		add(equipped);
		add(buy);

		FlxTween.tween(buy, {y: 820}, 0.1, {ease: FlxEase.cubeInOut, type: PERSIST});
		FlxTween.tween(equipped, {y: 820}, 0.1, {ease: FlxEase.cubeInOut, type: PERSIST});

		//ONLY FOR WHEN YOU ACCESS THE SHOP FOR THE FIRST TIME!
		if (!ClientPrefs.shopShowcased && !firstTime)
		{
			showcaseDialogue = new FlxTypeText(0, 0, 600, "OH! ANOTHER CUSTOMER!\n[Tap To Continue]", 32, true);
			showcaseDialogue.font = 'VCR OSD Mono';
			showcaseDialogue.color = FlxColor.WHITE;
			showcaseDialogue.alignment = CENTER;
			showcaseDialogue.borderStyle = OUTLINE;
			showcaseDialogue.borderColor = FlxColor.BLACK;
			showcaseDialogue.borderSize = 3;
			showcaseDialogue.setTypingVariation(0.55, true);
			showcaseDialogue.sounds = [FlxG.sound.load(Paths.sound('shopDialogue'), 0.6)];
			add(showcaseDialogue);	

			assistant.animation.play('talkMain');
			switch (assistNum)
			{
				case 1:
					assistant.offset.set(96, 3); //Talk 1
				case 2:
					assistant.offset.set(8, -1); //Talk 2
				case 3:
					assistant.offset.set(0, 5); //Talk 3
			}
			showcaseDialogue.start(0.04, true, ending);
			firstTime = true;
		}
		else
			merchantDialogue.start(0.04, true, ending);
		}

		Achievements.loadAchievements();

		super.create();

		addTouchPad("LEFT_FULL", "B");
	}

	var pressedBack:Bool = false;
	var pressedSpace:Bool = false;
	var tokensRunOut:Bool = false;
	var choiceNumber:Int = 0;
	var ended:Bool = true;
	var done:Bool = true;
	var gtfo:Bool = false;

	var shelfSelected:Int = 0;

	//SECRET SHOP VARIABLES FOR UPDATE
	var changedShop:Bool = false;
	var secretFirstTime:Bool = false;
	var secretShopAccessed:Bool = false;
	var questionShow:Bool = false;
	var pressedNo:Bool = false;

	//Zeel's other achievements
	var touchedBoobies:Int = 0;

	//For the Charms
	var canGoBack:Bool = false;

	//Cellar Shop
	var cellarShopAccessed:Bool = false;
	var cellarShopActive:Bool = false;

	override function update(elapsed:Float)
	{
		if (!ClientPrefs.shopUnlocked)
		{
			if (FlxG.keys.justPressed.BACKSPACE || controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxG.sound.music.fadeOut(0.4);
				MusicBeatState.switchState(new MainMenuState());
			}
					
			//run a timer in case said person does not press backspace.
			new FlxTimer().start(5, function (tmr:FlxTimer) {
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxG.sound.music.fadeOut(0.4);
				MusicBeatState.switchState(new MainMenuState());
			});
		}
		else if (!ClientPrefs.shopShowcased)
		{
			if (controls.ACCEPT || TouchUtil.pressAction())
			{
				trace ("Pressed Enter : " + pressedEnter);
				switch (assistNum)
				{
					case 1:
						assistant.offset.set(96, 3); //Talk 1
					case 2:
						assistant.offset.set(8, -1); //Talk 2
					case 3:
						assistant.offset.set(0, 5); //Talk 3
				}
				switch (pressedEnter)
				{
					case 0:
						dialogueText.text = "Greetings Good person! My name is Mimiko, and I am a travelling merchant!\n[Tap To Continue]";
					case 1:
						dialogueText.text = "Instead of selling stuff, you can win everything you want via gambling on my Prize Machines!\n[Tap To Continue]";
					case 2:
						dialogueText.text = "In order to use my machines, press whichever of the 3 Prize Machine buttons on your right!\n[Tap To Continue]";
					case 3:
						dialogueText.text = "My prizes vary between each machine, hence why we have 3 Machines here!\n[Tap To Continue]";
					case 4:
						{
							FlxTween.tween(testYourLuckBG, {x: MobileUtil.fixX(-130)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(tokenShow, {x: 780}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			
							FlxTween.tween(lights, {x: MobileUtil.fixX(90)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									
							FlxTween.tween(choice, {x: MobileUtil.fixX(250)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(testLuckButton, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										
							FlxTween.tween(spaceText, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(notEnoughTokensText, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							dialogueText.text = "Taking a turn only costs 1 token each time! If you have more than 1, you're good to go!\n[Tap To Continue]";
						}
					case 5:
						dialogueText.text = "Each Prize Machine has a different variety of items to win, so try to win them all!\n[Tap To Continue]";				
					case 6:
						dialogueText.text = "To use my Machine, click on the button below to start rolling the items! Once you're ready, press SPACE, and see what you'll earn!\n[Tap To Continue]";		
					case 7:
						dialogueText.text = "Beware though! Winning an item will not remove it from the Prize Machine, so if you earn it again, it will act like a miss, and your token will be wasted!\n[Tap To Continue]";
					case 8:
						{
							FlxTween.tween(testYourLuckBG, {x: mobilePositions[0]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(tokenShow, {x:mobilePositions[1]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

							FlxTween.tween(choice, {x: MobileUtil.fixX(1660)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(testLuckButton, {x: MobileUtil.fixX(1710)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(spaceText, {x: MobileUtil.fixX(1710)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(notEnoughTokensText, {x: MobileUtil.fixX(1710)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(lights, {x: MobileUtil.fixX(1480)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

							FlxTween.tween(blackOut, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							dialogueText.text = "Other than that, remember to use your mouse cursor to move around! Have fun shopping!\n[Tap To Continue]";
						}
					case 9:
						{
							FlxTween.tween(showcaseDialogue, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							ClientPrefs.shopShowcased = true;
							ClientPrefs.saveSettings();
						}
				}
				pressedEnter += 1;
				showcaseDialogue.resetText(dialogueText.text);
				if (pressedEnter <= 9)
				{
					showcaseDialogue.start(0.04, true, ending);
					assistant.animation.play('talkMain');
					switch (assistNum)
					{
						case 1:
							assistant.offset.set(96, 3); //Talk 1
						case 2:
							assistant.offset.set(8, -1); //Talk 2
						case 3:
							assistant.offset.set(0, 5); //Talk 3
					}
				}
			}
		}
		else
		{
		{
		//THIS WHOLE SECTION IS FOR THE SHOP, GO TO THE DEAD END FOR THE SECRET SHOP CODE
		//Keep Updating your Token Counter
		if (ClientPrefs.tokens > 0)
			tokenShow.text = "Tokens: <GR>" + ClientPrefs.tokens + "<GR>";
		else
			tokenShow.text = "Tokens: <R>" + ClientPrefs.tokens + "<R>";
		CustomFontFormats.addMarkers(tokenShow);

		//GIVE SHOP ACHIEVEMENT AT ANY TIME
		if (ClientPrefs.nunsationalFound && ClientPrefs.lustalityFound && ClientPrefs.tofuFound && ClientPrefs.marcochromeFound
			&& ClientPrefs.fnvFound && ClientPrefs.shortFound && ClientPrefs.nicFound && ClientPrefs.infatuationFound && ClientPrefs.rainyDazeFound && ClientPrefs.debugFound 
			&& ClientPrefs.morkyWeekFound && ClientPrefs.susWeekFound && ClientPrefs.morkyWeekFound && ClientPrefs.dsideWeekFound)
		{
			var achieveID:Int = Achievements.getAchievementIndex('shop_completed');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) {
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement("shop_completed");
				ClientPrefs.saveSettings();
			}
		}

		#if DEBUG_ALLOWED
			if (FlxG.keys.justPressed.EIGHT)
			{
				ClientPrefs.tokens += 1;
				//ClientPrefs.saveSettings();
			}			
			if (FlxG.keys.justPressed.SEVEN && ClientPrefs.tokens > 0)
			{
				ClientPrefs.tokens -= 1;
				//ClientPrefs.saveSettings();
			}
		#end
		if (controls.BACK || FlxG.mouse.justPressedRight)
			{
				//Prize Pool Section
				if (ClientPrefs.itemInfo && !pressedBack)
				{
					pressedBack = true;

					FlxG.sound.play(Paths.sound('cancelMenu'));
					prizeSlots.forEach(function(prize:FlxSprite)
					{
						var x:Float = 0;
						var y:Float = 0;

						switch (prize.ID)
						{
							case 14:
								switch(shelfSelected)
								{
									case 1:
										x = 250; y = 315;
									case 2:
										x = 50; y = 315;
									case 3:
										x = 650; y = 160;
								}
							case 15:
								switch(shelfSelected)
								{
									case 1:
										x = 450; y = 315;
									case 2:
										x = 250; y = 315;
									case 3:
										x = 850; y = 160;
								}
							case 16:
								switch(shelfSelected)
								{
									case 1:
										x = 650; y = 315;
									case 2:
										x = 450; y = 315;
									case 3:
										x = 50; y = 315;
								}

							default:
								x = prizeBoard[prize.ID][0];
								switch(shelfSelected)
								{
									case 1:
										if ((prize.ID >= 0 && prize.ID <= 5) || prize.ID == 17)
											y = prizeBoard[prize.ID][1];
										else
											y = 1010;
									case 2:
										if ((prize.ID >= 6 && prize.ID <= 10) || prize.ID == 18)
											y = prizeBoard[prize.ID][1];
										else
											y = 1010;
									case 3:
										if ((prize.ID >= 11 && prize.ID <= 13) || prize.ID == 19)
											y = prizeBoard[prize.ID][1];
										else
											y = 1010;
								}
						}

						FlxTween.tween(prize, {x: x, y: y, "scale.x": 1, "scale.y": 1, alpha: 0.3}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					});
					
					FlxTween.tween(blackOut, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(infoTitle, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(infoText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					//sell normal items and charms shit
					if (ClientPrefs.sellSelected)
					{
						FlxTween.tween(buy, {y: 820}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(equipped, {y: 820}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					
					new FlxTimer().start(0.6, function (tmr:FlxTimer) {
						pressedBack = false;
						ClientPrefs.itemInfo = false;
					});
				}
				//Test your Luck Section
				else if (ClientPrefs.luckSelected && !ClientPrefs.choiceSelected && !pressedBack)
				{
					pressedBack = true;
					shelfSelected = 0;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(testYourLuckBG, {x: mobilePositions[0]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(tokenShow, {x: mobilePositions[1]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(choice, {x: MobileUtil.fixX(1660)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(testLuckButton, {x: MobileUtil.fixX(1710)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(spaceText, {x: MobileUtil.fixX(1710)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(notEnoughTokensText, {x: MobileUtil.fixX(1710)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(lights, {x: MobileUtil.fixX(1480)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					new FlxTimer().start(0.6, function (tmr:FlxTimer) {
						pressedBack = false;
						ClientPrefs.luckSelected = false;
					});
				}
				//Sell Selection
				else if (ClientPrefs.sellSelected && !ClientPrefs.itemInfo && !pressedBack)
				{
					pressedBack = true;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(buyItemsBG, {y: 800}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					prizeSlots.forEach(function(prize:FlxSprite)
					{
						FlxTween.tween(prize, {y: (prize.ID > 13) ? 1070 : 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					});

					shelfSelected = 0;
					new FlxTimer().start(0.6, function (tmr:FlxTimer) {
						pressedBack = false;
						ClientPrefs.sellSelected = false;
					});
				}
				else if (ClientPrefs.choiceSelected || choiceNumber == 4)  //DON'T GO BACK IF YOU'RE USING THE LUCK SECTION
				{
					//Do nothing lmao
				}
				else if (!ClientPrefs.sellSelected && !ClientPrefs.luckSelected && !ClientPrefs.choiceSelected && !ClientPrefs.itemInfo)
				{
					FlxG.sound.music.fadeOut(0.4);
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new MainMenuState(), 'stickers');
				}
			}
			
			// Buttom Checks
			if (!ClientPrefs.sellSelected && !ClientPrefs.luckSelected && !ClientPrefs.choiceSelected && !ClientPrefs.itemInfo)
				checkButtons((changedShop) ? "Zeel" : "Main");

			//Dialogue
			if(TouchUtil.pressAction(assistant) && !ClientPrefs.luckSelected && !changedShop && !cellarShopActive
			&& (!TouchUtil.overlaps(luckOptionSlots.members[0]) && !TouchUtil.overlaps(luckOptionSlots.members[1]) && !TouchUtil.overlaps(luckOptionSlots.members[2])))
			{
					dialogueNumber = FlxG.random.int(1, 29);
					switch (assistNum)
					{
						case 1:
							assistant.offset.set(96, 3); //Talk 1
						case 2:
							assistant.offset.set(8, -1); //Talk 2
						case 3:
							assistant.offset.set(0, 5); //Talk 3
					}
					switch (dialogueNumber)
					{
						case 1:
							dialogueText.text = "My products depend on what my customer wants.";
						case 2:
							dialogueText.text = "I'm aware that I'm in a game you know.";
						case 3:
							dialogueText.text = "Don't worry, none of these are canon to the main week.";
						case 4:
							dialogueText.text = "I love scamming people.";
						case 5:
							dialogueText.text = "Never use the door on my right as an exit, I'm telling ya!";
						case 6:
							dialogueText.text = "Keep grinding those tokens! You might be able to use em to someone else, other than me!";
						case 7:
							dialogueText.text = "Do you know 'Mr Cartridge Guy'? He's a great business man but I don't like the way he interact with his customers...";
						case 8:
							dialogueText.text = "If you didn't notice yet, I have 9 disimbodied hands that I can control! Do you think you can you find them all?";
						case 9:
							dialogueText.text = "N E V E R USE THE DOOR TO YOUR LEFT.";
						case 10:
							dialogueText.text = "Go test your luck now!";
						case 11:
							dialogueText.text = "I love tokens.";
						case 12:
							dialogueText.text = "I'm not the only Mechant in this game... But I don't want you to meet her.";
						case 13:
							dialogueText.text = "Little blue balls man is dead.";
						case 14:
							dialogueText.text = "The world is full of obvious things.";
						case 15:
							dialogueText.text = "You want something free from me??? Hmm... Open Paycheck in freeplay and type 'Unpaid'.";
						case 16:
							dialogueText.text = "Hello TC.";
						case 17:
							dialogueText.text = "I don't sell things, I give away my stuff here.";
						case 18:
							dialogueText.text = "You can Examine the prizes at the prize pool.";
						case 19:
							dialogueText.text = "She thicc af bro";
						case 20:
							dialogueText.text = "I wouldn't spam a certain arrow key, if I were you. That's cheating.";
						case 21:
							dialogueText.text = "They're masterworks all, you can't go wrong.";
						case 22:
							dialogueText.text = "Whaddya want??";
						case 23:
							dialogueText.text = "There's a selection of good things for you to win, Stranger! ";
						case 24:
							dialogueText.text = "Tokens?";
						case 25:
							dialogueText.text = "It's a pleasure to see you safe. How's things going?";
						case 26:
							dialogueText.text = "Olah, Kumare!";
						case 27:
							dialogueText.text = "Don't worry, I got an eternity worth of living. Can you say the same?";
						case 28:
							dialogueText.text = "I go to college and make u proud!";
						case 29:
							dialogueText.text = "Looking to protect your self, or deal some damage?";
					}
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
					merchantDialogue.resetText(dialogueText.text);
					merchantDialogue.start(0.04, true, ending);
					assistant.animation.play('talkMain');
			}

			// Shop Button Triggers (Both Shops)
			buttonTrigger((changedShop) ? "Zeel" : "Main");
			
			// Luck Mechanism
			if (ClientPrefs.tokens == 0 && !tokensRunOut && !ClientPrefs.choiceSelected)
			{
				FlxTween.tween(testLuckButton, {y: testLuckButton.y + 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				tokensRunOut = true;
			}
			if (ClientPrefs.tokens > 0 && tokensRunOut)
			{
				FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(notEnoughTokensText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				tokensRunOut = false;
			}
			if(TouchUtil.pressAction(testLuckButton) && ClientPrefs.luckSelected && ended && ClientPrefs.tokens > 0)
			{
				ClientPrefs.choiceSelected = true;
				ClientPrefs.tokens -= 1;
				done = ended = false;
				var bgTimer:FlxTimer = new FlxTimer().start(0.05, getChoiceNumber);	
				FlxG.sound.play(Paths.sound('shop/mouseClick'));
				FlxTween.tween(testLuckButton, {y: testLuckButton.y + 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(spaceText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			}
			if (controls.ACCEPT || TouchUtil.pressAction(spaceText) && allowTap && !pressedSpace && ClientPrefs.choiceSelected && !done)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				allowTap = false;
				done = pressedSpace = true;
			}
			if(pressedSpace)
			{
					ended = true;
					switch(choiceNumber)
					{
						case 1:
						{
							trace('YAY, LEGACY WEEK [OPTION 1] IS SELECTED');
							if (!ClientPrefs.legacyWeekFound)
							{	
								ClientPrefs.legacyWeekFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.bonusUnlocked = true;

								NotificationAlert.sendCategoryNotification = true;
								NotificationAlert.showMessage(this, 'Normal', true);
							
								NotificationAlert.saveNotifications();
								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 2:
						{
							trace('YAY, NUNSATIONAL [OPTION 2] IS SELECTED');
							if (!ClientPrefs.nunsationalFound)
							{
								ClientPrefs.nunsationalFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.xtraUnlocked = true;

								NotificationAlert.showMessage(this, 'Freeplay', true);

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 3:
						{
							trace('YAY, LUSTALITY [OPTION 3] IS SELECTED');
							if (!ClientPrefs.lustalityFound)
							{
								ClientPrefs.lustalityFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.xtraUnlocked = true;

								NotificationAlert.showMessage(this, 'Freeplay', true);

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 4:
						{
							trace('YAY, TOFU [OPTION 4] IS SELECTED');
							if (!ClientPrefs.tofuFound)
							{
									ClientPrefs.tofuFound = true;
									ClientPrefs.choiceSelected = false;
									ClientPrefs.songsUnlocked += 1;
									ClientPrefs.xtraUnlocked = true;

									NotificationAlert.showMessage(this, 'Freeplay', true);

									ClientPrefs.saveSettings();
									new FlxTimer().start(0.5, function (tmr:FlxTimer) {
										FlxG.sound.play(Paths.sound('hooray'), 0.5);
									});
									flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 5:
						{
							trace('YAY, MARCOCHROME [OPTION 5] IS SELECTED');
							if (!ClientPrefs.marcochromeFound)
							{
								ClientPrefs.marcochromeFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.xtraUnlocked = true;

								NotificationAlert.showMessage(this, 'Freeplay', true);

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 6: //THIS GIVES YOU 3 TOKENS
						{
							ClientPrefs.tokens += 3;
							new FlxTimer().start(0.5, function (tmr:FlxTimer) {
								FlxG.sound.play(Paths.sound('hooray'), 0.5);
							});
							revertLuck();
						}
						case 7:
						{
							trace('YAY, RESISTANCE CHARM [OPTION 7] IS SELECTED');
							if (!ClientPrefs.resCharmCollected)
							{
								ClientPrefs.resCharmCollected = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;

								NotificationAlert.showMessage(this, 'Normal', true);
								NotificationAlert.sendInventoryNotification = true;
								NotificationAlert.saveNotifications();

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
					case 8:
						{
							trace('YAY, JOKE WEEK [OPTION 8] IS SELECTED');
							if (!ClientPrefs.morkyWeekFound)
							{
									ClientPrefs.morkyWeekFound = true;
									ClientPrefs.choiceSelected = false;
									ClientPrefs.songsUnlocked += 1;
									ClientPrefs.bonusUnlocked = true;

									NotificationAlert.sendCategoryNotification = true;
									NotificationAlert.showMessage(this, 'Normal', true);
							
									NotificationAlert.saveNotifications();
									ClientPrefs.saveSettings();
									new FlxTimer().start(0.5, function (tmr:FlxTimer) {
										FlxG.sound.play(Paths.sound('hooray'), 0.5);
									});
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 9:
						{
							trace('YAY, FNV [OPTION 10] IS SELECTED');
							if (!ClientPrefs.fnvFound)
							{
								ClientPrefs.fnvFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.xtraUnlocked = true;

								NotificationAlert.showMessage(this, 'Freeplay', true);

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 10:
						{
							trace('YAY, 0.0015 [OPTION 11] IS SELECTED');
							if (!ClientPrefs.shortFound)
							{
								ClientPrefs.shortFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.xtraUnlocked = true;

								NotificationAlert.showMessage(this, 'Freeplay', true);

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween =	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 11:
						{
							trace('YAY, SLOW.FLP [OPTION 12] IS SELECTED');
							if (!ClientPrefs.nicFound)
							{
								ClientPrefs.nicFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.xtraUnlocked = true;

								NotificationAlert.showMessage(this, 'Freeplay', true);

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 12:
						{
							trace('YAY, AUTO DODGE CHARM [OPTION 13] IS SELECTED');
							if (!ClientPrefs.autoCharmCollected)
							{
								ClientPrefs.autoCharmCollected = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;

								NotificationAlert.showMessage(this, 'Normal', true);
								NotificationAlert.sendInventoryNotification = true;
								NotificationAlert.saveNotifications();

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 13: //THIS GIVES OFF 5 TOKENS
						{
							ClientPrefs.tokens += 5;
							new FlxTimer().start(0.5, function (tmr:FlxTimer) {
								FlxG.sound.play(Paths.sound('hooray'), 0.5);
							});
							revertLuck();
						}
						case 14:
						{
							trace('YAY, FANFUCK FOREVER [OPTION 15] IS SELECTED');
							if (!ClientPrefs.infatuationFound)
							{
								ClientPrefs.infatuationFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.xtraUnlocked = true;

								NotificationAlert.showMessage(this, 'Freeplay', true);

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 15:
						{
							trace('YAY, RAINY DAZE [OPTION 16] IS SELECTED');
							if (!ClientPrefs.rainyDazeFound)
							{
								ClientPrefs.rainyDazeFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.xtraUnlocked = true;

								NotificationAlert.showMessage(this, 'Freeplay', true);

								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 16:
						{
							trace('YAY, MARAUDER [OPTION 17] IS SELECTED');
							if (!ClientPrefs.debugFound)
							{
								ClientPrefs.debugFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.xtraUnlocked = true;

								NotificationAlert.showMessage(this, 'Freeplay', true);
									
								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 17:
						{
							trace('YAY, SUS WEEK [OPTION 18] IS SELECTED');
							if (!ClientPrefs.susWeekFound)
							{
								ClientPrefs.susWeekFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.bonusUnlocked = true;

								NotificationAlert.sendCategoryNotification = true;
								NotificationAlert.showMessage(this, 'Normal', true);
							
								NotificationAlert.saveNotifications();
								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 18:
						{
							trace('YAY, D-SIDES WEEK [OPTION 19] IS SELECTED');
							if (!ClientPrefs.dsideWeekFound)
							{
								ClientPrefs.dsideWeekFound = true;
								ClientPrefs.choiceSelected = false;
								ClientPrefs.songsUnlocked += 1;
								ClientPrefs.bonusUnlocked = true;

								NotificationAlert.sendCategoryNotification = true;
								NotificationAlert.showMessage(this, 'Normal', true);
							
								NotificationAlert.saveNotifications();
								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
						case 19:
						{
							trace('YAY, HEALING CHARM [OPTION 20] IS SELECTED');
							if (!ClientPrefs.healCharmCollected)
							{
								ClientPrefs.healCharmCollected = true;
								ClientPrefs.choiceSelected = false;

								NotificationAlert.sendInventoryNotification = true;
								NotificationAlert.showMessage(this, 'Normal', true);
							
								NotificationAlert.saveNotifications();
								ClientPrefs.saveSettings();
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('hooray'), 0.5);
								});
								flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
							}
							revertLuck();
						}
					}
				pressedSpace = false;
			}

		//FROM BELOW HERE UNTIL super.update(elapsed), THIS IS WHERE THE SECRET SHOP CODE WILL SHOW UP
		if (controls.UI_LEFT && !changedShop)
		{
			merchantDialogue.skip();
			ending();
			changedShop = true;

			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxTween.tween(background, {x: MobileUtil.fixX(2000)}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			luckOptionSlots.forEach(function(button:FlxSprite)
			{
				FlxTween.tween(button, {x: 2670}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			});
			FlxTween.tween(assistant, {x: 2070}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(merchantDialogue, {x: 2000}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(lights, {x: MobileUtil.fixX(2070)}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(transitionOoooOo, {x: 1370}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(bulb, {x: 1600}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			new FlxTimer().start(2, function (tmr:FlxTimer) {
				FlxTween.tween(backgroundSecret, {x: 0}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				sellSlots.forEach(function(butt:FlxSprite)
				{
					FlxTween.tween(butt, {x: 200}, 1.8 + (butt.ID * 0.04), {ease: FlxEase.cubeInOut, type: PERSIST});
				});
				FlxTween.tween(booba, {x: MobileUtil.fixX(780)}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(assistantSecret, {x: MobileUtil.fixX(740)}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(secretMerchantDialogue, {x: MobileUtil.fixX(130)}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			});
			new FlxTimer().start(3.7, function (tmr:FlxTimer) {
				if (!ClientPrefs.secretShopShowcased)
				{
					showcaseSecretDialogue.x = MobileUtil.fixX(130);
					FlxTween.tween(showcaseSecretDialogue, {alpha: 1}, 0.01, {ease: FlxEase.cubeInOut, type: PERSIST});
					showcaseSecretDialogue.start(0.04, true, endingSecret);
				}
				else
					secretMerchantDialogue.start(0.04, true, endingSecret);
					assistantSecret.offset.set(110, 36);

				assistantSecret.animation.play('talking');
				secretShopAccessed = true;

				#if desktop
					// Updating Discord Rich Presence
					DiscordClient.changePresence("In Zeel's Secret Shop", null);
				#end
			});
		}
		if (controls.UI_RIGHT && secretShopAccessed && !ClientPrefs.sellSelected && !ClientPrefs.luckSelected && ClientPrefs.secretShopShowcased && changedShop)
		{
			secretMerchantDialogue.skip();
			endingSecret();
			changedShop = false;

			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxTween.tween(backgroundSecret, {x: -2000}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			sellSlots.forEach(function(butt:FlxSprite)
			{
				FlxTween.tween(butt, {x: -2900}, 1.8 + (butt.ID * 0.04), {ease: FlxEase.cubeInOut, type: PERSIST});
			});
			FlxTween.tween(booba, {x: -2630}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(assistantSecret, {x: -2670}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(secretMerchantDialogue, {x: -2400}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});

			new FlxTimer().start(2, function (tmr:FlxTimer) {
				FlxTween.tween(background, {x: mobilePositions[2]}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				luckOptionSlots.forEach(function(button:FlxSprite)
				{
					var offset:Int = 0;
					switch(button.ID)
					{
						case 1:
							if (!ClientPrefs.nunWeekPlayed)
								offset = 5;
						case 2:
							if (!ClientPrefs.kianaWeekPlayed)
								offset = 5;
					}	
					FlxTween.tween(button, {x: MobileUtil.fixX(780 + offset)},  1.8 + (button.ID * 0.04), {ease: FlxEase.cubeInOut, type: PERSIST});
					
				});
				FlxTween.tween(assistant, {x: -10}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(lights, {x: MobileUtil.fixX(1470)}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(bulb, {x: -400}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(merchantDialogue, {x: 0}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			
				FlxTween.tween(transitionOoooOo, {x: -1370}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			});
			new FlxTimer().start(3.7, function (tmr:FlxTimer) {
				if (!ClientPrefs.talkedToZeel)
				{
					ClientPrefs.talkedToZeel = true;
					ClientPrefs.saveSettings();
				}
				switch (assistNum)
				{
					case 1:
						assistant.offset.set(96, 3); //Talk 1
					case 2:
						assistant.offset.set(8, -1); //Talk 2
					case 3:
						assistant.offset.set(0, 5); //Talk 3
				}
				merchantDialogue.start(0.04, true, ending);
				assistant.animation.play('talkMain');
				secretShopAccessed = false;
			});
		}

		//Dialogue
		if (!ClientPrefs.secretShopShowcased && !secretFirstTime && changedShop)
		{
			secretFirstTime = true;
			pressedEnter = 0;
			new FlxTimer().start(1.8, function (tmr:FlxTimer) {
				var achieveZeelID:Int = Achievements.getAchievementIndex('zeel_found');
				if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveZeelID][2])) {
					Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveZeelID][2], true);
					giveAchievement("zeel_found");
					ClientPrefs.saveSettings();
				}
			});
		}

		if (!ClientPrefs.secretShopShowcased && changedShop && !gtfo)
		{
			if ((controls.ACCEPT || TouchUtil.pressAction()) && !questionShow)
			{
				trace ("Pressed Enter : " + pressedEnter);
				switch (pressedEnter)
				{
					case 0:
						dialogueTextSecret.text = "Haven't had any customers since last update~\n[Tap To Continue]";	
					case 1:
						dialogueTextSecret.text = "I don't want to bother you with questions, so I'll be straight forward this time~\n[Tap To Continue]";
					case 2:
						dialogueTextSecret.text = "If you wish to buy anything that this 'Mimiko' guy lets you win, click on any of the shelfs~\n[Tap To Continue]";
					case 3:
						dialogueTextSecret.text = "Each shelf contains specific items that are inside the corresponding prize machine~\n[Tap To Continue]";
					case 4:
						dialogueTextSecret.text = "Have fun shopping~ Don't hesitate to ask me anything~\n[Tap To Continue]";
					case 5:
					{
						ClientPrefs.secretShopShowcased = true;
						FlxTween.tween(showcaseSecretDialogue, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						secretMerchantDialogue.alpha = 1;
						ClientPrefs.secretShopShowcased = true;
						ClientPrefs.saveSettings();
						trace('changes saved');
					}
				}
				pressedEnter += 1;
				if (pressedEnter <= 5)
				{
					showcaseSecretDialogue.resetText(dialogueTextSecret.text);
					showcaseSecretDialogue.start(0.04, true, endingSecret);
					assistantSecret.animation.play('talking');
					assistantSecret.offset.set(110, 36);
				}
			}
		}
		else
		{
			if(TouchUtil.pressAction(assistantSecret) && !ClientPrefs.sellSelected)
			{
				if (TouchUtil.overlaps(booba))
				{
					touchedBoobies += 1;
					dialogueNumberSecret = FlxG.random.int(1, 18);
					switch (dialogueNumberSecret)
					{
						case 1:
							dialogueTextSecret.text = "Hey! Didn't your parents teach you not to poke any girls boobs? >:(";
						case 2:
							dialogueTextSecret.text = "Woah there, don't touch those!";
						case 3:
							dialogueTextSecret.text = "Jesus, are you that desperate to touch these?!";
						case 4:
							dialogueTextSecret.text = "Back off!\nI'm just a shopkeeper!";
						case 5:
							dialogueTextSecret.text = "What are you, a pervert?!";
						case 6:
							dialogueTextSecret.text = "This was not nice of you!\nYou'll make me increase the prizes!";
						case 7:
							dialogueTextSecret.text = "Go touch grass instead of my boobs!";
						case 8:
							dialogueTextSecret.text = "HEY! My eyes are up here!";
						case 9:
							dialogueTextSecret.text = "These are not made to be poked on!";
						case 10:
							dialogueTextSecret.text = "NO, do NOT touch these.";
						case 11:
							dialogueTextSecret.text = "Do you ACTUALLY do this behind that screen?";
						case 12:
							dialogueTextSecret.text = "You're being disgusting!";
						case 13:
							dialogueTextSecret.text = "This is harrassment, you know that?";
						case 14:
							dialogueTextSecret.text = "Such degeneracy!";
						case 15:
							dialogueTextSecret.text = "I don't care if my original variant is (possibly) fine with this, I do not enjoy this whatsoever!";
						case 16:
							dialogueTextSecret.text = "How would you like it if people poked your boobs?!";
						case 17:
							dialogueTextSecret.text = "That's really disturbing!\nStop this instant!";
						case 18:
							dialogueTextSecret.text = "If I were to touch your private parts like this, would you enjoy it?!?!";
					}
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
					secretMerchantDialogue.resetText(dialogueTextSecret.text);
					secretMerchantDialogue.start(0.04, true, endingSecret);
					assistantSecret.animation.play('whyutouchbooba');
					assistantSecret.offset.set(-13, 42);

					var achieveZeelBoobaID:Int = Achievements.getAchievementIndex('pervert');
					if((!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveZeelBoobaID][2])) && touchedBoobies == 1) {
						Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveZeelBoobaID][2], true);
						giveAchievement("pervert");
						ClientPrefs.saveSettings();
					}

					var achieveZeelBoobaX25ID:Int = Achievements.getAchievementIndex('pervertX25');
					if((!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveZeelBoobaX25ID][2])) && touchedBoobies == 25) {
						Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveZeelBoobaX25ID][2], true);
						giveAchievement("pervertX25");
						ClientPrefs.saveSettings();
					}
				}
				else
				{
					dialogueNumberSecret = FlxG.random.int(1, 23);
					switch (dialogueNumberSecret)
					{
						case 1:
							dialogueTextSecret.text = "I know I'm hot, but you're here to buy stuff, unless you want to try your luck over there.";
						case 2:
							dialogueTextSecret.text = "Isn't it weird that there's a random lady selling random stuff in the middle of a complete void?\nYea, I find it weird too.";
						case 3:
							dialogueTextSecret.text = "Hey, what's with that look?\nHave you never seen any female shopkeeper before?";
						case 4:
							dialogueTextSecret.text = "Do I look familiar to you?";
						case 5:
							dialogueTextSecret.text = "So how's it going?\nWhat's your game's status so far?";
						case 6:
							dialogueTextSecret.text = "Use your mouse to navigate through here!\nIt's not that hard to understand.";
						case 7:
							dialogueTextSecret.text = "No, don't even think of fantasizing about me.";
						case 8:
							dialogueTextSecret.text = "Nice to meet you player!\nMy name's Zeel~";
						case 9:
							dialogueTextSecret.text = "I may be a variant of Liz, but I'm not like her.";
						case 10:
							dialogueTextSecret.text = "No, I'm not behaving suspiciously right now.\nKeep it together!";
						case 11:
							dialogueTextSecret.text = "You know you can press the RIGHT ARROW to go back to Mimiko's shop, right?";
						case 12:
							dialogueTextSecret.text = "I sell a few extra stuff that the other mere shopkeeper doesn't by the way~";
						case 13:
							dialogueTextSecret.text = "It may be dark in here, but it definitely is cozy~";
						case 14:
							dialogueTextSecret.text = "Oh, you like my big personality?";
						case 15:
							dialogueTextSecret.text = "A mishap's on the go!\nStill love that line~";
						case 16:
							dialogueTextSecret.text = "These charms look like they'd help you a ton~";
						case 17:
							dialogueTextSecret.text = "I wonder how long have I been in here..";
						case 18:
							dialogueTextSecret.text = "Buying is better than gambling, am I right?~";
						case 19:
							dialogueTextSecret.text = "What's the matter?\nI'm open to hearing about you~";
						case 20:
							dialogueTextSecret.text = "...Are you here to do window shopping?";
						case 21:
							dialogueTextSecret.text = "It's nice to be alone sometimes..\nbut it's more fun to have company..";
						case 22:
							dialogueTextSecret.text = "My prices are guaranteed to make you proud of your purchases!";
						case 23:
							dialogueTextSecret.text = "Waiting...";
					}
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
					secretMerchantDialogue.resetText(dialogueTextSecret.text);
					secretMerchantDialogue.start(0.04, true, endingSecret);
					assistantSecret.animation.play('talking');
					assistantSecret.offset.set(110, 36);
				}
			}
		
		if (!ClientPrefs.itemInfo)
		{
			// Prize Ocacity Check
			checkPrizeOverlap();

			//Selling Section Bundled with Buying Process
			prizeSlots.forEach(function (prize:FlxSprite)
			{
				if (TouchUtil.pressAction(prize) && ClientPrefs.sellSelected)
				{
					ClientPrefs.itemInfo = true;
					prizeSelected = prize.ID;
					FlxG.sound.play(Paths.sound('scrollMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
	
					var x:Float = 0;
					var y:Float = 0;
					switch(shelfSelected)
					{
						case 1:
							x = prizeSlots.members[0].x; y = prizeSlots.members[0].y;
						case 2:
							x = prizeSlots.members[6].x; y = prizeSlots.members[6].y;
						case 3:
							x = prizeSlots.members[11].x; y = prizeSlots.members[11].y;
					}

					FlxTween.tween(prize, {x: x, y: y, "scale.x": 1.4, "scale.y": 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					prizeSlots.forEach(function (prize:FlxSprite)
					{
						if (prize.ID != prizeSelected)
							FlxTween.tween(prize, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					});
					FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					buy.alpha = 1;
					equipped.alpha = 0;
					FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					new FlxTimer().start(0.8, function (tmr:FlxTimer) {
						canGoBack = true;
					});

					setUpInfoPanel(prize.ID);
				}
			});
		}
		else
		{
			if (TouchUtil.pressAction(buy))
			{
				prizeSlots.forEach(function (prize:FlxSprite)
				{
					if (prize.ID == prizeSelected)
						processTransaction(prize.ID);
				});
			}
		}

			//EQUIPPED OPTION [Will only work on these 2 items]
			if (TouchUtil.pressAction(equipped))
			{
				switch (infoTitle.text)
				{
					case "Zeel's Naked Pics":
					{
						if (ClientPrefs.zeelNakedPics && !initializedVideo)
						{
							if (!videoDone) //FROM INDIE CROSS!
								{
									if (FlxG.sound.music != null)
										FlxG.sound.music.stop();

									FlxG.sound.play(Paths.sound('shop/mouseClick'));
									FlxG.sound.play(Paths.sound('confirmMenu'));
						
									var video:VideoSprite = new VideoSprite(Paths.video('Zeels Naked Pics'), false, true, false);
									add(video);
									video.play();
									initializedVideo = true;
									video.finishCallback = function()
									{
										System.exit(0);
									};
								}
						}
					}

					case "Trampoline Mode":
					{
						if (ClientPrefs.trampolineUnlocked)
						{
							FlxG.sound.play(Paths.sound('shop/mouseClick'));
							FlxG.sound.play(Paths.sound('confirmMenu'));
							LoadingState.loadAndSwitchState(new options.OptionsState());
						}
					}
				}
			}
		}

		//Cellar Shop
		if (controls.UI_UP && !cellarShopAccessed && !cellarShopActive && !secretShopAccessed && !ClientPrefs.sellSelected && !ClientPrefs.luckSelected)
		{
			//Dialogue reset
			merchantDialogue.skip();

			FlxG.sound.play(Paths.sound('scrollMenu'));
			cellarShopAccessed = true;
			cellarShopActive = true;

			transitionOoooOo.alpha = 0;
			FlxTween.tween(background, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			luckOptionSlots.forEach(function(button:FlxSprite)
			{
				FlxTween.tween(button, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			});
			FlxTween.tween(assistant, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(merchantDialogue, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(lights, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(bulb, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});

			FlxG.sound.music.fadeOut(1.2);  
				
			new FlxTimer().start(1.3, function (tmr:FlxTimer) {
				MusicBeatState.switchState(new LoreShop());
			});
		}
		}
		}
		super.update(elapsed);
	}

	function checkButtons(shop:String)
	{
		switch(shop)
		{
			case "Main":
				luckOptionSlots.forEach(function(button:FlxSprite)
				{
					if (!cellarShopActive)
					{
						if (TouchUtil.overlaps(button))
							button.alpha = 1;
						else
							button.alpha = 0.6;
					}
				});
			case "Zeel":
				sellSlots.forEach(function(button:FlxSprite)
				{
					if (TouchUtil.overlaps(button))
						button.alpha = 1;
					else
						button.alpha = 0.6;
				});
		}
	}

	function buttonTrigger(shop:String)
	{
		switch(shop)
		{
			case "Main":
				luckOptionSlots.forEach(function(button:FlxSprite)
				{
					if (TouchUtil.pressAction(button) && !ClientPrefs.luckSelected)
					{
						switch(button.ID)
						{
							case 0:
								ClientPrefs.luckSelected = true;
								merchantDialogue.skip();
								shelfSelected = 1;
								choiceNumber = FlxG.random.int(1, 7);
								choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
									
								lights.animation.play('redlightsFlash');
								testYourLuckBG.loadGraphic(Paths.image('shop/testYourLuckBG1'));
								FlxTween.tween(testYourLuckBG, {x: MobileUtil.fixX(-130)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
								FlxTween.tween(tokenShow, {x: MobileUtil.fixX(780)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
								FlxTween.tween(lights, {x: MobileUtil.fixX(90)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									
								FlxTween.tween(choice, {x: MobileUtil.fixX(250)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
								FlxTween.tween(testLuckButton, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										
								FlxTween.tween(spaceText, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
								FlxTween.tween(notEnoughTokensText, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
								FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
								FlxG.sound.play(Paths.sound('shop/mouseClick'));
	
							case 1:
								if (!ClientPrefs.nunWeekPlayed)
								{
									FlxG.sound.play(Paths.sound('accessDenied'));
									FlxG.camera.shake(0.01, 0.2, null, true, FlxAxes.XY);
								}
								else
								{
									ClientPrefs.luckSelected = true;
									merchantDialogue.skip();
									shelfSelected = 2;
									choiceNumber = FlxG.random.int(8, 14);
									choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
									
									lights.animation.play('bluelightsFlash');
				
									testYourLuckBG.loadGraphic(Paths.image('shop/testYourLuckBG2'));
									FlxTween.tween(testYourLuckBG, {x: MobileUtil.fixX(-130)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(tokenShow, {x: MobileUtil.fixX(780)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
									FlxTween.tween(lights, {x: MobileUtil.fixX(90)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									
									FlxTween.tween(choice, {x: MobileUtil.fixX(250)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(testLuckButton, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										
									FlxTween.tween(spaceText, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(notEnoughTokensText, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
									FlxG.sound.play(Paths.sound('shop/mouseClick'));
								}
	
							case 2:
								if (!ClientPrefs.kianaWeekPlayed)
								{
									FlxG.sound.play(Paths.sound('accessDenied'));
									FlxG.camera.shake(0.01, 0.2, null, true, FlxAxes.XY);
								}
								else
								{
									ClientPrefs.luckSelected = true;
									merchantDialogue.skip();
									shelfSelected = 3;
									choiceNumber = FlxG.random.int(15, 20);
									choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
									
									lights.animation.play('greenlightsFlash');
									testYourLuckBG.loadGraphic(Paths.image('shop/testYourLuckBG3'));
									FlxTween.tween(testYourLuckBG, {x: MobileUtil.fixX(-130)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(tokenShow, {x: MobileUtil.fixX(780)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
									FlxTween.tween(lights, {x: MobileUtil.fixX(90)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									
									FlxTween.tween(choice, {x: MobileUtil.fixX(250)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(testLuckButton, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										
									FlxTween.tween(spaceText, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(notEnoughTokensText, {x: MobileUtil.fixX(330)}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
									FlxG.sound.play(Paths.sound('shop/mouseClick'));
								}
						}
					}
				});

			case "Zeel":
				sellSlots.forEach(function(button:FlxSprite)
				{
					if (TouchUtil.pressAction(button) && !ClientPrefs.sellSelected && !gtfo)
					{
						switch(button.ID)
						{
							case 0:
								ClientPrefs.sellSelected = true;
								secretMerchantDialogue.skip();
			
								shelfSelected = 1;
								FlxTween.tween(buyItemsBG, {y: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

								prizeSlots.members[14].x = MobileUtil.fixX(250);
								prizeSlots.members[15].x = MobileUtil.fixX(450);
								prizeSlots.members[16].x = MobileUtil.fixX(650);
								prizeSlots.forEach(function (prize:FlxSprite)
								{
									if (prize.ID <= 5)
										FlxTween.tween(prize, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									else if (prize.ID >= 14 && prize.ID <= 17)
										FlxTween.tween(prize, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
								});

								FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
								FlxG.sound.play(Paths.sound('shop/mouseClick'));
							
							case 1:
								if (!ClientPrefs.nunWeekPlayed)
								{
									FlxG.sound.play(Paths.sound('accessDenied'));
									FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
								}
								else
								{
									ClientPrefs.sellSelected = true;
									secretMerchantDialogue.skip();
					
									shelfSelected = 2;
									FlxTween.tween(buyItemsBG, {y: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									
									prizeSlots.members[14].x = MobileUtil.fixX(50);
									prizeSlots.members[15].x = MobileUtil.fixX(250);
									prizeSlots.members[16].x = MobileUtil.fixX(450);
									
									prizeSlots.forEach(function (prize:FlxSprite)
									{
										if ((prize.ID >= 6 && prize.ID <= 10) || prize.ID == 18)
											FlxTween.tween(prize, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										else if (prize.ID >= 14 && prize.ID <= 16)
											FlxTween.tween(prize, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									});

									FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
									FlxG.sound.play(Paths.sound('shop/mouseClick'));
								}
		
							case 2:
								if (!ClientPrefs.kianaWeekPlayed)
								{
									FlxG.sound.play(Paths.sound('accessDenied'));
									FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
								}
								else
								{
									ClientPrefs.sellSelected = true;
									secretMerchantDialogue.skip();
			
									shelfSelected = 3;
									FlxTween.tween(buyItemsBG, {y: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									
									prizeSlots.members[14].x = MobileUtil.fixX(50);
									prizeSlots.members[15].x = MobileUtil.fixX(250);
									prizeSlots.members[16].x = MobileUtil.fixX(450);
									prizeSlots.forEach(function (prize:FlxSprite)
									{
										if ((prize.ID >= 11 && prize.ID <= 13) || prize.ID == 19)
											FlxTween.tween(prize, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										else if (prize.ID >= 14 && prize.ID <= 16)
											FlxTween.tween(prize, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									});

									FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
									FlxG.sound.play(Paths.sound('shop/mouseClick'));
								}
						}
					}
				});
		}
	}

	function revertLuck()
	{
		new FlxTimer().start(1.5, function (tmr:FlxTimer) {
			if (ClientPrefs.tokens != 0)
				FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			else
				FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.choiceSelected = false;
			if (flickerTween != null)
				flickerTween.cancel();
			ClientPrefs.saveSettings();
		});
	}
	
	function checkPrizeOverlap()
	{
		prizeSlots.forEach(function (prize:FlxSprite)
		{
			if (TouchUtil.overlaps(prize))
				prize.alpha = 1;
			else
				prize.alpha = 0.3;
		});
	}

	function setUpInfoPanel(id:Int)
	{
		switch(id)
		{
			case 0:
				infoTitle.text = (ClientPrefs.legacyWeekFound) ? "Legacy Week Pass" : "?????? ????";
				infoText.text = "Let's take a trip down to the memory lane!\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.legacyWeekFound) ? "SOLD" : "20 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.legacyWeekFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 1:
				infoTitle.text = (ClientPrefs.nunsationalFound) ? "Nunsational Pass" : "???????????";
				infoText.text = "The Nuns have 1 more surprise for you!\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.nunsationalFound) ? "SOLD" : "15 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.nunsationalFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}
			
			case 2:
				infoTitle.text = (ClientPrefs.lustalityFound) ? "Lustality Pass" : "?????????";
				infoText.text = "Kiana lusts to destroy you!\nWill you accept her old challenge?\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.lustalityFound) ? "SOLD" : "20 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.lustalityFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}
			
			case 3:
				infoTitle.text = (ClientPrefs.tofuFound) ? "Tofu Pass" : "????";
				infoText.text = "This is the result of TOO MUCH CONFIDENCE\nin a game of checkers.\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.tofuFound) ? "SOLD" : "12 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.tofuFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 4:
				infoTitle.text = (ClientPrefs.marcochromeFound) ? "Marcochrome Pass" : "?????-??????";
				infoText.text = "He seems different from what he used to be...\nWhat do you think happened to him?\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.marcochromeFound) ? "SOLD" : "15 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.marcochromeFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 5:
				infoTitle.text = (ClientPrefs.morkyWeekFound) ? "Joke Week Pass" : "???? ????";
				infoText.text = "ALL HAIL MORKY! ALL HAIL MORKY!\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.morkyWeekFound) ? "SOLD" : "15 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.morkyWeekFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 6:
				infoTitle.text = (ClientPrefs.fnvFound) ? "FNV Pass" : "???";
				infoText.text = "I don't know what's this, just take it.\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.fnvFound) ? "SOLD" : "FREE") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.fnvFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}
			
			case 7:
				infoTitle.text = (ClientPrefs.shortFound) ? "Jerry Pass" : "?.????";
				infoText.text = "A- (You guys like shorts?)\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.shortFound) ? "SOLD" : "1 Token") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.shortFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 8:
				infoTitle.text = (ClientPrefs.nicFound) ? "Slow.FLP Pass" : "????.???";
				infoText.text = "I AM GOD! ..Probably.\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.nicFound) ? "SOLD" : "15 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.nicFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 9:
				infoTitle.text = (ClientPrefs.infatuationFound) ? "Fanfuck Forever Pass" : "????????????";
				infoText.text = "You won't get away from me!! NEVEEEERRRR~\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.infatuationFound) ? "SOLD" : "20 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.infatuationFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}
			
			case 10:
				infoTitle.text = (ClientPrefs.rainyDazeFound) ? "Rainy Daze Pass" : "????? ????";
				infoText.text = "Just waiting for the weather to lay off\nand stop pouring down..\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.rainyDazeFound) ? "SOLD" : "15 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.rainyDazeFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}
			
			case 11:
				infoTitle.text = (ClientPrefs.debugFound) ? "Marauder Pass" : "????????";
				infoText.text = "Finally, he's contained!\nLast time he got out, the game almost fucking broke.\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.debugFound) ? "SOLD" : "7 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.debugFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 12:
				infoTitle.text = (ClientPrefs.susWeekFound) ? "Sus Week Pass" : "??? ????";
				infoText.text = "I don't know man, this item seems kind of sus..\nIt looks like another IMPOSTOR is AMONG US-\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.susWeekFound) ? "SOLD" : "20 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.susWeekFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 13:
				infoTitle.text = (ClientPrefs.dsideWeekFound) ? "D-sides Week Pass" : "?-????? ????";
				infoText.text = "Oooo~ This looks like a dope Cassette tape.\nI wonder what's inside?\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.dsideWeekFound) ? "SOLD" : "25 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.dsideWeekFound)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}
			
			case 14:
				infoTitle.text = "Zeel's Naked Pics";
				infoText.text = "Earning this item unlocks my Naked Pictures!\nPress EQUIPPED to view~\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.zeelNakedPics) ? "SOLD" : "75 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.zeelNakedPics)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}
			
			case 15:
				infoTitle.text = "Trampoline Mode";
				infoText.text = "Earning this item unlocks Trampoline Mode!\nTo use once you buy it, make sure you enable it through options >> Miescellaneous!\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.trampolineUnlocked) ? "SOLD" : "15 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.trampolineUnlocked)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 16:
				infoTitle.text = "Egg";
				infoText.text = "It's... an egg.\nMaybe not good for consuming it yourself, but someone else might be able to do so!\n-----------------------------------------
					\nItem Cost: 3 | Your Tokens: " + ClientPrefs.tokens + " | Eggs Owned: " + ClientPrefs.eggs;

			case 17:
				infoTitle.text = "Resistance Charm";
				infoText.text = "Uncomfortable to wear, but it is pretty protectable!\nThis Charm helps you resist health drain by over 50%!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.resCharmCollected) ? "SOLD" : "20 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.resCharmCollected)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 18:
				infoTitle.text = "Auto Dodge Charm";
				infoText.text = "This Charm makes you agile, meaning\nyou're hard to be hit by enemies!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.autoCharmCollected) ? "SOLD" : "25 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.autoCharmCollected)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}

			case 19:
				infoTitle.text = "Healing Charm";
				infoText.text = "Don't you just hate when you lose health?\nDon't worry, this Charm gives you the\nability to regain health!\nYou have 10 uses per song!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: " + ((ClientPrefs.healCharmCollected) ? "SOLD" : "25 Tokens") + " | Your Tokens: " + ClientPrefs.tokens;
				if (ClientPrefs.healCharmCollected)
				{
					buy.alpha = 0;
					equipped.alpha = 1;
				}
		}
	}

	function processTransaction(id:Int)
	{
		switch(id)
		{
			case 0:
				if (ClientPrefs.tokens >= 20 && !ClientPrefs.legacyWeekFound)
				{
					ClientPrefs.tokens -= 20;
					ClientPrefs.legacyWeekFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.bonusUnlocked = true;

					NotificationAlert.sendCategoryNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
									
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();

					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 1:
				if (ClientPrefs.tokens >= 15 && !ClientPrefs.nunsationalFound)
				{
					ClientPrefs.tokens -= 15;
					ClientPrefs.nunsationalFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 2:
				if (ClientPrefs.tokens >= 20 && !ClientPrefs.lustalityFound)
				{
					ClientPrefs.tokens -= 20;
					ClientPrefs.lustalityFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 3:
				if (ClientPrefs.tokens >= 12 && !ClientPrefs.tofuFound)
				{
					ClientPrefs.tokens -= 12;
					ClientPrefs.tofuFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 4:
				if (ClientPrefs.tokens >= 15 && !ClientPrefs.marcochromeFound)
				{
					ClientPrefs.tokens -= 15;
					ClientPrefs.marcochromeFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 5:
				if (ClientPrefs.tokens >= 15 && !ClientPrefs.morkyWeekFound)
				{
					ClientPrefs.tokens -= 15;
					ClientPrefs.morkyWeekFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.bonusUnlocked = true;

					NotificationAlert.sendCategoryNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
									
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 6:
				if (!ClientPrefs.fnvFound)
				{
					ClientPrefs.fnvFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 7:
				if (ClientPrefs.tokens >= 1 && !ClientPrefs.shortFound)
				{
					ClientPrefs.tokens -= 1;
					ClientPrefs.shortFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 8:
				if (ClientPrefs.tokens >= 15 && !ClientPrefs.nicFound)
				{
					ClientPrefs.tokens -= 15;
					ClientPrefs.nicFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 9:
				if (ClientPrefs.tokens >= 20 && !ClientPrefs.infatuationFound)
				{
					ClientPrefs.tokens -= 20;
					ClientPrefs.infatuationFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 10:
				if (ClientPrefs.tokens >= 15 && !ClientPrefs.rainyDazeFound)
				{
					ClientPrefs.tokens -= 15;
					ClientPrefs.rainyDazeFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 11:
				if (ClientPrefs.tokens >= 7 && !ClientPrefs.debugFound)
				{
					ClientPrefs.tokens -= 7;
					ClientPrefs.debugFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 12:
				if (ClientPrefs.tokens >= 20 && !ClientPrefs.susWeekFound)
				{
					ClientPrefs.tokens -= 20;
					ClientPrefs.susWeekFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.bonusUnlocked = true;

					NotificationAlert.sendCategoryNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
									
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 13:
				if (ClientPrefs.tokens >= 25 && !ClientPrefs.dsideWeekFound)
				{
					ClientPrefs.tokens -= 25;
					ClientPrefs.dsideWeekFound = true;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.bonusUnlocked = true;

					NotificationAlert.sendCategoryNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
									
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 14:
				if (ClientPrefs.tokens >= 75 && !ClientPrefs.zeelNakedPics)
				{
					ClientPrefs.tokens -= 75;
					ClientPrefs.zeelNakedPics = true;
					ClientPrefs.saveSettings();

					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 15:
				if (ClientPrefs.tokens >= 15 && !ClientPrefs.trampolineUnlocked)
				{
					ClientPrefs.tokens -= 15;
					ClientPrefs.trampolineUnlocked = true;

					NotificationAlert.sendOptionsNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
									
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();

					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 16:
				if (ClientPrefs.tokens >= 3)
				{
					ClientPrefs.tokens -= 3;
					ClientPrefs.eggs += 1;
					ClientPrefs.saveSettings();

					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 17:
				if (ClientPrefs.tokens >= 20 && !ClientPrefs.resCharmCollected)
				{
					ClientPrefs.tokens -= 20;
					ClientPrefs.resCharmCollected = true;

					NotificationAlert.showMessage(this, 'Normal', true);
					NotificationAlert.sendInventoryNotification = true;
					NotificationAlert.saveNotifications();

					ClientPrefs.saveSettings();

					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 18:
				if (ClientPrefs.tokens >= 25 && !ClientPrefs.autoCharmCollected)
				{
					ClientPrefs.tokens -= 25;
					ClientPrefs.autoCharmCollected = true;

					NotificationAlert.showMessage(this, 'Normal', true);
					NotificationAlert.sendInventoryNotification = true;
					NotificationAlert.saveNotifications();

					ClientPrefs.saveSettings();

					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			case 19:
				if (ClientPrefs.tokens >= 25 && !ClientPrefs.healCharmCollected)
				{
					ClientPrefs.tokens -= 25;
					ClientPrefs.healCharmCollected = true;

					NotificationAlert.showMessage(this, 'Normal', true);
					NotificationAlert.sendInventoryNotification = true;
					NotificationAlert.saveNotifications();

					ClientPrefs.saveSettings();

					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
		}

		setUpInfoPanel(id);
	}

	function giveAchievement(achievement:String) {
		add(new AchievementObject(achievement, camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "' + achievement + '"');
	}

	function ending()
	{
		switch(assistNum)
		{
			case 1 | 2:
				assistant.offset.set(0, 0); //Idle 1 / 2
			case 3:
				assistant.offset.set(0, 18); //Talk 3
		}	
		
		assistant.animation.play('idleMain');
	}

	function endingSecret()
	{
		assistantSecret.animation.play('liz');
		assistantSecret.offset.set(0, 0);
	}

	var allowTap:Bool = false;
	function getChoiceNumber(timer:FlxTimer)
	{
		if (ClientPrefs.choiceSelected && !ended && ClientPrefs.tokens >= 0)
		{
			allowTap = true;
			switch(shelfSelected)
			{
				case 1:
					choiceNumber = FlxG.random.int(1, 7);
				case 2:
					choiceNumber = FlxG.random.int(8, 14);
				case 3:
					choiceNumber = FlxG.random.int(15, 19);
			}
			choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
			var bgTimerAgain:FlxTimer = new FlxTimer().start(0.06, getChoiceNumber);
		}
	}
}