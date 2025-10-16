package;

import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.text.FlxTypeText;
import flash.text.TextField;
import lime.utils.Assets;

import flixel.addons.display.FlxGridOverlay;
import openfl.utils.Assets as OpenFlAssets;
import Achievements;

import flash.system.System;

class ShopState extends MusicBeatState
{
	private var camAchievement:FlxCamera;

	var transitionSprite:FlxSprite;
	
	// NORMAL SHOP ASSETS
	// Main Shop
	var mainBG:FlxSprite;
	var closedShop:FlxSprite;
	var bulb:FlxSprite;

	// Main Merchant Variables
	var assistant:FlxSprite;
	var animNum:Int = 0;
	var assistantOffsets:Array<Array<Float>> = [ // OffsetX, OffsetY
		[0, 0],
		[0, 0],
		[0, 18],
		[96, 3],
		[8, -1],
		[0, 5]
	];

	//Test Your Luck Assets
	var luckSelectionProperties:Array<Array<Float>> = [ // X (Normal), X (Out of Bounds)
		[-130, 1400],
		[780, 2480],
		[90, 1660],
		[250, 1710],
		[330, 1710],
		[330, 1710],
		[330, 1480]
	];

	var testYourLuckBG:FlxSprite;
	var tokenShow:FlxText;
	var choice:FlxSprite;
	var spaceText:FlxSprite;
	var testLuckButton:FlxSprite;
	var notEnoughTokensText:FlxSprite;
	var flickerTween:FlxTween;

	var pressedEnter:Int = 0;
	var blackOut:FlxSprite;

	var luckOptionSlots:FlxTypedGroup<FlxSprite>;

