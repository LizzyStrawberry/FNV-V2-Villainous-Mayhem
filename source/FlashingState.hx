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
	var optionText1:FlxText;
	var optionText2:FlxText;
	var optionText3:FlxText;
	var optionText4:FlxText;
	var optionTextFinal:FlxText;
	var optionTextDesc:FlxText;

	var warnTween:FlxTween;

	override function create()
	{
		super.create();
	
		bg.alpha = 0;
		FlxTween.tween(bg, { alpha: 0.4 }, 3);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, warning!\n
			This mod contains a lot of content that very low end PCS may struggle to play on!\n
			The mod has been tested on lower end hardware, and although it works fine, you may encounter some small issues!\n
			We recommend you tamper around in the options menu and toy around with the options for the best experience possible!\n
			Enjoy FNV's V2.0 Update!!\n
			Press ENTER to continue to Quick Settings.\n
			",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		warnText.y -= 10;
		warnText.alpha = 0;
		warnTween = FlxTween.tween(warnText, { alpha: 1 }, 3);
		FlxTween.tween(warnText, { y: warnText.y + 25 }, 3, {ease: FlxEase.cubeInOut, type: PINGPONG});
		add(warnText);

		settingsText = new FlxText(0, 0, FlxG.width,
			"QUICK SETTINGS",
			50);
		settingsText.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, CENTER);
		settingsText.alpha = 0;
		settingsText.screenCenter(Y);
		settingsText.y -= 300;
		add(settingsText);

		optionText1 = new FlxText(0, 0, FlxG.width,
			"Shaders: True",
			50);
		optionText1.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, LEFT);
		optionText1.alpha = 0;
		optionText1.screenCenter(Y);
		optionText1.y -= 210;
		optionText1.x += 50;
		add(optionText1);

		optionText2 = new FlxText(0, 0, FlxG.width,
			"Cinematic Bars: True",
			50);
		optionText2.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, LEFT);
		optionText2.alpha = 0;
		optionText2.screenCenter(Y);
		optionText2.y -= 110;
		optionText2.x += 50;
		add(optionText2);

		optionText3 = new FlxText(0, 0, FlxG.width,
			"Rating Sprites Style: FNV",
			50);
		optionText3.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, LEFT);
		optionText3.alpha = 0;
		optionText3.screenCenter(Y);
		optionText3.y += 10;
		optionText3.x += 50;
		add(optionText3);

		optionText4 = new FlxText(0, 0, FlxG.width,
			"Miss Related Combos: True",
			50);
		optionText4.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, LEFT);
		optionText4.alpha = 0;
		optionText4.screenCenter(Y);
		optionText4.y += 130;
		optionText4.x += 50;
		add(optionText4);
	
		optionTextFinal = new FlxText(0, 0, FlxG.width,
			"Apply Settings",
			50);
		optionTextFinal.setFormat("VCR OSD Mono", 35, FlxColor.WHITE, LEFT);
		optionTextFinal.alpha = 0;
		optionTextFinal.screenCenter(Y);
		optionTextFinal.y += 250;
		optionTextFinal.x += 50;
		add(optionTextFinal);

		optionTextDesc = new FlxText(0, 0, 500,
			"Miss Related Combos: True",
			50);
		optionTextDesc.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, CENTER);
		optionTextDesc.alpha = 0;
		optionTextDesc.screenCenter(Y);
		optionTextDesc.x += 750;
		add(optionTextDesc);

		changeSelection();
	}
	
	var pressedEnter:Int = 0;
	var enteringGame:Bool = false;
	override function update(elapsed:Float)
	{
		optionText2.alpha = optionText3.alpha = optionText4.alpha = optionTextDesc.alpha = optionTextFinal.alpha = optionText1.alpha;
		if(!leftState) 
		{
			if (controls.ACCEPT && pressedEnter < 1)
			{
				warnTween.cancel();
				pressedEnter = 1;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						FlxTween.tween(settingsText, { alpha: 1 }, 1, {
							onComplete: function (twn:FlxTween) {
								FlxTween.color(settingsText, 1, FlxColor.WHITE, FlxColor.YELLOW, {type: PINGPONG});
							} 
						});
						FlxTween.tween(optionText1, { alpha: 1 }, 1);
						pressedEnter = 2;
						}
					});
			}

			if (pressedEnter == 2)
			{
				if (controls.UI_UP_P)
					changeSelection(-1);
				if (controls.UI_DOWN_P)
					changeSelection(1);

				if (controls.UI_LEFT_P)
					applySelection(-1);
				if (controls.UI_RIGHT_P)
					applySelection(1);
			}

			if (controls.ACCEPT && pressedEnter == 2 && optionTextFinal.text == ">Apply Settings<" && enteringGame == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				leftState = true;
				pressedEnter = 3;
				enteringGame = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				
				FlxTween.tween(settingsText, { alpha: 0 }, 1);
				FlxTween.tween(optionText1, { alpha: 0 }, 1);
				FlxTween.tween(bg, { alpha: 0 }, 1, {
					onComplete: function (twn:FlxTween) 
					{
							MusicBeatState.switchState(new TitleState());
					}
				});
			}
		}
		super.update(elapsed);
	}

	var huh:Int = 0;
	function applySelection(wah:Int = 0)
	{	
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		huh += wah;
		if (huh < 0)
			huh = 1;
		if (huh > 1)
			huh = 0;

		if (huh == 0)
		{
			if (curOption == 0 && ClientPrefs.shaders)
				ClientPrefs.shaders = false;
			if (curOption == 1 && ClientPrefs.cinematicBars)
				ClientPrefs.cinematicBars = false;
			if (curOption == 2 && ClientPrefs.customRating == "FNV")
				ClientPrefs.customRating = "FNF";
			if (curOption == 3 && ClientPrefs.missRelatedCombos)
				ClientPrefs.missRelatedCombos = false;
		}	
		else if (huh == 1)
		{
			if (curOption == 0 && !ClientPrefs.shaders)
				ClientPrefs.shaders = true;
			if (curOption == 1 && !ClientPrefs.cinematicBars)
				ClientPrefs.cinematicBars = true;
			if (curOption == 2 && ClientPrefs.customRating == "FNF")
				ClientPrefs.customRating = "FNV";
			if (curOption == 3 && !ClientPrefs.missRelatedCombos)
				ClientPrefs.missRelatedCombos = true;
		}
		ClientPrefs.saveSettings();
		changeSelection();	
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	
		curOption += change;

		if (curOption < 0)
			curOption = 4;
		if (curOption > 4)
			curOption = 0;

		switch (curOption)
		{
			case 0:
				if (ClientPrefs.shaders)
					optionText1.text = "Shaders: <GR>True<GR>";
				else
					optionText1.text = "Shaders: <R>False<R>";

				optionTextDesc.text = "Select whether to have Shaders enabled or not.";
			case 1:
				if (ClientPrefs.cinematicBars)
					optionText2.text = "Cinematic Bars: <GR>True<GR>";
				else
					optionText2.text = "Cinematic Bars: <R>False<R>";
				optionTextDesc.text = "Select whether to have Cinematic Bars Enabled or Disabled.";

			case 2:
				if (ClientPrefs.customRating == "FNV")
					optionText3.text = "Rating Sprites Style: <DGR>FNV<DGR>";
				else
					optionText3.text = "Rating Sprites Style: <G>FNF<G>";
				optionTextDesc.text = "Select your Rating Sprite style, either FNV's Custom ones, or FNF's Base Sprites.";

			case 3:
				if (ClientPrefs.missRelatedCombos == true)
					optionText4.text = "Miss Related Combos: <GR>True<GR>";
				else
					optionText4.text = "Miss Related Combos: <R>False<R>";
				optionTextDesc.text = "Choose if you want to have:\n- Gold (0 Misses)\n- Silver (1-9 Misses)\n- Normal (10+ Misses) Rating Sprites, or keep them just as how base FNF works.";
			case 4:
				optionTextFinal.color = 0xFFFFF000;
				optionTextFinal.text = ">Apply Settings<";
				optionTextDesc.text = "Start the journey.";
		}

		if (curOption != 4)
		{
			optionTextFinal.color = 0xFFFFFFFF;
			optionTextFinal.text = "Apply Settings";
		}

		CustomFontFormats.addMarkers(optionText1);
		CustomFontFormats.addMarkers(optionText2);
		CustomFontFormats.addMarkers(optionText3);
		CustomFontFormats.addMarkers(optionText4);
	}
}
