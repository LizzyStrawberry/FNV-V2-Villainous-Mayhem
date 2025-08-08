package options;

import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import lime.utils.Assets;
import flash.text.TextField;
import haxe.Json;
import flixel.input.keyboard.FlxKey;
import Controls;

import flash.system.System;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Achievements', #if desktop 'Controls', #end 'Gameplay', 'Graphics - Visuals & UI', 'Miscellaneous', 'Erase Save Data'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	var erasingData:Bool = false;
	var eraseText:Alphabet;
	var yes:Alphabet;
    var no:Alphabet;
	var shiftingBack:Bool = false;
	var erasureSel:Int = 0;
	var selectedOption:Bool = false;
	var blackOut:FlxSprite;
	function openSelectedSubstate(label:String) {
		if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.35, 0.5);
		if (label != "Adjust Delay and Combo") {
			removeTouchPad();
			persistentUpdate = false;
		}

		switch(label) {
			case 'Achievements':
				MusicBeatState.switchState(new AchievementsMenuState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics - Visuals & UI':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Miscellaneous':
				openSubState(new options.MiscellaneousSubState());
			case 'Adjust Delay and Combo':
				LoadingState.loadAndSwitchState(new options.NoteOffsetState());
			case 'Erase Save Data':
				FlxG.sound.play(Paths.sound('cancelMenu'));
				erasingData = true;
				shiftingBack = true;
				grpOptions.forEach(function(option:Alphabet)
				{
					if (option.ID == options.length - 1)
						FlxTween.tween(option, {y: option.y - 450}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					else
						FlxTween.tween(option, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				});
				FlxTween.tween(selectorLeft, {y: selectorLeft.y - 450}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(selectorRight, {y: selectorRight.y - 450}, 0.7, {ease: FlxEase.circOut, type: PERSIST, onComplete: function (twn:FlxTween)
					{
						FlxTween.tween(eraseText, {alpha: 1}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(yes, {alpha: 1}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(no, {alpha: 1}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST, onComplete: function (twn:FlxTween)
							{
								shiftingBack = false;
							}
						});
					}
				});
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFea71fd;
		bg.updateHitbox();

		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(280, 300, options[i], true);
			optionText.ID = i;
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		//For Erasing Data
		eraseText = new Alphabet(MobileUtil.fixX(100), 500, "       Do you want to erase your save data?\nEverything you earned so far will be resetted!", true);
		eraseText.setAlignmentFromString('center');
        eraseText.scaleX = 0.55;
        eraseText.scaleY = 0.55;
		eraseText.alpha = 0;
		add(eraseText);

		yes = new Alphabet(MobileUtil.fixX(175), 330, "yes", true);
		yes.setAlignmentFromString('center');
        yes.scaleX = 1.1;
        yes.scaleY = 1.1;
        yes.updateHitbox();
		yes.alpha = 0;
		add(yes);

        no = new Alphabet(MobileUtil.fixX(825), 330, "no", true);
		no.setAlignmentFromString('center');
        no.scaleX = 1.1;
        no.scaleY = 1.1;
		no.alpha = 0;
        no.updateHitbox();
		add(no);

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 0;
		add(blackOut);

		super.create();

		addTouchPad('NONE', 'B');
	}

	override function closeSubState() {
		super.closeSubState();
		removeTouchPad();
		addTouchPad('NONE', 'B');
		ClientPrefs.saveSettings();
		persistentUpdate = true;
	}

	var shiftMult:Int = 1;
	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.BACK || FlxG.mouse.justPressedRight) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if (erasingData && !shiftingBack)
			{
				shiftingBack = true;
				grpOptions.forEach(function(option:Alphabet)
				{
					if (option.ID == 5)
						FlxTween.tween(option, {y: option.y + 450}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
					else
						FlxTween.tween(option, {alpha: 0.6}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				});
				FlxTween.tween(selectorLeft, {y: selectorLeft.y + 450}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(selectorRight, {y: selectorRight.y + 450}, 0.7, {ease: FlxEase.circOut, type: PERSIST, onComplete: function (twn:FlxTween)
					{
						erasingData = false;
						shiftingBack = false;
					}
				});
				FlxTween.tween(eraseText, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(yes, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(no, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			}
			else if (PauseSubState.pauseOptions)
			{
				PauseSubState.pauseOptions = false;
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			} 
			else if (ClientPrefs.optionsFreeplay)
			{
				if (FreeplayCategoryState.freeplayName == 'MAIN') //go to Main Freeplay
					MusicBeatState.switchState(new FreeplayState());
				else if (FreeplayCategoryState.freeplayName == 'BONUS') //go to Bonus Freeplay
					MusicBeatState.switchState(new FreeplayBonusState());
				else if (FreeplayCategoryXtraState.freeplayName == 'XTRASHOP') //go to Xtra Freeplay [Using Shop songs]
					MusicBeatState.switchState(new FreeplayXtraState());
				else if (FreeplayCategoryXtraState.freeplayName == 'XTRACROSSOVER') //go to Xtra Freeplay [Using Crossover Songs]
					MusicBeatState.switchState(new FreeplayXtraCrossoverState());
				else if (FreeplayCategoryXtraState.freeplayName == 'XTRABONUS') //go to Xtra Freeplay [Using Bonus Songs]
					MusicBeatState.switchState(new FreeplayXtraBonusState());
			}
			else
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
		}


		if (!erasingData)
		{
			if (controls.UI_UP_P)
				changeSelection(-1);
	
			if(FlxG.mouse.wheel != 0)
				changeSelection(-shiftMult * FlxG.mouse.wheel);

			if (controls.UI_DOWN_P)
				changeSelection(1);

			grpOptions.forEach(function(option:Alphabet)
			{
				if (TouchUtil.pressAction(option) && option.ID != curSelected)
				{
					curSelected = option.ID;
					changeSelection();
					return;
				}

				if (TouchUtil.pressAction(option) && option.ID == curSelected)
					openSelectedSubstate(options[curSelected]);
			});

			if (controls.ACCEPT) {
				openSelectedSubstate(options[curSelected]);
			}	
		}
		if (erasingData && !shiftingBack)
		{
			if (TouchUtil.pressAction(yes))
			{	
				if (curSelected != 1)
				{
					curSelected = 1;
					changeSelection();
					return;
				}
				else
				{
					selectedOption = true;
					eraseData(true);
				}		
			}
			if (TouchUtil.pressAction(no))
			{
				if (curSelected != 0)
				{
					curSelected = 0;
					changeSelection();
					return;
				}
				else
					eraseData(false);
			}

			if (controls.ACCEPT)
			{	
				if (curSelected == 1)
				{
					selectedOption = true;
					eraseData(true);
				}
				else
					eraseData(false);
			}
		}
	}

	function eraseData(erase:Bool)
	{
		if (erase)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			shiftingBack = true;
			FlxG.sound.music.fadeOut(1.8);
	
			FlxTween.tween(blackOut, {alpha: 1}, 2, {ease: FlxEase.cubeIn, type: PERSIST, onComplete: function (twn:FlxTween)
				{
					FlxG.save.erase();
					FlxG.save.flush();
					new FlxTimer().start(0.4, function(tmr:FlxTimer)
					{
						Sys.exit(0);
					});
				}
			});
		}
		else
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			shiftingBack = true;
			grpOptions.forEach(function(option:Alphabet)
			{
				if (option.ID == options.length - 1)
					FlxTween.tween(option, {y: option.y + 450}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				else
					FlxTween.tween(option, {alpha: 0.6}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			});
			FlxTween.tween(selectorLeft, {y: selectorLeft.y + 450}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(selectorRight, {y: selectorRight.y + 450}, 0.7, {ease: FlxEase.circOut, type: PERSIST, onComplete: function (twn:FlxTween)
				{
					erasingData = false;
					shiftingBack = false;
				}
			});
			FlxTween.tween(eraseText, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(yes, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(no, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		}
	}
	
	function changeSelection(change:Int = 0, allowHaptic:Bool = true) {
		if (ClientPrefs.haptics && allowHaptic) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		curSelected += change;
		if (!erasingData)
		{
			if (curSelected < 0)
				curSelected = options.length - 1;
			if (curSelected >= options.length)
				curSelected = 0;
	
			var bullShit:Int = 0;
	
			for (item in grpOptions.members) {
				item.targetY = bullShit - curSelected;
				bullShit++;
	
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
					selectorLeft.x = item.x - 63;
					selectorLeft.y = item.y;
					selectorRight.x = item.x + item.width + 15;
					selectorRight.y = item.y;
				}
			}
		}
		else
		{
			if (curSelected < 0)
				curSelected = 1;
			if (curSelected > 1)
				curSelected = 0;

			if (curSelected == 1) //Yes
			{
				yes.alpha = 1;
				no.alpha = 0.6;
			}
			if (curSelected == 0) //No
			{
				yes.alpha = 0.6;
				no.alpha = 1;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}