	//Dialogue
	var dialogueNumber:Int = 0;
	var dialogueText:String;
	var merchantDialogue:FlxTypeText;
	
	

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
		[50, 160, "prize_16"], // Prize 12 (Marauder)
		[250, 160, "prize_17"], // Prize 13 (Sus Week)
		[450, 160, "prize_18"], // Prize 14 (D-sides Week)
		[650, 260, "prize_Zeel"], // Prize 15 (Zeel)
		[850, 260, "prize_Trampoline"], // Prize 16 (Trampoline)
		[1050, 160, "prize_Egg"], // Prize 17 (Egg)
		[50, 315, "prize_7"], // Prize 18 (R.Charm) -> Number 7
		[1050, 160, "prize_12"], // Prize 19 (A.Charm) -> Number 12
		[1050, 160, "prize_19"], // Prize 20 (H.Charm) -> Number 19
	];

	//Pool Section Assets
	var infoText:FlxText;
	var infoTitle:FlxText;
	var lights:FlxSprite;

	//SECRET SHOP ASSETS
	var sellSlots:FlxTypedGroup<FlxSprite>;

	// Zeel
	var chestHitbox:FlxSprite;
	var assistantSecret:FlxSprite;
	var secretAssistantOffsets:Array<Array<Float>> = [ // OffsetX, OffsetY
		[110, 36], // Talking
		[-13, 42] // Pissed
	];

	//Dialogue
	var secretMerchantDialogue:FlxTypeText;

	//Purchasable Items Section
	var buyItemsBG:FlxSprite;
	var buy:FlxSprite;
	var equipped:FlxSprite;

	//Video Sprites
	var videoDone:Bool = false;
	var initializedVideo:Bool = false;

	#if DEBUG_ALLOWED
	function debugReset()
	{
		ClientPrefs.nunWeekFound = true;
		ClientPrefs.nunWeekPlayed = true;
		ClientPrefs.kianaWeekFound = true;
		ClientPrefs.kianaWeekPlayed = true;
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
	}
	#end

	override function create()
	{
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Inside the Shops", null);
		#end

		ClientPrefs.choiceSelected = ClientPrefs.luckSelected = ClientPrefs.sellSelected = ClientPrefs.itemInfo = false;
		
		FlxG.sound.playMusic(Paths.music('shopTheme'), 0);
		FlxG.sound.music.fadeIn(3.0); 

		if(!ClientPrefs.shopUnlocked)
		{
			closedShop = new FlxSprite().loadGraphic(Paths.image('shop/shopClosed'));
			closedShop.setGraphicSize(FlxG.width, FlxG.height);
			closedShop.antialiasing = ClientPrefs.globalAntialiasing;
			add(closedShop);
		}
		else
		{
			FlxG.sound.play(Paths.sound('shop/shopEnter'), 0.7);

			for (i in 0...luckSelectionProperties.length)
			{
				luckSelectionProperties[i][0] = MobileUtil.fixX(luckSelectionProperties[i][0] + 100);
				luckSelectionProperties[i][1] = MobileUtil.fixX(luckSelectionProperties[i][1] + 100);
			}

			transitionSprite = new FlxSprite(-FlxG.width - 90, 0).loadGraphic(Paths.image('shop/transition'));
			transitionSprite.antialiasing = ClientPrefs.globalAntialiasing;
			transitionSprite.scale.x = 1.5;
			add(transitionSprite);

			createShop("Mimiko");
			createShop("Zeel");

			//ONLY FOR WHEN YOU ACCESS THE SHOP FOR THE FIRST TIME!
			if (!ClientPrefs.shopShowcased) startDialogue("mimiko", "OH! ANOTHER CUSTOMER!\n[Press Enter To Continue]");
			else startDialogue("mimiko", "Greatings, welcome to my shop.");

			addTouchPad("LEFT_FULL", "B");
		}

		super.create();
	}

	var mobileFixes:Array<Float> = [];
	private function createShop(merchant:String = "mimiko")
	{
		switch(merchant.toLowerCase())
		{
			case "mimiko":
				// Create Background
				mainBG = new FlxSprite().loadGraphic(Paths.image('shop/Background'));
				mainBG.setGraphicSize(FlxG.width, FlxG.height);
				mainBG.screenCenter(XY);
				mobileFixes.push(mainBG.x);
				mainBG.antialiasing = ClientPrefs.globalAntialiasing;
				add(mainBG);

				// Machine Slots
				luckOptionSlots = new FlxTypedGroup<FlxSprite>();
				add(luckOptionSlots);
				for (i in 0...3)
				{
					var button:FlxSprite = new FlxSprite().loadGraphic(Paths.image('shop/Buttons'));
					button.frames = Paths.getSparrowAtlas('shop/Buttons');
					button.antialiasing = ClientPrefs.globalAntialiasing;
					button.ID = i;
					button.animation.addByPrefix('shine', 'slot ' + (i + 1), 24, true);
					if (i > 0) button.animation.addByPrefix('locked', 'locked slot ' + (i + 1), 24, true);
					button.screenCenter(); button.updateHitbox();
					luckOptionSlots.add(button);

					button.animation.play('shine'); // Default Anim to play
					switch(i)
					{
						case 0:
							button.x += 350;
							button.y -= 200;
						case 1:
							button.animation.play((ClientPrefs.nunWeekPlayed) ? 'shine' : "locked");
							button.x += (ClientPrefs.nunWeekPlayed) ? 350 : 355;
							button.y -= 10;	
						
						case 2:
							button.animation.play((ClientPrefs.kianaWeekPlayed) ? 'shine' : "locked");
							button.x += (ClientPrefs.kianaWeekPlayed) ? 350 : 355;
							button.y += 180;		
					}

					button.x = MobileUtil.fixX(button.x);
				}

				// Assistant Setup
				animNum = FlxG.random.int(0, 2);
				assistant = new FlxSprite(0, 110).loadGraphic(Paths.image('shop/Mimiko Merchant'));
				assistant.frames = Paths.getSparrowAtlas('shop/Mimiko Merchant');
				assistant.animation.addByPrefix('idle', 'mimiko idle ' + (animNum + 1), 24, true);
				assistant.animation.addByPrefix('talk', 'mimiko talk ' + (animNum + 1), 24, true);
				assistantReset();
				assistant.antialiasing = ClientPrefs.globalAntialiasing;
				add(assistant);

				bulb = new FlxSprite(-430, -10).loadGraphic(Paths.image('shop/bulb'));
				bulb.frames = Paths.getSparrowAtlas('shop/bulb');
				bulb.animation.addByPrefix('swing', 'swing', 13, true);
				bulb.animation.play('swing');
				bulb.antialiasing = ClientPrefs.globalAntialiasing;
				add(bulb);

				merchantDialogue = new FlxTypeText(0, 0, 600, "Hey there, Welcome to my shop.", 32, true);
				merchantDialogue.font = 'VCR OSD Mono';
				merchantDialogue.color = FlxColor.WHITE;
				merchantDialogue.alignment = CENTER;
				merchantDialogue.borderStyle = OUTLINE;
				merchantDialogue.borderColor = FlxColor.BLACK;
				merchantDialogue.borderSize = 3;
				merchantDialogue.setTypingVariation(0.55, true);
				merchantDialogue.sounds = [FlxG.sound.load(Paths.sound('shopDialogue'), 0.4)];

				//Test Your Luck Assets preparation
				testYourLuckBG = new FlxSprite(luckSelectionProperties[0][1], 0).loadGraphic(Paths.image('shop/testYourLuckBG1'));
				testYourLuckBG.antialiasing = ClientPrefs.globalAntialiasing;
				testYourLuckBG.scale.x = 1.1;
				add(testYourLuckBG);

				tokenShow = new FlxText(luckSelectionProperties[1][1], 335, FlxG.width, "Tokens: " + ClientPrefs.tokens, 32);
				tokenShow.setFormat("VCR OSD Mono", 60, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
				tokenShow.borderSize = 5;
				CustomFontFormats.addMarkers(tokenShow);
				add(tokenShow);

				lights = new FlxSprite(luckSelectionProperties[2][1], 180).loadGraphic(Paths.image('shop/lights'));
				lights.frames = Paths.getSparrowAtlas('shop/lights');
				lights.animation.addByPrefix('redlightsFlash', 'redLights0', 24, true);
				lights.animation.addByPrefix('greenlightsFlash', 'greenLights0', 24, true);
				lights.animation.addByPrefix('bluelightsFlash', 'blueLights0', 24, true);
				lights.animation.play('redlightsFlash');
				lights.scrollFactor.set();
				lights.antialiasing = ClientPrefs.globalAntialiasing;
				add(lights);

				choice = new FlxSprite(luckSelectionProperties[3][1], 280).loadGraphic(Paths.image('shop/prizes/prize_' + FlxG.random.int(1, 14)));
				choice.antialiasing = ClientPrefs.globalAntialiasing;
				choice.scale.x = 2.1;
				choice.scale.y = 2.1;
				add(choice);

				testLuckButton = new FlxSprite(luckSelectionProperties[4][1], 550).loadGraphic(Paths.image('shop/testLuckButton'));
				testLuckButton.antialiasing = ClientPrefs.globalAntialiasing;
				add(testLuckButton);

				spaceText = new FlxSprite(luckSelectionProperties[5][1], 550).loadGraphic(Paths.image('shop/pressSpace'));
				spaceText.antialiasing = ClientPrefs.globalAntialiasing;
				spaceText.alpha = 0;
				add(spaceText);

				notEnoughTokensText = new FlxSprite(luckSelectionProperties[6][1], 550).loadGraphic(Paths.image('shop/notEnoughTokens'));
				notEnoughTokensText.antialiasing = ClientPrefs.globalAntialiasing;
				notEnoughTokensText.alpha = 0;
				add(notEnoughTokensText);

			case "zeel":
				// Zeel
				assistantSecret = new FlxSprite(-FlxG.width - 720, 205).loadGraphic(Paths.image('shop/Liz Shopper'));
				assistantSecret.frames = Paths.getSparrowAtlas('shop/Liz Shopper');
				assistantSecret.scale.set(1.2, 1.2);
				assistantSecret.animation.addByPrefix('liz', 'Liz idle', 24, true);
				assistantSecret.animation.addByPrefix('talking', 'Liz talk', 24, true);
				assistantSecret.animation.addByPrefix('whyutouchbooba', 'Liz pissed', 24, true);
				assistantSecret.updateHitbox();
				assistantSecret.antialiasing = ClientPrefs.globalAntialiasing;
				add(assistantSecret);
				zeelReset();

				// Chest Hitbox
				chestHitbox = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/thatBoobaHitbox'));
				chestHitbox.screenCenter();
				chestHitbox.scale.set(1.25, 1.25);
				chestHitbox.visible = false; chestHitbox.x -= 2130; chestHitbox.y += 160;
				chestHitbox.updateHitbox();
				add(chestHitbox);

				// Dialogue for Zeel
				secretMerchantDialogue = new FlxTypeText(-2130, 30, 600, (ClientPrefs.secretShopShowcased) ? "Hey there, looks like you have finally found your way here!" : "Oh hello there! [Press Enter To Continue]", 32, true);
				secretMerchantDialogue.font = 'VCR OSD Mono';
				secretMerchantDialogue.color = FlxColor.WHITE;
				secretMerchantDialogue.alignment = CENTER;
				secretMerchantDialogue.setTypingVariation(0.55, true);
				secretMerchantDialogue.sounds = [FlxG.sound.load(Paths.sound('shopDialogue'), 0.4)];
				add(secretMerchantDialogue);

				// Sell Buttons
				sellSlots = new FlxTypedGroup<FlxSprite>();
				add(sellSlots);
				for (i in 0...3)
				{
					var locked:Bool = false;
					if ((i == 1 && !ClientPrefs.nunWeekPlayed) || (i == 2 && !ClientPrefs.kianaWeekPlayed)) locked = true;

					var button:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/sellOption' + (i + 1) + ((locked) ? "locked" : "")));
					button.antialiasing = ClientPrefs.globalAntialiasing;
					button.ID = i;
					button.scale.set(0.6, 0.6);
					button.screenCenter();
					button.updateHitbox();
					sellSlots.add(button);
					button.x -= 2620;

					switch(i)
					{
						case 0: button.y -= 80;
						case 1: button.y += 80;
						case 2: button.y += 250;		
					}
				}

				// Prize Slots with Info + Titles
				for (i in 0...prizeBoard.length)
				{
					prizeBoard[i][0] = MobileUtil.fixX(prizeBoard[i][0]);
					prizeBoard[i][1] = MobileUtil.fixY(prizeBoard[i][1]);
				}
				prizeSlots = new FlxTypedGroup<FlxSprite>();
				for (i in 0...20)
				{
					var prize:FlxSprite = new FlxSprite(prizeBoard[i][0], prizeBoard[i][1] + 1010).loadGraphic(Paths.image('shop/prizes/' + prizeBoard[i][2]));
					prize.antialiasing = ClientPrefs.globalAntialiasing;
					prize.ID = i;
					prizeSlots.add(prize);	
				}
				
				infoTitle = new FlxText(-10, 130, FlxG.width, "Test TItle", 32);
				infoTitle.setFormat("VCR OSD Mono", 60, FlxColor.WHITE, CENTER);
				infoTitle.alpha = 0;

				infoText = new FlxText(MobileUtil.fixX(250), 280, FlxG.width - 200, "Test Description", 25);
				infoText.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, LEFT);
				infoText.alpha = 0;

				buyItemsBG = new FlxSprite(0, 800).loadGraphic(Paths.image('shop/buyItemsBG'));
				buyItemsBG.setGraphicSize(FlxG.width, FlxG.height);
				buyItemsBG.screenCenter(X);
				buyItemsBG.antialiasing = ClientPrefs.globalAntialiasing;
				add(buyItemsBG);

				blackOut = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
				blackOut.alpha = 0;
				add(blackOut);
				add(merchantDialogue);

				buy = new FlxSprite().loadGraphic(Paths.image('shop/buy'));
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
		}
	}

	var allowInput:Bool = true;
	var tokensRunOut:Bool = false;
	var choiceNumber:Int = 0;
	var ended:Bool = true;
	var shelfSelected:Int = 0;
	var currentShop:String = "mimiko";

	//Zeel's other achievements
	var touchedBoobies:Int = 0;
	override function update(elapsed:Float)
	{
		var back:Bool = controls.BACK || FlxG.mouse.justPressedRight;

		if (!ClientPrefs.shopUnlocked)
		{
			if (back) exitShop();
					
			//run a timer in case user does not press backspace.
			new FlxTimer().start(5, function (_) { exitShop(); });
		}
		else 
		{
			// Token Show
			if (ClientPrefs.tokens > 0) tokenShow.text = "Tokens: <GR>" + ClientPrefs.tokens + "<GR>";
			else tokenShow.text = "Tokens: <R>" + ClientPrefs.tokens + "<R>";
			CustomFontFormats.addMarkers(tokenShow);

			super.update(elapsed);

			// Showcase Code
			if (!ClientPrefs.shopShowcased)
			{
				if (controls.ACCEPT || TouchUtil.pressAction())
				{
					switch (pressedEnter)
					{
						case 0: dialogueText = "Greetings Good person! My name is Mimiko, and I am a travelling merchant!\n[Press Enter To Continue]";
						case 1: dialogueText = "Instead of selling stuff, you can win everything you want via gambling on my Prize Machines!\n[Press Enter To Continue]";
						case 2: dialogueText = "In order to use my machines, press whichever of the 3 Prize Machine buttons on your right!\n[Press Enter To Continue]";
						case 3: dialogueText = "My prizes vary between each machine, hence why we have 3 Machines here!\n[Press Enter To Continue]";
						case 4:
							luckSelectionTween();
							FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							dialogueText = "Taking a turn only costs 1 token each time! If you have more than 1, you're good to go!\n[Press Enter To Continue]";

						case 5: dialogueText = "Each Prize Machine has a different variety of items to win, so try to win them all!\n[Press Enter To Continue]";				
						case 6: dialogueText = "To use my Machine, click on the button below to start rolling the items! Once you're ready, press SPACE, and see what you'll earn!\n[Press Enter To Continue]";		
						case 7: dialogueText = "Beware though! Winning an item will not remove it from the Prize Machine, so if you earn it again, it will act like a miss, and your token will be wasted!\n[Press Enter To Continue]";
						case 8:
							luckSelectionTween(true);
							FlxTween.tween(blackOut, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							dialogueText = "Other than that, remember to use your mouse cursor to move around! Have fun shopping!\n[Press Enter To Continue]";
						case 9:
							dialogueText = " ";
							ClientPrefs.shopShowcased = true;
							ClientPrefs.saveSettings();
					}
					pressedEnter++;
					startDialogue("mimiko", dialogueText);
				}
			}
			else
			{
				if (back && allowInput)
				{
					//Prize Pool Section
					if (ClientPrefs.itemInfo) exitShop("PrizePool");
					//Test your Luck Section
					else if (ClientPrefs.luckSelected && !ClientPrefs.choiceSelected) exitShop("luckSection")
					//Sell Selection
					else if (ClientPrefs.sellSelected && !ClientPrefs.itemInfo) exitShop("sellSection");
					else if (ClientPrefs.choiceSelected || choiceNumber == 4)  //DON'T GO BACK IF YOU'RE USING THE LUCK SECTION
					{
						//Do nothing lmao
					}
					else exitShop();
				}
				
				// 'Shop Completed' Achievement Check
				var achieveID:Int = Achievements.getAchievementIndex('shop_completed');
				if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
				{
					var totalChecks:Int = 0;
					var checks:Array<String> = ["nunsational", "lustality", "tofu", "marcochrome", "fnv", "short", "nic", "infatuation", "rainyDaze", "debug",
					"morkyWeek", "susWeek", "legacyWeek", "dsideWeek"];
					for (i in 0...checks.length) totalChecks += (Reflect.field(ClientPrefs, '${checks[i]}Found')) ? 1 : 0;
					if (totalChecks == checks.length) giveAchievement("shop_completed", achieveID);
				}

				switch(currentShop)
				{
					case "mimiko":
						//THIS WHOLE SECTION IS FOR MIMIKO'S SHOP

						#if DEBUG_ALLOWED
						if (FlxG.keys.justPressed.EIGHT) ClientPrefs.tokens += 1;			
						if (FlxG.keys.justPressed.SEVEN && ClientPrefs.tokens > 0) ClientPrefs.tokens -= 1;
						#end

						if (allowInput)
						{		
							// Button Checks
							if (!ClientPrefs.luckSelected && !ClientPrefs.choiceSelected) checkButtons("Main");
							// Shop Button Triggers
							buttonTrigger("Main");
						
							//Dialogue
							if(TouchUtil.pressAction(assistant) && !ClientPrefs.luckSelected
							&& (!TouchUtil.overlaps(luckOptionSlots.members[0]) && !TouchUtil.overlaps(luckOptionSlots.members[1]) && !TouchUtil.overlaps(luckOptionSlots.members[2])))
							{
								dialogueNumber = FlxG.random.int(1, 40);

								switch (dialogueNumber)
								{
									case 1: dialogueText = "My products depend on what my customer wants.";
									case 2: dialogueText = "I'm aware that I'm in a game you know.";
									case 3: dialogueText = "Don't worry, none of these are canon to the main week.";
									case 4: dialogueText = "I love scamming people.";
									case 5: dialogueText = "Your fate was sealed the moment you started your journey.";
									case 6: dialogueText = "Keep grinding those tokens! You might be able to use em to someone else, other than me!";
									case 7: dialogueText = "Do you know 'Mr Cartridge Guy'? He's a great business man, but I don't like the way he interact with his customers..";
									case 8: dialogueText = "If you didn't notice yet, I have 9 disimbodied hands that I can control! Do you think you can you find them all?";
									case 9: dialogueText = "N E V E R USE THE DOOR TO YOUR LEFT.";
									case 10: dialogueText = "Go test your luck now!";
									case 11: dialogueText = "I love tokens.";
									case 12: dialogueText = "I'm not the only Mechant in this game... But I don't want you to meet her.";
									case 13: dialogueText = "Little blue balls man is dead.";
									case 14: dialogueText = "The world is full of obvious things.";
									case 15: dialogueText = "You want something free from me?? I'm not like other people. Now get to gambling.";
									case 16: dialogueText = "Hello TC.";
									case 17: dialogueText = "I don't sell things, I give away my stuff here.";
									case 18: dialogueText = "You can Examine the prizes at the prize pool.";
									case 19: dialogueText = "She thicc af bro";
									case 20: dialogueText = "You don't have to go to your left or up. Just saying..";
									case 21: dialogueText = "They're masterworks all, you can't go wrong.";
									case 22: dialogueText = "Whaddya want??";
									case 23: dialogueText = "There's a selection of good things for you to win, Stranger! ";
									case 24: dialogueText = "Tokens?";
									case 25: dialogueText = "It's a pleasure to see you safe. How's things going?";
									case 26: dialogueText = "Olah, Kumare!";
									case 27: dialogueText = "Don't worry, I got an eternity worth of living. Can you say the same?";
									case 28: dialogueText = "I go to college and make u proud!";
									case 29: dialogueText = "Looking to protect your self, or deal some damage?";
									case 30: dialogueText = "I used have a Religious Fanatic friend.\nI wonder where she is now..";
									case 31: dialogueText = "Papers? I have a lot of those stored in my Cellar-\nI-I mean Attic.";
									case 32: dialogueText = "Trouble's PRESSING on you and still come UP to the top is a big W!!";
									case 33: dialogueText = "if you see any other vendors, don't buy from them.\nJust gamble from me.";
									case 34: dialogueText = "The Cellar hasn't been cleaned so don't go down there.\nWait, what Cellar?";
									case 35: dialogueText = "There is no \"upstairs\", what are you talking about?";
									case 36: dialogueText = "Father would be so proud of his vessel.";
									case 37: dialogueText = "Use charms, trigger that Mayhem thing and turn the tide!";
									case 38: dialogueText = "Oh the Dearest Family, nothing but inspiration!";
									case 39: dialogueText = "Mr. Mixter not only makes good drinks, but he has some fire beats too!";
									case 40: dialogueText = "Explode Infants!";
								}

								startDialogue("mimiko", dialogueText);
							}

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
				
								choiceTimer = new FlxTimer().start(0.05, getChoiceNumber);	

								FlxTween.tween(testLuckButton, {y: testLuckButton.y + 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
								FlxTween.tween(spaceText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							}
							if ((controls.ACCEPT || TouchUtil.pressAction(spaceText)) && ClientPrefs.choiceSelected && !ended)
							{
								if (choiceTimer != null) choiceTimer.cancel();
								FlxG.sound.play(Paths.sound('confirmMenu'));
								giveItem();
								ended = true;
							}
						}

					case "zeel":
						//Dialogue + Achievement
						if (!ClientPrefs.secretShopShowcased)
						{
							new FlxTimer().start(1.8, function (tmr:FlxTimer) {
								var achieveZeelID:Int = Achievements.getAchievementIndex('zeel_found');
								if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveZeelID][2])) {
									giveAchievement("zeel_found", achieveZeelID);
									ClientPrefs.saveSettings();
								}
							});

							if (controls.ACCEPT || TouchUtil.pressAction())
							{
								//trace ("Pressed Enter : " + pressedEnter);
								switch (pressedEnter)
								{
									case 0: dialogueText = "Haven't had any customers since last update~\n[Press Enter To Continue]";	
									case 1: dialogueText = "I don't want to bother you with questions, so I'll be straight forward this time~\n[Press Enter To Continue]";
									case 2: dialogueText = "If you wish to buy anything that this 'Mimiko' guy lets you win, click on any of the shelfs~\n[Press Enter To Continue]";
									case 3: dialogueText = "Each shelf contains specific items that are inside the corresponding prize machine~\n[Press Enter To Continue]";
									case 4: dialogueText = "Have fun shopping~ Don't hesitate to ask me anything~\n[Press Enter To Continue]";
									case 5:
									{
										dialogueText = " ";
										ClientPrefs.secretShopShowcased = true;
										trace('Secret Shop Sequence Complete, Changes Saved.');
									}
								}
								pressedEnter += 1;
								startDialogue("Zeel", dialogueText);
							}
						}
						else
						{
							if (allowInput)
							{
								if (!ClientPrefs.sellSelected && !ClientPrefs.itemInfo) checkButtons("Zeel");
								buttonTrigger("Zeel");
								if(TouchUtil.pressAction(assistantSecret) && !ClientPrefs.sellSelected)
								{
									if (TouchUtil.overlaps(chestHitbox))
									{
										touchedBoobies += 1;
										var dialNum = FlxG.random.int(1, 18);
										switch (dialNum)
										{
											case 1: dialogueText = "Hey! Didn't your parents teach you not to poke any girls boobs? >:(";
											case 2: dialogueText = "Woah there, don't touch those!";
											case 3: dialogueText = "Jesus, are you that desperate to touch these?!";
											case 4: dialogueText = "Back off!\nI'm just a shopkeeper!";
											case 5: dialogueText = "What are you, a pervert?!";
											case 6: dialogueText = "This was not nice of you!\nYou'll make me increase the prizes!";
											case 7: dialogueText = "Go touch grass instead of my boobs!";
											case 8: dialogueText = "HEY! My eyes are up here!";
											case 9: dialogueText = "These are not made to be poked on!";
											case 10: dialogueText = "NO, do NOT touch these.";
											case 11: dialogueText = "Do you ACTUALLY do this behind that screen?";
											case 12: dialogueText = "You're being disgusting!";
											case 13: dialogueText = "This is harrassment, you know that?";
											case 14: dialogueText = "Such degeneracy!";
											case 15: dialogueText = "I don't care if my original variant is (possibly) fine with this, I do not enjoy this whatsoever!";
											case 16: dialogueText = "How would you like it if people poked your boobs?!";
											case 17: dialogueText = "That's really disturbing!\nStop this instant!";
											case 18: dialogueText = "If I were to touch your private parts like this, would you enjoy it?!?!";
										}
										startDialogue("Zeel", dialogueText, true);

										var achieveZeelBoobaID:Int = Achievements.getAchievementIndex('pervert');
										if((!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveZeelBoobaID][2])) && touchedBoobies == 1) {
											giveAchievement("pervert", achieveZeelBoobaID);
											ClientPrefs.saveSettings();
										}

										var achieveZeelBoobaX25ID:Int = Achievements.getAchievementIndex('pervertX25');
										if((!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveZeelBoobaX25ID][2])) && touchedBoobies == 25) {
											giveAchievement("pervertX25", achieveZeelBoobaX25ID);
											ClientPrefs.saveSettings();
										}
									}
									else
									{
										var dialNum = FlxG.random.int(1, 23);
										switch (dialNum)
										{
											case 1: dialogueText = "I know I'm hot, but you're here to buy stuff, unless you want to try your luck over there.";
											case 2: dialogueText = "Isn't it weird that there's a random lady selling random stuff in the middle of a complete void?\nYea, I find it weird too.";
											case 3: dialogueText = "Hey, what's with that look?\nHave you never seen any female shopkeeper before?";
											case 4: dialogueText = "Do I look familiar to you?";
											case 5: dialogueText = "So how's it going?\nWhat's your game's status so far?";
											case 6: dialogueText = "Use your mouse to navigate through here!\nIt's not that hard to understand.";
											case 7: dialogueText = "No, don't even think of fantasizing about me.";
											case 8: dialogueText = "Nice to meet you player!\nMy name's Zeel~";
											case 9: dialogueText = "I may be a variant of Liz, but I'm not like her.";
											case 10: dialogueText = "No, I'm not behaving suspiciously right now.\nKeep it together!";
											case 11: dialogueText = "You know you can press the RIGHT ARROW to go back to Mimiko's shop, right?";
											case 12: dialogueText = "I sell a few extra stuff that the other mere shopkeeper doesn't by the way~";
											case 13: dialogueText = "It may be dark in here, but it definitely is cozy~";
											case 14: dialogueText = "Oh, you like my big personality?";
											case 15: dialogueText = "A mishap's on the go!\nStill love that line~";
											case 16: dialogueText = "These charms look like they'd help you a ton~";
											case 17: dialogueText = "I wonder how long have I been in here..";
											case 18: dialogueText = "Buying is better than gambling, am I right?~";
											case 19: dialogueText = "What's the matter?\nI'm open to hearing about you~";
											case 20: dialogueText = "...Are you here to do window shopping?";
											case 21: dialogueText = "It's nice to be alone sometimes..\nbut it's more fun to have company..";
											case 22: dialogueText = "My prices are guaranteed to make you proud of your purchases!";
											case 23: dialogueText = "Waiting...";
										}
										startDialogue("Zeel", dialogueText);
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
											if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
											
											allowInput = false;
											ClientPrefs.itemInfo = true;
											prizeSelected = prize.ID;
											FlxG.sound.play(Paths.sound('scrollMenu'));
							
											var x:Float = 0;
											var y:Float = 0;
											switch(shelfSelected)
											{
												case 1: x = prizeSlots.members[0].x; y = prizeSlots.members[0].y;
												case 2: x = prizeSlots.members[6].x; y = prizeSlots.members[6].y;
												case 3: x = prizeSlots.members[11].x; y = prizeSlots.members[11].y;
											}

											FlxTween.tween(prize, {x: x, y: y, "scale.x": 1.4, "scale.y": 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											prizeSlots.forEach(function (prize:FlxSprite)
											{
												if (prize.ID != prizeSelected) FlxTween.tween(prize, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											});
											FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											buy.alpha = 1;
											equipped.alpha = 0;
											FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

											new FlxTimer().start(0.8, function (tmr:FlxTimer) {
												allowInput = true;
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
											if (prize.ID == prizeSelected) processTransaction(prize.ID);
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
														if (FlxG.sound.music != null) FlxG.sound.music.stop();

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
												FlxG.sound.play(Paths.sound('confirmMenu'));
												LoadingState.loadAndSwitchState(new options.OptionsState());
											}
										}
									}
								}
							}
							
						}
				}

				// Changing Shops code snippet
				if (allowInput)
				{
					if (controls.UI_LEFT_P && !ClientPrefs.sellSelected && currentShop == "mimiko")
					{
						allowInput = false;
						merchantDialogue.skip();
						assistantReset();
						currentShop = "zeel";

						FlxG.sound.play(Paths.sound('confirmMenu'));
						FlxTween.tween(mainBG, {x: 2000}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						luckOptionSlots.forEach(function(button:FlxSprite)
						{
							FlxTween.tween(button, {x: 2670}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						});
						FlxTween.tween(assistant, {x: 2070}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(merchantDialogue, {x: 2000}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(lights, {x: 2070}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(transitionSprite, {x: 1500}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(bulb, {x: 1600}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							
						new FlxTimer().start(2, function (_)
						{
							sellSlots.forEach(function(butt:FlxSprite)
							{
								FlxTween.tween(butt, {x: 200}, 1.8 + (butt.ID * 0.04), {ease: FlxEase.cubeInOut, type: PERSIST});
							});
							FlxTween.tween(chestHitbox, {x: MobileUtil.fixX(780)}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(assistantSecret, {x: MobileUtil.fixX(740)}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(secretMerchantDialogue, {x: 130}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						});
									
						new FlxTimer().start(3.7, function (_) {
							allowInput = true;
							if (!ClientPrefs.secretShopShowcased)
							{
								startDialogue("zeel", "Why hello to my favourite customer~! [Press Enter To Continue]");
								pressedEnter = 0;
							}
							else startDialogue("zeel", "Hello Handsome~~");
							#if DISCORD_ALLOWED
							DiscordClient.changePresence("In Zeel's Secret Shop", null);
							#end
						});
					}
					if (controls.UI_RIGHT_P && !ClientPrefs.luckSelected && ClientPrefs.secretShopShowcased && currentShop == "zeel") // Return to normal shop
					{
						allowInput = false;
						secretMerchantDialogue.skip();
						zeelReset();
						currentShop = "mimiko";

						FlxG.sound.play(Paths.sound('confirmMenu'));
						sellSlots.forEach(function(butt:FlxSprite)
						{
							FlxTween.tween(butt, {x: -2900}, 1.8 + (butt.ID * 0.04), {ease: FlxEase.cubeInOut, type: PERSIST});
						});
						FlxTween.tween(chestHitbox, {x: -2630}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(assistantSecret, {x: -2670}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(secretMerchantDialogue, {x: -2400}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});

						new FlxTimer().start(2, function (tmr:FlxTimer) {
							FlxTween.tween(mainBG, {x: mobileFixes[0]}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							luckOptionSlots.forEach(function(button:FlxSprite)
							{
								var offset:Int = 0;
								switch(button.ID)
								{
									case 1: if (!ClientPrefs.nunWeekPlayed) offset = 5;
									case 2: if (!ClientPrefs.kianaWeekPlayed) offset = 5;
								}	
								FlxTween.tween(button, {x: MobileUtil.fixX(780 + offset)}, 1.8 + (button.ID * 0.04), {ease: FlxEase.cubeInOut, type: PERSIST});	
							});
							FlxTween.tween(assistant, {x: -10}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(lights, {x: MobileUtil.fixX(1470)}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(bulb, {x: -400}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(merchantDialogue, {x: 0}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						
							FlxTween.tween(transitionSprite, {x: -1500}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						});
						new FlxTimer().start(3.7, function (tmr:FlxTimer) {
						if (!ClientPrefs.talkedToZeel)
							{
								ClientPrefs.talkedToZeel = true;
								ClientPrefs.saveSettings();
							}
							allowInput = true;
							startDialogue("mimiko", "Welcome back player.");
						});
					}
					if (controls.UI_UP_P && currentShop == "mimiko" && !ClientPrefs.sellSelected && !ClientPrefs.luckSelected)
					{
						allowInput = true;
						//Dialogue reset
						merchantDialogue.skip();
						FlxG.sound.play(Paths.sound('scrollMenu'));

						transitionSprite.alpha = 0;
						FlxTween.tween(mainBG, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
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
		}		
	}

	function checkButtons(shop:String)
	{
		switch(shop)
		{
			case "Main":
				luckOptionSlots.forEach(function(button:FlxSprite)
				{
					if (TouchUtil.overlaps(button))
						button.alpha = 1;
					else
						button.alpha = 0.6;
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
						startDialogue("Mimiko", " ");
						var locked = (button.ID == 1 && !ClientPrefs.nunWeekPlayed) || (button.ID == 2 && !ClientPrefs.kianaWeekPlayed);
						var lightColors:Array<String> = ['red', 'blue', 'green'];
						
						if (locked)
						{
							FlxG.sound.play(Paths.sound('accessDenied'));
							FlxG.camera.shake(0.01, 0.2, null, true, FlxAxes.XY);
						}
						else
						{
							if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
							FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
							ClientPrefs.luckSelected = true;
							merchantDialogue.skip();

							shelfSelected = button.ID + 1;
							testYourLuckBG.loadGraphic(Paths.image('shop/testYourLuckBG$shelfSelected'));
							
							switch(button.ID)
							{
								case 0: choiceNumber = FlxG.random.int(1, 7);
								case 1: choiceNumber = FlxG.random.int(8, 14);
								case 2: choiceNumber = FlxG.random.int(15, 20);
							}
							choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
									
							lights.animation.play('${lightColors[button.ID]}lightsFlash');
							luckSelectionTween(false);
						}
					}
				});

			case "Zeel":
				sellSlots.forEach(function(button:FlxSprite)
				{
					if (TouchUtil.pressAction(button) && !ClientPrefs.sellSelected)
					{
						var locked = (button.ID == 1 && !ClientPrefs.nunWeekPlayed) || (button.ID == 2 && !ClientPrefs.kianaWeekPlayed);
						if (locked)
						{
							FlxG.sound.play(Paths.sound('accessDenied'));
							FlxG.camera.shake(0.01, 0.2, null, true, FlxAxes.XY);
						}
						else
						{
							if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
							FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
							ClientPrefs.sellSelected = true;
							secretMerchantDialogue.skip();

							shelfSelected = button.ID + 1;

							FlxTween.tween(buyItemsBG, {y: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							switch(button.ID)
							{
								case 0:
									prizeSlots.members[14].x = MobileUtil.fixX(250);
									prizeSlots.members[15].x = MobileUtil.fixX(450);
									prizeSlots.members[16].x = MobileUtil.fixX(650);
									prizeSlots.forEach(function (prize:FlxSprite)
									{
										if (prize.ID <= 5) FlxTween.tween(prize, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										else if (prize.ID >= 14 && prize.ID <= 17) FlxTween.tween(prize, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									});
								
								case 1:
									prizeSlots.members[14].x = MobileUtil.fixX(50);
									prizeSlots.members[15].x = MobileUtil.fixX(250);
									prizeSlots.members[16].x = MobileUtil.fixX(450);
									prizeSlots.forEach(function (prize:FlxSprite)
									{
										if ((prize.ID >= 6 && prize.ID <= 10) || prize.ID == 18) FlxTween.tween(prize, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										else if (prize.ID >= 14 && prize.ID <= 16) FlxTween.tween(prize, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									});
			
								case 2:
									prizeSlots.members[14].x = MobileUtil.fixX(650);
									prizeSlots.members[15].x = MobileUtil.fixX(850);
									prizeSlots.members[16].x = MobileUtil.fixX(50);
									prizeSlots.forEach(function (prize:FlxSprite)
									{
										if ((prize.ID >= 11 && prize.ID <= 15) || prize.ID == 19) FlxTween.tween(prize, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										else if (prize.ID == 16) FlxTween.tween(prize, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									});
							}
							removeTouchPad();
							addTouchPad("NONE", "B");
						}
					}
				});
		}
	}

	function exitShop(from:String = null)
	{
		allowInput = false;
		FlxG.sound.play(Paths.sound('cancelMenu'));
		switch(from.toLowerCase())
		{
			case "prizepool":
				prizeSlots.forEach(function(prize:FlxSprite)
				{
					var x:Float = 0;
					var y:Float = 0;

					switch (prize.ID)
					{
						case 14:
							switch(shelfSelected)
							{
								case 1: x = 250; y = 315;
								case 2: x = 50; y = 315;
								case 3: x = 650; y = 160;
							}
							x = MobileUtil.fixX(x);
						case 15:
							switch(shelfSelected)
							{
								case 1: x = 450; y = 315;
								case 2: x = 250; y = 315;
								case 3: x = 850; y = 160;
							}
							x = MobileUtil.fixX(x);
						case 16:
							switch(shelfSelected)
							{
								case 1: x = 650; y = 315;
								case 2: x = 450; y = 315;
								case 3: x = 50; y = 315;
							}
							x = MobileUtil.fixX(x);

						default:
							x = prizeBoard[prize.ID][0];
							switch(shelfSelected)
							{
								case 1:
									if ((prize.ID >= 0 && prize.ID <= 5) || prize.ID == 17) y = prizeBoard[prize.ID][1];
									else y = 1010;
								case 2:
									if ((prize.ID >= 6 && prize.ID <= 10) || prize.ID == 18) y = prizeBoard[prize.ID][1];
									else y = 1010;
								case 3:
									if ((prize.ID >= 11 && prize.ID <= 13) || prize.ID == 19) y = prizeBoard[prize.ID][1];
									else y = 1010;
							}
					}

					FlxTween.tween(prize, {x: x, y: y, "scale.x": 1, "scale.y": 1, alpha: 0.3}, 0.6, {ease: FlxEase.cubeInOut, type: PERSIST});
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
					allowInput = true;
					ClientPrefs.itemInfo = false;
				});
			
			case "lucksection":
				shelfSelected = 0;
				luckSelectionTween(true);

				new FlxTimer().start(0.6, function (tmr:FlxTimer) {
					allowInput = false;
					ClientPrefs.luckSelected = false;
				});

			case "sellsection":
				FlxTween.tween(buyItemsBG, {y: 800}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				prizeSlots.forEach(function(prize:FlxSprite)
				{
					FlxTween.tween(prize, {y: (prize.ID > 13) ? 1070 : 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				});

				shelfSelected = 0;
				new FlxTimer().start(0.6, function (tmr:FlxTimer) {
					allowInput = true;
					ClientPrefs.sellSelected = false;
				});
				removeTouchPad();
				addTouchPad("LEFT_FULL", "B");
			
			default:
				FlxG.sound.music.fadeOut(0.4);
				MusicBeatState.switchState(new MainMenuState(), "stickers");
		}
	}

	function giveItem()
	{
		var gotItemSuccessfully:Bool = false;
		if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		switch(choiceNumber)
		{
			case 1:
				trace('YAY, LEGACY WEEK [OPTION 1] IS SELECTED');
				if (!ClientPrefs.legacyWeekFound)
				{	
					gotItemSuccessfully = true;
					ClientPrefs.legacyWeekFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.bonusUnlocked = true;

					NotificationAlert.sendCategoryNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
								
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();
				}
			case 2:
				trace('YAY, NUNSATIONAL [OPTION 2] IS SELECTED');
				if (!ClientPrefs.nunsationalFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.nunsationalFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);
					ClientPrefs.saveSettings();
				}

			case 3:
				trace('YAY, LUSTALITY [OPTION 3] IS SELECTED');
				if (!ClientPrefs.lustalityFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.lustalityFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);
					ClientPrefs.saveSettings();
				}
			case 4:
				trace('YAY, TOFU [OPTION 4] IS SELECTED');
				if (!ClientPrefs.tofuFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.tofuFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);
					ClientPrefs.saveSettings();
				}
			case 5:
				trace('YAY, MARCOCHROME [OPTION 5] IS SELECTED');
				if (!ClientPrefs.marcochromeFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.marcochromeFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);
					ClientPrefs.saveSettings();
				}
			case 6: //THIS GIVES YOU 3 TOKENS
				gotItemSuccessfully = true;
				ClientPrefs.tokens += 3;
			case 7:
				trace('YAY, RESISTANCE CHARM [OPTION 7] IS SELECTED');
				if (!ClientPrefs.resCharmCollected)
				{
					gotItemSuccessfully = true;
					ClientPrefs.resCharmCollected = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;

					NotificationAlert.showMessage(this, 'Normal', true);
					NotificationAlert.sendInventoryNotification = true;
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();
				}
			case 8:
				trace('YAY, JOKE WEEK [OPTION 8] IS SELECTED');
				if (!ClientPrefs.morkyWeekFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.morkyWeekFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.bonusUnlocked = true;

					NotificationAlert.sendCategoryNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
								
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();
				}
			case 9:
				trace('YAY, FNV [OPTION 10] IS SELECTED');
				if (!ClientPrefs.fnvFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.fnvFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);
					ClientPrefs.saveSettings();
				}
			case 10:
				trace('YAY, 0.0015 [OPTION 11] IS SELECTED');
				if (!ClientPrefs.shortFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.shortFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);
					ClientPrefs.saveSettings();
				}
			case 11:
				trace('YAY, SLOW.FLP [OPTION 12] IS SELECTED');
				if (!ClientPrefs.nicFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.nicFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);
					ClientPrefs.saveSettings();
				}
			case 12:
				trace('YAY, AUTO DODGE CHARM [OPTION 13] IS SELECTED');
				if (!ClientPrefs.autoCharmCollected)
				{
					gotItemSuccessfully = true;
					ClientPrefs.autoCharmCollected = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;

					NotificationAlert.showMessage(this, 'Normal', true);
					NotificationAlert.sendInventoryNotification = true;
					NotificationAlert.saveNotifications();
				}
			case 13: //THIS GIVES OFF 5 TOKENS
				gotItemSuccessfully = true;
				ClientPrefs.tokens += 5;

			case 14:
				trace('YAY, FANFUCK FOREVER [OPTION 15] IS SELECTED');
				if (!ClientPrefs.infatuationFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.infatuationFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);

					ClientPrefs.saveSettings();
				}
			case 15:
				trace('YAY, RAINY DAZE [OPTION 16] IS SELECTED');
				if (!ClientPrefs.rainyDazeFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.rainyDazeFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);
					ClientPrefs.saveSettings();
				}
			case 16:
				trace('YAY, MARAUDER [OPTION 17] IS SELECTED');
				if (!ClientPrefs.debugFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.debugFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.xtraUnlocked = true;

					NotificationAlert.showMessage(this, 'Freeplay', true);						
					ClientPrefs.saveSettings();
				}
			case 17:
				trace('YAY, SUS WEEK [OPTION 18] IS SELECTED');
				if (!ClientPrefs.susWeekFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.susWeekFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.bonusUnlocked = true;

					NotificationAlert.sendCategoryNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
								
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();
				}
			case 18:
				trace('YAY, D-SIDES WEEK [OPTION 19] IS SELECTED');
				if (!ClientPrefs.dsideWeekFound)
				{
					gotItemSuccessfully = true;
					ClientPrefs.dsideWeekFound = true;
					ClientPrefs.choiceSelected = false;
					ClientPrefs.songsUnlocked += 1;
					ClientPrefs.bonusUnlocked = true;

					NotificationAlert.sendCategoryNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
								
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();
				}
			case 19:
				trace('YAY, HEALING CHARM [OPTION 20] IS SELECTED');
				if (!ClientPrefs.healCharmCollected)
				{
					gotItemSuccessfully = true;
					ClientPrefs.healCharmCollected = true;
					ClientPrefs.choiceSelected = false;

					NotificationAlert.sendInventoryNotification = true;
					NotificationAlert.showMessage(this, 'Normal', true);
								
					NotificationAlert.saveNotifications();
					ClientPrefs.saveSettings();
				}
		}

		new FlxTimer().start(0.5, function (_) {
			FlxG.sound.play(Paths.sound((gotItemSuccessfully) ? 'hooray' : "boo"), 0.5);
		});
		if (gotItemSuccessfully) flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
		revertLuck();
	}

	function revertLuck()
	{
		new FlxTimer().start(1.5, function (tmr:FlxTimer) {
			if (ClientPrefs.tokens != 0) FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			else FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			
			FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			
			if (flickerTween != null) flickerTween.cancel();

			ClientPrefs.choiceSelected = false;
			ClientPrefs.saveSettings();
		});
	}
	
	function checkPrizeOverlap()
	{
		prizeSlots.forEach(function (prize:FlxSprite)
		{
			prize.alpha = (TouchUtil.overlaps(prize)) ? 1 : 0.3;
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
					\nItem Cost: 2 | Your Tokens: " + ClientPrefs.tokens + " | Eggs Owned: " + ClientPrefs.eggs;

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

	// Must be in order!!
	var itemInformation:Array<Array<Dynamic>> = [ // Token Number, itemName To Check, Item Type, Notification Type, ID
		[20, "legacyWeek", "bonus", "Normal", 0],
		[15, "nunsational", "xtra", "Freeplay", 1],
		[20, "lustality", "xtra", "Freeplay", 2],
		[12, "tofu", "xtra", "Freeplay", 3],
		[15, "marcochrome", "xtra", "Freeplay", 4],
		[15, "morkyWeek", "bonus", "Normal", 5],
		[0, "fnv", "xtra", "Freeplay", 6],
		[1, "short", "xtra", "Freeplay", 7],
		[15, "nic", "xtra", "Freeplay", 8],
		[20, "infatuation", "xtra", "Freeplay", 9],
		[15, "rainyDaze", "xtra", "Freeplay", 10],
		[7, "debug", "xtra", "Freeplay", 11],
		[20, "susWeek", "bonus", "Normal", 12],
		[25, "dsideWeek", "bonus", "Normal", 13]
	];
	function processTransaction(id:Int)
	{
		if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		switch(id)
		{
			case 14:
				if (ClientPrefs.tokens >= 75 && !ClientPrefs.zeelNakedPics)
				{
					ClientPrefs.tokens -= 75;
					ClientPrefs.zeelNakedPics = true;
					ClientPrefs.saveSettings();

					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
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

			case 16:
				if (ClientPrefs.tokens >= 2)
				{
					ClientPrefs.tokens -= 2;
					ClientPrefs.eggs += 1;
					ClientPrefs.saveSettings();

					FlxG.sound.play(Paths.sound('confirmMenu'), 0.5);
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
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
			
			default:
				var isUnlocked:Dynamic = Reflect.field(ClientPrefs, '${itemInformation[id][1]}Found');

				for (i in 0...itemInformation.length)
				{
					var validID = (itemInformation[i][4] == id);
					if (ClientPrefs.tokens >= itemInformation[i][0] && !isUnlocked && validID)
					{
						FlxG.sound.play(Paths.sound('confirmMenu'));
						
						ClientPrefs.tokens -= Std.int(itemInformation[i][0]);
						ClientPrefs.songsUnlocked += 1;

						Reflect.setField(ClientPrefs, '${itemInformation[i][1]}Found', true);
						Reflect.setField(ClientPrefs, '${itemInformation[i][1]}Unlocked', true);

						if (itemInformation[i][3].length > 0)
						{
							NotificationAlert.showMessage(this, itemInformation[id][3], true);
							if (itemInformation[i][3].toLowerCase() == "normal") 
							{
								NotificationAlert.sendCategoryNotification = true;									
								NotificationAlert.saveNotifications();
							}
						} 
						
						ClientPrefs.saveSettings();
					}
				}
		}
		setUpInfoPanel(id);
	}

	function giveAchievement(achievement:String, id:Int) {
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		add(new AchievementObject(achievement, camAchievement));

		Achievements.achievementsMap.set(Achievements.achievementsStuff[id][2], true);
		trace('Giving achievement "' + achievement + '"');
	}

	function startDialogue(merchant:String, dialText:String, ?isPissed:Bool = false)
	{
		if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		switch(merchant.toLowerCase())
		{
			case "mimiko":
				merchantDialogue.resetText(dialText); // Reset with text
				assistant.animation.play('talk'); // Play animation
				assistant.offset.set(assistantOffsets[animNum + 3][0], assistantOffsets[animNum + 3][1]); // Set Offsets
				merchantDialogue.start(0.04, true, assistantReset); // Start Typed Text Sequence

			case "zeel":
				secretMerchantDialogue.resetText(dialText);
				if (isPissed)
				{
					secretMerchantDialogue.start(0.03, true, zeelReset);
					assistantSecret.animation.play('whyutouchbooba');
					assistantSecret.offset.set(-13, 42);
				}
				else
				{
					secretMerchantDialogue.start(0.04, true, zeelReset);
					assistantSecret.animation.play('talking');
					assistantSecret.offset.set(110, 36);
				}
				
		}
	}

	function assistantReset()
	{
		assistant.animation.play('idle');
		assistant.offset.set(assistantOffsets[animNum][0], assistantOffsets[animNum][1]);
	}

	function zeelReset()
	{
		assistantSecret.animation.play('liz');
		assistantSecret.offset.set(0, 0);
	}

	var choiceTimer:FlxTimer;
	function getChoiceNumber(timer:FlxTimer)
	{
		if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.025, 0.125, 0.5);
		ended = false;
		if (ClientPrefs.choiceSelected && !ended && ClientPrefs.tokens >= 0)
		{
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
			choiceTimer = new FlxTimer().start(0.05, getChoiceNumber);
		}
	}

	private function luckSelectionTween(tweenOut:Bool = false)
	{
		var selection:Int = (tweenOut) ? 1 : 0;
		FlxTween.tween(testYourLuckBG, {x: luckSelectionProperties[0][selection]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
		FlxTween.tween(tokenShow, {x: luckSelectionProperties[1][selection]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
		FlxTween.tween(lights, {x: luckSelectionProperties[2][selection]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
		FlxTween.tween(choice, {x: luckSelectionProperties[3][selection]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
		FlxTween.tween(testLuckButton, {x: luckSelectionProperties[4][selection]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
		FlxTween.tween(spaceText, {x: luckSelectionProperties[5][selection]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
		FlxTween.tween(notEnoughTokensText, {x: luckSelectionProperties[6][selection]}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

		new FlxTimer().start(0.8, function (tmr:FlxTimer) {
			allowInput = true;
		});
	}
}