package;

import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxBackdrop;
import Alphabet;

#if MODS_ALLOWED
import haxe.io.Path;
#end

import flash.system.System;

using StringTools;

class InfoState extends MusicBeatState
{
	public static var curCharSelected:Int = 0;

	var optionShit:Array<String> = [
		// Main Cast
		'GF',
		'BF',
		'Marco',
		'Aileen',
		'Beatrice',
		'Evelyn',
		'Yaku',
		'Kiana',
		'DV',
		'CGirl',
		'Pico',
		'Narrin',

		// Bonus Cast
		'Marcussy',
		'Amogleen',
		'Morky',
		'Aizeen',
		'Marcus',
		'CGoon',

		// Shop Cast
		'Michael',
		'NicFLP',
		'Tail',
		'FNV',
		'Lillie',
		'Porkchop',
		'Dooglas',
		'Short',
		'Fangirl',
		'Debug',
		'Asul',

		// Crossover Cast
		'Ourple',
		'Kyu',
		'TC',
		'Marcx',
		'Ai',
		'Uzi',
		'Cross',
		'Seer',
		'Lily',
		'Manager'
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
		[140, 3, 3], // Cross
		[19, 220, 235], // Seer
		[244, 161, 42], //Lily
		[205, 205, 253]//Manager	
	];

	var bg:FlxSprite;
	var BGchecker:FlxBackdrop;
	var titleText:Alphabet;
	var desc:FlxText;

	var charGroup:Array<FlxSprite> = [];
	var CHAR_DEFAULT_X:Int = 810;
	var CHAR_DEFAULT_Y:Int = 40;

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

		curCharSelected = 0;

		bg = new FlxSprite().loadGraphic(Paths.image('promotion/Background'));
		bg.color = 0xFFe1e1e1;
		bg.alpha = 0.5;
		add(bg);

		BGchecker = new FlxBackdrop(Paths.image('promotion/BGgrid-' + FlxG.random.int(1, 8)), FlxAxes.XY, 0, 0); 
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

