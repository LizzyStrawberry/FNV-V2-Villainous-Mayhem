package;

import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import Alphabet;

class FreeplayCategoryState extends MusicBeatState
{
    static var categorySelected:Int = 0;
    static var subCatSelected:Int = 0;
    public static var freeplayName:String = '';

    var textBG:FlxSprite;
    var Text:FlxText;

    var selectionArray:Array<Array<Dynamic>> = [ // X, Y, type, isUnlocked
        [0, 0, "Main", true],
        [645, 0, "Bonus", ClientPrefs.bonusUnlocked],
        [0, 360, "Xtra", ClientPrefs.xtraUnlocked]
    ];
    var selectionGroup:FlxTypedGroup<FlxSprite>;

    var weekArray:Array<Array<Dynamic>> = [ // X, Y, Week Number, ClientPrefs Property To Check, String to save
        [135, 845, 1, true, "MAIN"],
        [475, 845, 2, ClientPrefs.nunWeekPlayed, "NUNS"],
        [825, 845, 3, ClientPrefs.kianaWeekPlayed, "DEMONS"],
        [0, 845, 4, ClientPrefs.dsideWeekFound, "DSIDES"],
        [320, 845, 5, ClientPrefs.legacyWeekFound, "LEGACY"],
        [640, 845, 6, ClientPrefs.morkyWeekFound, "MORK"],
        [960, 845, 7, ClientPrefs.susWeekFound, "SUS"]
    ];
    var weekGroup:FlxTypedGroup<FlxSprite>;

    override function create()
    {
        freeplayName = '';

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Selecting Freeplay Mode", null);
		#end

        var bgGradient:FlxSprite = new FlxSprite().loadGraphic(Paths.image('pauseGradient/gradient_Null'));
        bgGradient.color = 0xFF00a800;
        bgGradient.setGraphicSize(FlxG.width, FlxG.height);
        bgGradient.screenCenter(X);
		bgGradient.alpha = 0;
		add(bgGradient);
        FlxTween.tween(bgGradient, {alpha: 1}, 3.4, {ease: FlxEase.quartInOut, type: PINGPONG});

        var assetLocation:String = "freeplayStuff/categories";

        selectionGroup = new FlxTypedGroup<FlxSprite>();
        add(selectionGroup);
        for (i in 0...selectionArray.length)
        {
            var x = selectionArray[i][0]; var y = selectionArray[i][1];
            var typeOfSel = selectionArray[i][2]; var isUnlocked = selectionArray[i][3];

            var selection = new FlxSprite(x, y).loadGraphic(Paths.image('$assetLocation/$typeOfSel' + ((!isUnlocked) ? "Locked" : "")));
            selection.ID = i;
            selection.updateHitbox();
            selection.antialiasing = ClientPrefs.globalAntialiasing;
            selectionGroup.add(selection);

            // Adjust hitboxes
            switch (typeOfSel.toLowerCase())
            {
                case "main", "bonus":
                    // Shrink the hitbox height to not overlap with the xtra sprite
                    selection.setSize(selection.width, selection.height - 300); 
                    selection.offset.set(0, 0); // keep it anchored at the top
            }

            FlxTween.tween(selection, {y: selection.y + 5}, 5 + (i * 0.025), {ease: FlxEase.cubeInOut, type: PINGPONG});
        }

        weekGroup = new FlxTypedGroup<FlxSprite>();
        add(weekGroup);

        for (i in 0...weekArray.length)
        {
            var x = weekArray[i][0]; var y = weekArray[i][1];
            var weekNum = weekArray[i][2]; var isUnlocked = weekArray[i][3];
            
            var weekAsset:FlxSprite = new FlxSprite(x, y).loadGraphic(Paths.image('$assetLocation/week' + ((!isUnlocked) ? "Locked" : weekNum)));
            weekAsset.ID = i + 1; // Start from 1
            weekAsset.antialiasing = ClientPrefs.globalAntialiasing;
            weekAsset.updateHitbox();
    		weekGroup.add(weekAsset);
        }

        textBG = new FlxSprite(0, FlxG.height - 38).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

        Text = new FlxText(textBG.x + 1000, textBG.y + 8, FlxG.width + 1000, "LEFT - A / RIGHT - D / MOUSE: Select Freeplay Category | ENTER: Enter Freeplay Section | BACKSPACE: Go back to the Main Menu", 24);
		Text.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);
		Text.scrollFactor.set();
		add(Text);

        FlxTween.tween(Text, {x: textBG.x - 2500}, 20, {ease: FlxEase.linear, type: LOOPING});
        changeItem(0, false);

