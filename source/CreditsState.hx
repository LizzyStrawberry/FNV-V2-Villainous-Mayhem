package;

import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;
import lime.utils.Assets;


class CreditsState extends MusicBeatState
{
	var curSelected:Int = 0;
	var curSelectedFormer:Int = -1;
	var creditsSelected:String = 'CURRENT';

	private var creditsStuff:Array<Array<String>> = [];
	private var formerCreditsStuff:Array<Array<String>> = [];
	// FNV DEVS CREDITS
	var bg:FlxSprite;
	var creditSprite:FlxSprite;
	var BGchecker:FlxBackdrop;
	var icon:FlxSprite;
	var titleText:Alphabet;
	var tipUp:FlxText;
	var tipDown:FlxText;

	var descBox:AttachedSprite;
	var descText:FlxText;

	var descBoxQuote:AttachedSprite;
	var descTextQuote:FlxText;
	var getIconY:Float = 0;

	var intendedColor:Int;
	var colorTween:FlxTween;

	// TRANSITIONS
	var arrowSelectorLeft:FlxSprite;
	var arrowSelectorRight:FlxSprite;
	var getarrowSelectorLeftX:Float = 0;
	var getarrowSelectorRightX:Float = 0;

	// FORMER MEMBER CREDITS
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	var descBoxFormer:AttachedSprite;
	var descTextFormer:FlxText;
	var offsetThing:Float = -75;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Viewing Credits", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);
		bg.screenCenter();

		BGchecker = new FlxBackdrop(Paths.image('promotion/BGgrid-' + FlxG.random.int(1, 8)), FlxAxes.XY, 0, 0); 
		BGchecker.updateHitbox(); 
		BGchecker.scrollFactor.set(0, 0); 
		BGchecker.alpha = 0; 
		BGchecker.screenCenter(X); 
		add(BGchecker);

		FlxTween.tween(BGchecker, {alpha: 1}, 2.2, {ease: FlxEase.cubeInOut, type: PERSIST});

		var creditsTitle:Alphabet = new Alphabet(75, 60, "Credits", true);
		creditsTitle.scaleX = 0.6;
		creditsTitle.scaleY = 0.6;
		creditsTitle.alpha = 0.4;
		add(creditsTitle);

		var textBGUp:FlxSprite = new FlxSprite(0, FlxG.height - 726).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBGUp.alpha = 0.6;
		add(textBGUp);

