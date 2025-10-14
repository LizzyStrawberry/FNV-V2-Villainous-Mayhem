package;

import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;
	public static var curOption:Int = 0;

	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
	var warnText:FlxText;

	// This mod is taking way too long to finish, I can't be bothered to fix everything or do better code on this old junk
	var settingsText:FlxText;
	var optionTextDesc:FlxText;

	var options:FlxTypedGroup<FlxText>;

	override function create()
	{
		super.create();
	
		bg.alpha = 0;
		FlxTween.tween(bg, { alpha: 0.4 }, 3);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, warning!
			\nThis mod contains instances of flashing lights and/or glitching effects, that could make you uncomfortable.
			\nIf you are photo-sensitive to these, turn the flashing lights off and skip cutscenes that contain said instances.
			\nThe mod has also been tested on lower end hardware, and although it works fine, you may encounter some small issues.
			\nWe recommend you tamper around in the options menu and toy around with the options for the best experience possible.\n
			Enjoy FNV's V2.0 Update!!\n
			Press ENTER to continue to Quick Settings.\n",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		warnText.y -= 10;
		warnText.alpha = 0;
		FlxTween.tween(warnText, { alpha: 1 }, 3);
		FlxTween.tween(warnText, {y: warnText.y + 25}, 3, {ease: FlxEase.cubeInOut, type: PINGPONG});
		add(warnText);

		settingsText = new FlxText(0, 0, FlxG.width,
			"QUICK SETTINGS",
			50);
		settingsText.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, CENTER);
		settingsText.alpha = 0;
		settingsText.screenCenter(Y);
		settingsText.y -= 300;
		add(settingsText);

		options = new FlxTypedGroup<FlxText>();
		add(options);

		optionTextDesc = new FlxText(0, 0, 500,
			"Test Description.",
			50);
		optionTextDesc.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, CENTER);
		optionTextDesc.alpha = 0;
		optionTextDesc.screenCenter(Y);
		optionTextDesc.x += 750;
		add(optionTextDesc);

		for (i in 0...5)
		{
			var opt:FlxText = new FlxText(50, (FlxG.height / 2) - (210 - (i * 100)), "");
			opt.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, LEFT);
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
		optionTextDesc.alpha = settingsText.alpha;
		if(!leftState) 
		{
			if (controls.ACCEPT && !inSettings)
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

				if (controls.ACCEPT && curOption == 4)
				{
					FlxG.sound.play(Paths.sound('confirmMenu'));
					leftState = true;
					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					
					FlxTween.tween(settingsText, { alpha: 0 }, 1);
					options.forEach(function(txt:FlxText)
					{
						FlxTween.tween(txt, {alpha: 0}, 0.95 + (txt.ID * 0.02));
					});
					FlxTween.tween(bg, { alpha: 0 }, 1, {
						onComplete: function (twn:FlxTween) 
						{
							MusicBeatState.switchState(new TitleState());
						}
					});
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
		var txt = options.members[opt];
		switch (opt)
		{
			case 0:
				textMark = (ClientPrefs.shaders) ? "<GR>" : "<R>";
				txt.text = 'Shaders: $textMark${(ClientPrefs.shaders) ? "True" : "False"}$textMark';
				optionTextDesc.text = "Select whether to have Shaders enabled or not.";
				
			case 1:
				textMark = (ClientPrefs.cinematicBars) ? "<GR>" : "<R>";
				txt.text = 'Cinematic Bars: $textMark${(ClientPrefs.cinematicBars) ? "True" : "False"}$textMark';
				optionTextDesc.text = "Select whether to have Cinematic Bars Enabled or Disabled.";

			case 2:
				textMark = (ClientPrefs.customRating == "FNV") ? "<DGR>" : "<G>";
				txt.text = 'Rating Style: $textMark${ClientPrefs.customRating}$textMark';
				optionTextDesc.text = "Select your Rating Sprite style, either FNV's Custom ones, or FNF's Base Sprites.";

			case 3:
				textMark = (ClientPrefs.missRelatedCombos) ? "<GR>" : "<R>";
				txt.text = 'Miss Related Combos: $textMark${(ClientPrefs.missRelatedCombos) ? "True" : "False"}$textMark';
				optionTextDesc.text = "Choose if you want to have:\n- Gold (0 Misses)\n- Silver (1-9 Misses)\n- Normal (10+ Misses) Rating Sprites, or keep them just as how base FNF works.";
			
			case 4:
				txt.color = 0xFFFFF000;
				txt.text = "Apply Settings";
				optionTextDesc.text = "Start the journey.";
		}

		if (opt != 4) txt.color = 0xFFFFFFFF;
		CustomFontFormats.addMarkers(options.members[opt]);
	}
}