        super.create();
    }

    var selectedSomething:Bool = false;
    var mouseMode:Bool = false;
    var locatedSprite:Bool = false;
    override function update(elapsed:Float)
    {
        if (!selectedSomething)
        {
            if (controls.BACK || FlxG.mouse.justPressedRight)
            {
                if (freeplayName != "")
                {
                    freeplayName = "";
                    selectionGroup.forEach(function(spr:FlxSprite)
                    {
                        FlxTween.cancelTweensOf(spr, ["alpha"]);
                        FlxTween.tween(spr, {alpha: (spr.ID == categorySelected) ? 1 : 0.5}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                    });
                    weekGroup.forEach(function(week:FlxSprite)
                    {
                        FlxTween.cancelTweensOf(week);
                        FlxTween.tween(week, {y: 845}, 0.5 + (week.ID * 0.01), {ease: FlxEase.circOut, type: PERSIST});
                    });
                }
                else
                {
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    MusicBeatState.switchState(new MainMenuState(), 'stickers');
                }
            }

            if (controls.UI_LEFT_P) changeItem(-1);	
   		    if (controls.UI_RIGHT_P) changeItem(1);
            mouseMode = (FlxG.mouse.justMoved) ? true : false;
            var found:Bool = false;

            if (freeplayName == "")
            {
                selectionGroup.forEach(function(spr:FlxSprite)
                {
                    if (found) return;

                    if (FlxG.mouse.overlaps(spr) && mouseMode)
                    {
                        if (categorySelected != spr.ID) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                        categorySelected = spr.ID; 
                        changeItem(0, false);
                        found = true;
                    }

                    var accepted = controls.ACCEPT || (FlxG.mouse.overlaps(spr) && FlxG.mouse.justPressed);
                    if (accepted && spr.ID == categorySelected)
                    {
                        var selectionName = selectionArray[spr.ID][2].toLowerCase();
                        var isUnlocked = selectionArray[spr.ID][3];
                        var hasSub = selectionName != "xtra";
                        // If unlocked, then move on
                        if (isUnlocked)
                        {
                            if (hasSub) 
                            {
                                var weekToSelect = (selectionName == "main") ? 3 : 4;
                                openWeekSubcat(weekToSelect, selectionName.toUpperCase(), (weekToSelect == 3) ? true : false);
                            }
                            else acceptCategory(selectionGroup, false); // We're not in a sub-category!
                        }
                        else
                        {
                            FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
                            FlxG.sound.play(Paths.sound('accessDenied'));  
                        }
                    }
                });
            }
            else
            {
                weekGroup.forEach(function(week:FlxSprite)
                {
                    if (FlxG.mouse.overlaps(week) && mouseMode)
                    {
                        if (subCatSelected != week.ID) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                        subCatSelected = week.ID;
                        changeItem(0, false);
                    }

                    var accepted = controls.ACCEPT || (FlxG.mouse.overlaps(week) && FlxG.mouse.justPressed);
                    
                    if (accepted && week.ID == subCatSelected)
                    {
                        var isUnlocked = weekArray[week.ID - 1][3];

                        // If unlocked, then move on
                        if (isUnlocked) acceptCategory(weekGroup, true, weekArray[week.ID - 1][4]);
                        else
                        {
                            FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
                            FlxG.sound.play(Paths.sound('accessDenied'));  
                        }
                    }
                });
            }
        }
        super.update(elapsed);
    }

    function openWeekSubcat(lastWeekNum:Int, freeplayType:String, lower:Bool)
    {
        FlxG.sound.play(Paths.sound('confirmMenu'));
        selectionGroup.forEach(function(spr:FlxSprite)
        {
            FlxTween.cancelTweensOf(spr, ["alpha"]);
            FlxTween.tween(spr, {alpha: 0}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
        });
        freeplayName = freeplayType;

        weekGroup.forEach(function(week:FlxSprite)
        {
            var check = (lower) ? week.ID <= lastWeekNum : week.ID >= lastWeekNum; 
            if (check)
            {
                FlxTween.cancelTweensOf(week);
                var ocacity:Float = (week.ID == subCatSelected) ? 1 : 0.5;
                var dur:Float = 0.5 + (week.ID * 0.025);
                    
                FlxTween.tween(week, {alpha: ocacity}, dur, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week, {y: 45}, dur, {ease: FlxEase.circOut, type: PERSIST});
            }            
        });
    }

    function acceptCategory(group:FlxTypedGroup<FlxSprite>, isSub:Bool, ?freeplaySave:String = null)
    {
        FlxG.sound.play(Paths.sound('confirmMenu'));
        selectedSomething = true;

        group.forEach(function(spr:FlxSprite)
        {
            var flash = (!isSub && spr.ID == categorySelected) || (isSub && spr.ID == subCatSelected);

            if (flash) FlxFlicker.flicker(spr, 1.5, 0.04, false);
            else FlxTween.tween(spr, {alpha: 0}, 0.7 + (spr.ID * 0.005), {ease: FlxEase.circOut, type: PERSIST});

            if (freeplaySave != null) FreeplayState.songCategory = freeplaySave;
        });

        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            if (isSub) MusicBeatState.switchState(new FreeplayState());
            else MusicBeatState.switchState(new FreeplayCategoryXtraState(), "stickers");
        });
    }

    function changeItem(huh:Int = 0, ?playSound:Bool = true)
	{
        if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
        
        if (freeplayName != "") // You're in a sub-category
        {
            subCatSelected += huh;

            if (freeplayName == "MAIN")
            {
                if (subCatSelected > 3) subCatSelected = 1;
                if (subCatSelected < 1) subCatSelected = 3;
            }
            else
            {
                if (subCatSelected > 7) subCatSelected = 4;
                if (subCatSelected < 4) subCatSelected = 7;
            }

            //trace("Current Week: " + subCatSelected);

            weekGroup.forEach(function(week:FlxSprite)
            {
                FlxTween.cancelTweensOf(week, ["alpha"]);
                FlxTween.tween(week, {alpha: (week.ID == subCatSelected) ? 1 : 0.5}, 0.3, {ease: FlxEase.circOut, type: PERSIST});
            });
        }
        else
        {
            categorySelected += huh;

            if (categorySelected > 2) categorySelected = 0;
            if (categorySelected < 0) categorySelected = 2;

            //trace("Current Category: " + categorySelected);

            selectionGroup.forEach(function(spr:FlxSprite)
            {
                FlxTween.cancelTweensOf(spr, ["alpha"]);
                FlxTween.tween(spr, {alpha: (spr.ID == categorySelected) ? 1 : 0.5}, 0.3, {ease: FlxEase.circOut, type: PERSIST});
            });
        }
    }
}