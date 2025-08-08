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

    var borders:FlxSprite;
    var xtraShop:FlxSprite;
    var xtraCrossover:FlxSprite;
    var xtraBonus:FlxSprite;
    var bgGradient:FlxSprite;

    override function create()
    {
        #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Selecting XTRA Freeplay Mode", null);
		#end

        FreeplayState.songCategory = '';

        bgGradient = new FlxSprite(0, 0).loadGraphic(Paths.image('pauseGradient/gradient_Null'));
        bgGradient.color = 0xFF00a800;
        bgGradient.x = 100;
		bgGradient.scale.x = 1.3;
		bgGradient.scale.y = 1.1;
		bgGradient.alpha = 0;
		bgGradient.scrollFactor.set();
		add(bgGradient);
        
        xtraShop = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/XtraShop'));
        xtraShop.x += 135;
        xtraShop.y += 45;
        xtraShop.antialiasing = ClientPrefs.globalAntialiasing;
        xtraShop.updateHitbox();
		add(xtraShop);

        if (ClientPrefs.crossoverUnlocked == false)
            xtraCrossover = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/XtraCrossoverLocked'));
        else if (ClientPrefs.crossoverUnlocked == true)
            xtraCrossover = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/XtraCrossover'));
        xtraCrossover.x += 480;
        xtraCrossover.y += 45;
        xtraCrossover.antialiasing = ClientPrefs.globalAntialiasing;
        xtraCrossover.updateHitbox();
		add(xtraCrossover);

        if (ClientPrefs.xtraBonusUnlocked == false)
            xtraBonus = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/XtraBonusLocked'));
        else
            xtraBonus = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/XtraBonus'));
        xtraBonus.x += 825;
        xtraBonus.y += 45;
        xtraBonus.antialiasing = ClientPrefs.globalAntialiasing;
        xtraBonus.updateHitbox();
		add(xtraBonus);

        textBG = new FlxSprite(0, FlxG.height - 38).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

        Text = new FlxText(textBG.x + 1000, textBG.y + 8, FlxG.width + 1000, "LEFT - A / RIGHT - D / MOUSE: Select Xtra Category | ENTER: Enter Xtra Section | BACKSPACE: Go back to Freeplay Selection Mode", 24);
		Text.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);
		Text.scrollFactor.set();
		add(Text);

        FlxTween.tween(Text, {x: textBG.x - 2500}, 20, {ease: FlxEase.linear, type: LOOPING});
        FlxTween.tween(bgGradient, {alpha: 1}, 3.4, {ease: FlxEase.quartInOut, type: PINGPONG});
        FlxTween.tween(xtraShop, {y: xtraShop.y + 10}, 5, {ease: FlxEase.cubeInOut, type: PINGPONG});
        FlxTween.tween(xtraCrossover, {y: xtraCrossover.y + 10}, 5.03, {ease: FlxEase.cubeInOut, type: PINGPONG});
        FlxTween.tween(xtraBonus, {y: xtraBonus.y + 10}, 5.06, {ease: FlxEase.cubeInOut, type: PINGPONG});

        borders = new FlxSprite(0, 0).loadGraphic(Paths.image('promotion/Borders'));
		borders.antialiasing = ClientPrefs.globalAntialiasing;
		add(borders);

        changeItem();

        super.create();
    }

    var sideSelected:String = '';
    var selectedSomething:Bool = false;
    override function update(elapsed:Float)
    {
        if (!selectedSomething)
        {
            if (controls.BACK || FlxG.mouse.justPressedRight)
		    {
			    //persistentUpdate = false;
			    FlxG.sound.play(Paths.sound('cancelMenu'));
			    MusicBeatState.switchState(new FreeplayCategoryState(), 'stickers');
		    }

            if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A)
		    {
			    FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			    changeItem(-1);	
		    }

		    if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D)
		    {
		    	FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		    	changeItem(1);
		    }

            if (FlxG.mouse.overlaps(xtraShop) && (sideSelected == '' || sideSelected == 'RIGHT' || sideSelected == 'MIDDLE'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'LEFT';
                categorySelected = 0;
		    	changeItem();	
            }
            if (FlxG.mouse.overlaps(xtraCrossover) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'RIGHT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'MIDDLE';
                categorySelected = 1;
                changeItem();	
            }
            if (FlxG.mouse.overlaps(xtraBonus) && (sideSelected == '' || sideSelected == 'MIDDLE' || sideSelected == 'LEFT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'RIGHT';
                categorySelected = 2;
                changeItem();	
            }

            if (categorySelected == 0 && (controls.ACCEPT || (FlxG.mouse.overlaps(xtraShop) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(xtraShop, 1.5, 0.04, false);
                FlxTween.tween(xtraCrossover, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(xtraBonus, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'XTRASHOP';

                FlxG.sound.play(Paths.sound('confirmMenu'));

                selectedSomething = true;

                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    MusicBeatState.switchState(new FreeplayState());
                });
            }

            if (ClientPrefs.crossoverUnlocked == true && categorySelected == 1 && (controls.ACCEPT || (FlxG.mouse.overlaps(xtraCrossover) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(xtraCrossover, 1.5, 0.04, false);
                FlxTween.tween(xtraShop, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(xtraBonus, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'XTRACROSSOVER';
    
                FlxG.sound.play(Paths.sound('confirmMenu'));
    
                selectedSomething = true;
                
                new FlxTimer().start(1, function(tmr:FlxTimer)
                 {
                    MusicBeatState.switchState(new FreeplayState());
                 });
            }
            if (ClientPrefs.crossoverUnlocked == false && categorySelected == 1 && (controls.ACCEPT || (FlxG.mouse.overlaps(xtraCrossover) && FlxG.mouse.justPressed)))
            {
                FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
				FlxG.sound.play(Paths.sound('accessDenied'));
            }

            if (ClientPrefs.xtraBonusUnlocked == true && categorySelected == 2 && (controls.ACCEPT || (FlxG.mouse.overlaps(xtraBonus) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(xtraBonus, 1.5, 0.04, false);
                FlxTween.tween(xtraShop, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(xtraCrossover, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'XTRABONUS';
    
                FlxG.sound.play(Paths.sound('confirmMenu'));
    
                selectedSomething = true;
                
                new FlxTimer().start(1, function(tmr:FlxTimer)
                 {
                    MusicBeatState.switchState(new FreeplayState());
                 });
            }
            if (ClientPrefs.xtraBonusUnlocked == false && categorySelected == 2 && (controls.ACCEPT || (FlxG.mouse.overlaps(xtraBonus) && FlxG.mouse.justPressed)))
            {
                FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
				FlxG.sound.play(Paths.sound('accessDenied'));
            }
        }
        super.update(elapsed);
    }

    function changeItem(huh:Int = 0)
	{
        categorySelected += huh;
	
		if (categorySelected > 2)
			categorySelected = 0;
		if (categorySelected < 0)
			categorySelected = 2;

        if (categorySelected == 0) //Shop
        {
            FlxTween.tween(xtraShop, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});

            FlxTween.tween(xtraCrossover, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});

            FlxTween.tween(xtraBonus, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
        }
        
        if (categorySelected == 1) //Crossover
        {
            FlxTween.tween(xtraShop, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});

            FlxTween.tween(xtraCrossover, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});

            FlxTween.tween(xtraBonus, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
        }

        if (categorySelected == 2) //Bonus
        {
            FlxTween.tween(xtraShop, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});

            FlxTween.tween(xtraCrossover, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});

            FlxTween.tween(xtraBonus, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
        }
    }
}