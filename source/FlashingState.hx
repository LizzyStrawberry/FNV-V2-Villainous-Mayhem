package;

import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxBackdrop;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;
	public static var curOption:Int = 0;

	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
	var warnText:FlxText;

	var settingsText:FlxText;
	var optionTextDesc:FlxText;

	var options:FlxTypedGroup<FlxText>;

	var backdrop:FlxBackdrop;

	override function create()
	{
		super.create();
	
		bg.setGraphicSize(Std.int(FlxG.width * 1.25));
		bg.alpha = 0;
		FlxTween.tween(bg, {alpha: 0.4}, 3);
		add(bg);

		backdrop = new FlxBackdrop(Paths.image('promotion/BGgrid-' + FlxG.random.int(1, 8)), FlxAxes.XY, 0, 0); 
		backdrop.updateHitbox(); 
		backdrop.scrollFactor.set(0, 0); 
		backdrop.alpha = 0; 
		backdrop.screenCenter(X); 
		add(backdrop);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, warning!
			\nThis mod contains instances of flashing lights and/or glitching effects, that could make you uncomfortable.\nIf you are photo-sensitive to these, turn the flashing lights off and skip cutscenes that contain said instances.
			\nWhile this has been tested, there's a slight chance you might encounter accidental crashes on this android version..\nWe recommend you tamper around in the options menu and toy around with the options for the best experience possible.\n
			Enjoy Friday Night Villainy: A Villainous Mayhem!
			Tap anywhere to continue to Quick Settings.\n",
			32);
		warnText.setFormat("SF Atarian System Bold Italic", 35, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		warnText.y -= 10;
		warnText.alpha = 0;
		FlxTween.tween(warnText, { alpha: 1 }, 3);
		FlxTween.tween(warnText, {y: warnText.y + 25}, 3, {ease: FlxEase.cubeInOut, type: PINGPONG});
		add(warnText);

		settingsText = new FlxText(0, 0, FlxG.width, "QUICK SETTINGS");
		settingsText.setFormat("SF Atarian System Bold Italic", 50, FlxColor.WHITE, CENTER);
		settingsText.alpha = 0;
		settingsText.screenCenter(Y);
		settingsText.y -= 300;
		add(settingsText);

		options = new FlxTypedGroup<FlxText>();
		add(options);

		optionTextDesc = new FlxText(FlxG.width - 750, 500, 680, "Test Description.");
		optionTextDesc.setFormat("SF Atarian System Bold Italic", 50, FlxColor.WHITE, CENTER);
		optionTextDesc.alpha = 0;
		optionTextDesc.screenCenter(Y);
		add(optionTextDesc);

		for (i in 0...5)
		{
			var opt:FlxText = new FlxText(MobileUtil.fixX(50), (FlxG.height / 2) - (210 - (i * 100)), "");
			opt.setFormat("SF Atarian System Bold Italic", 42, FlxColor.WHITE, LEFT);
			opt.ID = i;
			options.add(opt);

			setText(i);
			opt.alpha = 0;
		}

		changeSelection();
	}
	
	var inSettings:Bool = false;
	override function update(elapsed:Float)
	{
		backdrop.x += 0.5 * (elapsed / (1 / 120));
        backdrop.y += 0.16 / (ClientPrefs.framerate / 60);

		optionTextDesc.alpha = backdrop.alpha = settingsText.alpha;
		if(!leftState) 
		{
			if (TouchUtil.pressAction() && !inSettings)
			{
				FlxTween.cancelTweensOf(warnText, ["alpha"]);
				leftState = inSettings = true;

				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1 * warnText.alpha,
				{
					onComplete: function (_)
					{
						FlxTween.tween(settingsText, { alpha: 1 }, 1,
						{
							onComplete: function (_)
							{
								leftState = false;
								FlxTween.color(settingsText, 1, FlxColor.WHITE, FlxColor.YELLOW, {type: PINGPONG});
								addTouchPad('LEFT_FULL', 'A');
							} 
						});
						options.forEach(function(txt:FlxText)
						{
							FlxTween.tween(txt, {alpha: 1}, 1 + (txt.ID * 0.02));
						});
					}
				});
			}		

			if (inSettings)
			{
				if (controls.UI_UP_P) changeSelection(-1, true);
				if (controls.UI_DOWN_P) changeSelection(1, true);

				if (controls.UI_LEFT_P) applySelection(-1);
				if (controls.UI_RIGHT_P) applySelection(1);

				if (controls.ACCEPT && curOption == options.members.length - 1)
				{
					var marcoLaugh = FlxG.sound.play(Paths.sound('marcoLaugh'), 0.75);
					marcoLaugh.onComplete = function() 
					{
						MusicBeatState.switchState(new TitleState());
					};
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
					leftState = true;
					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					
					FlxTween.tween(settingsText, { alpha: 0 }, 1.5, {type: PERSIST, onComplete: function(_)
					{
						optionTextDesc.visible = backdrop.visible = settingsText.visible = false;
					}
					});
					options.forEach(function(txt:FlxText)
					{
						FlxTween.tween(txt, {alpha: 0}, 1.75 + (txt.ID * 0.02));
					});
					FlxTween.tween(bg, { alpha: 0 }, 1.5);
				}
			}
		}

		super.update(elapsed);
	}

	var huh:Int = 0;
	function applySelection(wah:Int = 0)
	{	
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);

		huh += wah;
		if (huh < 0) huh = 1;
		if (huh > 1) huh = 0;

		switch(curOption)
		{
			case 0: ClientPrefs.shaders = (huh == 1);
			case 1: ClientPrefs.cinematicBars = (huh == 1);
			case 2: ClientPrefs.customRating = (huh == 1) ? "FNF" : "FNV";
			case 3: ClientPrefs.missRelatedCombos = (huh == 1);
		}
		ClientPrefs.saveSettings();
		changeSelection();	
	}

	function changeSelection(change:Int = 0, ?playSound:Bool = false)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	
		curOption += change;

		if (curOption < 0) curOption = 4;
		if (curOption > 4) curOption = 0;

		setText(curOption);
	}

	function setText(opt:Int)
	{
		var textMark:String = "<R>";
		for (i in 0...options.members.length)
		{
			var txt = options.members[i];

			txt.text = (i == opt) ? "> " : "";
			switch (i)
			{
				case 0:
					textMark = (ClientPrefs.shaders) ? "<GR>" : "<R>";
					txt.text += 'Shaders: $textMark${(ClientPrefs.shaders) ? "True" : "False"}$textMark';
					
				case 1:
					textMark = (ClientPrefs.cinematicBars) ? "<GR>" : "<R>";
					txt.text += 'Cinematic Bars: $textMark${(ClientPrefs.cinematicBars) ? "True" : "False"}$textMark';

				case 2:
					textMark = (ClientPrefs.customRating == "FNV") ? "<DGR>" : "<G>";
					txt.text += 'Rating Style: $textMark${ClientPrefs.customRating}$textMark';

				case 3:
					textMark = (ClientPrefs.missRelatedCombos) ? "<GR>" : "<R>";
					txt.text += 'Miss Related Combos: $textMark${(ClientPrefs.missRelatedCombos) ? "True" : "False"}$textMark';
				
				case 4:
					txt.color = 0xFFFFF000;
					txt.text += "Apply Settings";
			}

			if (opt != 4) txt.color = 0xFFFFFFFF;
			CustomFontFormats.addMarkers(options.members[i]);
		}

		switch (opt)
		{
			case 0: optionTextDesc.text = "Select whether to have <G>Shaders<G> enabled or not.";	
			case 1: optionTextDesc.text = "Select whether to have <G>Cinematic Bars<G> Enabled or Disabled.";
			case 2: optionTextDesc.text = "Select your Rating Sprite Style to be <G>FNV's Custom Sprites<G>, or <G>FNF's Base Sprites.<G>";
 			case 3: optionTextDesc.text = "Choose if you want to have <G>Colored Rating Sprites based on your misses<G>, or keep them just as how base FNF looks.";	
			case 4: optionTextDesc.text = "Start your Journey.";
		}
		CustomFontFormats.addMarkers(optionTextDesc);
	}
}
