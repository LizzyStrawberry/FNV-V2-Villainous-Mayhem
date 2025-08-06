package tutorial;

import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.text.FlxTypeText;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;

import editors.ChartingState;
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import openfl.utils.Assets as OpenFlAssets;
import Alphabet;
#if MODS_ALLOWED
import sys.FileSystem;
#end

import flash.system.System;

class MenuAndInventoryState extends MusicBeatState
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

        currentImage.loadGraphic(Paths.image('tutorials/menuAndInventory/menuAndInventory-' + curImageSelected));
        switch (curImageSelected)
        {
			case 1:
                descText.text = "This is your main menu. It's easy to navigate through with your mouse or by using your keyboard!";
            case 2:
                descText.text = "To change your selection, press the arrows with your mouse or press LEFT / RIGHT to navigate through the menu. To access Options, press the Gear icon on the top-right corner.";
            case 3:
                descText.text = "To access the shop, the tutorial section (where you are right now!) and the owner's discord server, press the icons with your mouse!";
            case 4:
                descText.text = "To select your selection, press ENTER or click with your mouse. Simple so far, right?";
			case 5:
                descText.text = "How do you access the inventory though? Press I on your keyboard or the Bag Icon with your mouse while you're in the main menu to get in your Inventory!";
			case 6:
                descText.text = "Your inventory contains the buffs you collected, the charms you got AND the last character you played as. Clicking on the charms just gives you info on them.";
			case 7:
                descText.text = "Of course, clicking on any of the buffs lets you select the buff you want to use in-game! The moment you close your inventory, your buff is selected, and you can always come back to your inventory to change it at any point!";
        } 
		
		descText.screenCenter(Y);
		descText.y += 270;

		descBox.setPosition(descText.x - 10, descText.y - 10);
		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}