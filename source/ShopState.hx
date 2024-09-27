package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.math.FlxRandom;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.text.FlxTypeText;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxAxes;

import editors.ChartingState;
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import flixel.FlxCamera;
import Achievements;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

import vlc.MP4Handler;
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

	var luckOptionSlot1:FlxSprite;
	var luckOptionSlot2:FlxSprite;
	var luckOptionSlot3:FlxSprite;

	//Dialogue
	var dialogueNumber:Int = 0;
	var dialogueText:FlxText;
	var merchantDialogue:FlxTypeText;
	var assistant:FlxSprite;
	var assistNum:Int = 0;

	//Items
	var prize1:FlxSprite;
	var prize2:FlxSprite;
	var prize3:FlxSprite;
	var prize4:FlxSprite;
	var prize5:FlxSprite;
	var prize6:FlxSprite;
	var prize7:FlxSprite;
	var prize8:FlxSprite;
	var prize9:FlxSprite;
	var prize10:FlxSprite;
	var prize11:FlxSprite;
	var prize12:FlxSprite;
	var prize13:FlxSprite;
	var prize14:FlxSprite;

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
	var sellOption1:FlxSprite;
	var sellOption2:FlxSprite;
	var sellOption3:FlxSprite;
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
	var prizeZeel:FlxSprite;
	var prizeTrampoline:FlxSprite;
	var prizeEgg:FlxSprite;

	//Video Sprites
	var videoDone:Bool = false;
	var initializedVideo:Bool = false;

	//Charm Items
	var charmsBG:FlxSprite;
	var charmPrize1:FlxSprite;
	var charmPrize2:FlxSprite;
	var charmPrize3:FlxSprite;
	var charmPrize1X:Int = 0;
	var charmPrize1Y:Int = 0;
	var charmPrize2X:Int = 0;
	var charmPrize2Y:Int = 0;
	var charmPrize3X:Int = 0;
	var charmPrize3Y:Int = 0;

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
		
		FlxG.mouse.visible = true;
		FlxG.sound.playMusic(Paths.music('shopTheme'), 0);
		FlxG.sound.music.fadeIn(3.0); 

		if(ClientPrefs.shopUnlocked == false)
		{
			closedShop = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/shopClosed'));
			closedShop.antialiasing = ClientPrefs.globalAntialiasing;
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

			transitionOoooOo = new FlxSprite(-1370, 0).loadGraphic(Paths.image('shop/transition'));
			transitionOoooOo.antialiasing = ClientPrefs.globalAntialiasing;
			transitionOoooOo.scale.x = 1.5;
			add(transitionOoooOo);
			
			background = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/Background'));
			background.antialiasing = ClientPrefs.globalAntialiasing;
			add(background);

			luckOptionSlot1 = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/Buttons'));
			luckOptionSlot1.frames = Paths.getSparrowAtlas('shop/Buttons');//here put the name of the xml
			luckOptionSlot1.antialiasing = ClientPrefs.globalAntialiasing;
			luckOptionSlot1.animation.addByPrefix('shine', 'slot 1', 24, true);//on 'idle normal' change it to your xml one
			luckOptionSlot1.animation.play('shine');
			luckOptionSlot1.screenCenter();
			luckOptionSlot1.x += 350;
			luckOptionSlot1.y -= 200;
			luckOptionSlot1.updateHitbox();
			add(luckOptionSlot1);

			luckOptionSlot2 = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/Buttons'));
			luckOptionSlot2.frames = Paths.getSparrowAtlas('shop/Buttons');//here put the name of the xml
			luckOptionSlot2.antialiasing = ClientPrefs.globalAntialiasing;
			luckOptionSlot2.animation.addByPrefix('shine', 'slot 2', 24, true);//on 'idle normal' change it to your xml one
			luckOptionSlot2.animation.addByPrefix('locked', 'locked slot 2', 24, true);
			luckOptionSlot2.screenCenter();
			if (ClientPrefs.nunWeekPlayed == true)
				{
					
					luckOptionSlot2.animation.play('shine');
					luckOptionSlot2.x += 350;
					luckOptionSlot2.y -= 10;
				}
			else
				{
					luckOptionSlot2.animation.play('locked');
					luckOptionSlot2.x += 355;
					luckOptionSlot2.y -= 10;
				}			
			luckOptionSlot2.updateHitbox();
			add(luckOptionSlot2);

			luckOptionSlot3 = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/Buttons'));
			luckOptionSlot3.frames = Paths.getSparrowAtlas('shop/Buttons');//here put the name of the xml
			luckOptionSlot3.antialiasing = ClientPrefs.globalAntialiasing;
			luckOptionSlot3.animation.addByPrefix('shine', 'slot 3', 24, true);//on 'idle normal' change it to your xml one
			luckOptionSlot3.animation.addByPrefix('locked', 'locked slot 3', 24, true);
			luckOptionSlot3.screenCenter();
			if (ClientPrefs.kianaWeekPlayed == true)
				{
					luckOptionSlot3.animation.play('shine');
					luckOptionSlot3.x += 350;
					luckOptionSlot3.y += 180;
				}
			else
				{
					luckOptionSlot3.animation.play('locked');
					luckOptionSlot3.x += 355;
					luckOptionSlot3.y += 180;
				}			
			luckOptionSlot3.updateHitbox();
			add(luckOptionSlot3);

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

			//Normal Prizes
			prize1 = new FlxSprite(50, 100).loadGraphic(Paths.image('shop/prizes/prize_1')); //Legacy Week
			prize1.antialiasing = ClientPrefs.globalAntialiasing;
			prize1.y += 1010;

			prize2 = new FlxSprite(250, 100).loadGraphic(Paths.image('shop/prizes/prize_2')); //Nunsational
			prize2.antialiasing = ClientPrefs.globalAntialiasing;
			prize2.y += 1010;

			prize3 = new FlxSprite(450, 100).loadGraphic(Paths.image('shop/prizes/prize_3')); //Lustality
			prize3.antialiasing = ClientPrefs.globalAntialiasing;
			prize3.y += 1010;

			prize4 = new FlxSprite(650, 100).loadGraphic(Paths.image('shop/prizes/prize_4')); //Tofu
			prize4.antialiasing = ClientPrefs.globalAntialiasing;
			prize4.y += 1010;

			prize5 = new FlxSprite(850, 100).loadGraphic(Paths.image('shop/prizes/prize_5')); //Marcochrome
			prize5.antialiasing = ClientPrefs.globalAntialiasing;
			prize5.y += 1010;

			prize6 = new FlxSprite(1050, 100).loadGraphic(Paths.image('shop/prizes/prize_8')); //Joke Week
			prize6.antialiasing = ClientPrefs.globalAntialiasing;
			prize6.y += 1010;

			prize7 = new FlxSprite(50, 180).loadGraphic(Paths.image('shop/prizes/prize_9')); //FNV
			prize7.antialiasing = ClientPrefs.globalAntialiasing;
			prize7.y += 1010;

			prize8 = new FlxSprite(250, 180).loadGraphic(Paths.image('shop/prizes/prize_10')); //0.0015
			prize8.antialiasing = ClientPrefs.globalAntialiasing;
			prize8.y += 1010;

			prize9 = new FlxSprite(450, 180).loadGraphic(Paths.image('shop/prizes/prize_11')); //Slow.FLP
			prize9.antialiasing = ClientPrefs.globalAntialiasing;
			prize9.y += 1010;

			prize10 = new FlxSprite(650, 180).loadGraphic(Paths.image('shop/prizes/prize_14')); //FanFuck Forever
			prize10.antialiasing = ClientPrefs.globalAntialiasing;
			prize10.y += 1010;

			prize11 = new FlxSprite(850, 180).loadGraphic(Paths.image('shop/prizes/prize_15')); //Rainy Daze
			prize11.antialiasing = ClientPrefs.globalAntialiasing;
			prize11.y += 1010;

			prize12 = new FlxSprite(50, 260).loadGraphic(Paths.image('shop/prizes/prize_16')); //Marauder
			prize12.antialiasing = ClientPrefs.globalAntialiasing;
			prize12.y += 1010;

			prize13 = new FlxSprite(250, 260).loadGraphic(Paths.image('shop/prizes/prize_17')); //Sus Week
			prize13.antialiasing = ClientPrefs.globalAntialiasing;
			prize13.y += 1010;

			prize14 = new FlxSprite(450, 260).loadGraphic(Paths.image('shop/prizes/prize_18')); //D-sides Week
			prize14.antialiasing = ClientPrefs.globalAntialiasing;
			prize14.y += 1010;

			prizeZeel = new FlxSprite(650, 260).loadGraphic(Paths.image('shop/prizes/prize_Zeel'));
			prizeZeel.antialiasing = ClientPrefs.globalAntialiasing;
			prizeZeel.y += 1010;

			prizeTrampoline = new FlxSprite(850, 260).loadGraphic(Paths.image('shop/prizes/prize_Trampoline'));
			prizeTrampoline.antialiasing = ClientPrefs.globalAntialiasing;
			prizeTrampoline.y += 1010;

			prizeEgg = new FlxSprite(1050, 260).loadGraphic(Paths.image('shop/prizes/prize_Egg'));
			prizeEgg.antialiasing = ClientPrefs.globalAntialiasing;
			prizeEgg.y += 1010;

			charmPrize1 = new FlxSprite(50, 260).loadGraphic(Paths.image('shop/prizes/prize_7')); //Resistance Charm
			charmPrize1.antialiasing = ClientPrefs.globalAntialiasing;
			charmPrize1.y += 1010;

			charmPrize2 = new FlxSprite(1050, 180).loadGraphic(Paths.image('shop/prizes/prize_12')); //Auto Dodge Charm
			charmPrize2.antialiasing = ClientPrefs.globalAntialiasing;
			charmPrize2.y += 1010;

			charmPrize3 = new FlxSprite(1050, 180).loadGraphic(Paths.image('shop/prizes/prize_19')); //Healing Charm
			charmPrize3.antialiasing = ClientPrefs.globalAntialiasing;
			charmPrize3.y += 1010;

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
			testYourLuckBG = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/testYourLuckBG1'));
			testYourLuckBG.antialiasing = ClientPrefs.globalAntialiasing;
			testYourLuckBG.x += 1400;
			testYourLuckBG.scale.x = 1.1;
			add(testYourLuckBG);
			

			tokenShow = new FlxText(820, 335, FlxG.width,
				"Tokens: " + ClientPrefs.tokens,
				32);
				tokenShow.setFormat("VCR OSD Mono", 60, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
				tokenShow.x += 1700;
				tokenShow.borderSize = 5;

				CustomFontFormats.addMarkers(tokenShow);
			add(tokenShow);

			choice = new FlxSprite(460, 280).loadGraphic(Paths.image('shop/prizes/prize_' + FlxG.random.int(1, 14)));
			choice.antialiasing = ClientPrefs.globalAntialiasing;
			choice.scale.x = 2.1;
			choice.scale.y = 2.1;
			choice.x += 1400;
			add(choice);

			lights = new FlxSprite(1580, 180).loadGraphic(Paths.image('shop/lights'));//put your cords and image here
			lights.frames = Paths.getSparrowAtlas('shop/lights');//here put the name of the xml
			//lights.scale.set(1.1, 1.1);
			lights.animation.addByPrefix('redlightsFlash', 'redLights0', 24, true);//on 'idle normal' change it to your xml one
			lights.animation.addByPrefix('greenlightsFlash', 'greenLights0', 24, true);
			lights.animation.addByPrefix('bluelightsFlash', 'blueLights0', 24, true);
			lights.animation.play('redlightsFlash');//you can rename the anim however you want to
			lights.scrollFactor.set();
			lights.antialiasing = ClientPrefs.globalAntialiasing;
			add(lights);
		
			testLuckButton = new FlxSprite(330, 550).loadGraphic(Paths.image('shop/testLuckButton'));
			testLuckButton.antialiasing = ClientPrefs.globalAntialiasing;
			testLuckButton.x += 1400;
			add(testLuckButton);
			

			spaceText = new FlxSprite(630, 550).loadGraphic(Paths.image('shop/pressSpace'));
			spaceText.antialiasing = ClientPrefs.globalAntialiasing;
			spaceText.alpha = 0;
			spaceText.x += 1400;
			add(spaceText);

			notEnoughTokensText = new FlxSprite(630, 550).loadGraphic(Paths.image('shop/notEnoughTokens'));
			notEnoughTokensText.antialiasing = ClientPrefs.globalAntialiasing;
			notEnoughTokensText.alpha = 0;
			notEnoughTokensText.x += 1400;
			add(notEnoughTokensText);
			
		//SECRET SHOP ASSETS
		backgroundSecret = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		backgroundSecret.antialiasing = ClientPrefs.globalAntialiasing;
		backgroundSecret.x -= 2000;
		add(backgroundSecret);

		assistantSecret = new FlxSprite(0, 205).loadGraphic(Paths.image('shop/Liz Shopper'));//put your cords and image here
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

		booba = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/thatBoobaHitbox'));
		booba.screenCenter();
		booba.scale.set(1.25, 1.25);
		booba.alpha = 0;
		booba.x -= 2130;
		booba.y += 160;
		booba.updateHitbox();
		add(booba);

		sellOption1 = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/sellOption1'));
		sellOption1.antialiasing = ClientPrefs.globalAntialiasing;
		sellOption1.screenCenter();
		sellOption1.x -= 2620;
		sellOption1.y -= 80;
		sellOption1.scale.set(0.6, 0.6);
		sellOption1.updateHitbox();
		add(sellOption1);

		if (ClientPrefs.nunWeekPlayed == true)
			sellOption2 = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/sellOption2'));
		else
			sellOption2 = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/sellOption2locked'));
		sellOption2.antialiasing = ClientPrefs.globalAntialiasing;
		sellOption2.screenCenter();
		sellOption2.x -= 2620;
		sellOption2.y += 80;
		sellOption2.scale.set(0.6, 0.6);
		sellOption2.updateHitbox();
		add(sellOption2);

		if (ClientPrefs.kianaWeekPlayed == true)
			sellOption3 = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/sellOption3'));
		else
			sellOption3 = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/sellOption3locked'));
		sellOption3.antialiasing = ClientPrefs.globalAntialiasing;
		sellOption3.screenCenter();
		sellOption3.x -= 2620;
		sellOption3.y += 250;
		sellOption3.scale.set(0.6, 0.6);
		sellOption3.updateHitbox();
		add(sellOption3);

		//dialogue
		dialogueTextSecret = new FlxText(0, 0, FlxG.width, "", 32);

		if (ClientPrefs.secretShopShowcased == false)
			secretMerchantDialogue = new FlxTypeText(-130, 30, 600, "Oh hello there! [Press Enter To Continue]", 32, true);
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
			showcaseSecretDialogue = new FlxTypeText(-130, 30, 600, "Oh hello there! [Press Enter To Continue]", 32, true);
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
		
		add(prize1);
		add(prize2);
		add(prize3);
		add(prize4);
		add(prize5);
		add(prize6);
		add(prize7);
		add(prize8);
		add(prize9);
		add(prize10);
		add(prize11);
		add(prize12);
		add(prize13);
		add(prize14);
		
		add(prizeZeel);
		add(prizeTrampoline);
		add(prizeEgg);

		add(charmPrize1);
		add(charmPrize2);
		add(charmPrize3);

		add(infoTitle);	
		add(infoText);
		add(equipped);
		add(buy);

		FlxTween.tween(buy, {y: 820}, 0.1, {ease: FlxEase.cubeInOut, type: PERSIST});
		FlxTween.tween(equipped, {y: 820}, 0.1, {ease: FlxEase.cubeInOut, type: PERSIST});

		//ONLY FOR WHEN YOU ACCESS THE SHOP FOR THE FIRST TIME!
		if (ClientPrefs.shopShowcased == false && firstTime == false)
		{
			showcaseDialogue = new FlxTypeText(0, 0, 600, "OH! ANOTHER CUSTOMER!\n[Press Enter To Continue]", 32, true);
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
		{
			merchantDialogue.start(0.04, true, ending);
		}
		}

		Achievements.loadAchievements();

		super.create();
	}

	var pressedBack:Bool = false;
	var pressedSpace:Bool = false;
	var tokensRunOut:Bool = false;
	var choiceNumber:Int = 0;
	var ended:Bool = true;
	var done:Bool = true;
	var gtfo:Bool = false;

	var shelfOneON:Bool = false;
	var shelfTwoON:Bool = false;
	var shelfThreeON:Bool = false;

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
		if (ClientPrefs.shopUnlocked == false)
			{
				if (FlxG.keys.justPressed.BACKSPACE)
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
		else if (ClientPrefs.shopShowcased == false)
			{
			if (FlxG.keys.justPressed.ENTER)
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
						dialogueText.text = "Greetings Good person! My name is Mimiko, and I am a travelling merchant!\n[Press Enter To Continue]";
					case 1:
						dialogueText.text = "Instead of selling stuff, you can win everything you want via gambling on my Prize Machines!\n[Press Enter To Continue]";
					case 2:
						dialogueText.text = "In order to use my machines, press whichever of the 3 Prize Machine buttons on your right!\n[Press Enter To Continue]";
					case 3:
						dialogueText.text = "My prizes vary between each machine, hence why we have 3 Machines here!\n[Press Enter To Continue]";
					case 4:
						{
							FlxTween.tween(testYourLuckBG, {x: -130}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(tokenShow, {x: 780}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			
							FlxTween.tween(lights, {x: 70}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							
							FlxTween.tween(choice, {x: 250}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(testLuckButton, {x: 310}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							
							FlxTween.tween(spaceText, {x: 310}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(notEnoughTokensText, {x: 310}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							dialogueText.text = "Taking a turn only costs 1 token each time! If you have more than 1, you're good to go!\n[Press Enter To Continue]";
						}
					case 5:
						dialogueText.text = "Each Prize Machine has a different variety of items to win, so try to win them all!\n[Press Enter To Continue]";				
					case 6:
						dialogueText.text = "To use my Machine, click on the button below to start rolling the items! Once you're ready, press SPACE, and see what you'll earn!\n[Press Enter To Continue]";		
					case 7:
						dialogueText.text = "Beware though! Winning an item will not remove it from the Prize Machine, so if you earn it again, it will act like a miss, and your token will be wasted!\n[Press Enter To Continue]";
					case 8:
						{
							FlxTween.tween(testYourLuckBG, {x: 1400}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(tokenShow, {x: 2480}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

							FlxTween.tween(choice, {x: 1660}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(testLuckButton, {x: 1710}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

							FlxTween.tween(spaceText, {x: 1710}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(notEnoughTokensText, {x: 1710}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							
							FlxTween.tween(lights, {x: 1480}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(blackOut, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							dialogueText.text = "Other than that, remember to use your mouse cursor to move around! Have fun shopping!\n[Press Enter To Continue]";
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
		if (ClientPrefs.nunsationalFound == true && ClientPrefs.lustalityFound == true && ClientPrefs.tofuFound == true && ClientPrefs.marcochromeFound == true 
			&& ClientPrefs.fnvFound == true && ClientPrefs.shortFound == true && ClientPrefs.nicFound == true && ClientPrefs.infatuationFound == true
			&& ClientPrefs.rainyDazeFound == true && ClientPrefs.debugFound == true 
			&& ClientPrefs.morkyWeekFound == true && ClientPrefs.susWeekFound == true && ClientPrefs.morkyWeekFound == true && ClientPrefs.dsideWeekFound == true)
		{
			var achieveID:Int = Achievements.getAchievementIndex('shop_completed');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) {
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveShopAchievement();
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
				if (ClientPrefs.itemInfo == true && pressedBack == false)
				{
					pressedBack = true;

					FlxG.sound.play(Paths.sound('cancelMenu'));
					if(infoTitle.text == "Legacy Week Pass" || infoTitle.text == "?????? ????")
						FlxTween.tween(prize1.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					if(infoTitle.text == "Nunsational Pass" || infoTitle.text == "???????????")
					{
						FlxTween.tween(prize2.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize2, {x: 250}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Lustality Pass" || infoTitle.text == "?????????")
					{
						FlxTween.tween(prize3.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize3, {x: 450}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Tofu Pass" || infoTitle.text == "????")
					{
						FlxTween.tween(prize4.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize4, {x: 650}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Marcochrome Pass" || infoTitle.text == "?????-??????")
					{
						FlxTween.tween(prize5.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize5, {x: 850}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Joke Week Pass" || infoTitle.text == "???? ????")
					{
						FlxTween.tween(prize6.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize6, {x: 1050}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "FNV Pass" || infoTitle.text == "???")
					{
						FlxTween.tween(prize7.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize7, {x: 50}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize7, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "0.0015 Pass" || infoTitle.text == "?.????")
					{
						FlxTween.tween(prize8.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize8, {x: 250}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize8, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Slow.FLP Pass" || infoTitle.text == "????.???")
					{
						FlxTween.tween(prize9.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize9, {x: 450}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize9, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Fanfuck Forever Pass" || infoTitle.text == "????????????")
					{
						FlxTween.tween(prize10.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize10, {x: 650}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize10, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Rainy Daze Pass" || infoTitle.text == "????? ????")
					{
						FlxTween.tween(prize11.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize11, {x: 850}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize11, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Marauder Pass" || infoTitle.text == "????????")
					{
						FlxTween.tween(prize12.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize12, {x: 50}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize12, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Sus Week Pass" || infoTitle.text == "??? ????")
					{
						FlxTween.tween(prize13.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize13, {x: 250}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize13, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "D-sides Week Pass" || infoTitle.text == "?-????? ????")
					{
						FlxTween.tween(prize14.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize14, {x: 450}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(prize14, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					if(infoTitle.text == "Zeel's Naked Pics")
					{
						FlxTween.tween(prizeZeel.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						if (shelfOneON == true)
						{
							FlxTween.tween(prizeZeel, {x: 250}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(prizeZeel, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						}
						else if (shelfTwoON == true)
						{
							FlxTween.tween(prizeZeel, {x: 50}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(prizeZeel, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						}
						else if (shelfThreeON == true)
						{
							FlxTween.tween(prizeZeel, {x: 650}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(prizeZeel, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						}
					}
					if(infoTitle.text == "Trampoline Mode")
					{
						FlxTween.tween(prizeTrampoline.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						if (shelfOneON == true)
						{
							FlxTween.tween(prizeTrampoline, {x: 450}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(prizeTrampoline, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						}
						else if (shelfTwoON == true)
						{
							FlxTween.tween(prizeTrampoline, {x: 250}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(prizeTrampoline, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						}
						else if (shelfThreeON == true)
						{
							FlxTween.tween(prizeTrampoline, {x: 850}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							FlxTween.tween(prizeTrampoline, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						}
					}
					if(infoTitle.text == "Egg")
						{
							FlxTween.tween(prizeEgg.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							if (shelfOneON == true)
							{
								FlxTween.tween(prizeEgg, {x: 650}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
								FlxTween.tween(prizeEgg, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							}
							if (shelfTwoON == true)
							{
								FlxTween.tween(prizeEgg, {x: 450}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
								FlxTween.tween(prizeEgg, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							}
							else if (shelfThreeON == true)
							{
								FlxTween.tween(prizeEgg, {x: 50}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
								FlxTween.tween(prizeEgg, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
							}
						}

					if(infoTitle.text == "Resistance Charm")
					{
						FlxTween.tween(charmPrize1.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(charmPrize1, {x: 50}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(charmPrize1, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}

					if(infoTitle.text == "Auto Dodge Charm")
					{
						FlxTween.tween(charmPrize2.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(charmPrize2, {x: 1050}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(charmPrize2, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}

					if(infoTitle.text == "Healing Charm")
					{
						FlxTween.tween(charmPrize3.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(charmPrize3, {x: 1050}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(charmPrize3, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					
					FlxTween.tween(blackOut, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(infoTitle, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(infoText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					FlxTween.tween(prize1, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize2, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize3, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize4, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize5, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize6, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize7, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize8, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize9, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize10, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize11, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize12, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize13, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize14, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					FlxTween.tween(prizeZeel, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeTrampoline, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeEgg, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					FlxTween.tween(charmPrize1, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(charmPrize2, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(charmPrize3, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					//sell normal items and charms shit
					if (ClientPrefs.sellSelected == true)
					{
						FlxTween.tween(buy, {y: 820}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(equipped, {y: 820}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
					
					new FlxTimer().start(0.6, function (tmr:FlxTimer) {
						pressedBack = false;
						ClientPrefs.itemInfo = false;
					});
				}
				//Test your Luck Section
				else if (ClientPrefs.luckSelected == true && ClientPrefs.choiceSelected == false && pressedBack == false)
				{
					pressedBack = true;
					shelfOneON = false;
					shelfTwoON = false;
					shelfThreeON = false;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(testYourLuckBG, {x: 1400}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(tokenShow, {x: 2480}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(choice, {x: 1660}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(testLuckButton, {x: 1710}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(spaceText, {x: 1710}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(notEnoughTokensText, {x: 1710}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(lights, {x: 1480}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					new FlxTimer().start(0.6, function (tmr:FlxTimer) {
						pressedBack = false;
						ClientPrefs.luckSelected = false;
					});
				}
				//Sell Selection
				else if (ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false && pressedBack == false)
				{
					pressedBack = true;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(buyItemsBG, {y: 800}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize1, {y: 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize2, {y: 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize3, {y: 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize4, {y: 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize5, {y: 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize6, {y: 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize7, {y: 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize8, {y: 1020}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize9, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize10, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize11, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize12, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize13, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize14, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(charmPrize1, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(charmPrize2, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(charmPrize3, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
					FlxTween.tween(prizeZeel, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeTrampoline, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeEgg, {y: 1070}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					shelfOneON = false;
					shelfTwoON = false;
					shelfThreeON = false;
					new FlxTimer().start(0.6, function (tmr:FlxTimer) {
						pressedBack = false;
						ClientPrefs.sellSelected = false;
					});
				}
				//Sell Selection
				else if (ClientPrefs.choiceSelected == true) //DON'T GO BACK IF YOU'RE USING THE LUCK SECTION
				{
					//Do nothing lmao
				}
				else if (choiceNumber == 4) //ONLY IF YOU WIN ANY OF THESE SONGS
				{
					//Do nothing lmao
				}
				else if (ClientPrefs.sellSelected == false && ClientPrefs.luckSelected == false && ClientPrefs.choiceSelected == false && ClientPrefs.itemInfo == false)
				{
					FlxG.sound.music.fadeOut(0.4);
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new MainMenuState(), 'stickers');
				}
			}
			
			//button thingies lmao
			if(FlxG.mouse.overlaps(luckOptionSlot1) && (ClientPrefs.sellSelected == false && ClientPrefs.luckSelected == false && ClientPrefs.choiceSelected == false && ClientPrefs.itemInfo == false))
            {
                luckOptionSlot1.alpha = 1;
            }
            else
            {
                luckOptionSlot1.alpha = 0.6;
            }
			if(FlxG.mouse.overlaps(luckOptionSlot2) && (ClientPrefs.sellSelected == false && ClientPrefs.luckSelected == false && ClientPrefs.choiceSelected == false && ClientPrefs.itemInfo == false))
			{
				luckOptionSlot2.alpha = 1;
			}
			else
			{
				luckOptionSlot2.alpha = 0.6;
			}
			if(FlxG.mouse.overlaps(luckOptionSlot3) && (ClientPrefs.sellSelected == false && ClientPrefs.luckSelected == false && ClientPrefs.choiceSelected == false && ClientPrefs.itemInfo == false))
            {
                luckOptionSlot3.alpha = 1;
            }
            else
            {
                luckOptionSlot3.alpha = 0.6;
            }
			//Dialogue
		if(FlxG.mouse.overlaps(assistant) && FlxG.mouse.justPressed && ClientPrefs.luckSelected == false && changedShop == false
			&& cellarShopActive == false
			&& (!FlxG.mouse.overlaps(luckOptionSlot1) && !FlxG.mouse.overlaps(luckOptionSlot2) && !FlxG.mouse.overlaps(luckOptionSlot3)))
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
							dialogueText.text = "Go test you luck now!";
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

			//Test your Luck Functtionality
			if (cellarShopActive == false)
			{
				if(FlxG.mouse.overlaps(luckOptionSlot1) && FlxG.mouse.justPressed && ClientPrefs.luckSelected == false)
				{
					merchantDialogue.skip();
					shelfOneON = true;
					choiceNumber = FlxG.random.int(1, 7);
					choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
					ClientPrefs.luckSelected = true;
					lights.animation.play('redlightsFlash');
					testYourLuckBG.loadGraphic(Paths.image('shop/testYourLuckBG1'));
					FlxTween.tween(testYourLuckBG, {x: -130}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(tokenShow, {x: 780}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					FlxTween.tween(lights, {x: 90}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
					FlxTween.tween(choice, {x: 250}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(testLuckButton, {x: 330}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
					FlxTween.tween(spaceText, {x: 330}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(notEnoughTokensText, {x: 330}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				if(FlxG.mouse.overlaps(luckOptionSlot2) && FlxG.mouse.justPressed && ClientPrefs.luckSelected == false && ClientPrefs.nunWeekPlayed == true)
				{
					merchantDialogue.skip();
					shelfTwoON = true;
					choiceNumber = FlxG.random.int(8, 14);
					choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
					ClientPrefs.luckSelected = true;
					lights.animation.play('bluelightsFlash');
					testYourLuckBG.loadGraphic(Paths.image('shop/testYourLuckBG2'));
					FlxTween.tween(testYourLuckBG, {x: -130}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(tokenShow, {x: 780}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					FlxTween.tween(lights, {x: 90}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
					FlxTween.tween(choice, {x: 250}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(testLuckButton, {x: 330}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
					FlxTween.tween(spaceText, {x: 330}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(notEnoughTokensText, {x: 330}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else if (FlxG.mouse.overlaps(luckOptionSlot2) && FlxG.mouse.justPressed && ClientPrefs.luckSelected == false && ClientPrefs.nunWeekPlayed == false)
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.01, 0.2, null, true, FlxAxes.XY);
				}
				if(FlxG.mouse.overlaps(luckOptionSlot3) && FlxG.mouse.justPressed && ClientPrefs.luckSelected == false && ClientPrefs.kianaWeekPlayed == true)
				{
					merchantDialogue.skip();
					shelfThreeON = true;
					choiceNumber = FlxG.random.int(15, 20);
					choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
					ClientPrefs.luckSelected = true;
					lights.animation.play('greenlightsFlash');
					testYourLuckBG.loadGraphic(Paths.image('shop/testYourLuckBG3'));
					FlxTween.tween(testYourLuckBG, {x: -130}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(tokenShow, {x: 780}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

					FlxTween.tween(lights, {x: 90}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
					FlxTween.tween(choice, {x: 250}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(testLuckButton, {x: 330}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
					FlxTween.tween(spaceText, {x: 330}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(notEnoughTokensText, {x: 330}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else if (FlxG.mouse.overlaps(luckOptionSlot3) && FlxG.mouse.justPressed && ClientPrefs.luckSelected == false && ClientPrefs.kianaWeekPlayed == false)
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.01, 0.2, null, true, FlxAxes.XY);
				}
			}
			
			if (ClientPrefs.tokens == 0 && tokensRunOut == false && ClientPrefs.choiceSelected == false)
			{
				FlxTween.tween(testLuckButton, {y: testLuckButton.y + 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				tokensRunOut = true;
			}
			if (ClientPrefs.tokens > 0 && tokensRunOut == true)
			{
				FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(notEnoughTokensText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				tokensRunOut = false;
			}
			if(FlxG.mouse.overlaps(testLuckButton) && FlxG.mouse.justPressed && ClientPrefs.luckSelected == true && ended == true && ClientPrefs.tokens > 0)
			{
				ClientPrefs.choiceSelected = true;
				ClientPrefs.tokens -= 1;
				ended = false;
				done = false;
				var bgTimer:FlxTimer = new FlxTimer().start(0.05, getChoiceNumber);	
				FlxG.sound.play(Paths.sound('shop/mouseClick'));
				FlxTween.tween(testLuckButton, {y: testLuckButton.y + 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(spaceText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			}
			if (controls.ACCEPT && pressedSpace == false && ClientPrefs.choiceSelected == true && done == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				pressedSpace = true;
				done = true;
			}
			if(pressedSpace)
			{
					ended = true;
					switch(choiceNumber)
					{
						case 1:
						{
							trace('YAY, LEGACY WEEK [OPTION 1] IS SELECTED');
							if (ClientPrefs.legacyWeekFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
								}
								else
								{
									new FlxTimer().start(0.5, function (tmr:FlxTimer) {
										FlxG.sound.play(Paths.sound('boo'), 0.5);
									});
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								}
						}
						case 2:
						{
							trace('YAY, NUNSATIONAL [OPTION 2] IS SELECTED');
							if (ClientPrefs.nunsationalFound == false)
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
								if (ClientPrefs.tokens != 0)
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										flickerTween.cancel();
										ClientPrefs.saveSettings();
									});
								}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										flickerTween.cancel();
										ClientPrefs.saveSettings();
									});
								}
							flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 3:
						{
							trace('YAY, LUSTALITY [OPTION 3] IS SELECTED');
							if (ClientPrefs.lustalityFound == false)
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
								if (ClientPrefs.tokens != 0)
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										flickerTween.cancel();
										ClientPrefs.saveSettings();
									});
								}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										flickerTween.cancel();
										ClientPrefs.saveSettings();
									});
								}
							flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 4:
						{
							trace('YAY, TOFU [OPTION 4] IS SELECTED');
							if (ClientPrefs.tofuFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 5:
						{
							trace('YAY, MARCOCHROME [OPTION 5] IS SELECTED');
							if (ClientPrefs.marcochromeFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 6: //THIS GIVES YOU 3 TOKENS
						{
							ClientPrefs.tokens += 3;
							new FlxTimer().start(0.5, function (tmr:FlxTimer) {
								FlxG.sound.play(Paths.sound('hooray'), 0.5);
							});
							if (ClientPrefs.tokens != 0)
							{
								new FlxTimer().start(1.5, function (tmr:FlxTimer) {
									FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									ClientPrefs.choiceSelected = false;
									ClientPrefs.saveSettings();
								});
							}
							else
							{
								new FlxTimer().start(1.5, function (tmr:FlxTimer) {
									FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									ClientPrefs.choiceSelected = false;
									ClientPrefs.saveSettings();
								});
							}
						}
						case 7:
						{
							trace('YAY, RESISTANCE CHARM [OPTION 7] IS SELECTED');
							if (ClientPrefs.resCharmCollected == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
					case 8:
						{
							trace('YAY, JOKE WEEK [OPTION 8] IS SELECTED');
							if (ClientPrefs.morkyWeekFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 9:
						{
							trace('YAY, FNV [OPTION 10] IS SELECTED');
							if (ClientPrefs.fnvFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
								flickerTween = 	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 10:
						{
							trace('YAY, 0.0015 [OPTION 11] IS SELECTED');
							if (ClientPrefs.shortFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
								flickerTween =	FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 11:
						{
							trace('YAY, SLOW.FLP [OPTION 12] IS SELECTED');
							if (ClientPrefs.nicFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 12:
						{
							trace('YAY, AUTO DODGE CHARM [OPTION 13] IS SELECTED');
							if (ClientPrefs.autoCharmCollected == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 13: //THIS GIVES OFF 5 TOKENS
						{
							ClientPrefs.tokens += 5;
							new FlxTimer().start(0.5, function (tmr:FlxTimer) {
								FlxG.sound.play(Paths.sound('hooray'), 0.5);
							});
							if (ClientPrefs.tokens != 0)
							{
								new FlxTimer().start(1.5, function (tmr:FlxTimer) {
									FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									ClientPrefs.choiceSelected = false;
									ClientPrefs.saveSettings();
								});
							}
							else
							{
								new FlxTimer().start(1.5, function (tmr:FlxTimer) {
									FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
									ClientPrefs.choiceSelected = false;
									ClientPrefs.saveSettings();
								});
							}
						}
						case 14:
						{
							trace('YAY, FANFUCK FOREVER [OPTION 15] IS SELECTED');
							if (ClientPrefs.infatuationFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 15:
						{
							trace('YAY, RAINY DAZE [OPTION 16] IS SELECTED');
							if (ClientPrefs.rainyDazeFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 16:
						{
							trace('YAY, MARAUDER [OPTION 17] IS SELECTED');
							if (ClientPrefs.debugFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 17:
						{
							trace('YAY, SUS WEEK [OPTION 18] IS SELECTED');
							if (ClientPrefs.susWeekFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 18:
						{
							trace('YAY, D-SIDES WEEK [OPTION 19] IS SELECTED');
							if (ClientPrefs.dsideWeekFound == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
						case 19:
						{
							trace('YAY, HEALING CHARM [OPTION 20] IS SELECTED');
							if (ClientPrefs.healCharmCollected == false)
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
									if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									else
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											flickerTween.cancel();
											ClientPrefs.saveSettings();
										});
									}
									flickerTween = FlxTween.tween(spaceText, {alpha: 0}, 0.05, {ease: FlxEase.cubeInOut, type: PINGPONG});
							}
							else
							{
								new FlxTimer().start(0.5, function (tmr:FlxTimer) {
									FlxG.sound.play(Paths.sound('boo'), 0.5);
								});
								if (ClientPrefs.tokens != 0)
									{
										new FlxTimer().start(1.5, function (tmr:FlxTimer) {
											FlxTween.tween(testLuckButton, {y: 550}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
											ClientPrefs.choiceSelected = false;
											ClientPrefs.saveSettings();
										});
									}
								else
								{
									new FlxTimer().start(1.5, function (tmr:FlxTimer) {
										FlxTween.tween(notEnoughTokensText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										FlxTween.tween(spaceText, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
										ClientPrefs.choiceSelected = false;
										ClientPrefs.saveSettings();
									});
								}
							}
						}
					}
				pressedSpace = false;
			}

		//FROM BELOW HERE UNTIL super.update(elapsed), THIS IS WHERE THE SECRET SHOP CODE WILL SHOW UP
		if (FlxG.keys.justPressed.LEFT && changedShop == false)
		{
			merchantDialogue.skip();
			ending();
			
			changedShop = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			if (ClientPrefs.secretShopShowcased == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxTween.tween(background, {x: 2000}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(luckOptionSlot1, {x: 2620}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(luckOptionSlot2, {x: 2620}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(luckOptionSlot3, {x: 2620}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(assistant, {x: 2070}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(merchantDialogue, {x: 2000}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(lights, {x: 2070}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(transitionOoooOo, {x: 1370}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			
				FlxTween.tween(bulb, {x: 1600}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			
				new FlxTimer().start(2, function (tmr:FlxTimer) {
					FlxTween.tween(backgroundSecret, {x: 0}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(sellOption1, {x: 200}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(sellOption2, {x: 200}, 1.84, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(sellOption3, {x: 200}, 1.88, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(booba, {x: 780}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(assistantSecret, {x: 740}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(secretMerchantDialogue, {x: 130}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					secretMerchantDialogue.alpha = 0;
					FlxTween.tween(showcaseSecretDialogue, {x: 130}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				});
				new FlxTimer().start(3.7, function (tmr:FlxTimer) {
					FlxTween.tween(showcaseSecretDialogue, {alpha: 1}, 0.01, {ease: FlxEase.cubeInOut, type: PERSIST});
					showcaseSecretDialogue.start(0.04, true, endingSecret);
					assistantSecret.offset.set(110, 36);
					assistantSecret.animation.play('talking');
					secretShopAccessed = true;
					#if desktop
						// Updating Discord Rich Presence
						DiscordClient.changePresence("In Zeel's Secret Shop", null);
					#end
				});
			}
			else
			{
				FlxTween.tween(background, {x: 2000}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(luckOptionSlot1, {x: 2670}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(luckOptionSlot2, {x: 2670}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(luckOptionSlot3, {x: 2670}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(assistant, {x: 2070}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(merchantDialogue, {x: 2000}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(lights, {x: 2070}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(transitionOoooOo, {x: 1370}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
				FlxTween.tween(bulb, {x: 1600}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
				new FlxTimer().start(2, function (tmr:FlxTimer) {
					FlxTween.tween(backgroundSecret, {x: 0}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(sellOption1, {x: 200}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(sellOption2, {x: 200}, 1.84, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(sellOption3, {x: 200}, 1.88, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(booba, {x: 780}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(assistantSecret, {x: 740}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(secretMerchantDialogue, {x: 130}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				});
				new FlxTimer().start(3.7, function (tmr:FlxTimer) {
					secretMerchantDialogue.start(0.04, true, endingSecret);
					assistantSecret.offset.set(110, 36);
					assistantSecret.animation.play('talking');
					secretShopAccessed = true;
				});
			}
		}
		if (FlxG.keys.justPressed.RIGHT && secretShopAccessed == true && ClientPrefs.sellSelected == false && ClientPrefs.luckSelected == false && ClientPrefs.secretShopShowcased == true)
		{
			secretMerchantDialogue.skip();
			endingSecret();

			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxTween.tween(backgroundSecret, {x: -2000}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(sellOption1, {x: -2900}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(sellOption2, {x: -2900}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(sellOption3, {x: -2900}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(booba, {x: -2630}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(assistantSecret, {x: -2670}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(secretMerchantDialogue, {x: -2400}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});

			new FlxTimer().start(2, function (tmr:FlxTimer) {
				FlxTween.tween(background, {x: 0}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(luckOptionSlot1, {x: 780}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				if (ClientPrefs.nunWeekPlayed == true)
					FlxTween.tween(luckOptionSlot2, {x: 780}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				else
					FlxTween.tween(luckOptionSlot2, {x: 785}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				if (ClientPrefs.kianaWeekPlayed == true)
					FlxTween.tween(luckOptionSlot3, {x: 780}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				else
					FlxTween.tween(luckOptionSlot3, {x: 785}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(assistant, {x: -10}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(lights, {x: 1470}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(bulb, {x: -400}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(merchantDialogue, {x: 0}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			
				FlxTween.tween(transitionOoooOo, {x: -1370}, 1.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			});
			new FlxTimer().start(3.7, function (tmr:FlxTimer) {
				if (ClientPrefs.talkedToZeel == false)
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
			changedShop = false;
		}

		//Dialogue
		if (ClientPrefs.secretShopShowcased == false && secretFirstTime == false && changedShop == true)
		{
			secretFirstTime = true;
			pressedEnter = 0;
			new FlxTimer().start(1.8, function (tmr:FlxTimer) {
			var achieveZeelID:Int = Achievements.getAchievementIndex('zeel_found');
				if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveZeelID][2])) {
					Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveZeelID][2], true);
					giveZeelAchievement();
					ClientPrefs.saveSettings();
				}
			});
		}

		if (ClientPrefs.secretShopShowcased == false && changedShop == true && gtfo == false)
		{
			if (FlxG.keys.justPressed.ENTER && questionShow == false && gtfo == false)
			{
				trace ("Pressed Enter : " + pressedEnter);
				switch (pressedEnter)
				{
					case 0:
						dialogueTextSecret.text = "Haven't had any customers since last update~\n[Press Enter To Continue]";	
					case 1:
						dialogueTextSecret.text = "I don't want to bother you with questions, so I'll be straight forward this time~\n[Press Enter To Continue]";
					case 2:
						dialogueTextSecret.text = "If you wish to buy anything that this 'Mimiko' guy lets you win, click on any of the shelfs~\n[Press Enter To Continue]";
					case 3:
						dialogueTextSecret.text = "Each shelf contains specific items that are inside the corresponding prize machine~\n[Press Enter To Continue]";
					case 4:
						dialogueTextSecret.text = "Have fun shopping~ Don't hesitate to ask me anything~\n[Press Enter To Continue]";
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
			if(FlxG.mouse.overlaps(assistantSecret) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == false)
			{
				if (FlxG.mouse.overlaps(booba))
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
						giveZeelBoobaAchievement();
						ClientPrefs.saveSettings();
					}

					var achieveZeelBoobaX25ID:Int = Achievements.getAchievementIndex('pervertX25');
					if((!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveZeelBoobaX25ID][2])) && touchedBoobies == 25) {
						Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveZeelBoobaX25ID][2], true);
						giveZeelBoobaX25Achievement();
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
			//button shit
			if(FlxG.mouse.overlaps(sellOption1) && (ClientPrefs.sellSelected == false && ClientPrefs.luckSelected == false && ClientPrefs.choiceSelected == false && ClientPrefs.itemInfo == false))
				sellOption1.alpha = 1;
			else
				sellOption1.alpha = 0.6;
			if(FlxG.mouse.overlaps(sellOption2) && (ClientPrefs.sellSelected == false && ClientPrefs.luckSelected == false && ClientPrefs.choiceSelected == false && ClientPrefs.itemInfo == false))
				sellOption2.alpha = 1;
			else
				sellOption2.alpha = 0.6;
			if(FlxG.mouse.overlaps(sellOption3) && (ClientPrefs.sellSelected == false && ClientPrefs.luckSelected == false && ClientPrefs.choiceSelected == false && ClientPrefs.itemInfo == false))
				sellOption3.alpha = 1;
			else
				sellOption3.alpha = 0.6;

			if(FlxG.mouse.overlaps(sellOption1) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == false && gtfo == false)
				{
					secretMerchantDialogue.skip();

					ClientPrefs.sellSelected = true;
					shelfOneON = true;
					FlxTween.tween(buyItemsBG, {y: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize1, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize2, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize3, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize4, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize5, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize6, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(charmPrize1, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
					prizeZeel.x = 250;
					prizeTrampoline.x = 450;
					prizeEgg.x = 650;
					FlxTween.tween(prizeZeel, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeTrampoline, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeEgg, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}

				if(FlxG.mouse.overlaps(sellOption2) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == false && gtfo == false && ClientPrefs.nunWeekPlayed == true)
				{
					secretMerchantDialogue.skip();

					ClientPrefs.sellSelected = true;
					shelfTwoON = true;
					FlxTween.tween(buyItemsBG, {y: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize7, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize8, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize9, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize10, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize11, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(charmPrize2, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
					prizeZeel.x = 50;
					prizeTrampoline.x = 250;
					prizeEgg.x = 450;
					FlxTween.tween(prizeZeel, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeTrampoline, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeEgg, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else if (FlxG.mouse.overlaps(sellOption2) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == false && gtfo == false && ClientPrefs.nunWeekPlayed == false)
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}

				if(FlxG.mouse.overlaps(sellOption3) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == false && gtfo == false && ClientPrefs.kianaWeekPlayed == true)
				{
					secretMerchantDialogue.skip();

					ClientPrefs.sellSelected = true;
					shelfThreeON = true;
					FlxTween.tween(buyItemsBG, {y: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize12, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize13, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prize14, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(charmPrize3, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
						
					prizeZeel.x = 650;
					prizeTrampoline.x = 850;
					prizeEgg.x = 50;
					FlxTween.tween(prizeZeel, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeTrampoline, {y: 160}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeEgg, {y: 315}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxG.sound.play(Paths.sound('shop/shopOpenShelf'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
				}
				else if (FlxG.mouse.overlaps(sellOption3) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == false && gtfo == false && ClientPrefs.kianaWeekPlayed == false)
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}

		
		//Selling Section Bundled with Buying Process
		if (FlxG.mouse.overlaps(prize1) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize1.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

			if (ClientPrefs.legacyWeekFound == false)
				{
					infoTitle.text = "?????? ????";
					infoText.text = "Let's take a trip down to the memory lane!\n-----------------------------------------
					\nItem Cost: 20 Tokens | Your Tokens: " + ClientPrefs.tokens;
				}
			else
				{
					infoTitle.text = "Legacy Week Pass";
					infoText.text = "Let's take a trip down to the memory lane!\n-----------------------------------------
					\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
				}

			FlxTween.tween(prize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize4, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize5, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize6, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Legacy Week Pass" || infoTitle.text == "?????? ????") && ClientPrefs.tokens >= 20 && ClientPrefs.legacyWeekFound == false)
		{
			ClientPrefs.tokens -= 20;
			ClientPrefs.legacyWeekFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.bonusUnlocked = true;

			NotificationAlert.sendCategoryNotification = true;
			NotificationAlert.showMessage(this, 'Normal', true);
							
			NotificationAlert.saveNotifications();
			ClientPrefs.saveSettings();
			equipped.y = 600;

			infoTitle.text = "Legacy Week Pass";
			infoText.text = "Let's take a trip down to the memory lane!\n-----------------------------------------
			\nItem Cost: 20 Tokens | Your Tokens: " + ClientPrefs.tokens;

			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
	
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.legacyWeekFound == true && (infoTitle.text == "Legacy Week Pass" || infoTitle.text == "?????? ????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "?????? ????" && ClientPrefs.tokens < 20 && ClientPrefs.legacyWeekFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize2) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize2.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize2, {x: prize1.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize2, {y: prize1.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.nunsationalFound == false)
			{
				infoTitle.text = "???????????";
				infoText.text = "The Nuns have 1 more surprise for you!\n-----------------------------------------
				\nItem Cost: 15 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Nunsational Pass";
				infoText.text = "The Nuns have 1 more surprise for you!\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize4, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize5, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize6, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Nunsational Pass" || infoTitle.text == "???????????") && ClientPrefs.tokens >= 15 && ClientPrefs.nunsationalFound == false)
		{
			ClientPrefs.tokens -= 15;
			ClientPrefs.nunsationalFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;

			NotificationAlert.showMessage(this, 'Freeplay', true);

			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Nunsational Pass";
			infoText.text = "The Nuns have 1 more surprise for you!\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.nunsationalFound == true && (infoTitle.text == "Nunsational Pass" || infoTitle.text == "???????????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "???????????" && ClientPrefs.tokens < 15 && ClientPrefs.nunsationalFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize3) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize3.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize3, {x: prize1.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize3, {y: prize1.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.lustalityFound == false)
			{
				infoTitle.text = "?????????";
				infoText.text = "Kiana lusts to destroy you!\nWill you accept her old challenge?\n-----------------------------------------
				\nItem Cost: 20 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Lustality Pass";
				infoText.text = "Kiana lusts to destroy you!\nWill you accept her old challenge?\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize4, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize5, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize6, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Lustality Pass" || infoTitle.text == "?????????") && ClientPrefs.tokens >= 15 && ClientPrefs.lustalityFound == false)
		{
			ClientPrefs.tokens -= 20;
			ClientPrefs.lustalityFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;

			NotificationAlert.showMessage(this, 'Freeplay', true);

			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Lustality Pass";
			infoText.text = "Kiana lusts to destroy you!\nWill you accept her old challenge?\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.lustalityFound == true && (infoTitle.text == "Lustality Pass" || infoTitle.text == "?????????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "?????????" && ClientPrefs.tokens < 20 && ClientPrefs.lustalityFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize4) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize4.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize4, {x: prize1.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize4, {y: prize1.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.tofuFound == false)
			{
				infoTitle.text = "????";
				infoText.text = "This is the result of TOO MUCH CONFIDENCE\nin a game of checkers.\n-----------------------------------------
				\nItem Cost: 12 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Tofu Pass";
				infoText.text = "This is the result of TOO MUCH CONFIDENCE\nin a game of checkers.\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize5, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize6, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Tofu Pass" || infoTitle.text == "????") && ClientPrefs.tokens >= 12 && ClientPrefs.tofuFound == false)
		{
			ClientPrefs.tokens -= 12;
			ClientPrefs.tofuFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;

			NotificationAlert.showMessage(this, 'Freeplay', true);

			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Tofu Pass";
			infoText.text = "This is the result of TOO MUCH CONFIDENCE\nin a game of checkers.\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.tofuFound == true && (infoTitle.text == "Tofu Pass" || infoTitle.text == "????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "????" && ClientPrefs.tokens < 12 && ClientPrefs.tofuFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize5) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize5.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize5, {x: prize1.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize5, {y: prize1.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.marcochromeFound == false)
			{
				infoTitle.text = "?????-??????";
				infoText.text = "He seems different from what he used to be...\nWhat do you think happened to him?\n-----------------------------------------
				\nItem Cost: 15 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Marcochrome Pass";
				infoText.text = "He seems different from what he used to be...\nWhat do you think happened to him?\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize4, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize6, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Marcochrome Pass" || infoTitle.text == "?????-??????") && ClientPrefs.tokens >= 15 && ClientPrefs.marcochromeFound == false)
		{
			ClientPrefs.tokens -= 15;
			ClientPrefs.marcochromeFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;
			
			NotificationAlert.showMessage(this, 'Freeplay', true);

			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Marcochrome Pass";
			infoText.text = "He seems different from what he used to be...\nWhat do you think happened to him?\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.marcochromeFound == true && (infoTitle.text == "Marcochrome Pass" || infoTitle.text == "?????-??????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "?????-??????" && ClientPrefs.tokens < 15 && ClientPrefs.marcochromeFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize6) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize6.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize6, {x: prize1.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize6, {y: prize1.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.morkyWeekFound == false)
			{
				infoTitle.text = "???? ????";
				infoText.text = "ALL HAIL MORKY! ALL HAIL MORKY!\n-----------------------------------------
				\nItem Cost: 15 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Joke Week Pass";
				infoText.text = "ALL HAIL MORKY! ALL HAIL MORKY!\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize4, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize5, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Joke Week Pass" || infoTitle.text == "???? ????") && ClientPrefs.tokens >= 15 && ClientPrefs.morkyWeekFound == false)
		{
			ClientPrefs.tokens -= 15;
			ClientPrefs.morkyWeekFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.bonusUnlocked = true;

			NotificationAlert.sendCategoryNotification = true;
			NotificationAlert.showMessage(this, 'Normal', true);
							
			NotificationAlert.saveNotifications();
			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Joke Week Pass";
			infoText.text = "ALL HAIL MORKY! ALL HAIL MORKY!\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.morkyWeekFound == true && (infoTitle.text == "Joke Week Pass" || infoTitle.text == "???? ????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "???? ????" && ClientPrefs.tokens < 15 && ClientPrefs.morkyWeekFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize7) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize7.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize7, {x: prize7.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize7, {y: prize7.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.fnvFound == false)
			{
				infoTitle.text = "???";
				infoText.text = "I don't know what's this, just take it.\n-----------------------------------------
				\nItem Cost: FREE | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "FNV Pass";
				infoText.text = "I don't know what's this, just take it.\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize8, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize9, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize10, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize11, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "FNV Pass" || infoTitle.text == "???") && ClientPrefs.fnvFound == false)
		{
			ClientPrefs.fnvFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;

			NotificationAlert.showMessage(this, 'Freeplay', true);

			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "FNV Pass";
			infoText.text = "I don't know what's this, just take it.\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.fnvFound == true && (infoTitle.text == "FNV Pass" || infoTitle.text == "???"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}

		if (FlxG.mouse.overlaps(prize8) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize8.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize8, {x: prize7.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize8, {y: prize7.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.shortFound == false)
			{
				infoTitle.text = "?.????";
				infoText.text = "A- (You guys like shorts?)\n-----------------------------------------
				\nItem Cost: 1 Token | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "0.0015 Pass";
				infoText.text = "A- (You guys like shorts?)\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize7, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize9, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize10, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize11, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "0.0015 Pass" || infoTitle.text == "?.????") && ClientPrefs.tokens >= 1 && ClientPrefs.shortFound == false)
		{
			ClientPrefs.tokens -= 1;
			ClientPrefs.shortFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;

			NotificationAlert.showMessage(this, 'Freeplay', true);

			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "0.0015 Pass";
			infoText.text = "A- (You guys like shorts?)\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.shortFound == true && (infoTitle.text == "0.0015 Pass" || infoTitle.text == "?.????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "?.????" && ClientPrefs.tokens < 1 && ClientPrefs.shortFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize9) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize9.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize9, {x: prize7.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize9, {y: prize7.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.nicFound == false)
			{
				infoTitle.text = "????.???";
				infoText.text = "I AM GOD! ..Probably.\n-----------------------------------------
				\nItem Cost: 15 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Slow.FLP Pass";
				infoText.text = "I AM GOD! ..Probably.\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize7, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize8, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize10, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize11, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Slow.FLP Pass" || infoTitle.text == "????.???") && ClientPrefs.tokens >= 15 && ClientPrefs.nicFound == false)
		{
			ClientPrefs.tokens -= 15;
			ClientPrefs.nicFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;

			NotificationAlert.showMessage(this, 'Freeplay', true);

			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Slow.FLP Pass";
			infoText.text = "I AM GOD! ..Probably.\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.nicFound == true && (infoTitle.text == "Slow.FLP Pass" || infoTitle.text == "????.???"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "????.???" && ClientPrefs.tokens < 15 && ClientPrefs.nicFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize10) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize10.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize10, {x: prize7.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize10, {y: prize7.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.infatuationFound == false)
			{
				infoTitle.text = "????????????";
				infoText.text = "You won't get away from me!! NEVEEEERRRR~\n-----------------------------------------
				\nItem Cost: 20 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Fanfuck Forever Pass";
				infoText.text = "You won't get away from me!! NEVEEEERRRR~\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize7, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize8, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize9, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize11, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Fanfuck Forever Pass" || infoTitle.text == "????????????") && ClientPrefs.tokens >= 20 && ClientPrefs.infatuationFound == false)
		{
			ClientPrefs.tokens -= 20;
			ClientPrefs.infatuationFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;
			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Fanfuck Forever Pass";
			infoText.text = "You won't get away from me!! NEVEEEERRRR~\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.infatuationFound == true && (infoTitle.text == "Fanfuck Forever Pass" || infoTitle.text == "????????????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "????????????" && ClientPrefs.tokens < 20 && ClientPrefs.infatuationFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize11) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize11.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize11, {x: prize7.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize11, {y: prize7.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.rainyDazeFound == false)
			{
				infoTitle.text = "????? ????";
				infoText.text = "Just waiting for the weather to lay off\nand stop pouring down..\n-----------------------------------------
				\nItem Cost: 15 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Rainy Daze Pass";
				infoText.text = "Just waiting for the weather to lay off\nand stop pouring down..\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize7, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize8, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize9, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize10, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Rainy Daze Pass" || infoTitle.text == "????? ????") && ClientPrefs.tokens >= 15 && ClientPrefs.rainyDazeFound == false)
		{
			ClientPrefs.tokens -= 15;
			ClientPrefs.rainyDazeFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;

			NotificationAlert.showMessage(this, 'Freeplay', true);

			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Rainy Daze Pass";
			infoText.text = "Just waiting for the weather to lay off\nand stop pouring down..\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.rainyDazeFound == true && (infoTitle.text == "Rainy Daze Pass" || infoTitle.text == "????? ????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "????????" && ClientPrefs.tokens < 15 && ClientPrefs.rainyDazeFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize12) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize12.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize12, {x: prize12.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize12, {y: prize12.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.debugFound == false)
			{
				infoTitle.text = "????????";
				infoText.text = "Finally, he's contained!\nLast time he got out, the game almost fucking broke.\n-----------------------------------------
				\nItem Cost: 7 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Marauder Pass";
				infoText.text = "Finally, he's contained!\nLast time he got out, the game almost fucking broke.\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize13, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize14, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Marauder Pass" || infoTitle.text == "????????") && ClientPrefs.tokens >= 7 && ClientPrefs.debugFound == false)
		{
			ClientPrefs.tokens -= 7;
			ClientPrefs.debugFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.xtraUnlocked = true;

			NotificationAlert.showMessage(this, 'Freeplay', true);
			
			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Marauder Pass";
			infoText.text = "Finally, he's contained!\nLast time he got out, the game almost fucking broke.\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.debugFound == true && (infoTitle.text == "Marauder Pass" || infoTitle.text == "????????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "????????" && ClientPrefs.tokens < 7 && ClientPrefs.debugFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize13) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize13.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize13, {x: prize12.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize13, {y: prize12.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.susWeekFound == false)
			{
				infoTitle.text = "??? ????";
				infoText.text = "I don't know man, this item seems kind of sus..\nIt looks like another IMPOSTOR is AMONG US-\n-----------------------------------------
				\nItem Cost: 20 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Sus Week Pass";
				infoText.text = "I don't know man, this item seems kind of sus..\nIt looks like another IMPOSTOR is AMONG US-\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize12, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize14, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "Sus Week Pass" || infoTitle.text == "??? ????") && ClientPrefs.tokens >= 20 && ClientPrefs.susWeekFound == false)
		{
			ClientPrefs.tokens -= 20;
			ClientPrefs.susWeekFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.bonusUnlocked = true;

			NotificationAlert.sendCategoryNotification = true;
			NotificationAlert.showMessage(this, 'Normal', true);
							
			NotificationAlert.saveNotifications();
			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "Sus Week Pass";
			infoText.text = "I don't know man, this item seems kind of sus..\nIt looks like another IMPOSTOR is AMONG US-\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.susWeekFound == true && (infoTitle.text == "Sus Week Pass" || infoTitle.text == "??? ????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "??? ????" && ClientPrefs.tokens < 20 && ClientPrefs.susWeekFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prize14) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prize14.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize14, {x: prize12.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize14, {y: prize12.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			if (ClientPrefs.dsideWeekFound == false)
			{
				infoTitle.text = "?-????? ????";
				infoText.text = "Oooo~ This looks like a dope Cassette tape.\nI wonder what's inside?\n-----------------------------------------
				\nItem Cost: 25 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "D-sides Week Pass";
				infoText.text = "Oooo~ This looks like a dope Cassette tape.\nI wonder what's inside?\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize12, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize13, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
	
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && (infoTitle.text == "D-sides Week Pass" || infoTitle.text == "?-????? ????") && ClientPrefs.tokens >= 25 && ClientPrefs.dsideWeekFound == false)
		{
			ClientPrefs.tokens -= 25;
			ClientPrefs.dsideWeekFound = true;
			ClientPrefs.songsUnlocked += 1;
			ClientPrefs.bonusUnlocked = true;

			NotificationAlert.sendCategoryNotification = true;
			NotificationAlert.showMessage(this, 'Normal', true);
							
			NotificationAlert.saveNotifications();
			ClientPrefs.saveSettings();
			equipped.y = 600;
	
			infoTitle.text = "D-sides Week Pass";
			infoText.text = "Oooo~ This looks like a dope Cassette tape.\nI wonder what's inside?\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
	
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
		
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.dsideWeekFound == true && (infoTitle.text == "D-sides Week Pass" || infoTitle.text == "?-????? ????"))
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "?-????? ????" && ClientPrefs.tokens < 25 && ClientPrefs.dsideWeekFound == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prizeZeel) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prizeZeel.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			if (shelfOneON == true)
			{
				FlxTween.tween(prizeZeel, {x: prize1.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeZeel, {y: prize1.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			}
			else if (shelfTwoON == true)
			{
				FlxTween.tween(prizeZeel, {x: prize7.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeZeel, {y: prize7.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			}
			else if (shelfThreeON == true)
			{
				FlxTween.tween(prizeZeel, {x: prize12.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeZeel, {y: prize12.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			}
		
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			
			if (ClientPrefs.zeelNakedPics == false)
			{
				infoTitle.text = "Zeel's Naked Pics";
				infoText.text = "Earning this item unlocks Zeel's Naked Pics!\nPress EQUIPPED to view~\n!!BACK ON IT'S NORMAL PRIZE!!\n-----------------------------------------
				\nItem Cost: 75 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Zeel's Naked Pics";
				infoText.text = "Earning this item unlocks Zeel's Naked Pics!\nPress EQUIPPED to view~\n!!BACK ON IT'S NORMAL PRIZE!!\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}

			FlxTween.tween(prize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize4, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize5, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize6, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize7, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize8, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize9, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize10, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize11, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize12, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize13, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize14, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

			FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Zeel's Naked Pics" && ClientPrefs.tokens >= 75 && ClientPrefs.zeelNakedPics == false)
		{
			ClientPrefs.tokens -= 75;
			ClientPrefs.zeelNakedPics = true;
			ClientPrefs.saveSettings();
						
			infoTitle.text = "Zeel's Naked Pics";
			infoText.text = "Earning this item unlocks Zeel's Naked Pics!\nPress EQUIPPED to view~\n!!BACK ON IT'S NORMAL PRIZE!!\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
		
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));

			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.zeelNakedPics == true && infoTitle.text == "Zeel's Naked Pics")
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Zeel's Naked Pics" && ClientPrefs.tokens < 20 && ClientPrefs.zeelNakedPics == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}	

		if (FlxG.mouse.overlaps(prizeTrampoline) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));
			FlxTween.tween(prizeTrampoline.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			if (shelfOneON)
			{
				FlxTween.tween(prizeTrampoline, {x: prize1.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeTrampoline, {y: prize1.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			}
			else if (shelfTwoON)
			{
				FlxTween.tween(prizeTrampoline, {x: prize7.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeTrampoline, {y: prize7.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			}
			else if (shelfThreeON)
			{
				FlxTween.tween(prizeTrampoline, {x: prize12.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeTrampoline, {y: prize12.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			}
		
			FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
			if (ClientPrefs.trampolineUnlocked == false)
			{
				infoTitle.text = "Trampoline Mode";
				infoText.text = "Earning this item unlocks Trampoline Mode!\nTo use once you buy it, make sure you enable it through options >> FNV Settings!\n-----------------------------------------
				\nItem Cost: 15 Tokens | Your Tokens: " + ClientPrefs.tokens;
			}
			else
			{
				infoTitle.text = "Trampoline Mode";
				infoText.text = "Earning this item unlocks Trampoline Mode!\nTo use once you buy it, make sure you enable it through options >> FNV Settings!\n-----------------------------------------
				\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			}
	
			FlxTween.tween(prize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize4, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize5, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize6, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize7, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize8, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize9, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize10, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize11, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize12, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize13, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prize14, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(charmPrize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				
			FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			ClientPrefs.itemInfo = true;
		}
		if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Trampoline Mode" && ClientPrefs.tokens >= 15 && ClientPrefs.trampolineUnlocked == false)
		{
			ClientPrefs.tokens -= 15;
			ClientPrefs.trampolineUnlocked = true;

			NotificationAlert.sendOptionsNotification = true;
			NotificationAlert.showMessage(this, 'Normal', true);
							
			NotificationAlert.saveNotifications();
			ClientPrefs.saveSettings();
						
			infoTitle.text = "Trampoline Mode";
			infoText.text = "Earning this item unlocks Trampoline Mode!\nTo use once you buy it, make sure you enable it through options >> FNV Settings!\n-----------------------------------------
			\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
		
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.sound.play(Paths.sound('shop/mouseClick'));

			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (ClientPrefs.trampolineUnlocked == true && infoTitle.text == "Trampoline Mode")
		{
			FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
			buy.alpha = 0;
			equipped.alpha = 1;
		}
		else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Trampoline Mode" && ClientPrefs.tokens < 15 && ClientPrefs.trampolineUnlocked == false)
		{
			FlxG.sound.play(Paths.sound('accessDenied'));
			FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
		}

		if (FlxG.mouse.overlaps(prizeEgg) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxG.sound.play(Paths.sound('shop/mouseClick'));
				FlxTween.tween(prizeEgg.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				if (shelfOneON)
				{
					FlxTween.tween(prizeEgg, {x: prize1.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeEgg, {y: prize1.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				}
				else if (shelfTwoON)
				{
					FlxTween.tween(prizeEgg, {x: prize7.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeEgg, {y: prize7.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				}
				else if (shelfThreeON)
				{
					FlxTween.tween(prizeEgg, {x: prize12.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(prizeEgg, {y: prize12.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				}
			
				FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

				infoTitle.text = "Egg";
				infoText.text = "It's... an egg.\nMaybe not good for consuming it yourself, but someone else might be able to do so!\n-----------------------------------------
				\nItem Cost: 3 | Your Tokens: " + ClientPrefs.tokens + " | Eggs Owned: " + ClientPrefs.eggs;
		
				FlxTween.tween(prize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize4, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize5, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize6, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize7, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize8, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize9, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize10, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize11, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize12, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize13, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize14, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(charmPrize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(charmPrize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(charmPrize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					
				FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				ClientPrefs.itemInfo = true;
			}
			if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Egg" && ClientPrefs.tokens >= 3)
			{
				ClientPrefs.tokens -= 3;
				ClientPrefs.eggs += 1;
				ClientPrefs.saveSettings();
							
				infoTitle.text = "Egg";
				infoText.text = "It's... an egg.\nMaybe not good for consuming it yourself, but someone else might be able to.!\n-----------------------------------------
				\nItem Cost: 3 | Your Tokens: " + ClientPrefs.tokens + " | Eggs Owned: " + ClientPrefs.eggs;
			
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxG.sound.play(Paths.sound('shop/mouseClick'));
			}
			else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Egg" && ClientPrefs.tokens < 3)
			{
				FlxG.sound.play(Paths.sound('accessDenied'));
				FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
			}

			//Charms Section + Buy Info for each stuff
			if (FlxG.mouse.overlaps(charmPrize1) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxG.sound.play(Paths.sound('shop/mouseClick'));
				FlxTween.tween(charmPrize1.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(charmPrize1, {x: prize1.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(charmPrize1, {y: prize1.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
		
				infoTitle.text = "Resistance Charm";
				if (ClientPrefs.resCharmCollected == false)
					infoText.text = "Uncomfortable to wear, but it is pretty protectable!\nThis Charm helps you resist health drain by over 50%!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: 20 Tokens | Your Tokens: " + ClientPrefs.tokens;
				else
					infoText.text = "Uncomfortable to wear, but it is pretty protectable!\nThis Charm helps you resist health drain by over 50%!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
		
				FlxTween.tween(prize1, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize2, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize3, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize4, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize5, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize6, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

				FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				ClientPrefs.itemInfo = true;
			}
			//Resistance Charm Purchase
			if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Resistance Charm" && ClientPrefs.tokens >= 20 && ClientPrefs.resCharmCollected == false)
				{
					ClientPrefs.tokens -= 20;
					ClientPrefs.resCharmCollected = true;

					NotificationAlert.showMessage(this, 'Normal', true);
					NotificationAlert.sendInventoryNotification = true;
					NotificationAlert.saveNotifications();

					ClientPrefs.saveSettings();
							
					infoTitle.text = "Resistance Charm";
					infoText.text = infoText.text = "Uncomfortable to wear, but it is pretty protectable!\nThis Charm helps you resist health drain by over 50%!\nRemember, only 1 charm per song!\n-----------------------------------------
						\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
	
					FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					buy.alpha = 0;
					equipped.alpha = 1;
				}
				else if (ClientPrefs.resCharmCollected == true && infoTitle.text == "Resistance Charm")
				{
					FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					buy.alpha = 0;
					equipped.alpha = 1;
				}
				else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Resistance Charm" && ClientPrefs.tokens < 20 && ClientPrefs.resCharmCollected == false)
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}

			if (FlxG.mouse.overlaps(charmPrize2) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxG.sound.play(Paths.sound('shop/mouseClick'));
				FlxTween.tween(charmPrize2.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(charmPrize2, {x: prize7.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(charmPrize2, {y: prize7.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
		
				infoTitle.text = "Auto Dodge Charm";
				if (ClientPrefs.autoCharmCollected == false)
					infoText.text = "This Charm makes you agile, meaning\nyou're hard to be hit by enemies!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: 25 Tokens | Your Tokens: " + ClientPrefs.tokens;
				else
					infoText.text = "This Charm makes you agile, meaning\nyou're hard to be hit by enemies!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
		
				FlxTween.tween(prize7, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize8, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize9, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize10, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize11, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

				FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				ClientPrefs.itemInfo = true;
				new FlxTimer().start(0.8, function (tmr:FlxTimer) {
					canGoBack = true;
				});
			}
			//Auto Dodge Charm Purchase
			if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Auto Dodge Charm" && ClientPrefs.tokens >= 25 && ClientPrefs.autoCharmCollected == false)
				{
					ClientPrefs.tokens -= 25;
					ClientPrefs.autoCharmCollected = true;

					NotificationAlert.showMessage(this, 'Normal', true);
					NotificationAlert.sendInventoryNotification = true;
					NotificationAlert.saveNotifications();

					ClientPrefs.saveSettings();
							
					infoTitle.text = "Auto Dodge Charm";
					infoText.text = "This Charm makes you agile, meaning\nyou're hard to be hit by enemies!\nRemember, only 1 charm per song!\n-----------------------------------------
						\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
	
					FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					buy.alpha = 0;
					equipped.alpha = 1;
				}
				else if (ClientPrefs.autoCharmCollected == true && infoTitle.text == "Auto Dodge Charm")
				{
					FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					buy.alpha = 0;
					equipped.alpha = 1;
				}
				else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Auto Dodge Charm" && ClientPrefs.tokens < 25 && ClientPrefs.autoCharmCollected == false)
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}
			
			if (FlxG.mouse.overlaps(charmPrize3) && FlxG.mouse.justPressed && ClientPrefs.sellSelected == true && ClientPrefs.itemInfo == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxG.sound.play(Paths.sound('shop/mouseClick'));
				FlxTween.tween(charmPrize3.scale, {x: 1.4, y: 1.4}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(charmPrize3, {x: prize12.x}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(charmPrize3, {y: prize12.y}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(blackOut, {alpha: 0.85}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(infoTitle, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(infoText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(buy, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(equipped, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
		
				infoTitle.text = "Healing Charm";
				if (ClientPrefs.healCharmCollected == false)
					infoText.text = "Don't you just hate when you lose health?\nDon't worry, this Charm gives you the\nability to regain health!\nYou have 10 uses per song!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: 25 Tokens | Your Tokens: " + ClientPrefs.tokens;
				else
					infoText.text = "Don't you just hate when you lose health?\nDon't worry, this Charm gives you the\nability to regain health!\nYou have 10 uses per song!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
		
				FlxTween.tween(prize12, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize13, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prize14, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				
				FlxTween.tween(prizeZeel, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeTrampoline, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(prizeEgg, {alpha: 0.1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				ClientPrefs.itemInfo = true;
				new FlxTimer().start(0.8, function (tmr:FlxTimer) {
					canGoBack = true;
				});
			}
			//Healing Charm Purchase
			if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Healing Charm" && ClientPrefs.tokens >= 25 && ClientPrefs.healCharmCollected == false)
				{
					ClientPrefs.tokens -= 25;
					ClientPrefs.healCharmCollected = true;

					NotificationAlert.showMessage(this, 'Normal', true);
					NotificationAlert.sendInventoryNotification = true;
					NotificationAlert.saveNotifications();

					ClientPrefs.saveSettings();
							
					infoTitle.text = "Healing Charm";
					infoText.text = "Don't you just hate when you lose health?\nDon't worry, this Charm gives you\nthe ability to regain health!\nYou have 10 uses per song!\nRemember, only 1 charm per song!\n-----------------------------------------
					\nItem Cost: SOLD | Your Tokens: " + ClientPrefs.tokens;
			
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxG.sound.play(Paths.sound('shop/mouseClick'));
	
					FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					buy.alpha = 0;
					equipped.alpha = 1;
				}
				else if (ClientPrefs.healCharmCollected == true && infoTitle.text == "Healing Charm")
				{
					FlxTween.tween(buy, {y: 600}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
					buy.alpha = 0;
					equipped.alpha = 1;
				}
				else if (FlxG.mouse.overlaps(buy) && FlxG.mouse.justPressed && infoTitle.text == "Healing Charm" && ClientPrefs.tokens < 25 && ClientPrefs.healCharmCollected == false)
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
				}	

			//EQUIPPED OPTION [Will only work on these 2 items]
			if (FlxG.mouse.overlaps(equipped) && FlxG.mouse.justPressed)
			{
				switch (infoTitle.text)
				{
					case "Zeel's Naked Pics":
					{
						if (ClientPrefs.zeelNakedPics == true && !initializedVideo)
						{
							if (!videoDone) //FROM INDIE CROSS!
								{
									if (FlxG.sound.music != null)
										FlxG.sound.music.stop();

									FlxG.sound.play(Paths.sound('shop/mouseClick'));
									FlxG.sound.play(Paths.sound('confirmMenu'));
						
									var video:MP4Handler = new MP4Handler();
									video.playVideo(Paths.video('Zeels Naked Pics'));
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
						if (ClientPrefs.trampolineUnlocked == true)
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
		if (FlxG.keys.justPressed.UP && cellarShopAccessed == false && cellarShopActive == false && secretShopAccessed == false && ClientPrefs.sellSelected == false && ClientPrefs.luckSelected == false)
		{
			//Dialogue reset
			merchantDialogue.skip();

			FlxG.sound.play(Paths.sound('scrollMenu'));
			cellarShopAccessed = true;
			cellarShopActive = true;

			transitionOoooOo.alpha = 0;
			FlxTween.tween(background, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(luckOptionSlot1, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(luckOptionSlot2, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(luckOptionSlot3, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
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
	
	// Unlocks "Shopalic" achievement
	function giveShopAchievement() {
		add(new AchievementObject('shop_completed', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "shop_completed"');
	}

	// Unlocks "Who is she?" achievement
	function giveZeelAchievement() {
		add(new AchievementObject('zeel_found', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "zeel_found"');
	}

	// Unlocks "Pervert" achievement
	function giveZeelBoobaAchievement() {
		add(new AchievementObject('pervert', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "pervert"');
	}

	// Unlocks "PervertX25" achievement
	function giveZeelBoobaX25Achievement() {
		add(new AchievementObject('pervertX25', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "pervertX25"');
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

	function getChoiceNumber(timer:FlxTimer)
	{
		if (ClientPrefs.choiceSelected == true && ended == false && ClientPrefs.tokens >= 0)
		{
			if (shelfOneON == true)
				choiceNumber = FlxG.random.int(1, 7);
			else if (shelfTwoON == true)
				choiceNumber = FlxG.random.int(8, 14);
			else if (shelfThreeON == true)
				choiceNumber = FlxG.random.int(15, 19);
			choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
			var bgTimerAgain:FlxTimer = new FlxTimer().start(0.06, getChoiceNumberAgain);
		}
	}

	function getChoiceNumberAgain(timer:FlxTimer)
		{
			if (ClientPrefs.choiceSelected == true && ended == false && ClientPrefs.tokens >= 0)
			{
				if (shelfOneON == true)
					choiceNumber = FlxG.random.int(1, 7);
				else if (shelfTwoON == true)
					choiceNumber = FlxG.random.int(8, 14);
				else if (shelfThreeON == true)
					choiceNumber = FlxG.random.int(15, 19);
				choice.loadGraphic(Paths.image('shop/prizes/prize_' + choiceNumber));
				var bgTimer:FlxTimer = new FlxTimer().start(0.06, getChoiceNumber);
			}
		}
}

