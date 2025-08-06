package tutorial;

import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import lime.utils.Assets;
import flash.text.TextField;
import haxe.Json;
import Controls;

class TutorialState extends MusicBeatState
{
    public static var tutorials:Array<String> = ['Main Menu and Inventory', 'Week Selection', 'Core Mechanics', 'Shops'];
	private var grpTuts:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	var BG:FlxSprite;

    override function create()
	{
		#if desktop
		DiscordClient.changePresence("Viewing Tutorial Menu", null);
		#end

        BG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		BG.updateHitbox();
		BG.screenCenter();
		BG.color = 0xFF00c2ff;
		add(BG);

		grpTuts = new FlxTypedGroup<Alphabet>();
		add(grpTuts);

		for (i in 0...tutorials.length)
		{
			var tutorialText:Alphabet = new Alphabet(90, 320, tutorials[i], true);
			tutorialText.isMenuItem = true;
			tutorialText.ID = i;
			tutorialText.targetY = i;
			tutorialText.snapToPosition();
			grpTuts.add(tutorialText);
		}

		grpTuts.forEach(function(tutorialText:Alphabet)
		{
			if (ClientPrefs.shopTutUnlocked == false && tutorialText.ID == 3)
			{
				tutorialText.text = '?????';
			}
			if (ClientPrefs.coreMechTutUnlocked == false && tutorialText.ID == 2)
			{
				tutorialText.text = '???? ????????';
			}
		});

		var titleText:Alphabet = new Alphabet(1575, 40, "Tutorials", true);
		titleText.scaleX = 0.6;
		titleText.scaleY = 0.6;
		titleText.alpha = 0.4;
		add(titleText);

		changeSelection();

		super.create();
    }

	var shiftMult:Int = 1;
    override public function update(elapsed:Float)
	{
        
		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}
		if(FlxG.mouse.wheel != 0)
		{
			changeSelection(-shiftMult * FlxG.mouse.wheel);
		}

		
		if (controls.BACK || FlxG.mouse.justPressedRight) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState(), 'stickers');
		}
        if (controls.ACCEPT){
            openSelectedState(tutorials[curSelected]);
        }

		var bullShit:Int = 0;
		for (item in grpTuts.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;
	
			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));
	
			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
        super.update(elapsed);
    }

    function changeSelection(change:Int = 0)
	{
		curSelected += change;
		if (curSelected < 0)
			curSelected = tutorials.length - 1;
		if (curSelected >= tutorials.length)
			curSelected = 0;

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function openSelectedState(label:String)
		{
			switch(label) {
				case 'Main Menu and Inventory':
					FlxG.switchState(new tutorial.MenuAndInventoryState());
				case 'Shops':
					if (ClientPrefs.shopTutUnlocked == true)
						FlxG.switchState(new tutorial.ShopsTutState());
				case 'Week Selection':
					FlxG.switchState(new tutorial.WeekSelectionState());
				case 'Core Mechanics':
					if (ClientPrefs.coreMechTutUnlocked == true)
						FlxG.switchState(new tutorial.CoreMechanicsState());
			}
		}
}