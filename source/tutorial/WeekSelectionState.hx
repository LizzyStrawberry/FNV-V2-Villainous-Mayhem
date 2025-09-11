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

class WeekSelectionState extends MusicBeatState
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
		addTouchPad('LEFT_RIGHT', 'B');
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
			curImageSelected = 4;
		if (curImageSelected > 4)
			curImageSelected = 1;

        currentImage.loadGraphic(Paths.image('tutorials/weekSelection/TutorialWeekSel-' + curImageSelected));
        switch (curImageSelected)
        {
			case 1:
                descText.text = "When you click on Story Mode, you have 4 different gamemodes to choose from. Reminder, the more you progress in-game, the more modes you unlock!";
            case 2:
                descText.text = "To select a week category, select the category you want to play either by tapping the corresponding number on screen.";
            case 3:
                descText.text = "To change a week, click on the arrows";
            case 4:
                descText.text = "Lastly, choose the difficulty you want either by tapping the blue arrows, and then click on the difficulty to load the week!";
        } 
		
		descText.screenCenter(Y);
		descText.y += 270;

		descBox.setPosition(descText.x - 10, descText.y - 10);
		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}