		tipUp = new FlxText(textBGUp.x + 1200, textBGUp.y + 8, FlxG.width + 2200, "Friday Night Villainy Developer Team | Fat Villain Studios | Friday Night Villainy Developer Team | Fat Villain Studios | Friday Night Villainy Developer Team | Fat Villain Studios | Friday Night Villainy Developer Team | Fat Villain Studios", 24);
		tipUp.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);
		tipUp.scrollFactor.set();
		add(tipUp);

		var textBGDown:FlxSprite= new FlxSprite(0, FlxG.height - 38).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBGDown.alpha = 0.6;
		add(textBGDown);

        tipDown = new FlxText(textBGDown.x + 1200, textBGDown.y + 8, FlxG.width + 1600, "SWIPE: Change Developer | B: Go back to the Main Menu | Tap on DEV Icon to go to DEV's Social Media Page | LEFT / RIGHT ARROWS: Change Credits Category | C: Go to Special Credits", 24);
		tipDown.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);
		tipDown.scrollFactor.set();
		add(tipDown);

		FlxTween.tween(tipUp, {x: textBGUp.x - 4000}, 27, {ease: FlxEase.linear, type: LOOPING});
		FlxTween.tween(tipDown, {x: textBGDown.x - 4000}, 27, {ease: FlxEase.linear, type: LOOPING});

		creditsStuff = [ //Name - Icon name - Description - Quote - Link
			['StatureGuy',	'statureguy', '<G>Roles:<G>\n- Owner of FNV\n- Director\n- Artist (All Assets + Cutscenes)\n- Main Voice Actor', "'I love Aileen'", 'https://www.youtube.com/channel/UCZ6Dkr6tseJJacSSjTd9OgQ', '00FBFF'],
			['Lizzy Strawberry', 'strawberry', '<G>Roles:<G>\n- Main Coder\n- Main Sprite Animator\n- Song Coverer\n- Charter\n- Chromatic Scaler', "'<G>FNV<G> is the best mod ever, I'm not biased I swear,,'", 'https://www.youtube.com/c/LizzyStrawberry', 'f760eb'],
			['Lillie', 'lillie', '<G>Roles:<G>\n- Additional Coder\n- Sprite Animator\n- Core Musician\n- Chromatic Creator\n- Charter ', "'<P>Oh? Did I<P> <G>Win<G>?'", 'https://www.youtube.com/@lilliancraig4690', 'fe8ca1'],
			['TheRealOscamon', 'oscamon', '<G>Roles:<G>\n- Core Musician (Bangin fr)\n- Sprite Animator ', "'I am <GR>Oscamon<GR>..\nyes this is my quote'", 'https://www.youtube.com/channel/UC3kTxyzWnFopnfzLjD2jMuA', '18f55b'],
			['HQC', 'hqc', '<G>Roles:<G>\n- Core Musician\n(Banger Music ong)', "'<C_>Kevin<C_>'", 'https://x.com/hqcs_', '6bebfb'],
			['D3MON1X_', 'd3mon1x', '<G>Roles:<G>\n- Core Musician\n(Even more Banger Music fr)\n- Asul\'s Voice Actor', "'<R>Yaku<R> step on me plea-'", 'https://x.com/D3MON1X_', '843277'],
			['Ricey', 'ricey', '<G>Roles:<G>\n- Former Core Musician\n(Banger Music once again)\n- Chromatic Creator ', "'uhm <R>i eat people for breakfast<R>'", 'https://twitter.com/hmhuhmh_r1', 'a548a3'],
			['Shiloh', 'lanternAura', '<G>Roles:<G>\n- Core Musician\n(Coming in clutch fr)\n Chromatic Creator ', "'im <G>me<G>. me <G>be<G>. goddamn. <G>i am<G>'", 'https://lanternaura.carrd.co/', 'fc8901'],
			['Araz', 'araz', '<G>Roles:<G>\n- Core Pause Menu Musician\n- Musician (Helped in Toxic Mishap (Legacy))', "'I forgot <G>how to music<G>'", 'https://www.youtube.com/channel/UCFefL4ngJkpsYFcBWlDC4RQ', 'FFF300'],
			['Kitty', 'kitty', "<G>Roles:<G>\n- Narrin's Voice Actor", "<G>“Who the fuck is that”<G>\n— @K1ttyC0s3tt3", 'https://twitter.com/K1tty_C0s3tt3', 'f3327f'],
			['AJTheFunky', 'aj', '<G>Roles:<G>\n- Main Charter\n- Made Hidden Menu Music Cover', "'Subscribe to <GR>AjTheFunky<GR> on <R>YouTube<R> :3'", 'https://ajthefunky.carrd.co/', '57ce78']
		];

		creditSprite = new FlxSprite(MobileUtil.fixX(-80)).loadGraphic(Paths.image('credits/FNVDevs/credits-' + creditsStuff[curSelected][1]));
		creditSprite.scrollFactor.set(0, 0);
		creditSprite.updateHitbox();
		creditSprite.screenCenter();
		creditSprite.x = MobileUtil.fixX(creditSprite.x);
		creditSprite.antialiasing = ClientPrefs.globalAntialiasing;
		add(creditSprite);

		titleText = new Alphabet(MobileUtil.fixX(640), 90, "This is a test", true);
		titleText.setAlignmentFromString('center');
		titleText.scaleX = 0.7;
		titleText.scaleY = 0.7;
		add(titleText);

		icon = new FlxSprite(MobileUtil.fixX(-80)).loadGraphic(Paths.image('credits/FNVDevIcons/' + creditsStuff[curSelected][1]));
		icon.screenCenter();
		icon.y += 270;
		icon.alpha = 0.7;
		add(icon);
		getIconY = icon.y;

		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(MobileUtil.fixX(50), 320, 380, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2;
		descBox.sprTracker = descText;
		add(descText);

		descBoxQuote = new AttachedSprite();
		descBoxQuote.makeGraphic(1, 1, FlxColor.BLACK);
		descBoxQuote.xAdd = -10;
		descBoxQuote.yAdd = -10;
		descBoxQuote.alphaMult = 0.6;
		descBoxQuote.alpha = 0.6;
		add(descBoxQuote);

		descTextQuote = new FlxText(MobileUtil.fixX(850), 320, 380, "", 32);
		descTextQuote.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descTextQuote.scrollFactor.set();
		descTextQuote.borderSize = 2;
		descBoxQuote.sprTracker = descTextQuote;
		add(descTextQuote);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;

		CustomFontFormats.addMarkers(descText);
		CustomFontFormats.addMarkers(descTextQuote);

		arrowSelectorLeft = new FlxSprite(MobileUtil.fixX(-20), 230).loadGraphic(Paths.image('freeplayStuff/arrowSelectorLeft'));
		arrowSelectorLeft.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorLeft.scale.set(0.5, 0.5);
		add(arrowSelectorLeft);

		arrowSelectorRight = new FlxSprite(MobileUtil.fixX(1160), 230).loadGraphic(Paths.image('freeplayStuff/arrowSelectorRight'));
		arrowSelectorRight.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorRight.scale.set(0.5, 0.5);
		add(arrowSelectorRight);

		getarrowSelectorRightX = arrowSelectorRight.x;
		getarrowSelectorLeftX = arrowSelectorLeft.x;

		// Former Section
		formerCreditsStuff = [ //Name - Icon name - Description - Link - BG Color
			['Former Developers'],
			['Person Man',		'pman',		'Former Programmer (Le Funny Man)',								'https://www.youtube.com/channel/UCkvnsbNpey7uA8tG2dTDT9Q',	'A0A0A0'],
			['JCD',			'jc',			"Former Sprite Animator (Old Marco + GF Sprites) \nI own Friday Night Huntin': Dimension Hunters BTW!",							'https://www.youtube.com/c/JCDelirious',		'FF362D'],
			['Slash',				'slash',			"Former Chromatic Creator (Marco's Chromatic Scaler)",						'https://www.youtube.com/channel/UCpO66kLXQVIMS93aZ2lvZKA',			'3ED343'],
			['Mayo Guy',			'mayoGuy',			'Former Charter',	'https://twitter.com/The_Mayo_Guy',			'929292'],
			['Zuyu', 'zuyu', 'Former Charter / Musician', 'https://www.youtube.com/channel/UCPPZrEArPKQorpw7jrvOesw', '00FFFF'],
			['Pixl', 'pixl', 'Former Charter', 'https://overpixel.carrd.co/', 'be43c0'],
			['Rev', 'rev', 'Former Charter', 'https://revsstuffidk.carrd.co/', '5a7bff']
		];

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...formerCreditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(FlxG.width / 3, 250, formerCreditsStuff[i][0], !isSelectable);
			optionText.isMenuItem = true;
			optionText.targetY = i;
			optionText.x += 1500;
			optionText.changeX = false;
			optionText.snapToPosition();
			grpOptions.add(optionText);
	
			if(isSelectable) {
				var icon:AttachedSprite = new AttachedSprite('credits/formerMembers/' + formerCreditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
		
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);

				if(curSelectedFormer == -1) curSelectedFormer = i;
			}
			else {optionText.alignment = CENTERED; optionText.x += 230;}
		}

		descBoxFormer = new AttachedSprite();
		descBoxFormer.makeGraphic(1, 1, FlxColor.BLACK);
		descBoxFormer.xAdd = -10;
		descBoxFormer.yAdd = -10;
		descBoxFormer.alphaMult = 0.6;
		descBoxFormer.alpha = 0.6;
		add(descBoxFormer);

		descTextFormer = new FlxText(MobileUtil.fixX(50), FlxG.height + offsetThing - 25, 1180, "", 32);
		descTextFormer.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descTextFormer.scrollFactor.set();
		descTextFormer.x += 1500;
		//descText.borderSize = 2.4;
		descBoxFormer.sprTracker = descTextFormer;
		add(descTextFormer);
		descTextFormer.text = formerCreditsStuff[curSelectedFormer][2];

		var scrollMain = new ScrollableObject(-0.004, 50, 100, FlxG.width, FlxG.height, "X");
		scrollMain.onFullScroll.add(delta -> {
			if (creditsSelected == 'CURRENT')
				changeCredits(delta, true, true, true);
		});
		add(scrollMain);
		var scrollFormer = new ScrollableObject(-0.004, 50, 100, FlxG.width, FlxG.height, "Y");
		scrollFormer.onFullScroll.add(delta -> {
			if (creditsSelected == 'FORMER')
				changeCredits(delta, true, true, true);
		});
		add(scrollFormer);

		changeCredits(0, false, false, false);
		fixFormerCredits();
		super.create();

		addTouchPad("NONE", "B_C");
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	var transitioning:Bool = false;
	override function update(elapsed:Float)
	{
		BGchecker.x += 0.5*(elapsed/(1/120));
        BGchecker.y += 0.36 / (ClientPrefs.framerate / 60); 

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if (TouchUtil.overlaps(arrowSelectorLeft))
				FlxTween.tween(arrowSelectorLeft, {x: getarrowSelectorLeftX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			else
				FlxTween.tween(arrowSelectorLeft, {x: getarrowSelectorLeftX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

			if (TouchUtil.overlaps(arrowSelectorRight))
				FlxTween.tween(arrowSelectorRight, {x: getarrowSelectorRightX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			else
				FlxTween.tween(arrowSelectorRight, {x: getarrowSelectorRightX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

			if (FlxG.keys.pressed.TAB || touchPad.buttonC.justPressed)
				MusicBeatState.switchState(new LegacyCreditsState());	

			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState(), 'stickers');
				quitting = true;
			}

			if (creditsSelected == 'CURRENT')
			{
				if(controls.UI_LEFT_P)
					changeCredits(-1, true, true);
				if(controls.UI_RIGHT_P)
					changeCredits(1, true, true);

				if (TouchUtil.overlaps(icon))
				{
					FlxTween.tween(icon, {y: getIconY - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(icon, {alpha: 1}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				} 
				else
				{
					FlxTween.tween(icon, {y: getIconY}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(icon, {alpha: 0.7}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				}
				if (TouchUtil.pressAction(icon) || controls.ACCEPT)
					CoolUtil.browserLoad(creditsStuff[curSelected][4]);
			}
			else if (creditsSelected == 'FORMER')
			{
				if(controls.UI_UP_P)
					changeCredits(-1, true, true);
				if(controls.UI_DOWN_P)
					changeCredits(1, true, true);

				if (controls.ACCEPT || TouchUtil.pressAction(grpOptions.members[curSelectedFormer]))
					CoolUtil.browserLoad(formerCreditsStuff[curSelectedFormer][3]);
			}

			if (!transitioning)
			{
				if (TouchUtil.pressAction(arrowSelectorLeft))
				{
					if (creditsSelected == 'CURRENT')
						changeCreditsCategory('FORMER');
					else
						changeCreditsCategory('CURRENT');
					transitioning = true;
				}
		
				if (TouchUtil.pressAction(arrowSelectorRight))
				{
					if (creditsSelected == 'CURRENT')
						changeCreditsCategory('FORMER');
					else
						changeCreditsCategory('CURRENT');
					transitioning = true;
				}
			}
			
		}
		
		super.update(elapsed);
	}

	function changeCreditsCategory(category:String, ?allowHaptics:Bool = true)
	{
		if (ClientPrefs.haptics && allowHaptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		creditsSelected = category;
		FlxG.sound.play(Paths.sound('scrollMenu'));
		switch(creditsSelected)
		{
			case 'CURRENT':
				trace('Current Category!');
				for (item in grpOptions.members)
				{
					FlxTween.tween(item, {x: item.x + 1500}, 1.5, {ease: FlxEase.cubeInOut, type: PERSIST});
				}
				FlxTween.tween(descTextFormer, {x: descTextFormer.x + 1500}, 1.5, {ease: FlxEase.cubeInOut, type: PERSIST});
				new FlxTimer().start(1.5, function(tmr:FlxTimer)
				{
					FlxTween.tween(titleText, {x: titleText.x + 1500}, 1, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(icon, {x: icon.x + 1500}, 1, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(descText, {x: descText.x + 1500}, 1, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(descTextQuote, {x: descTextQuote.x + 1500}, 1, {ease: FlxEase.cubeInOut, type: PERSIST});
					FlxTween.tween(creditSprite, {x: creditSprite.x + 1500}, 1, {ease: FlxEase.cubeInOut, type: PERSIST, onComplete: function(twn:FlxTween)
						{
							transitioning = false;
							changeCredits(0, false, false);
						}
					});
				});
			case 'FORMER':
				trace('Former Category!');
				FlxTween.tween(titleText, {x: titleText.x - 1500}, 1.5, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(icon, {x: icon.x - 1500}, 1.5, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(descText, {x: descText.x - 1500}, 1.5, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(descTextQuote, {x: descTextQuote.x - 1500}, 1.5, {ease: FlxEase.cubeInOut, type: PERSIST});
				FlxTween.tween(creditSprite, {x: creditSprite.x - 1500}, 1.5, {ease: FlxEase.cubeInOut, type: PERSIST, onComplete: function(twn:FlxTween)
					{
						for (item in grpOptions.members)
						{
							FlxTween.tween(item, {x: item.x - 1500}, 1, {ease: FlxEase.cubeInOut, type: PERSIST});
						}
						FlxTween.tween(descTextFormer, {x: descTextFormer.x - 1500}, 1, {ease: FlxEase.cubeInOut, type: PERSIST});
						new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							transitioning = false;
							changeCredits(0, false, false);
						});
					}
				});	
		}
	}

	var moveTween:FlxTween = null;
	var moveTweenQuote:FlxTween = null;
	function changeCredits(change:Int = 0, playSound:Bool = true, tween:Bool = true, ?allowHaptics:Bool = true)
	{
		if (ClientPrefs.haptics && allowHaptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		if (playSound)	FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if (creditsSelected == 'CURRENT')
		{
			tipDown.text = "SWIPE: Change Developer | B: Go back to the Main Menu | Tap on DEV Icon to go to DEV's Social Media Page | LEFT / RIGHT ARROWS: Change Credits Category | C: Go to Special Credits";
			curSelected += change;

			if (curSelected < 0)
				curSelected = 11;
			if (curSelected > 11)
				curSelected = 0;
	
			creditSprite.loadGraphic(Paths.image('credits/FNVDevs/credits-' + creditsStuff[curSelected][1]));
			if (curSelected == 4)
				creditSprite.scale.set(1.2, 1.2);
			else
				creditSprite.scale.set(1, 1);

			if (curSelected == 11)
				creditSprite.x = MobileUtil.fixX(358.5);
			else
				creditSprite.x = MobileUtil.fixX(383.5);
	
			icon.loadGraphic(Paths.image('credits/FNVDevIcons/' + creditsStuff[curSelected][1]));
	
			titleText.text = creditsStuff[curSelected][0];
	
			descText.text = creditsStuff[curSelected][2];
			descTextQuote.text = creditsStuff[curSelected][3];

			if (tween)
			{
				descText.y = 300;
				if(moveTween != null) moveTween.cancel();
				moveTween = FlxTween.tween(descText, {y : descText.y + 20}, 0.25, {ease: FlxEase.sineOut});
				descBox.setGraphicSize(Std.int(descText.width + 25), Std.int(descText.height + 20));
				descBox.updateHitbox();
		
				descTextQuote.y = 300;
				if(moveTweenQuote != null) moveTweenQuote.cancel();
				moveTweenQuote = FlxTween.tween(descTextQuote, {y : descTextQuote.y + 20}, 0.25, {ease: FlxEase.sineOut});
				descBoxQuote.setGraphicSize(Std.int(descTextQuote.width + 25), Std.int(descTextQuote.height + 20));
				descBoxQuote.updateHitbox();
			}
	
			CustomFontFormats.addMarkers(descText);
			CustomFontFormats.addMarkers(descTextQuote);
		}
		else if (creditsSelected == 'FORMER')
		{
			tipDown.text = "SWIPE: Change Credit | B: Go back to the Main Menu | Tap on DEV's name to go to DEV's Social Media Page | LEFT / RIGHT ARROWS: Change Credits Category | C: Go to Special Credits";
		
			curSelectedFormer += change;
			if (curSelectedFormer < 1)
				curSelectedFormer = 7;
			if (curSelectedFormer > 7)
				curSelectedFormer = 1;

			var bullShit:Int = 0;
			for (item in grpOptions.members)
			{
				item.targetY = bullShit - curSelectedFormer;
				bullShit++;

				if(!unselectableCheck(bullShit-1)) {
					if (Math.abs(item.targetY) == 1)
					{
						FlxTween.tween(item, {alpha: 0.5}, 0.5, {ease: FlxEase.sineOut});
						FlxTween.tween(item.scale, {x: 0.8, y: 0.8}, 0.5, {ease: FlxEase.sineOut});
					}
					if (Math.abs(item.targetY) >= 2)
					{
						FlxTween.tween(item, {alpha: 0}, 0.5, {ease: FlxEase.sineOut});
						FlxTween.tween(item.scale, {x: 0.6, y: 0.6}, 0.5, {ease: FlxEase.sineOut});
					}
					if (item.targetY == 0)
					{
						FlxTween.tween(item, {alpha: 1}, 0.5, {ease: FlxEase.sineOut});
						FlxTween.tween(item.scale, {x: 1, y: 1}, 0.5, {ease: FlxEase.sineOut});
					}
				}
			}

			descTextFormer.text = formerCreditsStuff[curSelectedFormer][2];

			if (tween)
			{
				descTextFormer.y = descTextFormer.y - 20;
				if(moveTween != null) moveTween.cancel();
				moveTween = FlxTween.tween(descTextFormer, {y : descTextFormer.y + 20}, 0.25, {ease: FlxEase.sineOut});
				descBoxFormer.setGraphicSize(Std.int(descTextFormer.width + 25), Std.int(descTextFormer.height + 20));
				descBoxFormer.updateHitbox();
			}
		}

		var newColor:Int = getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}
	}

	function getCurrentBGColor() {
		var bgColor:String;
		if (creditsSelected == 'FORMER')
			bgColor = formerCreditsStuff[curSelectedFormer][4];
		else
			bgColor = creditsStuff[curSelected][5];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return formerCreditsStuff[num].length <= 1;
	}

	var moveTween1:FlxTween = null;
	var moveTween2:FlxTween = null;
	var moveTween3:FlxTween = null;
	var moveTweenScale1:FlxTween = null;
	var moveTweenScale2:FlxTween = null;
	var moveTweenScale3:FlxTween = null;
	function fixFormerCredits(change:Int = 0)
		{
			curSelectedFormer += change;
			if (curSelectedFormer < 1)
				curSelectedFormer = 8;
			if (curSelectedFormer > 8)
				curSelectedFormer = 1;
	
			var bullShit:Int = 0;
			for (item in grpOptions.members)
			{
				item.targetY = bullShit - curSelectedFormer;
				bullShit++;

				if(!unselectableCheck(bullShit-1)) {
					if (Math.abs(item.targetY) == 1)
					{
						if(moveTween2 != null) moveTween2.cancel();
						if(moveTweenScale2 != null) moveTweenScale2.cancel();
						moveTween2 = FlxTween.tween(item, {alpha: 0.5}, 0.5, {ease: FlxEase.sineOut});
						moveTweenScale2 = FlxTween.tween(item.scale, {x: 0.8, y: 0.8}, 0.5, {ease: FlxEase.sineOut});
					}
					if (Math.abs(item.targetY) >= 2)
					{
						if(moveTween3 != null) moveTween3.cancel();
						if(moveTweenScale3 != null) moveTweenScale3.cancel();
						moveTween3 = FlxTween.tween(item, {alpha: 0}, 0.5, {ease: FlxEase.sineOut});
						moveTweenScale3 = FlxTween.tween(item.scale, {x: 0.6, y: 0.6}, 0.5, {ease: FlxEase.sineOut});
					}
					if (item.targetY == 0)
					{
						if(moveTween1 != null) moveTween1.cancel();
						if(moveTweenScale1 != null) moveTweenScale1.cancel();
						moveTween1 = FlxTween.tween(item, {alpha: 1}, 0.5, {ease: FlxEase.sineOut});
						moveTweenScale1 = FlxTween.tween(item.scale, {x: 1, y: 1}, 0.5, {ease: FlxEase.sineOut});
					}
				}
			}
	
			descTextFormer.text = formerCreditsStuff[curSelectedFormer][2];
		}
}