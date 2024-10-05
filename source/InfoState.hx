package;

#if desktop
import Discord.DiscordClient;
#end
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
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxBackdrop;
import Alphabet;

#if MODS_ALLOWED
import sys.FileSystem;
#end

import vlc.MP4Handler;
import flash.system.System;

class InfoState extends MusicBeatState
{
	public static var curCharSelected:Int = 0;

	var optionShit:Array<String> = [
		// Main Cast
		'intruderGF',
		'BF',
		'marco',
		'aileen',
		'beatrice',
		'evelyn',
		'yaku',
		'kiana',
		'dv',
		'CGirl',
		'pico',
		'narrin',

		// Bonus Cast
		'marcussy',
		'amogleen',
		'morky',
		'aizeen',
		'marcus',
		'CGoon',

		// Shop Cast
		'michael',
		'nic',
		'tail',
		'fnv',
		'lillie',
		'porkchop',
		'dooglas',
		'short',
		'fangirl',
		'debugGuy',
		'asul',

		// Crossover Cast
		'vguy',
		'kyu',
		'tc',
		'marcx',
		'ai',
		'uzi',
		'lily',
		'manager'
	];

	var colors:Array<Array<Int>> = [ //each color takes 3 array slots
		[165, 0, 77], //gf
		[0, 213, 255], //Bf
		[29, 134, 21], //Marco
		[163, 187, 137], //Aileen
		[255, 0, 0],	//Beatrice
		[216, 190, 116], //Evelyn
		[255, 228, 93], //Yaku
		[255, 159, 160], //Kiana
		[29, 134, 21], //DV
		[41, 0, 204], //CGirl
		[237, 158, 0], //Pico
		[213, 84, 192], //Narrin

		[29, 134, 21], //Marcussy
		[163, 187, 137], //Amogleen
		[24, 148, 78], //Morky
		[66, 66, 66], //Aizeen
		[67, 143, 58], //Marcus
		[180, 138, 178], //CGoon

		[118, 148, 105], //Michael
		[255, 255, 255], //Nic.FLP
		[255, 255, 255], //Tail.FLP
		[146, 1, 151], //FNV
		[254, 196, 209], //Lillie
		[104, 50, 222], //Porkchop
		[255, 255, 255], //Dooglas
		[255, 255, 255], //Short
		[23, 107, 225], //Fangirl
		[0, 0, 0], //Debug Guy
		[3, 252, 252], //Asul

		[163, 87, 171], //Ourple
		[250, 219, 76], //Kyu
		[183, 1, 103], //TC
		[137, 191, 82],//Marcx
		[168, 145, 1],//AI
		[121, 55, 161],//Uzi
		[244, 161, 42], //Lily
		[205, 205, 253]//Manager	
	];

	var bg:FlxSprite;
	var BGchecker:FlxBackdrop;
	var titleText:Alphabet;
	var desc:FlxText;
	var char:FlxSprite;
	var textBG:FlxSprite;
	var textBGMain:FlxSprite;
	var Text:FlxText;
	var num:Int = 0;

	var arrowSelectorLeft:FlxSprite;
	var arrowSelectorRight:FlxSprite;
	var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;

	var loreScrollButton:FlxSprite;
	var scrollAsset:FlxSprite;
	var scrollDesc:FlxText;
	var blackOut:FlxSprite;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Infodex", null);
		#end

		//persistentUpdate = persistentDraw = true;
		
		curCharSelected = 0;

		bg = new FlxSprite().loadGraphic(Paths.image('promotion/Background'));
		bg.color = 0xFFe1e1e1;
		bg.alpha = 0.5;
		add(bg);

		BGchecker = new FlxBackdrop(Paths.image('promotion/BGgrid-' + FlxG.random.int(1, 8)), 0, 0, true, true); 
		BGchecker.updateHitbox(); 
		BGchecker.scrollFactor.set(0, 0); 
		BGchecker.alpha = 0; 
		BGchecker.screenCenter(X); 
		add(BGchecker);

		FlxTween.tween(BGchecker, {alpha: 1}, 2.2, {ease: FlxEase.cubeInOut, type: PERSIST});

