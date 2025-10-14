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
import Alphabet;

import flash.system.System;

class GalleryState extends MusicBeatState
{
	public static var categorySelected:Int = 1;

	//stole my own code to make this easier lmao
	var arrowSelectorLeft:FlxSprite;
	var arrowSelectorRight:FlxSprite;
	var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;

	var background:FlxSprite;
	var currentImage:FlxSprite;
	var imageNumber:Int = 1;
	var imageText:FlxText;
	var categoryTitle:Alphabet;

	var numberCounter:FlxText;

	var colors:Array<String> = [ 
        '0xFF03fc20',
        '0xFF03fcc2',
        '0xFF0318fc',
        '0xFF9003fc',
        '0xFFfc03d2',
        '0xFFfc0303',
        '0xFFfc7303',
        '0xFFfcf403'
	];

	var curNum:Int;
    var curColor:String;
    var previousColor:String;

	var allowImageChange:Bool = false;

	var textBG:FlxSprite;
	var Text:FlxText;

	override function create()
	{
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Viewing the Gallery", null);
		#end

		imageNumber = 1;

		curNum = FlxG.random.int(0, 7);
        curColor = colors[curNum];
        previousColor = curColor;

		background = new FlxSprite(0, 0).loadGraphic(Paths.image('Gallery/Background'));
		background.setGraphicSize(FlxG.width, FlxG.height);
		background.screenCenter();
		background.antialiasing = ClientPrefs.globalAntialiasing;
		add(background);

		FlxTween.color(background, 5, FlxColor.fromString(previousColor), FlxColor.fromString(curColor), {ease: FlxEase.cubeInOut});

        new FlxTimer().start(5, function (tmr:FlxTimer) 
        {
            previousColor = curColor;
            curNum = FlxG.random.int(0, 7);
            curColor = colors[curNum];
            new FlxTimer().start(1, function (tmr:FlxTimer)
            {
                changeColor();
            });
        });

		textBG = new FlxSprite(0, FlxG.height - 38).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		Text = new FlxText(textBG.x + 1000, textBG.y + 8, FlxG.width + 1000, "LEFT / RIGHT: Change Image | SWIPE UP / DOWN: Change Gallery Category | C: Go to Video Player (MUST HAVE MAIN GAME COMPLETED!) | B: Go back to the Main Menu", 24);
		Text.setFormat("VCR OSD Mono", 20, FlxColor.WHITE, RIGHT);
		Text.scrollFactor.set();
		add(Text);
	
		FlxTween.tween(Text, {x: textBG.x - 2500}, 20, {ease: FlxEase.linear, type: LOOPING});

		currentImage = new FlxSprite(MobileUtil.fixX(0), -20).loadGraphic(Paths.image('Gallery/randomArts/image_1'));
		currentImage.antialiasing = ClientPrefs.globalAntialiasing;
		currentImage.scale.set(0.7, 0.7);
		add(currentImage);

		arrowSelectorLeft = new FlxSprite(MobileUtil.fixX(80), 240).loadGraphic(Paths.image('freeplayStuff/arrowSelectorLeft'));
		arrowSelectorLeft.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorLeft.scale.set(0.5, 0.5);
		add(arrowSelectorLeft);

		arrowSelectorRight = new FlxSprite(MobileUtil.fixX(1060), 240).loadGraphic(Paths.image('freeplayStuff/arrowSelectorRight'));
		arrowSelectorRight.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorRight.scale.set(0.5, 0.5);
		add(arrowSelectorRight);

		getRightArrowX = arrowSelectorRight.x;
		getLeftArrowX = arrowSelectorLeft.x;

		numberCounter = new FlxText(0, 0, FlxG.width, imageNumber + "/114", 32);
		numberCounter.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		add(numberCounter);

		//dialogue
		imageText = new FlxText(0, 620, FlxG.width, "", 32);
		imageText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		add(imageText);

		categoryTitle = new Alphabet(360, 10, "This is a test", true);
		categoryTitle.alpha = 0.6;
		add(categoryTitle);

		changeImage();
		changeCategory();

		var scroll = new ScrollableObject(0.005, 50, 100, FlxG.width, FlxG.height, "Y");
		scroll.onFullScroll.add(delta -> {
			changeCategory(delta, true);
		});
		add(scroll);

		super.create();

		addTouchPad("NONE", "B_C");
	}

