package;

import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import Alphabet;

class FreeplayCategoryXtraState extends MusicBeatState
{
    public static var categorySelected:Int = 0;

    var textBG:FlxSprite;
    var Text:FlxText;

    var selectionArray:Array<Array<Dynamic>> = [ // X, Y, type, isUnlocked
        [135, 45, "Shop", true],
        [480, 45, "Crossover", ClientPrefs.crossoverUnlocked],
        [825, 45, "Bonus", ClientPrefs.xtraBonusUnlocked]
    ];
    var selectionGroup:FlxTypedGroup<FlxSprite>;

    override function create()
    {
        FreeplayState.songCategory = '';

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Selecting XTRA Freeplay Mode", null);
		#end

        var bgGradient:FlxSprite = new FlxSprite().loadGraphic(Paths.image('pauseGradient/gradient_Null'));
        bgGradient.color = 0xFF00a800;
        bgGradient.setGraphicSize(FlxG.width, FlxG.height);
        bgGradient.screenCenter(X);
		bgGradient.alpha = 0;
		add(bgGradient);

        var assetLocation:String = "freeplayStuff/categories";
        selectionGroup = new FlxTypedGroup<FlxSprite>();
        add(selectionGroup);
        for (i in 0...selectionArray.length)
        {
            var x = selectionArray[i][0]; var y = selectionArray[i][1];
            var typeOfSel = selectionArray[i][2]; var isUnlocked = selectionArray[i][3];

            var selection = new FlxSprite(x, y).loadGraphic(Paths.image('$assetLocation/Xtra$typeOfSel' + ((!isUnlocked) ? "Locked" : "")));
            selection.ID = i;
            selection.updateHitbox();
            selection.antialiasing = ClientPrefs.globalAntialiasing;
            selectionGroup.add(selection);

            selection.x = MobileUtil.fixX(selection.x);

            FlxTween.tween(selection, {y: selection.y + 5}, 5 + (i * 0.025), {ease: FlxEase.cubeInOut, type: PINGPONG});
        }

        textBG = new FlxSprite(0, FlxG.height - 38).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

        Text = new FlxText(textBG.x + 1000, textBG.y + 8, FlxG.width + 1000, "LEFT - A / RIGHT - D / MOUSE: Select Xtra Category | ENTER: Enter Xtra Section | BACKSPACE: Go back to Freeplay Selection Mode", 24);
		Text.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);
		Text.scrollFactor.set();
		add(Text);

        FlxTween.tween(Text, {x: textBG.x - 2500}, 20, {ease: FlxEase.linear, type: LOOPING});

        var borders:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('promotion/Borders'));
        borders.setGraphicSize(FlxG.width, FlxG.height);
		borders.antialiasing = ClientPrefs.globalAntialiasing;
		add(borders);

        changeItem(0, false, false);

        addTouchPad("NONE", "B");

        super.create();
    }

    var mouseMode:Bool = false;
    var selectedSomething:Bool = false;
    override function update(elapsed:Float)
    {
        if (!selectedSomething)
        {
            if (controls.BACK || FlxG.mouse.justPressedRight)
		    {
                selectedSomething = true;
			    FlxG.sound.play(Paths.sound('cancelMenu'));
			    MusicBeatState.switchState(new FreeplayCategoryState(), 'stickers');
		    }

            if (controls.UI_LEFT_P) changeItem(-1);	
   		    if (controls.UI_RIGHT_P) changeItem(1);
            mouseMode = (TouchUtil.touch != null) ? true : false;

            selectionGroup.forEach(function(spr:FlxSprite)
            {
                if (TouchUtil.overlaps(spr) && mouseMode)
                {
                    if (categorySelected != spr.ID) 
                    {
                        if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
                        FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                    }
                    categorySelected = spr.ID; 
                    changeItem(0, false, false);
                }

                var accepted = controls.ACCEPT || TouchUtil.pressAction(spr);
                if (accepted && spr.ID == categorySelected)
                {
                    var selectionName = "XTRA" + selectionArray[spr.ID][2].toUpperCase();
                    var isUnlocked = selectionArray[spr.ID][3];
                    // If unlocked, then move on
                    if (isUnlocked) acceptCategory(selectionGroup, selectionName);
                    else
                    {
                        FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
                        FlxG.sound.play(Paths.sound('accessDenied'));  
                    }
                }
            });
        }
        super.update(elapsed);
    }

    function acceptCategory(group:FlxTypedGroup<FlxSprite>, freeplaySave:String)
    {
        if (ClientPrefs.haptics) Haptic.vibrateOneShot(1, 0.75, 0.5);
        FlxG.sound.play(Paths.sound('confirmMenu'));
        selectedSomething = true;

        group.forEach(function(spr:FlxSprite)
        {
            var flash = spr.ID == categorySelected;

            if (flash) FlxFlicker.flicker(spr, 1.5, 0.04, false);
            else FlxTween.tween(spr, {alpha: 0}, 0.7 + (spr.ID * 0.005), {ease: FlxEase.circOut, type: PERSIST});

            FreeplayState.songCategory = freeplaySave;
        });

        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            MusicBeatState.switchState(new FreeplayState());
        });
    }

    function changeItem(huh:Int = 0, ?playSound:Bool = true, ?allowHaptic:Bool = true)
	{
        if (ClientPrefs.haptics && allowHaptic) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
        if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
        categorySelected += huh;
	
		if (categorySelected > 2)
			categorySelected = 0;
		if (categorySelected < 0)
			categorySelected = 2;

        selectionGroup.forEach(function(spr:FlxSprite)
        {
            FlxTween.cancelTweensOf(spr, ["alpha"]);
            FlxTween.tween(spr, {alpha: (spr.ID == categorySelected) ? 1 : 0.5}, 0.3, {ease: FlxEase.circOut, type: PERSIST});
        });
    }
}