		var platform:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('characterInfo/platform'));
		platform.screenCenter(XY);
		platform.y += 300;
		platform.x += 400;
		add(platform);

		loadCharacters(FileSystem.absolutePath("assets/images/characterInfo"));
		updateCharPositions(false);

		textBGMain = new FlxSprite(-400, 45).loadGraphic(Paths.image('characterInfo/infoCard'));
		textBGMain.scale.set(1.2, 1);
		textBGMain.x += 490;
		add(textBGMain);

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

		desc = new FlxText(30, 175, 750,
			"This will only appear if i\ndon't have any text\nset for the characters.\nWe'll be checking the amount of space\nI can use to add these descriptions in.\nI should theoretically have enough\nspace to type this much stuff.\n#fortniteforlife lmao",
			52);
		desc.setFormat("SF Atarian System", 28, FlxColor.WHITE, CENTER);
		add(desc);

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

	function loadCharacters(folder:String)
	{
		if (FileSystem.exists(folder) && FileSystem.isDirectory(folder)) 
		{
			var ID:Int = 0;
			var files = FileSystem.readDirectory(folder);
			var sortedChars:Array<String> = [];

			for (file in files) 
				if (StringTools.endsWith(file, "Info.png")) // Check if filename ends with "Info.png"
					sortedChars.push(Path.withoutExtension(file.replace("Info", "").trim()));

			// Sort Characters based on optionShit array
			sortedChars.sort(function(a, b) {
				var indexA = optionShit.indexOf(a);
				var indexB = optionShit.indexOf(b);
				if (indexA == -1) indexA = 9999; // Put unknown characters at the end
				if (indexB == -1) indexB = 9999;
	
				return indexA - indexB;
			});

			// Add sorted characters in charGroup
			for (charName in sortedChars)
			{
				var char:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("characterInfo/" + charName + "Info"));
				
				char.ID = ID;
				char.screenCenter(XY);
				char.x = CHAR_DEFAULT_X - 750;
				switch (charName.toLowerCase())
				{
					case "dv" | "marcussy" | "debug":
						char.y = CHAR_DEFAULT_Y - 75;
					default:
						char.y = CHAR_DEFAULT_Y;
				}
				charGroup.push(char);
            	add(char);
				
				checkIfLocked(charName.toLowerCase(), char);

				ID++;
			}
		} 
		else
			trace("Error: Directory not found - " + folder);
	}

	function checkIfLocked(charName:String, spr:FlxSprite)
	{
		// Main Cast
		switch (charName)
		{
			case 'beatrice' | 'evelyn' | 'yaku':
				if (!ClientPrefs.nunWeekPlayed) spr.color = FlxColor.BLACK;
			case 'kiana' | 'dv' | 'cgirl' | 'pico' | 'narrin':
				if (!ClientPrefs.kianaWeekPlayed) spr.color = FlxColor.BLACK;

				//Bonus Cast
			case 'marcussy' | 'amogleen':
				if (!ClientPrefs.susWeekPlayed) spr.color = FlxColor.BLACK;
			case 'aizeen' | 'marcus' | 'cgoon':
				if (!ClientPrefs.dsideWeekPlayed) spr.color = FlxColor.BLACK;
			case 'morky' | 'porkchop' | 'dooglas':
				if (!ClientPrefs.morkyWeekPlayed) spr.color = FlxColor.BLACK;
				
			//Shop Cast
			case 'michael':
				if (!ClientPrefs.marcochromePlayed) spr.color = FlxColor.BLACK;
			case 'nicflp' | 'tail':
				if (!ClientPrefs.nicPlayed) spr.color = FlxColor.BLACK;
			case 'fnv':
				if (!ClientPrefs.fnvPlayed) spr.color = FlxColor.BLACK;
			case 'lillie':
				if (!ClientPrefs.rainyDazePlayed) spr.color = FlxColor.BLACK;
			case 'short':
				if (!ClientPrefs.shortPlayed) spr.color = FlxColor.BLACK;
			case 'fangirl':
				if (!ClientPrefs.infatuationPlayed) spr.color = FlxColor.BLACK;
			case 'debug':
				if (!ClientPrefs.debugPlayed) spr.color = FlxColor.BLACK;
			case 'asul':
				if (!ClientPrefs.itsameDsidesUnlocked) spr.color = FlxColor.BLACK;
				
			//Crossover Cast
			case 'ourple':
				if (!ClientPrefs.ourplePlayed) spr.color = FlxColor.BLACK;
			case 'kyu':
				if (!ClientPrefs.kyuPlayed) spr.color = FlxColor.BLACK;
			case 'tc':
				if (!ClientPrefs.tacticalMishapPlayed) spr.color = FlxColor.BLACK;
			case 'marcx' | 'ai' | 'uzi':
				if (!ClientPrefs.breacherPlayed) spr.color = FlxColor.BLACK;
			case 'cross' | 'seer':
				if (!ClientPrefs.negotiationPlayed) spr.color = FlxColor.BLACK;
			case 'lily' | 'manager':
				if (!ClientPrefs.ccPlayed) spr.color = FlxColor.BLACK;
		}
	}

	private function updateCharPositions(smoothTransition:Bool = false):Void
	{
		var transitionDuration:Float = 0.2;
		var spacing:Int = 600;
        for (i in 0...charGroup.length)
		{
			var char = charGroup[i];
            var offset = i - curCharSelected;
            var targetX = CHAR_DEFAULT_X + offset * spacing;
            var targetScale = 1.0;
            var targetAlpha = 1.0;

			if (optionShit[curCharSelected].toLowerCase() == "dv" || optionShit[curCharSelected].toLowerCase() == "marcussy" || optionShit[curCharSelected].toLowerCase() == "debug")
				targetX -= 150;

			switch(offset)
			{
				case 0: // Centered Image
					targetScale = 1.0;
                	targetAlpha = 1.0;
				case 1 | -1: //Left / Right
					targetScale = Math.max(0.5, 1 - Math.abs(offset) * 0.2);
                	targetAlpha = Math.max(0.5, 1 - Math.abs(offset) * 0.3);
				default: // Offset
					targetScale = Math.max(0.25, 0.5 - Math.abs(offset) * 0.2);
                	targetAlpha = Math.max(0, 0.5 - Math.abs(offset) * 0.3);
			}

            if (smoothTransition)
                FlxTween.tween(char, {x: targetX, alpha: targetAlpha, "scale.x": targetScale, "scale.y": targetScale}, transitionDuration, {ease: FlxEase.circOut});
			else
			{
                char.x = targetX;
                char.alpha = targetAlpha;
                char.scale.set(targetScale, targetScale);
            }
        }
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
					switch(optionShit[curCharSelected].toLowerCase())
					{
						case 'marco':
							CoolUtil.browserLoad('https://docs.google.com/document/d/1C8gNNa3uo0NFByPt96AF2D7HdPNsXng4GcuzuNPnaOA/edit?usp=sharing');
						case 'aileen':
							CoolUtil.browserLoad('https://docs.google.com/document/d/19EtuvfK-s7Zc0bS0IeYCsvP3qgGli34bgRnMo-pvkL0/edit?usp=sharing');
						case 'beatrice':
							CoolUtil.browserLoad('https://docs.google.com/document/d/1zdtYnemJ1gRQT1QTce3QSYLv2IJrF8Nc-ePxJNBMM1E/edit?usp=sharing');
						case 'evelyn':
							CoolUtil.browserLoad('https://docs.google.com/document/d/1zdtYnemJ1gRQT1QTce3QSYLv2IJrF8Nc-ePxJNBMM1E/edit?usp=sharing');
						case "yaku":
						case 'kiana':

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
								fardTimer = new FlxTimer().start(2, function(tmr:FlxTimer)
								{
									fardsCounter = 0;
								});
							}
					}
				}
			}
		}
		else if (morkyFarded && !showedFard)
		{
			showedFard = true;
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.sound('fart'));
			var video:VideoSprite = new VideoSprite(Paths.video('morky farded'), false, false, false);
			add(video);
			video.play();
			video.finishCallback = function()
			{
				System.exit(0);				
			};
			new FlxTimer().start(1, function (tmr:FlxTimer) {
				System.exit(0);
			});
		}

		super.update(elapsed);
	}

	function showLore()
	{
		switch(optionShit[curCharSelected].toLowerCase())
		{
			case 'marco':
				if (ClientPrefs.marcoScroll)
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
				if (ClientPrefs.aileenScroll)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "Aileen was born in her old hometown Lampside.\nShe used to live with her Mother who was an\nEmployee in A.A.A.V (An Agency Against Villains),\nher Father who is a C-class Villain and\nher Twin Brother, Alverv.
					\n[Click <G>here<G> to view the full extension]";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'beatrice':
				if (ClientPrefs.beatriceScroll)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "Beatrice grew up in an orphanage.\nDespite never knowing who her parents were,\nshe wasn't bothered by it.
					\n[Click <G>here<G> to view the full extension]";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'evelyn':
				if (ClientPrefs.evelynScroll)
				{
					FlxTween.tween(blackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollAsset, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(scrollDesc, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
					scrollDesc.text = "EX-BR Model 3 or Evelyn is a prototype\nthat was created for a supposed\n“World Domination” by an Evil organization.
					\n[Click <G>here<G> to view the full extension]";
				}
				else
				{
					FlxG.sound.play(Paths.sound('accessDenied'));
					showingLore = false;
				}
			case 'yaku':
				if (ClientPrefs.yakuScroll)
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
				if (ClientPrefs.kianaScroll)
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
			case 'morky':
				if (ClientPrefs.morkyScroll)
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
		}
		CustomFontFormats.addMarkers(scrollDesc);
		trace('Showing Lore');
	}

	function changeItem(huh:Int = 0)
	{
		var lockAlpha:Bool = false;
		var currentColor:Int = curCharSelected;
		curCharSelected += huh;

		if (curCharSelected >= optionShit.length)
			curCharSelected = 0;
		if (curCharSelected < 0)
			curCharSelected = optionShit.length - 1;

		// Change Color for BG
		FlxTween.color(bg, 2, FlxColor.fromRGB(colors[currentColor][0], colors[currentColor][1], colors[currentColor][2]), FlxColor.fromRGB(colors[curCharSelected][0], colors[curCharSelected][1], colors[curCharSelected][2]), {ease: FlxEase.circOut, type: PERSIST});

		switch (optionShit[curCharSelected].toLowerCase())
		{
			// Main Cast
			case 'gf':
				titleText.text = "Trespasser GF";

				desc.text = "Full name: Gigi Dearest\nAliases: Gf, Fair Maiden, Ugly Boring Teenager, Chuckletits, Bitch\nAge: 19 - Species: Demon\nVA: StatureGuy (GIniquitous)
					\nA Lost, curious, but way smarter counterpart of the original girlfriend who just wants to get back to her Boyfriend (kinda).
					\n'That's how you do it!'";
				
				allowLore = false;
			case 'bf':
				titleText.text = "Boyfriend";

				desc.text = "Real Name: Balthazar Escobar Francisco the 3rd\nAliases: Lil Boyfriend, Ugly worm, cuckoo, Little dude, Little man\nAge: Old - Species: Dumbass
				\nA tiny arrogant little brat who thinks nothing more than to fuck his GF, yet he gets cucked all the time. 
				\n'Take that Daddy Dearest! Hiiiiiyaaaaaa!!!'";
					
				allowLore = false;
			case 'marco':
				titleText.text = "Marco";

				desc.text = "Full Name: Marco Isavilan\nReal name: Michael Pureheart\nAliases: Asshole, The Cheapskate, Sir, Isavilan\nAge: 30 - Species: Human - Height: 6'2\nVA: StatureGuy
				\nGreenville's Infamous Self proclaimed Best\nCheapskate Villain in the entire universe!\nHe brings terror on people on a budget.
				\n'AILEEN!!'";

				allowLore = true;
				if (ClientPrefs.marcoScroll)
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
				else
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
			case 'aileen':
				titleText.text = "Aileen";

				desc.text = "Full name: Aileen Polostar\nAliases: My Highest Assistant, AILEEN, Smokin Assistant\nAge: 24 - Species:Human - Height: 5'2\nVA: (New) Gentile | (Old) Riyu
				\nMarco's loyal assistant who fixes schedules and organizes her boss's daily routine of being an asshole. She sometimes gets more credit on being the most patient person on the world.					
				\n'Contrary to popular belief, I'm not smarter than my boss. I only use my brain more than his.'";

				allowLore = true;
				if (ClientPrefs.aileenScroll)
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
				else
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
			case 'beatrice':
				if (ClientPrefs.nunWeekPlayed)
				{
					titleText.text = "Beatrice";
					
					desc.text = "Full name: Beatrice Cygiamon\nAliases: Kind Hearted Nun, That Nun in the church\nAge: 21\nSpecies: Human\nHeight: 5'10\nVA: Riyu
					\nA Kind hearted nun of the Euroda Orphanage, who works 24/7 with full joy while putting all her trust to God.
					\n'Welcome to the Orphanage! My name is Sister Beatrice!'";
				}
				else
				{
					titleText.text = "?????";
					desc.text = "Unlock Week 2 First!";
				}
				allowLore = true;
				if (ClientPrefs.beatriceScroll)
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
				else
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
			case 'evelyn':
				if (ClientPrefs.nunWeekPlayed)
				{
					titleText.text = "Evelyn";

					desc.text = "Codename: EX-BR Model 3\nAge: ???\nSpecies: Cybernetic Organism\nHeight: 6'2
					\nAn A.I. created by an unknown company, who gained sentience and will to run away from it and live as an orphanage nun.
					\n'...'";
				}
				else
				{
					titleText.text = "?????";		
					desc.text = "Unlock Week 2 First!";
				}
				allowLore = true;
				if (ClientPrefs.evelynScroll)
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
				else
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
				case 'yaku':
				if (ClientPrefs.nunWeekPlayed)
				{
					titleText.text = "Yaku";

					desc.text = "Codename: Experiment no. 266 \nReal name: Yaku Feridot\nAliases: 266, Ghost, Bestie, Latina Magnet\nAge: 25\nSpecies: Highly Enhanced Human - Height: 7ft\nChromatic Voice: StatureGuy
					\nA human experiment created by an unknown company as the perfect killer human, who broke out of his employers' strings to live as a regular Janitor in an orphanage.
					\n'You're next.'";
				}
				else
				{
					titleText.text = "????";
					desc.text = "Unlock Week 2 First!";
				}
				allowLore = true;
				if (ClientPrefs.yakuScroll)
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
				else
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));		
			case 'kiana':
				if (ClientPrefs.kianaWeekPlayed)
				{
					titleText.text = "Kiana";
	
					desc.text = "Aliases: The First Dweller, Lust demon, Basilisk, Professional Nut Gargler\nAge: ???\nSpecies: Part Entity - Part Ancient Deity\nHeight: 4'11 (Seductive Form) - 43 ft (Real Form)\nVA: DevilDewDrop
					\nA Fluid thirsty 'Dweller'\nfrom The Unnamed Dimension.\nShe will use her seductive form\nto lure prey from other dimensions\nso she can feed on their desires and souls.\n'STUPID BITCH'";
				}
				else
				{
					titleText.text = "?????";
					desc.text = "Unlock Week 3 First!";
				}
				allowLore = true;
				if (ClientPrefs.kianaScroll)
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
				else
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
			case 'dv':
				if (ClientPrefs.kianaWeekPlayed)
				{
					titleText.text = "DV";

					desc.text = "Full Name: Dimitrov Vaughan\nSkin name: Fernanda\nAliases: Mad, The third Dweller, Shadow man, Skinwalker, Skin Stealer\nAge: 253\nHeight: 6ft (Fernanda) - 11 ft (Dv)\nSpecies: Entity\nChromatic Voice: StatureGuy
					\nA creature from the Abyss who works together with the other dwellers.It steals skin of his victims to wear as disguise in the human world.";
				}
				else
				{
					titleText.text = "??";
					desc.text = "Unlock Week 3 First!";
				}
				allowLore = false;
			case 'cgirl':
				if (ClientPrefs.kianaWeekPlayed)
				{
					titleText.text = "Busted C.C.";

					desc.text = "Based on: Cassete Girl\nAliases: CG, Kassetto, Kasetto \nAge:23 \nSpecies: Android
					\nA Busted-Up Cassette Clone based on Cassette Girl who is blind. The reasons she got here in the first place are unknown. 	
					\n'Coconut Ice Cream'";
				}
				else
				{
					titleText.text = "?????? ?.?.";
					desc.text = "Unlock Week 3 First!";
				}
				allowLore = false;
			case 'pico':
				if (ClientPrefs.kianaWeekPlayed)
				{
					titleText.text = "Pico";

					desc.text = "Aliases: Prick-o, Prico, Sexually Ambiguous Little Friend, Little doll\nAge: 20 - Species: Human\nVA: StatureGuy
					\nThe Contract Killer/Former School Shooter, who's in the quest of finding Girlfriend.
					\n'SHUT UP YOUR PINK ASS MOUTH'";
				}
				else
				{
					titleText.text = "????";						
					desc.text = "Unlock Week 3 First!";
				}
				allowLore = false;
			case 'narrin':
				if (ClientPrefs.kianaWeekPlayed)
				{
					titleText.text = "Narrin";

					desc.text = "Real Name: Nadia Baroque\nAliases: The Jester, 2nd Dweller, Clown, Pink-Ass, Toy Maker, The Puppeteer\nAge: 105 - Species: Humanoid Entity\nVA: D3MON1X_
					\nThe second dweller of the unnamed dimension, who loves to play with her victims before turning them into her slave puppets, who resemble and think like her. The victim is aware that this is happening real time.
					\n'WELL SO FAR, IM JUST A CHARACTER'";
				}
				else
				{
					titleText.text = "??????";	
					desc.text = "Unlock Week 3 First!";
				}
				allowLore = false;

				//Bonus Cast
			case 'marcussy':
				if (ClientPrefs.susWeekPlayed)
				{
					titleText.text = "Marcussy";
	
					desc.text = "Real Name: Marco Isavilan\nAliases: The Villain in Board\nSpecies: Among us Sussy Impostor 
					\nThe Custom Among us Character\nmade by Marco himself.\nThis is the first time\nhe became an impostor\nin the game and\nhe's having a good time.";
				}
				else
				{
					titleText.text = "?????";
					desc.text = "Unlock Week Sus First!";
				}	
				allowLore = false;
			case 'amogleen':
				if (ClientPrefs.susWeekPlayed)
				{
					titleText.text = "Amogleen";

					desc.text = "Real Name: Aileen Polostar\nSpecies: Among us Pet 
					\nCrewmate Sona of Aileen\ncustomized by Marco\nto put in the game with him\nas a pet crewmate.\n[Aileen is not aware that Marco did this]";
				}
				else
				{
					titleText.text = "?????";
					desc.text = "Unlock Week Sus First!";
				}
				allowLore = false;
			case 'morky':
				if (ClientPrefs.morkyWeekPlayed)
				{
					titleText.text = "Morky";

					desc.text = "Full Name: MORKY\nAge: NOT OLD!11!\nHeight:NOT SHORT!1!1\nVA: StatureGuy
					\nMORKY IS THE REAL MARCO!1!1\nMORKY IS THE REAL VILLAIN!1!1\nEVERYONE ELSE IS NOT REAL!11!\nCOME AND PLAY WITH ME!1!!1
					\n'I AM MORKY AND I AM A VILLAIN!'";
				}
				else
				{
					titleText.text = "?????";	
					desc.text = "Unlock the Joke Week First!";
				}
				allowLore = true;
				if (ClientPrefs.morkyScroll)
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButton'));
				else
					loreScrollButton.loadGraphic(Paths.image('characterInfo/loreButtonLocked'));
			case 'aizeen':
				if (ClientPrefs.dsideWeekPlayed)
				{	
					titleText.text = "Aizeen";

					desc.text = "Full Name: Aizeen Verieevel\nReal Name: Aileen H. Polostar - Age: Mid 20s\nVA: Wilda_Acid
							\nAn unhinged villain who is romantically and very sexually attracted to her assistant who is an open gay man.
							\n'MARCUS, I STILL LOVE YOU, PLEASE LOVE ME BACK'";
				}
				else
				{
					titleText.text = "?????";
					desc.text = "Unlock Week D-sides First!";	
				}
				allowLore = false;
			case 'marcus':
				if (ClientPrefs.dsideWeekPlayed)
				{	
					titleText.text = "Marcus";

					desc.text = "Full name: Marcus Heartpure\nAliases: Gay Assistant, Marcus! my sweet little Assistant, \nSpecies: Human - Height: 5'11\nChromatic Voice: StatureGuy
								\nA gay man who doesn't like his boss very much for 10 or 27 reasons.
								\n'Ma'am, I'm gay, shut up'";
				}
				else
				{
					titleText.text = "??????";
					desc.text = "Unlock Week D-sides First!";	
				}
				allowLore = false;
			case 'cgoon':
				if (ClientPrefs.dsideWeekPlayed)
				{
					titleText.text = "Cassette Goon";

					desc.text = "Aliases: D-Sides Cassette Goon\nAge: ???\nHeight:???\nSpecies: Android
					\nD-Sides Cassette Goon whose design is based on News Goon.\n[design of KaosKurve in Newgrounds!!]";
				}
				else
				{
					titleText.text = "???????? ????";
					desc.text = "Unlock Week D-sides First!";
				}
				allowLore = false;
				
			//Shop Cast
			case 'michael':
				if (ClientPrefs.marcochromePlayed)
				{
					titleText.text = "Michael";

					desc.text = "Full Name: Michael PureHeart\nAliases: CEO left hand Man, Smartest man in the Company, Young Chemist\nAge: 23 [before the incident]\nSpecies: Human - Height: 6ft\nChromatic Voice: StatureGuy
					\nA Young British Chemist who suffered a worse fate than death... or is it?
					\n'If I had a wife, I would love her so much. Too bad I don't have a wife'";
				}
			else
				{
					titleText.text = "?????";	
					desc.text = "Unlock Marcochrome First!";
				}
				allowLore = false;
			case 'nicflp':
				if (ClientPrefs.nicPlayed)
				{
					titleText.text = "Nic.FLP";
	
					desc.text = "Full name: Philippe Necrosis\nAge: Old\nAliases: Do not steal OC, Sonic\nSpecies: Hedge, Flp, A hog\nHeight: Small\nVA: StatureGuy
								\nTHERE IS NO ESCAPE VERSION 2029
								\n'I AM GOD probably idk, I'm kinda insecure'";
				}
				else
				{
					titleText.text = "?????";	
					desc.text = "Unlock Slow.FLP First!";
				}
				allowLore = false;
			case 'tail':
				if (ClientPrefs.nicPlayed)
				{
					titleText.text = "Tail.FLP";

					desc.text = "Real Name: Miles Tails Prower\nAge: Not Old\nVA: StatureGuy
					\nUnlike the other Tails's\nin most EXE stories,\nthis one didn't suffer a horrible fate...\nNevermind, this one dies too.
					\n'Sonic, pls don't kill me!'";
				}
				else
				{
					titleText.text = "?????";
					desc.text = "Unlock Slow.FLP First!";
				}
				allowLore = false;
			case 'fnv':
				if (ClientPrefs.fnvPlayed)
				{	
					titleText.text = "FNV";

					desc.text = "Real Name: Friday Night Villainy\nAliases: FNV\nAge: FNV\nSpecies: FNV\nHeight: FNV
					\nFNV
					\n'fnv'";
				}
				else
				{
					titleText.text = "???";	
					desc.text = "Unlock FNV First!";
				}
				allowLore = false;
			case 'lillie':
				if (ClientPrefs.rainyDazePlayed)
				{
					titleText.text = "Lillie";

					desc.text = "Real Name: Lillian Craig\nAge: 24\nAliases: SakuraKoto, Lillie, Sexually Attractive Transgender Woman\nSpecies: Human\nHeight: 6'2 ft
								\nAn Artist/Singer who likes to play Sims, Minecraft and Roblox. She likes Pico dangerously a lot (at least this variant)";
				}
				else
				{
					titleText.text = "??????";
					desc.text = "Unlock Rainy Daze First!";
				}
				allowLore = false;
			case 'porkchop':
				if (ClientPrefs.morkyWeekPlayed)
				{
					titleText.text = "Porkchop";

					desc.text = "Age:???\nHeight: Short\nSpecies: Lean Bunny
					\nA Purple Rabbit who wears a hat.
					\n(Character is owned by Porkchop on Discord!)";
				}
				else
				{
					titleText.text = "?????";
					desc.text = "Unlock Instrumentally Deranged First!";
				}
				allowLore = false;
			case 'dooglas':
				if (ClientPrefs.morkyWeekPlayed)
				{
					titleText.text = "Dooglas";

					desc.text = "Aliases: Simp\nAge: ???\nSpecies: bruh idk\nHeight: Small
					\nA very notorious simp who loves women.
					\n'Wer may wumen'
					\n(Character is owned by Porkchop on Discord!)";
				}
				else
				{
					titleText.text = "???????";	
					desc.text = "Unlock Instrumentally Deranged First!";
				}
				allowLore = false;
			case 'short':
				if (ClientPrefs.shortPlayed)
				{
					titleText.text = "Jerry";

					desc.text = "His name is Jerry.\n
					\n
					\n
					\n
					\nHe appeared in Jerry.";
				}
				else
				{
					titleText.text = "???????";	
					desc.text = "Unlock 0.0015 First!";
				}
				allowLore = false;
			case 'fangirl':
				if (ClientPrefs.infatuationPlayed)
				{
					titleText.text = "Lefty";

					desc.text = "Real Name: Layla Linder\nAge: 34\nAlias: Lefty (Her other personality's name) Villain stalker, The Collector\nSpecies: Human 
					\nLayla Linder was once a smart engineer, but ever since the incident that gave her a very unstable split personality, she is struggling to take back the wheel that is once hers .
					\n'Lefty don't like when Layla gets hurt!'";
				}
				else
				{
					titleText.text = "???????";	
					desc.text = "Unlock Fanfuck Forever First!";
				}
				allowLore = false;
			case 'debug':
				if (ClientPrefs.debugPlayed)
				{
					titleText.text = "Debug guy";

					desc.text = "Real Name: Roku Dorubo\nAge: 64 (Human Body) | 34 (as a Virus) | 98 (in total)\nAliases: Debug Guy, Anti-Anti-Virus, Virus-san, Debug-san, Roro, Soulless One\nSpecies: Polygurian (Formerly) | Virus\nHeight: 9'4 (Polygurian) | Various (Virus)\nChromatic Voice: StatureGuy
								\nA Polygurian that turned himself into a virus to immortalise his consciousness. He likes to hijack indie games and party 24/7.
								\n'Looks like Our broadcast has ended'";
				}
				else
				{
					titleText.text = "?????";	
					desc.text = "Unlock Marauder First!";
				}
				allowLore = false;
			case 'asul':
				if (ClientPrefs.itsameDsidesUnlocked)
				{	
					titleText.text = "Asul";

					desc.text = "Real Name: Kiana\nAliases: Favorite Sister, Fatty, Chubs, Blue, Tails, Bon-Bon, Shy \nAge: ???\nSpecies: Part Entity Creature | Part Ancient Deity \nHeight: 4'11 (Default Form) | 353 Ft (Eldritch form)
								\nDraco Kiana's Shy but kind counterpart who loves Reading books and Dislikes Thunder.
								\n'I have the ability to wipe out all of humanity, but I won't, because that's not very nice..'";
				}
				else
				{
					titleText.text = "???????";
					desc.text = "Unlock Fanfuck Forever First!";
				}
				allowLore = false;
				
			//Crossover Cast
			case 'ourple':
				if (ClientPrefs.ourplePlayed)
				{	
					titleText.text = "Ourple";

					desc.text = "Real Name: William Afton\nAge: Super Old\nAliases: Springtrap, Scraptrap, Dave Miller, Steve Raglan, Williamus Aftus
								\nA funny restaurant founder who has an average Kill to Death Ratio.
								\n'I always cum back.'";
				}
				else
				{
					titleText.text = "??????";
					desc.text = "Unlock Vguy First!";	
				}
				allowLore = false;
			case 'kyu':
				if (ClientPrefs.kyuPlayed)
				{	
					titleText.text = "Kyu";

					desc.text = "Full name: Kyu Faraday\nAge: 19 (From her Mod) | 27 (FNV)\nAliases: ???\nSpecies: Human \nHeight 5'9 | 5'11 (FNV Heels)
								\nA White Blonde woman with abs that can grind meat or fry eggs. She has these Powers too i guess.
								\n'Prepare yourself! This'll prolly sound bad, But I'll go with the flow.'";
				}
				else
				{
					titleText.text = "???";	
					desc.text = "Unlock Fast Food Therapy First!";	
				}
				allowLore = false;
			case 'tc':
				if (ClientPrefs.tacticalMishapPlayed)
				{
					titleText.text = "TC";

					desc.text = "Real Name: Tactical Cupcakes\nAge: in her 20s\nAliases: Bestie, Greatest in (Insert Game here), TC, Tac, Tounge Champion, Bitch, Muted Les-Biatch, Mutey\nSpecies: Human \nHeight: 5'10
								\nA British Girl who loves hanging out with her friends and playing her own content.
								\n'That Marco guy is Discord incarnate, you know what's in discord, my Server link is inthedescriptionbytheway'";
				}
				else
				{
					titleText.text = "??";
					desc.text = "Unlock Tactical Mishap First!";	
				}
				allowLore = false;
			case 'marcx':
				if (ClientPrefs.breacherPlayed)
				{
					titleText.text = "Marcx";

					desc.text = "Full Name: Marx Abigasshole\nAge: 40 \nAliases: Villanous Worker drone, Sir, Profanity Machine, Mr.'No one is ever calling you that'\nSpecies: Worker drone - Height: 3ft\nChromatic Voice: StatureGuy
								\nThe very first worker drone that is powered by radioactive human piss
								\n'Would be funny if there was a human counter of myself'";
				}
				else
				{
					titleText.text = "?????";	
					desc.text = "Unlock Breacher First!";	
				}
				allowLore = false;
			case 'ai':
				if (ClientPrefs.breacherPlayed)
				{	
					titleText.text = "A.I.";

					desc.text = "Full name: AI Pollutantstar\nAliases: Marx's Murder drone, Aileen, Bitch, Piss power psychopath\nAge: ??\nSpecies: Disassembly Drone\nHeight: 7'4 ft 
								\nThe first ever Murder Drone that is powered by radioactive human piss 
								\n'It's 'A-I' as in 'Ey-Aye' not Aileen, sir.'";
				}
				else
				{
					titleText.text = "?.?.";
					desc.text = "Unlock Breacher First!";	
				}
				allowLore = false;
			case 'uzi':
				if (ClientPrefs.breacherPlayed)
				{	
					titleText.text = "Uzi";

					desc.text = "Full name: Uzi Doorman\nAge: around 18-20 (Theoretically)\nAliases: Barely Sentient Toaster, darkXWolf17, 002, Dapper Buddy \nSpecies: Worker Drone\nHeight: 4'2 ft
							\nA Rebellious Worker Drone that got weird UnGodly powers after Puberty.
							\n'THERE HAS TO BE A SEASON 2 PLEASE'";
				}
				else
				{
					titleText.text = "???";
					desc.text = "Unlock Breacher First!";	
				}
				allowLore = false;
			case 'cross':
				if (ClientPrefs.negotiationPlayed)
				{	
					titleText.text = "Cross";

					desc.text = "Age: Unknown\nAlias: Bob, Boss\nSpecies: Demon
					\nI went to you thinking that you can help getting my assistant back from that squidward looking BITCH!\nAll you did is talked about money which I genuinely listen!\nCan't wait to make our first investment!!
					\n'The lord is my shepherd, I lack nothing. He makes me lie DOWN in pastures, he leads me beside white waters he refreshes my soul.'";
				}
				else
				{
					titleText.text = "?????";
					desc.text = "Unlock Negotiation First!";	
				}
				allowLore = false;
			case 'seer':
				if (ClientPrefs.negotiationPlayed)
				{	
					titleText.text = "Seer";

					desc.text = "Age: Unknown\nSpecies: Android
					\nI saw your hand with 5 kings- Fucking 5 kings???\nI already have 2 in my hands!! There's only 4 in one deck!!!!\nThat's why I'm so confident to bet my own assistant!!!\nWHERE THE FUCK DID THE OTHER KINGS COME FROM??\nAll i want is your Goddamn mini fridge and you still pull an illegal move on ME!!
					\n'IT WAS A TELEVISION'";
				}
				else
				{
					titleText.text = "?????";
					desc.text = "Unlock Negotiation First!";	
				}
				allowLore = false;
			case 'lily':
				if (ClientPrefs.ccPlayed)
				{
					titleText.text = "Lily";

					desc.text = "Full name: Lily Engraved\nAge: 20s\nAliases: Lily In Grave, Lily-Chan\nSpecies: Human (FNV and Formerly on her mod) | Zombie 
							\nA Popstar that loved starring and popping on the stage till she received a hammer time right on her noggin.
							\n'Are you ready?'";
				}
				else
				{
					titleText.text = "????";
					desc.text = "Unlock Concert Chaos First!";	
				}
				allowLore = false;
			case 'manager':
				if (ClientPrefs.ccPlayed)
				{	
					titleText.text = "Manager";

					desc.text = "Full name: Bruna Brunette\nAge: Between 20 or 30 - Aliases: Manager-Chan - Species: Human\nDear Bruna Brunette,\nFrom the moment I met you, I was captivated by your uniqueness and charm. Your auburn hair pulled back into a ponytail frames your face perfectly, highlighting your natural beauty and grace.\nAnd your glasses? They’re not just an accessory; they reveal the depth of your intelligence and the warmth of your spirit. Managing a popstar is no easy feat, but you handle it with such skill and pose. Your ability to balance the demands of such a high-profile job while remaining kind and compassionate is truly inspiring. I also deeply admire your courage in sharing your struggles with anxiety. Your openness and resilience only make me appreciate you more. You bring so much light and joy into the lives of those around you. I am incredibly grateful to be part of your world and look forward to all the moments we’ll share together.\nThank you for being such a wonderful person, Bruna. You are a true treasure.
								\nWith all my love, Kinn.";
				}
				else
				{
					titleText.text = "???????";
					desc.text = "Unlock Concert Chaos First!";	
				}
				allowLore = false;
		}

		updateCharPositions(true);
	}
}