		textBG = new FlxSprite(0, FlxG.height - 726).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		Text = new FlxText(textBG.x + 1000, textBG.y + 8, FlxG.width + 1000, "LEFT - A / RIGHT - D: Change Character | BACKSPACE: Go back to the Main Menu", 24);
		Text.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);
		Text.scrollFactor.set();
		add(Text);
	
		FlxTween.tween(Text, {x: textBG.x - 2500}, 20, {ease: FlxEase.linear, type: LOOPING});

		textBGMain = new FlxSprite(-400, 45).loadGraphic(Paths.image('characterInfo/infoCard'));
		textBGMain.scale.set(1.2, 1);
		textBGMain.x += 490;
		add(textBGMain);

		var platform:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('characterInfo/platform'));
		platform.screenCenter(XY);
		platform.y += 300;
		platform.x += 400;
		add(platform);

		titleText = new Alphabet(420, 90, "This is a test", true);
		titleText.setAlignmentFromString('center');
		add(titleText);

		arrowSelectorLeft = new FlxSprite(titleText.x - 410, titleText.y - 55).loadGraphic(Paths.image('freeplayStuff/arrowSelectorLeft'));
		arrowSelectorLeft.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorLeft.scale.set(0.5, 0.5);
		add(arrowSelectorLeft);

		arrowSelectorRight = new FlxSprite(titleText.x + 280, titleText.y - 55).loadGraphic(Paths.image('freeplayStuff/arrowSelectorRight'));
		arrowSelectorRight.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorRight.scale.set(0.5, 0.5);
		add(arrowSelectorRight);

		getRightArrowX = arrowSelectorRight.x;
		getLeftArrowX = arrowSelectorLeft.x;

		desc = new FlxText(60, 200, 700,
			"This will only appear if i\ndon't have any text\nset for the characters.\nWe'll be checking the amount of space\nI can use to add these descriptions in.\nI should theoretically have enough\nspace to type this much stuff.\n#fortniteforlife lmao",
			52);
		desc.setFormat("SF Atarian System", 33, FlxColor.WHITE, CENTER);
		add(desc);

		char = new FlxSprite(0, 0).loadGraphic(Paths.image('characterInfo/GFInfo'));
		char.x = 810;
		char.y = 40;
		char.scrollFactor.set(0, 0);
		char.alpha = 1;
		char.updateHitbox();
		char.antialiasing = ClientPrefs.globalAntialiasing;
		add(char);

		loreScrollButton = new FlxSprite(0, 0).loadGraphic(Paths.image('characterInfo/loreButton'));
		loreScrollButton.screenCenter();
		loreScrollButton.x -= 570;
		loreScrollButton.y += 280;
		loreScrollButton.alpha = 1;
		add(loreScrollButton);

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 0;
		add(blackOut);

		scrollAsset = new FlxSprite(0, 0).loadGraphic(Paths.image('characterInfo/scrollAsset'));
		scrollAsset.screenCenter();
		scrollAsset.alpha = 0;
		add(scrollAsset);

		scrollDesc = new FlxText(scrollAsset.x - 130, scrollAsset.y + 80, 900,
			"This will only appear if i\ndon't have any text\nset for the characters.\nWe'll be checking the amount of space\nI can use to add these descriptions in.\nI should theoretically have enough\nspace to type this much stuff.\n#fortniteforlife lmao",
			52);
		scrollDesc.setFormat("SF Atarian System", 38, FlxColor.WHITE, CENTER);
		scrollDesc.alpha = 0;
		add(scrollDesc);

		titleText.text = "Gigi Dearest";

		desc.text = "Full name: Girlfriend\nAge: 19
			\nA lost and curious version of Gf.\nShe is way smarter and Way cheekier\nthan her Canon Counterpart
			\n'Left Right Down up'";

		changeItem();

		super.create();
	}

	var sidePressed:String = '';
	var showingLore:Bool = false;
	var allowLore:Bool = false;

	var fardTimer:FlxTimer;
	var fardsCounter:Int = 0;
	var morkyFarded:Bool = false;
	var showedFard:Bool = false;
	override function update(elapsed:Float)
	{
		BGchecker.x += 0.5*(elapsed/(1/120));
        BGchecker.y += 0.16 / (ClientPrefs.framerate / 60); 

		if (!morkyFarded)
		{
			if (controls.BACK || FlxG.mouse.justPressedRight)
			{
				if (showingLore)
				{
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(blackOut, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					showingLore = false;
				}
				else
				{
					FlxTween.tween(BGchecker, {alpha: 0}, 0.4, {ease: FlxEase.quadInOut, type: PERSIST});
					persistentUpdate = false;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new MainMenuState(), 'stickers');
				}
			}

			if (!showingLore)
			{
				if (allowLore)
					if (FlxG.mouse.overlaps(loreScrollButton))
						loreScrollButton.alpha = 1;
					else
						loreScrollButton.alpha = 0.6;
				else
					loreScrollButton.alpha = 0;

				if (FlxG.mouse.overlaps(loreScrollButton) && FlxG.mouse.justPressed && allowLore)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					showingLore = true;
					showLore();
				}

				if (FlxG.mouse.overlaps(arrowSelectorLeft))
					FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				else
					FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		
				if (FlxG.mouse.overlaps(arrowSelectorRight))
					FlxTween.tween(arrowSelectorRight, {x: getRightArrowX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				else
					FlxTween.tween(arrowSelectorRight, {x: getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
	
				if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A || (FlxG.mouse.overlaps(arrowSelectorLeft) && FlxG.mouse.justPressed))
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					sidePressed = 'LEFT';
					changeItem(-1);	
				}
	
				if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D || (FlxG.mouse.overlaps(arrowSelectorRight) && FlxG.mouse.justPressed))
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					sidePressed = 'RIGHT';
					changeItem(1);
				}
			}
			else
			{
				if (controls.ACCEPT || (FlxG.mouse.overlaps(scrollDesc) && FlxG.mouse.justPressed))
				{
					switch(optionShit[curCharSelected])
					{
						case 'marco':
							CoolUtil.browserLoad('https://docs.google.com/document/d/1VMh3tncUc5x8l2jWUDagkcAzh0tcA-_C/edit?usp=sharing&ouid=108769625338074704736&rtpof=true&sd=true');
						case 'aileen':

						case 'beatrice':

						case 'evelyn':

						case 'yaku':

						case 'kiana':

						case 'dv':

						case 'narrin':

						case 'morky':
							if (fardTimer != null)
							{
								if (fardTimer.progress != 1 && fardsCounter == 20)
									morkyFarded = true;
								fardTimer.cancel();
							}
							if (fardsCounter != 20)
							{
								fardsCounter += 1;
								FlxG.sound.play(Paths.sound('morky'));
								fardTimer = new FlxTimer().start(2, resetFards);
							}
						case 'debugGuy':

					}
				}
			}
		}
		else if (morkyFarded && !showedFard)
		{
			showedFard = true;
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.sound('fart'));
			var video:MP4Handler = new MP4Handler();
			video.finishCallback = function()
			{
				System.exit(0);				
			};
			new FlxTimer().start(1, function (tmr:FlxTimer) {
				System.exit(0);
			});
			video.playVideo(Paths.video('morky farded'));
		}

		super.update(elapsed);
	}

	function resetFards(timer:FlxTimer)
	{
		fardsCounter = 0;
	}

	function showLore()
	{
		switch(optionShit[curCharSelected])
		{
			case 'marco':
				if (ClientPrefs.marcoScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "Before he became the infamous villain, he was\nonce named \"Michael PureHeart\",\na young but brilliant chemist who had the\nexpertise in making body enhancement\nsupplements.\nAt the age of 22, fresh out of his English\nUniversity, Michael receives a letter...
					\n[Click <G>here<G> to view the full extension]";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'aileen':
				if (ClientPrefs.aileenScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "I am Aileen's lore, nice to meet you\nlmao";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'beatrice':
				if (ClientPrefs.beatriceScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "I am Beatrice's lore, nice to meet you\nlmao";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'evelyn':
				if (ClientPrefs.evelynScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "I am Evelyn's lore, nice to meet you\nlmao";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'yaku':
				if (ClientPrefs.yakuScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'kiana':
				if (ClientPrefs.kianaScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "I am the bitch's lore, nice to meet you\nlmao";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'dv':
				if (ClientPrefs.dvScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "I am DV's lore, nice to meet you\nlmao";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'narrin':
				if (ClientPrefs.narrinScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "I am Narrin's lore, nice to meet you\nlmao";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'morky':
				if (ClientPrefs.morkyScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "\n\n\n\nI heyt Wemens";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'debugGuy':
				if (ClientPrefs.kaizokuScroll == true)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "I am Kaizoku's lore, nice to meet you\nlmao";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}				
		}
		CustomFontFormats.addMarkers(scrollDesc);
		trace('Showing Lore');
	}

	function changeItem(huh:Int = 0)
		{
			var currentColor:Int = curCharSelected;
			curCharSelected += huh;

			if (curCharSelected >= optionShit.length)
				curCharSelected = 0;
			if (curCharSelected < 0)
				curCharSelected = optionShit.length - 1;

			FlxTween.color(bg, 2, FlxColor.fromRGB(colors[currentColor][0], colors[currentColor][1], colors[currentColor][2]), FlxColor.fromRGB(colors[curCharSelected][0], colors[curCharSelected][1], colors[curCharSelected][2]), {ease: FlxEase.circOut, type: PERSIST});

			switch (optionShit[curCharSelected])
			{
				// Main Cast
				case 'intruderGF':
					char.loadGraphic(Paths.image('characterInfo/GFInfo'));
					char.scrollFactor.set(0, 0);
					char.x = 810;
					char.y = 40;
					char.alpha = 1;
					char.updateHitbox();
					char.antialiasing = ClientPrefs.globalAntialiasing;

					titleText.text = "Trespasser GF";

					desc.text = "Full name: Gigi Dearest\nAliases: Gf, Fair Maiden, Ugly Boring Teenager, Chuckletits, Bitch\nAge: 19\nSpecies: Demon
						\nA Lost, curious, but way smarter counterpart of the original girlfriend who just wants to get back to her Boyfriend (kinda).
						\n'That's how you do it!'";
					
					allowLore = false;
				case 'BF':
					char.loadGraphic(Paths.image('characterInfo/BFInfo'));
					char.scrollFactor.set(0, 0);
					char.x = 810;
					char.y = 40;
					char.alpha = 1;
					char.updateHitbox();
					char.antialiasing = ClientPrefs.globalAntialiasing;

					titleText.text = "Boyfriend";

					desc.text = "Real Name: Balthazar Escobar Francisco the 3rd\nAliases: Lil Boyfriend, Ugly worm, cuckoo, Little dude, Little man\nAge: Old\nSpecies: Dumbass
					\nA tiny arrogant little brat who thinks nothing more than to fuck his GF, yet he gets cucked all the time. 
					\n'Take that Daddy Dearest! Hiiiiiyaaaaaa!!!'";
					
					allowLore = false;
				case 'marco':
					char.loadGraphic(Paths.image('characterInfo/MarcoInfo'));
					char.scrollFactor.set(0, 0);
					char.x = 810;
					char.y = 40;
					char.alpha = 1;
					char.updateHitbox();
					char.antialiasing = ClientPrefs.globalAntialiasing;

					titleText.text = "Marco";

					desc.text = "Full Name: Marco Isavilan\nReal name: Michael Pureheart\nAliases: Asshole, The Cheapskate, Sir, Isavilan\nAge: 30\nSpecies: Human\nHeight: 6'2
					\nGreenville's Infamous Self proclaimed Best\nCheapskate Villain in the entire universe!\nHe brings terror on people on a budget.
					\n'AILEEN!!'";

					allowLore = true;
					if (ClientPrefs.marcoScroll == true)
						loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
					else
						loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
				case 'aileen':
					char.loadGraphic(Paths.image('characterInfo/AileenInfo'));
					char.scrollFactor.set(0, 0);
					char.x = 810;
					char.y = 40;
					char.alpha = 1;
					char.updateHitbox();
					char.antialiasing = ClientPrefs.globalAntialiasing;

					titleText.text = "Aileen";

					desc.text = "Full name: Aileen Polostar\nAliases: My Highest Assistant, AILEEN, Smokin Assistant\nAge: 24\nSpecies:Human\nHeight: 5'2
					\nMarco's loyal assistant who fixes schedules and organizes her boss's daily routine of being an asshole. She sometimes gets more credit on being the most patient person on the world.					
					\n'Contrary to popular belief, I'm not smarter than my boss. I only use my brain more than his.'";

					allowLore = true;
					if (ClientPrefs.aileenScroll == true)
						loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
					else
						loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
				case 'beatrice':
					if (ClientPrefs.nunWeekPlayed == true)
					{
						char.loadGraphic(Paths.image('characterInfo/BeatriceInfo'));
						char.scrollFactor.set(0, 0);
						char.x = 810;
						char.y = 40;
						char.alpha = 1;
						char.updateHitbox();
						char.antialiasing = ClientPrefs.globalAntialiasing;

						titleText.text = "Beatrice";
						
						desc.text = "Full name: Beatrice Cygiamon\nAliases: Kind Hearted Nun, That Nun in the church\nAge: 21\nSpecies: Human\nHeight: 5'10
						\nA Kind hearted nun of the Euroda Orphanage, who works 24/7 with full joy while putting all her trust to God.
						\n'Welcome to the Orphanage! My name is Sister Beatrice!'";
					}
					else
					{
						char.alpha = 0;

						titleText.text = "?????";
						
						desc.text = "Unlock Week 2 First!";
					}
					allowLore = true;
					if (ClientPrefs.beatriceScroll == true)
						loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
					else
						loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
				case 'evelyn':
					if (ClientPrefs.nunWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/EvelynInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;

							titleText.text = "Evelyn";

							desc.text = "Codename: EX-BR Model 3\nAge: ???\nSpecies: Cybernetic Organism\nHeight: 6'2
							\nAn A.I. created by an unknown company, who gained sentience and will to run away from it and live as an orphanage nun.
							\n'...'";
						}
						else
						{
							char.alpha = 0;

							titleText.text = "?????";
						
							desc.text = "Unlock Week 2 First!";
						}
						allowLore = true;
						if (ClientPrefs.evelynScroll == true)
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
						else
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
				case 'yaku':
					if (ClientPrefs.nunWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/YakuInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;

							titleText.text = "Yaku";

							desc.text = "Codename: Experiment no. 266 \nReal name: Yaku Feridot\nAliases: 266, Ghost, Bestie, Latina Magnet\nAge: 25\nSpecies: Highly Enhanced Human\nHeight: 7ft
							\nA human experiment created by an unknown company as the perfect killer human, who broke out of his employers' strings to live as a regular Janitor in an orphanage.
							\n'You're next.'";
						}
						else
						{
							char.alpha = 0;

							titleText.text = "????";
						
							desc.text = "Unlock Week 2 First!";
						}
						allowLore = true;
						if (ClientPrefs.yakuScroll == true)
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
						else
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));		
				case 'kiana':
					if (ClientPrefs.kianaWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/KianaInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Kiana";
	
							desc.text = "Aliases: The First Dweller, Lust demon, Basilisk, Professional Nut Gargler\nAge: ???\nSpecies: Part Entity - Part Ancient Deity\nHeight: 4'11 (Seductive Form) - 43 ft (Real Form)
							\nA Fluid thirsty 'Dweller'\nfrom The Unnamed Dimension.\nShe will use her seductive form\nto lure prey from other dimensions\nso she can feed on their desires and souls.
							\n'STUPID BITCH'";
						}
						else
						{
							char.alpha = 0;

							titleText.text = "?????";
						
							desc.text = "Unlock Week 3 First!";
						}
						allowLore = true;
						if (ClientPrefs.kianaScroll == true)
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
						else
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
				case 'dv':
					if (ClientPrefs.kianaWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/DVInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 670;
							char.y = -20;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;

							titleText.text = "DV";

							desc.text = "Full Name: Dimitrov Vaughan\nSkin name: Fernanda\nAliases: Mad, The third Dweller, Shadow man, Skinwalker, Skin Stealer\nAge: 253\nHeight: 6ft (Fernanda) - 11 ft (Dv)\nSpecies: Entity
							\nA creature from the Abyss who works together with the other dwellers.It steals skin of his victims to wear as disguise in the human world.";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "??";
						
							desc.text = "Unlock Week 3 First!";
						}
						allowLore = true;
						if (ClientPrefs.dvScroll == true)
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
						else
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
				case 'CGirl':
					if (ClientPrefs.kianaWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/CGirlInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;

							titleText.text = "Busted C.C.";

							desc.text = "Based on: Cassete Girl\nAliases: CG, Kassetto, Kasetto \nAge:23 \nSpecies: Android
							\nA Busted-Up Cassette Clone based on Cassette Girl who is blind. The reasons she got here in the first place are unknown. 	
							\n'Coconut Ice Cream'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "?????? ?.?.";
						
							desc.text = "Unlock Week 3 First!";
						}
						allowLore = false;
				case 'pico':
					if (ClientPrefs.kianaWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/PicoInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Pico";
	
							desc.text = "Aliases: Prick-o, Prico, Sexually Ambiguous Little Friend, Little doll\nAge: 20\nSpecies: Human
							\nThe Contract Killer/Former School Shooter, who's in the quest of finding Girlfriend.
							\n'SHUT UP YOUR PINK ASS MOUTH'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "????";
						
							desc.text = "Unlock Week 3 First!";
						}
						allowLore = false;
				case 'narrin':
					if (ClientPrefs.kianaWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/NarrinInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Narrin";
	
							desc.text = "Real Name: Nadia Baroque\nAliases: The Jester, 2nd Dweller, Clown, Pink-Ass, Toy Maker, The Puppeteer\nAge: 105\nSpecies: Humanoid Entity
							\nThe second dweller of the unnamed dimension, who loves to play with her victims before turning them into her slave puppets, who resemble and think like her. The victim is aware that this is happening real time.
							\n'WELL SO FAR, IM JUST A CHARACTER'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "??????";
						
							desc.text = "Unlock Week 3 First!";
						}
						allowLore = true;
						if (ClientPrefs.narrinScroll == true)
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
						else
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));

				//Bonus Cast
				case 'marcussy':
					if (ClientPrefs.susWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/MarcussyInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 700;
							char.y = -5;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Marcussy";
	
							desc.text = "Real Name: Marco Isavilan\nAliases: The Villain in Board\nSpecies: Among us Sussy Impostor 
							\nThe Custom Among us Character\nmade by Marco himself.\nThis is the first time\nhe became an impostor\nin the game and\nhe's having a good time.";
						}
						else
						{
							char.alpha = 0;

							titleText.text = "?????";
						
							desc.text = "Unlock Week Sus First!";
						}	
						allowLore = false;
				case 'amogleen':
					if (ClientPrefs.susWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/AmogleenInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Amogleen";
	
							desc.text = "Real Name: Aileen Polostar\nSpecies: Among us Pet 
							\nCrewmate Sona of Aileen\ncustomized by Marco\nto put in the game with him\nas a pet crewmate.\n[Aileen is not aware that Marco did this]";
						}
						else
						{
							char.alpha = 0;

							titleText.text = "?????";
						
							desc.text = "Unlock Week Sus First!";
						}
						allowLore = false;
				case 'morky':
					if (ClientPrefs.morkyWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/MorkyInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;

							titleText.text = "Morky";

							desc.text = "Full Name: MORKY\nAge: NOT OLD!11!\nHeight:NOT SHORT!1!1
							\nMORKY IS THE REAL MARCO!1!1\nMORKY IS THE REAL VILLAIN!1!1\nEVERYONE ELSE IS NOT REAL!11!\nCOME AND PLAY WITH ME!1!!1
							\n'I AM MORKY AND I AM A VILLAIN!'";
						}
						else
						{
							char.alpha = 0;

							titleText.text = "?????";
						
							desc.text = "Unlock the Joke Week First!";
						}
						allowLore = true;
						if (ClientPrefs.morkyScroll == true)
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
						else
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
				case 'aizeen':
					if (ClientPrefs.dsideWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/AizeenInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Aizeen";
	
							desc.text = "Full Name: Aizeen Verieevel\nReal Name: Aileen H. Polostar\nAge: Mid 20s
									\nAn unhinged villain who is romantically and very sexually attracted to her assistant who is an open gay man.
									\n'MARCUS, I STILL LOVE YOU, PLEASE LOVE ME BACK'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "?????";
						
							desc.text = "Unlock Week D-sides First!";	
						}
						allowLore = false;
				case 'marcus':
					if (ClientPrefs.dsideWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/MarcusInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Marcus";
	
							desc.text = "Full name: Marcus Heartpure\nAliases: Gay Assistant, Marcus! my sweet little Assistant, \nSpecies: Human\nHeight: 5'11
										\nA gay man who doesn't like his boss very much for 10 or 27 reasons.
										\n'Ma'am, I'm gay, shut up'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "??????";
						
							desc.text = "Unlock Week D-sides First!";	
						}
						allowLore = false;
				case 'CGoon':
					if (ClientPrefs.dsideWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/CGoonInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;

							titleText.text = "Cassette Goon";

							desc.text = "Aliases: D-Sides Cassette Goon\nAge: ???\nHeight:???\nSpecies: Android
							\nD-Sides Cassette Goon whose design is based on News Goon.\n[design of KaosKurve in Newgrounds!!]";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "???????? ????";
						
							desc.text = "Unlock Week D-sides First!";
						}
						allowLore = false;
					
				//Shop Cast
				case 'michael':
					if (ClientPrefs.marcochromePlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/MichaelInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Michael";
	
							desc.text = "Full Name: Michael PureHeart\nAliases: CEO left hand Man, Smartest man in the Company, Young Chemist\nAge: 23 [before the incident]\nSpecies: Human\nHeight: 6ft
							\nA Young British Chemist who suffered a worse fate than death... or is it?
							\n'If I had a wife, I would love her so much. Too bad I don't have a wife'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "?????";
						
							desc.text = "Unlock Marcochrome First!";
						}
						allowLore = false;
				case 'nic':
					if (ClientPrefs.nicPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/NicFLPInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Nic.FLP";
	
							desc.text = "Full name: Philippe Necrosis\nAge: Old\nAliases: Do not steal OC, Sonic\nSpecies: Hedge, Flp, A hog\nHeight: Small
										\nTHERE IS NO ESCAPE VERSION 2029
										\n'I AM GOD probably idk, I'm kinda insecure'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "?????";
						
							desc.text = "Unlock Slow.FLP First!";
						}
						allowLore = false;
				case 'tail':
					if (ClientPrefs.nicPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/tailInfo'));//here put the name of the xml
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.scale.x = 1;
							char.scale.y = 1;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Tail.FLP";
	
							desc.text = "Real Name: Miles Tails Prower\nAge: Not Old
							\nUnlike the other Tails's\nin most EXE stories,\nthis one didn't suffer a horrible fate...\nNevermind, this one dies too.
							\n'Sonic, pls don't kill me!'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "?????";
						
							desc.text = "Unlock Slow.FLP First!";
						}
						allowLore = false;
				case 'fnv':
					if (ClientPrefs.fnvPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/FNVInfo'));//here put the name of the xml
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.scale.x = 1;
							char.scale.y = 1;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "FNV";
	
							desc.text = "Real Name: Friday Night Villainy\nAliases: FNV\nAge: FNV\nSpecies: FNV\nHeight: FNV
							
							\nFNV
							
							\n'fnv'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "???";
						
							desc.text = "Unlock FNV First!";
						}
						allowLore = false;
				case 'lillie':
					if (ClientPrefs.rainyDazePlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/LillieInfo'));//here put the name of the xml
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.scale.x = 1;
							char.scale.y = 1;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Lillie";
	
							desc.text = "Real Name: Lillian Craig\nAge: 24\nAliases: SakuraKoto, Lillie, Sexually Attractive Transgender Woman\nSpecies: Human\nHeight: 6'2 ft
										\nAn Artist/Singer who likes to play Sims, Minecraft and Roblox. She likes Pico dangerously a lot (at least this variant)";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "??????";
						
							desc.text = "Unlock Rainy Daze First!";
						}
						allowLore = false;
				case 'porkchop':
					if (ClientPrefs.morkyWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/PorkchopInfo'));//here put the name of the xml
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.scale.x = 1;
							char.scale.y = 1;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Porkchop";
	
							desc.text = "Age:???\nHeight: Short\nSpecies: Lean Bunny
							\nA Purple Rabbit who wears a hat.
							\n(Character is owned by Porkchop on Discord!)";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "?????";
						
							desc.text = "Unlock Instrumentally Deranged First!";
						}
						allowLore = false;
				case 'dooglas':
					if (ClientPrefs.morkyWeekPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/DooglasInfo'));//here put the name of the xml
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.scale.x = 1;
							char.scale.y = 1;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Dooglas";
	
							desc.text = "Aliases: Simp\nAge: ???\nSpecies: bruh idk\nHeight: Small
							\nA very notorious simp who loves women.
							\n'Wer may wumen'
							\n(Character is owned by Porkchop on Discord!)";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "???????";
						
							desc.text = "Unlock Instrumentally Deranged First!";
						}
						allowLore = false;
				case 'short':
					if (ClientPrefs.shortPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/ShortInfo'));//here put the name of the xml
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.scale.x = 1;
							char.scale.y = 1;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Jerry";
	
							desc.text = "His name is Jerry.\n
							\n
							\n
							\n
							\n
							\n
							\nHe appeared in Jerry.";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "???????";
						
							desc.text = "Unlock 0.0015 First!";
						}
						allowLore = false;
				case 'fangirl':
					if (ClientPrefs.infatuationPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/FangirlInfo'));//here put the name of the xml
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.scale.x = 1;
							char.scale.y = 1;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Fangirl";
	
							desc.text = "Real Name: Fangirl\nAge: 
							\nPlaceholder description.
							\n...";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "???????";
						
							desc.text = "Unlock Fanfuck Forever First!";
						}
						allowLore = false;
				case 'debugGuy':
					if (ClientPrefs.debugPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/DebugInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 670;
							char.y = -20;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Debug guy";
	
							desc.text = "Real Name: Roku Dorubo\nAge: 64 (Human Body) | 34 (as a Virus) | 98 (in total)\nAliases: Debug Guy, Anti-Anti-Virus, Virus-san, Debug-san, Roro, Soulless One\nSpecies: Polygurian (Formerly) | Virus\nHeight: 9'4 (Polygurian) | Various (Virus)
										\nA Polygurian that turned himself into a virus to immortalise his consciousness. He likes to hijack indie games and party 24/7.
										\n'Looks like Our broadcast has ended'";
						}
						else
						{
							char.alpha = 0;

							titleText.text = "?????";
						
							desc.text = "Unlock Marauder First!";
						}
						allowLore = true;
						if (ClientPrefs.kaizokuScroll == true)
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
						else
							loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
				case 'asul':
					if (ClientPrefs.infatuationPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/AsulInfo'));//here put the name of the xml
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.scale.x = 1;
							char.scale.y = 1;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Asul";
	
							desc.text = "Real Name: Kiana\nAliases: Favorite Sister, Fatty, Chubs, Blue, Tails, Bon-Bon, Shy \nAge: ???\nSpecies: Part Entity Creature | Part Ancient Deity \nHeight: 4'11 (Default Form) | 353 Ft (Eldritch form)
										\nDraco Kiana's Shy but kind counterpart who loves Reading books and Dislikes Thunder.
										\n'I have the ability to wipe out all of humanity, but I won't, because that's not very nice..'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "???????";
						
							desc.text = "Unlock Fanfuck Forever First!";
						}
						allowLore = false;
					
				//Crossover Cast
				case 'vguy':
					if (ClientPrefs.ourplePlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/OurpleInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Ourple";
	
							desc.text = "Real Name: William Afton\nAge: Super Old\nAliases: Springtrap, Scraptrap, Dave Miller, Steve Raglan, Williamus Aftus
										\nA funny restaurant founder who has an average Kill to Death Ratio.
										\n'I always cum back.'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "??????";
						
							desc.text = "Unlock Vguy First!";	
						}
						allowLore = false;
				case 'kyu':
					if (ClientPrefs.kyuPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/KyuInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Kyu";
	
							desc.text = "Full name: Kyu Faraday\nAge: 19 (From her Mod) | 27 (FNV)\nAliases: ???\nSpecies: Human \nHeight 5'9 | 5'11 (FNV Heels)
										\nA White Blonde woman with abs that can grind meat or fry eggs. She has these Powers too i guess.
										\n'Prepare yourself! This'll prolly sound bad, But I'll go with the flow.'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "???";
						
							desc.text = "Unlock Fast Food Therapy First!";	
						}
						allowLore = false;
				case 'tc':
					if (ClientPrefs.tacticalMishapPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/TCInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "TC";
	
							desc.text = "Real Name: Tactical Cupcakes\nAge: in her 20s\nAliases: Bestie, Greatest in (Insert Game here), TC, Tac, Tounge Champion, Bitch, Muted Les-Biatch, Mutey\nSpecies: Human \nHeight: 5'10
										\nA British Girl who loves hanging out with her friends and playing her own content.
										\n'That Marco guy is Discord incarnate, you know what's in discord, my Server link is inthedescriptionbytheway'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "??";
						
							desc.text = "Unlock Tactical Mishap First!";	
						}
						allowLore = false;
				case 'marcx':
					if (ClientPrefs.breacherPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/MarcxInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Marcx";
	
							desc.text = "Full Name: Marx Abigasshole\nAge: 40 \nAliases: Villanous Worker drone, Sir, Profanity Machine, Mr.'No one is ever calling you that'\nSpecies: Worker drone\nHeight: 3ft 
										\nThe very first worker drone that is powered by radioactive human piss
										\n'Would be funny if there was a human counter of myself'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "?????";
						
							desc.text = "Unlock Breacher First!";	
						}
						allowLore = false;
				case 'ai':
					if (ClientPrefs.breacherPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/AiInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "A.I.";
	
							desc.text = "Full name: AI Pollutantstar\nAliases: Marx's Murder drone, Aileen, Bitch, Piss power psychopath\nAge: ??\nSpecies: Disassembly Drone\nHeight: 7'4 ft 
										\nThe first ever Murder Drone that is powered by radioactive human piss 
										\n'It's 'A-I' as in 'Ey-Aye' not Aileen, sir.'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "?.?.";
						
							desc.text = "Unlock Breacher First!";	
						}
						allowLore = false;
				case 'uzi':
					if (ClientPrefs.breacherPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/UziInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Uzi";
	
							desc.text = "Full name: Uzi Doorman\nAge: around 18-20 (Theoretically)\nAliases: Barely Sentient Toaster, darkXWolf17, 002, Dapper Buddy \nSpecies: Worker Drone\nHeight: 4'2 ft
									\nA Rebellious Worker Drone that got weird UnGodly powers after Puberty.
									\n'THERE HAS TO BE A SEASON 2 PLEASE'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "???";
						
							desc.text = "Unlock Breacher First!";	
						}
						allowLore = false;
				case 'lily':
					if (ClientPrefs.ccPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/LilyInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Lily";
	
							desc.text = "Full name: Lily Engraved\nAge: 20s\nAliases: Lily In Grave, Lily-Chan\nSpecies: Human (FNV and Formerly on her mod) | Zombie 
									\nA Popstar that loved starring and popping on the stage till she received a hammer time right on her noggin.
									\n'Are you ready?'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "????";
						
							desc.text = "Unlock Concert Chaos First!";	
						}
						allowLore = false;
				case 'manager':
					if (ClientPrefs.ccPlayed == true)
						{
							char.loadGraphic(Paths.image('characterInfo/ManagerInfo'));
							char.scrollFactor.set(0, 0);
							char.x = 810;
							char.y = 40;
							char.alpha = 1;
							char.updateHitbox();
							char.antialiasing = ClientPrefs.globalAntialiasing;
	
							titleText.text = "Manager";
	
							desc.text = "Full name: Bruna Brunette\nAge: Between 20 or 30\nAliases: Manager-Chan\nSpecies: Human
										\n'This love letter is definitely written by ChatGPT.'";
						}
						else
						{
							char.alpha = 0;
	
							titleText.text = "???????";
						
							desc.text = "Unlock Concert Chaos First!";	
						}
						allowLore = false;
			}
		}
}