	function completedMainGame()
	{
		// Have all Weeks Completed except for the crossover section
		return Achievements.isAchievementUnlocked('Tutorial_Beaten')
			&& Achievements.isAchievementUnlocked('WeekMarco_Beaten') && Achievements.isAchievementUnlocked('WeekMarcoVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekMarcoIniquitous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekNun_Beaten') && Achievements.isAchievementUnlocked('WeekNunVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekNunIniquitous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekKiana_Beaten') && Achievements.isAchievementUnlocked('WeekKianaVillainous_Beaten') && Achievements.isAchievementUnlocked('WeekKianaIniquitous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekMorky_Beaten') && Achievements.isAchievementUnlocked('WeekMorkyVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekSus_Beaten') && Achievements.isAchievementUnlocked('WeekSusVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekLegacy_Beaten') && Achievements.isAchievementUnlocked('WeekLegacyVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekDside_Beaten') && Achievements.isAchievementUnlocked('WeekDsideVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('weekIniquitous_Beaten');
	}
	
	override function update(elapsed:Float)
	{
		if (controls.BACK || FlxG.mouse.justPressedRight)
		{
			MusicBeatState.switchState(new MainMenuState(), 'stickers');
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
		
		if ((FlxG.keys.pressed.SHIFT || touchPad.buttonC.justPressed) && completedMainGame())
		{
			FlxG.sound.music.stop();
			MusicBeatState.switchState(new VideoPlayer());
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		
		if (FlxG.mouse.overlaps(arrowSelectorLeft))
			FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

		if (FlxG.mouse.overlaps(arrowSelectorRight))
			FlxTween.tween(arrowSelectorRight, {x: getRightArrowX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(arrowSelectorRight, {x: getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

		if (allowImageChange)
		{
			if (controls.UI_LEFT_P || (FlxG.mouse.overlaps(arrowSelectorLeft) && FlxG.mouse.justPressed))
				changeImage(-1, true, true);
			if (controls.UI_RIGHT_P || (FlxG.mouse.overlaps(arrowSelectorRight) && FlxG.mouse.justPressed))
				changeImage(1, true, true);
		}

		if (controls.UI_DOWN_P)
			changeCategory(-1);
		if (controls.UI_UP_P)
			changeCategory(1);

		super.update(elapsed);
	}

	function changeColor()
	{
		FlxTween.color(background, 5, FlxColor.fromString(previousColor), FlxColor.fromString(curColor), {ease: FlxEase.cubeInOut});
	
		new FlxTimer().start(5, function (tmr:FlxTimer) 
		{
			previousColor = curColor;
			curNum = FlxG.random.int(0, 7);
			curColor = colors[curNum];
			new FlxTimer().start(1, function (tmr:FlxTimer)
			{
				changeColor();
			});
		});
	}

	function changeCategory(huh:Int = 0, ?allowHaptics:Bool = false)
	{
		if (ClientPrefs.haptics && allowHaptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		categorySelected += huh;

		if (categorySelected > 7)
			categorySelected = 1;
		if (categorySelected < 1)
			categorySelected = 7;

		if (categorySelected == 1)
		{
			categoryTitle.text = "Menu Screens";
			categoryTitle.x = MobileUtil.fixX(370);

			currentImage.alpha = 1;
			arrowSelectorLeft.alpha = 1;
			arrowSelectorRight.alpha = 1;
			numberCounter.alpha = 1;
			imageText.y = 620;

			allowImageChange = true;
			imageNumber = 1;
			changeImage();
		}

		if (categorySelected == 2)
		{
			categoryTitle.text = "Title Loading Screens";
			categoryTitle.x = MobileUtil.fixX(170);

			currentImage.alpha = 1;
			arrowSelectorLeft.alpha = 1;
			arrowSelectorRight.alpha = 1;
			numberCounter.alpha = 1;
			imageText.y = 620;

			allowImageChange = true;
			imageNumber = 1;
			changeImage();
		}

		if (categorySelected == 3)
		{
			categoryTitle.text = "New Loading Screens";
			categoryTitle.x = MobileUtil.fixX(210);

			currentImage.alpha = 1;
			arrowSelectorLeft.alpha = 1;
			arrowSelectorRight.alpha = 1;
			numberCounter.alpha = 1;
			imageText.y = 620;

			allowImageChange = true;
			imageNumber = 1;
			changeImage();
		}
				
		if (categorySelected == 4)
		{
			categoryTitle.text = "Old Loading Screens";
			categoryTitle.x = MobileUtil.fixX(210);

			if (ClientPrefs.oldLoadScreensUnlocked == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

				currentImage.alpha = 0;
				arrowSelectorLeft.alpha = 0;
				arrowSelectorRight.alpha = 0;
				numberCounter.alpha = 0;
				imageText.y = 320;
				imageText.text = "You do not have this category unlocked yet.";

				allowImageChange = false;
			}
			else
			{
				currentImage.alpha = 1;
				arrowSelectorLeft.alpha = 1;
				arrowSelectorRight.alpha = 1;
				numberCounter.alpha = 1;
				imageText.y = 620;

				imageNumber = 1;
				changeImage();

				allowImageChange = true;
			}
		}

		if (categorySelected == 5)
		{
			categoryTitle.text = "Ad Mechanic Art";
			categoryTitle.x = MobileUtil.fixX(300);

			if (ClientPrefs.adMechanicScreensUnlocked == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

				currentImage.alpha = 0;
				arrowSelectorLeft.alpha = 0;
				arrowSelectorRight.alpha = 0;
				numberCounter.alpha = 0;
				imageText.y = 320;
				imageText.text = "You do not have this category unlocked yet.";

				allowImageChange = false;
			}
			else
			{
				currentImage.alpha = 1;
				arrowSelectorLeft.alpha = 1;
				arrowSelectorRight.alpha = 1;
				numberCounter.alpha = 1;
				imageText.y = 620;
				
				imageNumber = 1;
				changeImage();

				allowImageChange = true;
			}
		}

		if (categorySelected == 6)
		{
			categoryTitle.text = "Fanarts";
			categoryTitle.x = MobileUtil.fixX(470);

			if (ClientPrefs.fanartScreensUnlocked == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

				currentImage.alpha = 0;
				arrowSelectorLeft.alpha = 0;
				arrowSelectorRight.alpha = 0;
				numberCounter.alpha = 0;
				imageText.y = 320;
				imageText.text = "You do not have this category unlocked yet.";

				allowImageChange = false;
			}
			else
			{
				currentImage.alpha = 1;
				arrowSelectorLeft.alpha = 1;
				arrowSelectorRight.alpha = 1;
				numberCounter.alpha = 1;
				imageText.y = 620;
				
				imageNumber = 1;
				changeImage();

				allowImageChange = true;
			}
		}

		if (categorySelected == 7)
		{
			categoryTitle.text = "Random Arts";
			categoryTitle.x = MobileUtil.fixX(385);

			if (ClientPrefs.randomArtScreensUnlocked == false)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

				currentImage.alpha = 0;
				arrowSelectorLeft.alpha = 0;
				arrowSelectorRight.alpha = 0;
				numberCounter.alpha = 0;
				imageText.y = 320;
				imageText.text = "You do not have this category unlocked yet.";

				allowImageChange = false;
			}
			else
			{
				currentImage.alpha = 1;
				arrowSelectorLeft.alpha = 1;
				arrowSelectorRight.alpha = 1;
				numberCounter.alpha = 1;
				imageText.y = 620;
				
				imageNumber = 1;
				changeImage();

				allowImageChange = true;
			}
		}
	}

	var messageShown:Bool = false;
	function changeImage(change:Int = 0, playSound:Bool = true, ?allowHaptics:Bool = false)
		{
			if (ClientPrefs.haptics && allowHaptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
			if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	
			imageNumber += change;

			if (categorySelected == 1)
			{
				if (imageNumber > 59)
					imageNumber = 1;
				if (imageNumber < 1)
					imageNumber = 59;
				numberCounter.text = imageNumber + "/59";
				currentImage.loadGraphic(Paths.image('mainMenuBgs/menu-' + imageNumber));
				imageText.text = "Various Main Menu Screens.\nAll are randomized and unlockable.";
			}

			if (categorySelected == 2)
			{
				if (imageNumber > 11)
					imageNumber = 1;
				if (imageNumber < 1)
					imageNumber = 11;
				numberCounter.text = imageNumber + "/11";
				currentImage.loadGraphic(Paths.image('Gallery/titleScreens/loadingScreen-' + imageNumber));

				messageShown = false;
				switch(imageNumber)
				{
					case 1: imageText.text = "Opening Loading Screen N.1 [Drawn by Lizzy Strawberry]";
					case 2: imageText.text = "Opening Loading Screen N.2 [Drawn by StatureGuy]";
					case 3: imageText.text = "Opening Loading Screen N.3 [Drawn by StatureGuy]";
					case 4: imageText.text = "Opening Loading Screen N.4 [Drawn by Porkchop]";
					case 5: imageText.text = "Opening Loading Screen N.5 [Drawn by StatureGuy]";
					case 6: imageText.text = "Opening Loading Screen N.6 [Drawn by Lizzy Strawberry]";
					case 8: imageText.text = "Old Opening Loading Screen N.1 [Drawn by StatureGuy]";	
					case 9: imageText.text = "Old Opening Loading Screen N.2 [Drawn by McFlurryAsh/R3tro]";
					case 10: imageText.text = "Old Opening Loading Screen N.3 [Drawn by SamanthaIsStupid-]";
					case 11: imageText.text = "Old Opening Loading Screen N.4 [Drawn by McNugget]";
				}
			}

			if (categorySelected == 3)
			{
				if (imageNumber > 24)
					imageNumber = 1;
				if (imageNumber < 1)
					imageNumber = 24;
				numberCounter.text = imageNumber + "/24";
				currentImage.loadGraphic(Paths.image('Gallery/newLoadingScreens/image_' + imageNumber));

				messageShown = false;
				switch(imageNumber)
				{
					case 1:
						{
							imageText.text = "The Cheap Skate Villain's In-Game Loading Screen.";
							messageShown = false;
						}
					case 2:
						{
							imageText.text = "Orphanage Hustle's In-Game Loading Screen.";
						}
					case 3:
						{
							imageText.text = "Narrin's In-Game Loading Screen used in The Unnamed Trio.";
							
						}
					case 4:
						{
							imageText.text = "DV's In-Game Loading Screen used in The Unnamed Trio.";
							
						}
					case 5:
						{
							imageText.text = "Kiana's In-Game Loading Screen used in Week 3 and all Kiana-related songs.";
							
						}
					case 6:
						{
							imageText.text = "Toxic Legacy's In-Game Loading Screen.";
							
						}
					case 7:
						{
							imageText.text = "4-Side Villainy's In-Game Loading Screen.";
							
						}
					case 8:
						{
							imageText.text = "The Entertainer's In-Game Loading Screen.";
							
						}
					case 9:
						{
							imageText.text = "A Villain Among Us' In-Game Loading Screen.";
							
						}
					case 10:
						{
							imageText.text = "Marcochrome's In-Game Loading Screen.";
						}
					case 11:
						{
							imageText.text = "Marauder's In-Game Loading Screen.";
							
						}
					case 12:
						{
							imageText.text = "Rainy Daze's In-Game Loading Screen.";
						}
					case 13:
						{
							imageText.text = "FNV's In-Game Loading Screen.";
						}
					case 14:
						{
							imageText.text = "Instrumentally Deranged's In-Game Loading Screen.";
						}
					case 15:
						{
							imageText.text = "FanFuck Forever's In-Game Loading Screen.";
						}
					case 16:
						{
							imageText.text = "Tofu's In-Game Loading Screen.";
						}
					case 17:
						{
							imageText.text = "Shortest Song Ever's (0.0015) In-Game Loading Screen.";
						}
					case 18:
						{
							imageText.text = "Slow.FLP's In-Game Loading Screen.";
						}
					case 19:
						{
							imageText.text = "VGuy's In-Game Loading Screen.";
						}
					case 20:
						{
							imageText.text = "Fast Food Therapy's In-Game Loading Screen.";
						}
					case 21:
						{
							imageText.text = "Tactical Mishap's In-Game Loading Screen.";
						}
					case 22:
						{
							imageText.text = "Breacher's In-Game Loading Screen.";
						}
					case 23:
						{
							imageText.text = "Concert Chaos' In-Game Loading Screen.";
						}
				}
			}

			if (categorySelected == 4)
			{
				if (imageNumber > 11)
					imageNumber = 1;
				if (imageNumber < 1)
					imageNumber = 11;
				numberCounter.text = imageNumber + "/11";
				currentImage.loadGraphic(Paths.image('Gallery/oldLoadingScreens/image_' + imageNumber));

				messageShown = false;
				switch(imageNumber)
				{
					case 1:
						{
							imageText.text = "Marco's In-Game Loading Screen [Done by Roseruh!].";
							messageShown = false;
						}
					case 2:
						{
							imageText.text = "Beatrice's In-Game Loading Screen [Done by Sen].";
						}
					case 3:
						{
							imageText.text = "Aileen's In-Game Loading Screen [Done by Sen].";
							
						}
					case 4:
						{
							imageText.text = "Kiana's In-Game Loading Screen [Done by Roseruh!].";
							
						}
					case 5:
						{
							imageText.text = "DV's In-Game Loading Screen [Done by StaturoGuy].";
							
						}
					case 6:
						{
							imageText.text = "Morky's In-Game Loading Screen [Done by TD64].";
							
						}
					case 7:
						{
							imageText.text = "Aizeen's In-Game Loading Screen [Done by StaturoGuy].";
							
						}
					case 8:
						{
							imageText.text = "Michael's In-Game Loading Screen [Done by McFlurryAsh/R3tro].";
							
						}
					case 9:
						{
							imageText.text = "Marauder In-Game Loading Screen.";
							
						}
					case 10:
						{
							imageText.text = "Nic's In-Game Loading Screen [Done by StaturoGuy].";
							
						}
					case 11:
						{
							imageText.text = "Marcussy's In-Game Loading Screen [Done by StaturoGuy].";
							
						}
				}
			}

			if (categorySelected == 5)
			{
				if (imageNumber > 10)
					imageNumber = 1;
				if (imageNumber < 1)
					imageNumber = 10;
				currentImage.loadGraphic(Paths.image('Gallery/adMechanic/image_' + imageNumber));
				numberCounter.text = imageNumber + "/10";
				imageText.text = "All Pop up images used for the Ad Mechanic [In Order | All credits go to their respective artists]";
			}

			if (categorySelected == 6)
			{
				if (imageNumber > 45)
					imageNumber = 1;
				if (imageNumber < 1)
					imageNumber = 45;
				numberCounter.text = imageNumber + "/45";
				currentImage.loadGraphic(Paths.image('Gallery/fanarts/image_' + imageNumber));

				messageShown = false;
				switch(imageNumber)
				{
					case 1:
					{
						imageText.text = "Aizeen Fanart\nFanart by MSG_MTH";
					}
					case 2:
					{
						imageText.text = "DV Fanart\nFanart by GhostDann";
					}
					case 3:
					{
						imageText.text = "DV Fanart\nFanart by Stickguy";
					}
					case 4:
					{
						imageText.text = "DV Fanart\nFanart by JustYourBoyDJ";
					}
					case 5:
					{
						imageText.text = "Evelyn Fanart\nFanart by Fluffysketches";
					}
					case 6:
					{
						imageText.text = "Evelyn Fanart\nFanart by Valkinator";
					}
					case 7:
					{
						imageText.text = "Beatrice and Evelyn Fanart\nFanart by McFlurryAsh/R3tro";
					}
					case 8:
					{
						imageText.text = "Beatrice and Evelyn Fanart\nFanart by Porkchop";
					}
					case 9:
					{
						imageText.text = "Beatrice Fanart\nFanart by Zuyu";
					}
					case 10:
					{
						imageText.text = "Kiana Fanart\nFanart by Gray Avian";
					}
					case 11:
					{
						imageText.text = "Kiana Fanart\nFanart by Mss_Gray";
					}
					case 12:
					{
						imageText.text = "Kiana Fanart\nFanart by Hat and Tie";
					}
					case 13:
					{
						imageText.text = "Kiana Fanart\nFanart by CoolDetective123";
					}
					case 14:
					{
						imageText.text = "Aileen Fanart\nFanart by Zuyu";
					}
					case 15:
					{
						imageText.text = "Aileen Fanart\nFanart by Shin";
					}
					case 16:
					{
						imageText.text = "Marco Fanart\nFanart by Crako";
					}
					case 17:
					{
						imageText.text = "Aileen Fanart\nFanart by Handzy";
					}
					case 18:
					{
						imageText.text = "Marco Fanart\nFanart by Rexwald";
					}
					case 19:
					{
						imageText.text = "Aileen Fanart\nFanart by Sen";
					}
					case 20:
					{
						imageText.text = "Marco Fanart\nFanart by Rexwald";
					}
					case 21:
					{
						imageText.text = "Aileen Fanart\nFanart by Crako";
					}
					case 22:
					{
						imageText.text = "Marco Fanart\nFanart by Handzy";
					}
					case 23:
					{
						imageText.text = "Marco Fanart\nFanart by Rexwald";
					}
					case 24:
					{
						imageText.text = "Marco Fanart\nFanart by Fluffysketches";
					}
					case 25:
					{
						imageText.text = "Marco Fanart\nFanart by Terra_Core";
					}
					case 26:
					{
						imageText.text = "Marco Fanart\nFanart by Crako";
					}
					case 27:
					{
						imageText.text = "Marco and Aileen Fanart\nFanart by Handzy";
					}
					case 28:
					{
						imageText.text = "Marco and Aileen Fanart\nFanart by Handzy";
					}
					case 29:
					{
						imageText.text = "Group Fanart\nFanart by Porkchop";
					}
					case 30:
					{
						imageText.text = "Group Fanart\nFanart by Cass";
					}
					case 31:
					{
						imageText.text = "Group Fanart\nFanart by McFlurryAsh/R3tro";
					}
					case 32:
					{
						imageText.text = "Marco and Aileen Fanart\nFanart by ZGuy22";
					}
					case 33:
					{
						imageText.text = "Gigi Dearest Fanart\nFanart by Ketsuki";
					}
					case 34:
					{
						imageText.text = "Marco Fanart\nFanart by Ricey";
					}
					case 35:
					{
						imageText.text = "Finale Fanart\nFanart by Lizzy Strawberry";
					}
					case 36:
					{
						imageText.text = "DV Fanart\nFanart by Akira";
					}
					case 37:
					{
						imageText.text = "DV Fanart\nFanart by Akira";
					}
					case 38:
					{
						imageText.text = "Marco Fanart\nFanart by Rizmeko";
					}
					case 39:
					{
						imageText.text = "Aileen Fanart\nFanart by Rizmeko";
					}
					case 40:
					{
						imageText.text = "Marco Fanart\nFanart by Rizmeko";
					}
					case 41:
					{
						imageText.text = "Marco Fanart\nFanart by Rizmeko";
					}
					case 42:
					{
						imageText.text = "Marco Fanart\nFanart by Rizmeko";
					}
					case 43:
					{
						imageText.text = "Marco Fanart\nFanart by Phant0mPers0n";
					}
					case 44:
					{
						imageText.text = "Marco Fanart\nFanart by Rizmeko";
					}
					case 45:
					{
						imageText.text = "TC Fanart\nFanart by Sonrio";
					}
				}
			}

			if (categorySelected == 7)
			{
				if (imageNumber > 32)
					imageNumber = 1;
				if (imageNumber < 1)
					imageNumber = 32;
				numberCounter.text = imageNumber + "/32";
				currentImage.loadGraphic(Paths.image('Gallery/randomArts/image_' + imageNumber));

				messageShown = false;
				switch(imageNumber)
				{
					case 1:
					{
						imageText.text = "Aileen and Michael Together";
					}
					case 2:
					{
						imageText.text = "Michael Reference Art";
					}
					case 3:
					{
						imageText.text = "Marco Reference Art";
					}
					case 4:
					{
						imageText.text = "She be horny as fuck-";
					}
					case 5:
					{
						imageText.text = "What can I say, she likes fruits.";
					}
					case 6:
					{
						imageText.text = "Since when do fruit salads have lactose in-";
					}
					case 7:
					{
						imageText.text = "DV Reference Sheet";
					}
					case 8:
					{
						imageText.text = "Aizeen be looking good ngl";
					}
					case 9:
					{
						imageText.text = "Hewwo :3";
					}
					case 10:
					{
						imageText.text = "Intruder GF Reference Sheet";
					}
					case 11:
					{
						imageText.text = "We gon' do some evil shit, bitch-";
					}
					case 12:
					{
						imageText.text = "Just a cute couple :3";
					}
					case 13:
					{
						imageText.text = "WHERE ARE THE NUDES-";
					}
					case 14:
					{
						imageText.text = "Mimiko reference sheet";
					}
					case 15:
					{
						imageText.text = "Everywhere I go, I see him.";
					}
					case 16:
					{
						imageText.text = "A day in the life of an assistant";
					}
					case 17:
					{
						imageText.text = "Beatrice my beloved!";
					}
					case 18:
					{
						imageText.text = "Old Beatrice reference sheet";
					}
					case 19:
					{
						imageText.text = "DV's one of the million transformations";
					}
					case 20:
					{
						imageText.text = "I promise this isn't canon.";
					}
					case 21:
					{
						imageText.text = "Aileen my beloved";
					}
					case 22:
					{
						imageText.text = "Minus Marco Design";
					}
					case 23:
					{
						imageText.text = "I mean, do you?";
					}
					case 24:
					{
						imageText.text = "A day in the life of an assistant part 2";
					}
					case 25:
					{
						imageText.text = "Kiana my beloved~";
					}
					case 26:
					{
						imageText.text = "She be carrying her problems";
					}
					case 27:
					{
						imageText.text = "Evelyn my beloved";
					}
					case 28:
					{
						imageText.text = "We have come for your rapping skills";
					}
					case 29:
					{
						imageText.text = "Yea she likes Marco";
					}
					case 30:
					{
						imageText.text = "Oopsies!";
					}
					case 31:
					{
						imageText.text = "Stinky Twitter page";
					}
					case 32:
					{
						imageText.text = "FNV Devs in a nutshell";
					}
				}
			}
		}
}