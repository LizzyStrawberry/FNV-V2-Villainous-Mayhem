package tutorial;

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
import flixel.addons.text.FlxTypeText;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxAxes;

import editors.ChartingState;
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import Alphabet;
#if MODS_ALLOWED
import sys.FileSystem;
#end

import flash.system.System;

class CoreMechanicsState extends MusicBeatState
{
    private var arrowSelectorLeft:FlxSprite;
	private var arrowSelectorRight:FlxSprite;
	private var getLeftArrowX:Float = 0;
	private var getRightArrowX:Float = 0;

    private var curImageSelected:Int = 1;
    private var descBox:FlxSprite;
	private var descText:FlxText;
    private var currentImage:FlxSprite;

    override function create()
	{
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

        descBox = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		descBox.alpha = 0.6;
		add(descBox);

        arrowSelectorLeft = new FlxSprite(80, 240).loadGraphic(Paths.image('freeplayStuff/arrowSelectorLeft'));
		arrowSelectorLeft.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorLeft.scale.set(0.5, 0.5);
		add(arrowSelectorLeft);

		arrowSelectorRight = new FlxSprite(1060, 240).loadGraphic(Paths.image('freeplayStuff/arrowSelectorRight'));
		arrowSelectorRight.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorRight.scale.set(0.5, 0.5);
		add(arrowSelectorRight);

		getRightArrowX = arrowSelectorRight.x;
		getLeftArrowX = arrowSelectorLeft.x;

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		currentImage = new FlxSprite(0, -50).loadGraphic(Paths.image('Gallery/image_1'));
		currentImage.antialiasing = ClientPrefs.globalAntialiasing;
		currentImage.scale.set(0.7, 0.7);
		add(currentImage);

        changeSelection();
    }

    override function update(elapsed:Float)
	{
		if (controls.BACK || FlxG.mouse.justPressedRight)
		{
			MusicBeatState.switchState(new TutorialState(), 'stickers');
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}

        if (FlxG.mouse.overlaps(arrowSelectorLeft))
			FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

		if (FlxG.mouse.overlaps(arrowSelectorRight))
			FlxTween.tween(arrowSelectorRight, {x: getRightArrowX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(arrowSelectorRight, {x: getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

        if (controls.UI_LEFT_P || (FlxG.mouse.overlaps(arrowSelectorLeft) && FlxG.mouse.justPressed))
		{
			changeSelection(-1);
		}
		if (controls.UI_RIGHT_P || (FlxG.mouse.overlaps(arrowSelectorRight) && FlxG.mouse.justPressed))
		{
			changeSelection(1);
		}
        super.update(elapsed);
    }

    function changeSelection(change:Int = 0)
	{
		curImageSelected += change;
		if (curImageSelected < 1)
			curImageSelected = 7;
		if (curImageSelected > 7)
			curImageSelected = 1;

        currentImage.loadGraphic(Paths.image('tutorials/mechanics/MechanicsSel-' + curImageSelected));
        switch (curImageSelected)
        {
            case 1:
                descText.text = "Charms are one part of FNV's core mechanics.\nThey grant you power ups throughout whatever song you're playing, at the cost of 1 token each time you use one!";
				descText.size = 32;
            case 2:
                descText.text = "To unlock the charms, you either win them by chance from Mimiko's Slot Machines, or you buy them off of Zeel's shop!";
				descText.size = 32;
            case 3:
                descText.text = "The Resistance charm reduces the amount of health drain, or any other damage gain you get from any of the opponent's attacks! It's default keybind is 1!\nThe Auto Dodge Charm lets you play your song peacefully without worrying about dodging, as it does it on it's own! It's default keybind is 2!\nThe Healing charm grants you health! You get 10 uses each time you activate it, and to heal, you have to manually press your healing charm button to use! It's default keybind is 3!\nRemember: You can only use ONE charm per song, and ONLY if you have more than 1 tokens!";
				descText.size = 18;
			case 4:
                descText.text = "The other half of the core mechanics is your Mayhem Bar, and it's Buffs! This bar acts as a temporary power up for your character, and depending on what buff you use, it acts accordingly for a small amount of time before it needs to recharge!";
				descText.size = 32;
			case 5:
				descText.text = "To use the bar ingame, you have to first select which buff you want to use for your gameplay session through your inventory!\nTo properly use the bar, make sure you don't miss your notes! Pressing them correctly fills your bar up, but if you miss, your bar decreases!\nUpon being full, the bar will flash, indicating you maxed it out! Press your MAYHEM button to activate it, and it'll grant you your power up, aswell as bonus score and cool lights!";
				descText.size = 18;
			case 6:
				descText.text = "Each buff gets unlocked by finishing each of the 3 main weeks of the mod (Weeks 1 - 3).\nThe Health Regeneration buff heals you periodically for a few seconds!\nThe Second Chance buff lets you continue playing with full health if you manage to lose all your health upon it's activation! BEWARE: it only works once per song, and it only grants you a second chance when you lose all your health before the bar depletes down!\nThe Immunity buff let's you miss as much as you want without losing health, either by the opponent, or you, or the mechanics given ingame!\nYou can only use 1 buff per song, aka the one you select from your inventory, and it's free of charge!";
				descText.size = 18;
			case 7:
				descText.text = "Lastly, if you ever see this sign on your instructions screen, it means that this song will be a BOSS FIGHT!\nIn Boss Fights, Health Regeneration per note is slower, and the enemy can deal a lot more damage to you!\nThe miss penalty is also wau stricter, so consider using your charms and buffs if you find yourself in a difficult situation!";
				descText.size = 18;
		} 
		
		descText.screenCenter(Y);
		descText.y += 270;

		descBox.setPosition(descText.x - 10, descText.y - 10);
		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}