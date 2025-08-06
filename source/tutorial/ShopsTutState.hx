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

class ShopsTutState extends MusicBeatState
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
			curImageSelected = 9;
		if (curImageSelected > 9)
			curImageSelected = 1;

        currentImage.loadGraphic(Paths.image('tutorials/shops/shops-' + curImageSelected));
        switch (curImageSelected)
        {
            case 1:
                descText.text = "One of FNV's Main Attractions are the Shops!\nEach shop has its own Merchant and own shopping rules!\nClicking on each Merchan can activate dialogue,\nso keep that in mind!";
				descText.size = 32;
            case 2:
                descText.text = "The first shop is Mimiko's shop, the Main of the 3!\nHis shopping rules lean more to gambling\nwith each prize machine having access to a set of items you can gamble!";
				descText.size = 32;
            case 3:
                descText.text = "Simply select whichever prize machine you want to access it!\nBeware, not all are unlocked at the start!\nEach main week you beat, a new prize machine is unlocked!";
				descText.size = 32;
			case 4:
                descText.text = "When accessing a prize machine,\nyou have to press the button below to use 1 token and start the gambling process!\nWhilst items are being randomly selected,\npress SPACE when you feel lucky and you win whichever item is selected!\nWARNING: If you get an item you already purchased,\nit'll act as a miss!";
				descText.size = 22;
			case 5:
				descText.text = "To your left from Mimiko's shop, you have Zeel's Illegal Emporium!\nEach section she has here corresponds to what Mimiko's prize machines have, and a few extra items!!";
				descText.size = 32;
			case 6:
				descText.text = "You can access each one by pressing them,\nand inside you'll find every item Mimiko makes you gamble for!";
				descText.size = 32;
			case 7:
				descText.text = "The twist is that each item has its own price tag,\nso you better start grinding for those tokens!";
				descText.size = 32;
			case 8:
				descText.text = "Lastly, by going upstairs from Mimiko's Shop,\nyou enter The Cellar!\nThe Hermit is your merchant, who you can buy Scrolls and Gallery Items from!";
				descText.size = 32;
			case 9:
				descText.text = "She doesn't accept Tokens though!\nInstead, she'll trade items for you for Eggs, so you better find out where to get Eggs from!";
				descText.size = 32;
		} 
		
		descText.screenCenter(Y);
		descText.y += 270;

		descBox.setPosition(descText.x - 10, descText.y - 10);
		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}