package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;
	public static var curOption:Int = 0;

	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
	var warnText:FlxText;

	var settingsText:FlxText;
	var optionText1:FlxText;
	var optionText2:FlxText;
	var optionText3:FlxText;
	var optionText4:FlxText;
	var optionTextFinal:FlxText;

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
		warnText.alpha = 0;
		warnTween = FlxTween.tween(warnText, { alpha: 1 }, 3);
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
		optionText1.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, CENTER);
		optionText1.alpha = 0;
		optionText1.screenCenter(Y);
		optionText1.y -= 210;
		add(optionText1);

		optionText2 = new FlxText(0, 0, FlxG.width,
			"Cinematic Bars: True",
			50);
		optionText2.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, CENTER);
		optionText2.alpha = 0;
		optionText2.screenCenter(Y);
		optionText2.y -= 110;
		add(optionText2);

		optionText3 = new FlxText(0, 0, FlxG.width,
			"Rating Sprites Style: FNV",
			50);
		optionText3.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, CENTER);
		optionText3.alpha = 0;
		optionText3.screenCenter(Y);
		optionText3.y += 10;
		add(optionText3);

		optionText4 = new FlxText(0, 0, FlxG.width,
			"Miss Related Combos: True",
			50);
		optionText4.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, CENTER);
		optionText4.alpha = 0;
		optionText4.screenCenter(Y);
		optionText4.y += 130;
		add(optionText4);
	
		optionTextFinal = new FlxText(0, 0, FlxG.width,
			"Apply Settings",
			50);
		optionTextFinal.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, CENTER);
		optionTextFinal.alpha = 0;
		optionTextFinal.screenCenter(Y);
		optionTextFinal.y += 250;
		add(optionTextFinal);

		changeSelection();
	}
	
	var pressedEnter:Int = 0;
	var enteringGame:Bool = false;
	override function update(elapsed:Float)
	{
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
						FlxTween.tween(optionText2, { alpha: 1 }, 1);
						FlxTween.tween(optionText3, { alpha: 1 }, 1);
						FlxTween.tween(optionText4, { alpha: 1 }, 1);
						FlxTween.tween(optionTextFinal, { alpha: 1 }, 1);
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
				FlxTween.tween(optionText2, { alpha: 0 }, 1);
				FlxTween.tween(optionText3, { alpha: 0 }, 1);
				FlxTween.tween(optionText4, { alpha: 0 }, 1);
				FlxTween.tween(optionTextFinal, { alpha: 0 }, 1);
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
				if (curOption == 0 && ClientPrefs.shaders == true)
				{
					ClientPrefs.shaders = false;
					ClientPrefs.saveSettings();
				}
				if (curOption == 1 && ClientPrefs.cinematicBars == true)
				{
					ClientPrefs.cinematicBars = false;
					ClientPrefs.saveSettings();
				}
				if (curOption == 2 && ClientPrefs.customRating == "FNV")
				{
					ClientPrefs.customRating = "FNF";
					ClientPrefs.saveSettings();
				}
				if (curOption == 3 && ClientPrefs.missRelatedCombos == true)
				{
					ClientPrefs.missRelatedCombos = false;
					ClientPrefs.saveSettings();
				}
				if (curOption == 4)
				{
					//do nothing
				}
			}	
			if (huh == 1)
				{
					if (curOption == 0 && ClientPrefs.shaders == false)
					{
						ClientPrefs.shaders = true;
						ClientPrefs.saveSettings();
					}
					if (curOption == 1 && ClientPrefs.cinematicBars == false)
					{
						ClientPrefs.cinematicBars = true;
						ClientPrefs.saveSettings();
					}
					if (curOption == 2 && ClientPrefs.customRating == "FNF")
					{
						ClientPrefs.customRating = "FNV";
						ClientPrefs.saveSettings();
					}
					if (curOption == 3 && ClientPrefs.missRelatedCombos == false)
					{
						ClientPrefs.missRelatedCombos = true;
						ClientPrefs.saveSettings();
					}
					if (curOption == 4)
					{
						//do nothing
					}
				}
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

			if (curOption == 0)
				if (ClientPrefs.shaders == true)
					optionText1.text = "Shaders: >True<";
				else
					optionText1.text = "Shaders: >False<";
			else
				if (ClientPrefs.shaders == true)
					optionText1.text = "Shaders: True";
				else
					optionText1.text = "Shaders: False";

			if (curOption == 1)
				if (ClientPrefs.cinematicBars == true)
					optionText2.text = "Cinematic Bars: >True<";
				else
					optionText2.text = "Cinematic Bars: >False<";
			else
				if (ClientPrefs.cinematicBars == true)
					optionText2.text = "Cinematic Bars: True";
				else
					optionText2.text = "Cinematic Bars: False";

			if (curOption == 2)
				if (ClientPrefs.customRating == "FNV")
					optionText3.text = "Rating Sprites Style: >FNV<";
				else
					optionText3.text = "Rating Sprites Style: >FNF<";
			else
				if (ClientPrefs.customRating == "FNV")
					optionText3.text = "Rating Sprites Style: FNV";
				else
					optionText3.text = "Rating Sprites Style: FNF";
			
			if (curOption == 3)
				if (ClientPrefs.missRelatedCombos == true)
					optionText4.text = "Miss Related Combos: >True<";
				else
					optionText4.text = "Miss Related Combos: >False<";
			else
				if (ClientPrefs.missRelatedCombos == true)
					optionText4.text = "Miss Related Combos: True";
				else
					optionText4.text = "Miss Related Combos: False";

			if (curOption == 4)
				{
					optionTextFinal.color = 0xFFFFF000;
					optionTextFinal.text = ">Apply Settings<";
				}		
			else
				{
					optionTextFinal.color = 0xFFFFFFFF;
					optionTextFinal.text = "Apply Settings";
				}
		}
}
