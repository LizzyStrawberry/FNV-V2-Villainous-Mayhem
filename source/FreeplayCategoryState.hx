package;

import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import Alphabet;

class FreeplayCategoryState extends MusicBeatState
{
    public static var categorySelected:Int = 0;
    public static var freeplayName:String = '';

    var textBG:FlxSprite;
    var Text:FlxText;

    var bgGradient:FlxSprite;
    var firstSpriteSelection:FlxSprite;
    var secondSpriteSelection:FlxSprite;
    var thirdSpriteSelection:FlxSprite;
    var week1:FlxSprite;
    var week2:FlxSprite;
    var week3:FlxSprite;
    var week4:FlxSprite;
    var week5:FlxSprite;
    var week6:FlxSprite;
    var week7:FlxSprite;

    override function create()
    {
        #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Selecting Freeplay Mode", null);
		#end

        freeplayName = '';

        bgGradient = new FlxSprite(0, 0).loadGraphic(Paths.image('pauseGradient/gradient_Null'));
        bgGradient.color = 0xFF00a800;
        bgGradient.setGraphicSize(FlxG.width, FlxG.height);
        bgGradient.screenCenter(X);
		bgGradient.alpha = 0;
		bgGradient.scrollFactor.set();
		add(bgGradient);

        firstSpriteSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/Main'));
        firstSpriteSelection.antialiasing = ClientPrefs.globalAntialiasing;
        firstSpriteSelection.updateHitbox();
		add(firstSpriteSelection);

        if (!ClientPrefs.bonusUnlocked)
            secondSpriteSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/BonusLocked'));
        else
            secondSpriteSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/Bonus'));
        secondSpriteSelection.x += 645;
        secondSpriteSelection.antialiasing = ClientPrefs.globalAntialiasing;
        secondSpriteSelection.updateHitbox();
		add(secondSpriteSelection);

        if (!ClientPrefs.xtraUnlocked)
            thirdSpriteSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/XtraLocked'));
        else
            thirdSpriteSelection = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/Xtra'));
        thirdSpriteSelection.y += 360;
        thirdSpriteSelection.antialiasing = ClientPrefs.globalAntialiasing;
        thirdSpriteSelection.updateHitbox();
		add(thirdSpriteSelection);

        firstSpriteSelection.x = MobileUtil.fixX(firstSpriteSelection.x);
        secondSpriteSelection.x = MobileUtil.fixX(secondSpriteSelection.x);
        thirdSpriteSelection.x = MobileUtil.fixX(thirdSpriteSelection.x);

        week1 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/week1'));
        week1.x += 135;
        //week1.y += 45;
        week1.y += 845;
        week1.antialiasing = ClientPrefs.globalAntialiasing;
        week1.updateHitbox();
		add(week1);

        if (!ClientPrefs.nunWeekFound)
            week2 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/weekLocked'));
        else
            week2 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/week2'));
        week2.x += 475;
        week2.y += 845;
        week2.antialiasing = ClientPrefs.globalAntialiasing;
        week2.updateHitbox();
		add(week2);

        if (!ClientPrefs.kianaWeekFound)
            week3 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/weekLocked'));
        else
            week3 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/week3'));
        week3.x += 825;
        week3.y += 845;
        week3.antialiasing = ClientPrefs.globalAntialiasing;
        week3.updateHitbox();
		add(week3);

        if (!ClientPrefs.dsideWeekFound)
            week4 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/weekLocked'));
        else
            week4 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/week4'));
        week4.y += 845;
        week4.antialiasing = ClientPrefs.globalAntialiasing;
        week4.updateHitbox();
		add(week4);

        if (!ClientPrefs.legacyWeekFound)
            week5 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/weekLocked'));
        else
            week5 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/week5'));
        week5.x += 320;
        week5.y += 845;
        week5.antialiasing = ClientPrefs.globalAntialiasing;
        week5.updateHitbox();
		add(week5);

        if (!ClientPrefs.morkyWeekFound)
            week6 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/weekLocked'));
        else
            week6 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/week6'));
        week6.x += 640;
        week6.y += 845;
        week6.antialiasing = ClientPrefs.globalAntialiasing;
        week6.updateHitbox();
		add(week6);

        if (!ClientPrefs.susWeekFound)
            week7 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/weekLocked'));
        else
            week7 = new FlxSprite().loadGraphic(Paths.image('freeplayStuff/categories/week7'));
        week7.x += 960;
        week7.y += 845;
        week7.antialiasing = ClientPrefs.globalAntialiasing;
        week7.updateHitbox();
		add(week7);

        week1.x = MobileUtil.fixX(week1.x);
        week2.x = MobileUtil.fixX(week2.x);
        week3.x = MobileUtil.fixX(week3.x);
        week4.x = MobileUtil.fixX(week4.x);
        week5.x = MobileUtil.fixX(week5.x);
        week6.x = MobileUtil.fixX(week6.x);
        week7.x = MobileUtil.fixX(week7.x);

        textBG = new FlxSprite(0, FlxG.height - 38).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

        Text = new FlxText(textBG.x + 1000, textBG.y + 8, FlxG.width + 1000, "LEFT - A / RIGHT - D / MOUSE: Select Freeplay Category | ENTER: Enter Freeplay Section | BACKSPACE: Go back to the Main Menu", 24);
		Text.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);
		Text.scrollFactor.set();
		add(Text);

        FlxTween.tween(Text, {x: textBG.x - 2500}, 20, {ease: FlxEase.linear, type: LOOPING});

        FlxTween.tween(bgGradient, {alpha: 1}, 3.4, {ease: FlxEase.quartInOut, type: PINGPONG});
        FlxTween.tween(firstSpriteSelection, {y: firstSpriteSelection.y + 7}, 5, {ease: FlxEase.cubeInOut, type: PINGPONG});
        FlxTween.tween(secondSpriteSelection, {y: secondSpriteSelection.y + 7}, 5.01, {ease: FlxEase.cubeInOut, type: PINGPONG});
        FlxTween.tween(thirdSpriteSelection, {y: thirdSpriteSelection.y + 7}, 5.02, {ease: FlxEase.cubeInOut, type: PINGPONG});

        changeItem();

        super.create();
    }

    var changin:Bool = false;
    var sideSelected:String = '';

    var selectedSomething:Bool = false;
    var selectedMainSomething:Bool = false;
    var selectedBonusSomething:Bool = false;
    override function update(elapsed:Float)
    {
        if (!changin)
        {
            if (controls.BACK || FlxG.mouse.justPressedRight)
            {
                if (selectedSomething && (!selectedMainSomething) && freeplayName == "MAIN")
                {
                    selectedMainSomething = true;
                    sideSelected = '';
                    FlxTween.tween(firstSpriteSelection, {alpha: 1}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(secondSpriteSelection, {alpha: 1}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(thirdSpriteSelection, {alpha: 1}, 0.5, {ease: FlxEase.circOut, type: PERSIST});

                    FlxTween.tween(week1, {y: 845}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(week2, {y: 845}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(week3, {y: 845}, 0.5, {ease: FlxEase.circOut, type: PERSIST});

                    new FlxTimer().start(0.5, function(tmr:FlxTimer)
                    {
                        selectedMainSomething = false;
                        selectedSomething = false;
                        changeItem();	
                    });
                }
                else if (selectedSomething && (!selectedBonusSomething) && freeplayName == "BONUS")
                    {
                        selectedBonusSomething = true;
                        sideSelected = '';
                        FlxTween.tween(firstSpriteSelection, {alpha: 1}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                        FlxTween.tween(secondSpriteSelection, {alpha: 1}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                        FlxTween.tween(thirdSpriteSelection, {alpha: 1}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
    
                        FlxTween.tween(week4, {y: 845}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                        FlxTween.tween(week5, {y: 845}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                        FlxTween.tween(week6, {y: 845}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                        FlxTween.tween(week7, {y: 845}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
    
                        new FlxTimer().start(0.5, function(tmr:FlxTimer)
                        {
                            selectedBonusSomething = false;
                            selectedSomething = false;
                            changeItem();	
                        });
                    }
                else if ((!selectedSomething) && (!selectedMainSomething) && (!selectedBonusSomething))
                {
                    FlxG.sound.play(Paths.sound('cancelMenu'));
                    MusicBeatState.switchState(new MainMenuState(), 'stickers');
                }
            }
        }

        if ((!selectedSomething) && (!selectedMainSomething) && (!selectedBonusSomething))
        {
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

            if (FlxG.mouse.overlaps(firstSpriteSelection) && !FlxG.mouse.overlaps(thirdSpriteSelection) && (sideSelected == '' || sideSelected == 'RIGHT' || sideSelected == 'DOWN'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'LEFT';
                categorySelected = 0;
		    	changeItem();	
            }
            if (FlxG.mouse.overlaps(secondSpriteSelection) && !FlxG.mouse.overlaps(thirdSpriteSelection) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'DOWN'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'RIGHT';
                categorySelected = 1;
                changeItem();	
            }
            //Extra work for Xtra
            if (FlxG.mouse.overlaps(thirdSpriteSelection) && FlxG.mouse.overlaps(firstSpriteSelection) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'RIGHT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'DOWN';
                categorySelected = 2;
                changeItem();	
            }
            else if (FlxG.mouse.overlaps(thirdSpriteSelection) && FlxG.mouse.overlaps(secondSpriteSelection) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'RIGHT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'DOWN';
                categorySelected = 2;
                changeItem();	
            }
            else if (FlxG.mouse.overlaps(thirdSpriteSelection) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'RIGHT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'DOWN';
                categorySelected = 2;
                changeItem();	
            }

            if (categorySelected == 0 && (controls.ACCEPT || (FlxG.mouse.overlaps(firstSpriteSelection) && FlxG.mouse.justPressed)))
            {
                FlxTween.tween(firstSpriteSelection, {alpha: 0}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(secondSpriteSelection, {alpha: 0}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(thirdSpriteSelection, {alpha: 0}, 0.5, {ease: FlxEase.circOut, type: PERSIST});

                FlxTween.tween(week1, {y: 45}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week2, {y: 45}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week3, {y: 45}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                freeplayName = 'MAIN';

                FlxG.sound.play(Paths.sound('confirmMenu'));

                selectedSomething = true;
                selectedMainSomething = true;
                changin = true;

                new FlxTimer().start(0.5, function(tmr:FlxTimer)
                {
                    changeItem();
                    changin = false;
                    selectedMainSomething = false;
                });
            }

            if (ClientPrefs.bonusUnlocked == true && categorySelected == 1 && (controls.ACCEPT || (FlxG.mouse.overlaps(secondSpriteSelection) && FlxG.mouse.justPressed)))
            {
                FlxTween.tween(firstSpriteSelection, {alpha: 0}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(secondSpriteSelection, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(thirdSpriteSelection, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

                FlxTween.tween(week4, {y: 45}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week5, {y: 45}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week6, {y: 45}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week7, {y: 45}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
                freeplayName = 'BONUS';
    
                FlxG.sound.play(Paths.sound('confirmMenu'));
    
                selectedSomething = true;
                selectedBonusSomething = true;
                changin = true;
                
                new FlxTimer().start(0.5, function(tmr:FlxTimer)
                {
                    changeItem();
                    changin = false;
                    selectedBonusSomething = false;
                });
            }
            if (ClientPrefs.bonusUnlocked == false && categorySelected == 1 && (controls.ACCEPT || (FlxG.mouse.overlaps(secondSpriteSelection) && FlxG.mouse.justPressed)))
            {
                FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
				FlxG.sound.play(Paths.sound('accessDenied'));
            }

            if (ClientPrefs.xtraUnlocked == true && categorySelected == 2 && (controls.ACCEPT || (FlxG.mouse.overlaps(thirdSpriteSelection) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(thirdSpriteSelection, 1.5, 0.04, false);
                FlxTween.tween(firstSpriteSelection, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(secondSpriteSelection, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                freeplayName = 'XTRA';
    
                FlxG.sound.play(Paths.sound('confirmMenu'));
    
                selectedSomething = true;
                    
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    MusicBeatState.switchState(new FreeplayCategoryXtraState(), 'stickers');
                });
            }
            if (ClientPrefs.xtraUnlocked == false && categorySelected == 2 && (controls.ACCEPT || (FlxG.mouse.overlaps(thirdSpriteSelection) && FlxG.mouse.justPressed)))
            {
                FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
				FlxG.sound.play(Paths.sound('accessDenied'));
            }
        }

        if (selectedSomething && (!selectedMainSomething) && freeplayName == "MAIN")
        {
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
    
            if (FlxG.mouse.overlaps(week1) && (sideSelected == '' || sideSelected == 'RIGHT' || sideSelected == 'MIDDLE'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'LEFT';
                categorySelected = 0;
                changeItem();	
            }
            if (FlxG.mouse.overlaps(week2) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'RIGHT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'MIDDLE';
                categorySelected = 1;
                changeItem();	
            }
            if (FlxG.mouse.overlaps(week3) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'MIDDLE'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'RIGHT';
                categorySelected = 2;
                changeItem();	
            }
    
            if (categorySelected == 0 && (controls.ACCEPT || (FlxG.mouse.overlaps(week1) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(week1, 1.5, 0.04, false);
                FlxTween.tween(week2, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week3, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'MAIN';
    
                FlxG.sound.play(Paths.sound('confirmMenu'));
    
                    selectedMainSomething = true;
    
                    new FlxTimer().start(1, function(tmr:FlxTimer)
                    {
                        MusicBeatState.switchState(new FreeplayState());
                    });
                }
    
            if (ClientPrefs.nunWeekFound == true && categorySelected == 1 && (controls.ACCEPT || (FlxG.mouse.overlaps(week2) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(week2, 1.5, 0.04, false);
                FlxTween.tween(week1, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week3, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'NUNS';

                FlxG.sound.play(Paths.sound('confirmMenu'));
    
                selectedMainSomething = true;
                    
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    MusicBeatState.switchState(new FreeplayState());
                });
            }
            if (ClientPrefs.nunWeekFound == false && categorySelected == 1 && (controls.ACCEPT || (FlxG.mouse.overlaps(week2) && FlxG.mouse.justPressed)))
            {
                FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
                FlxG.sound.play(Paths.sound('accessDenied'));
            }
    
            if (ClientPrefs.kianaWeekFound == true && categorySelected == 2 && (controls.ACCEPT || (FlxG.mouse.overlaps(week3) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(week3, 1.5, 0.04, false);
                FlxTween.tween(week1, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week2, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'DEMONS';

                FlxG.sound.play(Paths.sound('confirmMenu'));
        
                selectedMainSomething = true;
                        
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    MusicBeatState.switchState(new FreeplayState());
                });
            }
            if (ClientPrefs.kianaWeekFound == false && categorySelected == 2 && (controls.ACCEPT || (FlxG.mouse.overlaps(week3) && FlxG.mouse.justPressed)))
            {
                FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
                FlxG.sound.play(Paths.sound('accessDenied'));
             }
        }

        if (selectedSomething && (!selectedBonusSomething) && freeplayName == "BONUS")
        {
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
    
            if (FlxG.mouse.overlaps(week4) && (sideSelected == '' || sideSelected == 'RIGHT' || sideSelected == 'MIDDLELEFT' || sideSelected == 'MIDDLERIGHT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'LEFT';
                categorySelected = 0;
                changeItem();	
            }
            if (FlxG.mouse.overlaps(week5) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'RIGHT' || sideSelected == 'MIDDLERIGHT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'MIDDLELEFT';
                categorySelected = 1;
                changeItem();	
            }
            if (FlxG.mouse.overlaps(week6) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'MIDDLELEFT' || sideSelected == 'RIGHT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'MIDDLERIGHT';
                categorySelected = 2;
                changeItem();	
            }
            if (FlxG.mouse.overlaps(week7) && (sideSelected == '' || sideSelected == 'LEFT' || sideSelected == 'MIDDLELEFT' || sideSelected == 'MIDDLERIGHT'))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                sideSelected = 'RIGHT';
                categorySelected = 3;
                changeItem();	
            }
    
            if (ClientPrefs.dsideWeekFound == true && categorySelected == 0 && (controls.ACCEPT || (FlxG.mouse.overlaps(week4) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(week4, 1.5, 0.04, false);
                FlxTween.tween(week5, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week6, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week7, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'DSIDES';
    
                FlxG.sound.play(Paths.sound('confirmMenu'));
    
                selectedBonusSomething = true;
    
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    MusicBeatState.switchState(new FreeplayState());
                });
            }
            if (ClientPrefs.dsideWeekFound == false && categorySelected == 0 && (controls.ACCEPT || (FlxG.mouse.overlaps(week4) && FlxG.mouse.justPressed)))
            {
                FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
                FlxG.sound.play(Paths.sound('accessDenied'));
            }
    
            if (ClientPrefs.legacyWeekFound == true && categorySelected == 1 && (controls.ACCEPT || (FlxG.mouse.overlaps(week5) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(week5, 1.5, 0.04, false);
                FlxTween.tween(week4, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week6, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week7, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'LEGACY';

                FlxG.sound.play(Paths.sound('confirmMenu'));
    
                selectedBonusSomething = true;
                    
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    MusicBeatState.switchState(new FreeplayState());
                });
            }
            if (ClientPrefs.legacyWeekFound == false && categorySelected == 1 && (controls.ACCEPT || (FlxG.mouse.overlaps(week5) && FlxG.mouse.justPressed)))
            {
                FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
                FlxG.sound.play(Paths.sound('accessDenied'));
            }
    
            if (ClientPrefs.morkyWeekFound == true && categorySelected == 2 && (controls.ACCEPT || (FlxG.mouse.overlaps(week6) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(week6, 1.5, 0.04, false);
                FlxTween.tween(week4, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week5, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week7, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'MORK';

                FlxG.sound.play(Paths.sound('confirmMenu'));
        
                selectedBonusSomething = true;
                        
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    MusicBeatState.switchState(new FreeplayState());
                });
            }
            if (ClientPrefs.susWeekFound == false && categorySelected == 2 && (controls.ACCEPT || (FlxG.mouse.overlaps(week6) && FlxG.mouse.justPressed)))
            {
                FlxG.camera.shake(0.007, 0.2, null, false, FlxAxes.XY);
                FlxG.sound.play(Paths.sound('accessDenied'));
            }

            if (ClientPrefs.susWeekFound == true && categorySelected == 3 && (controls.ACCEPT || (FlxG.mouse.overlaps(week7) && FlxG.mouse.justPressed)))
            {
                FlxFlicker.flicker(week7, 1.5, 0.04, false);
                FlxTween.tween(week4, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week5, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week6, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
                FreeplayState.songCategory = 'SUS';

                FlxG.sound.play(Paths.sound('confirmMenu'));
        
                selectedBonusSomething = true;
                        
                new FlxTimer().start(1, function(tmr:FlxTimer)
                {
                    MusicBeatState.switchState(new FreeplayState());
                });
            }
            if (ClientPrefs.susWeekFound == false && categorySelected == 3 && (controls.ACCEPT || (FlxG.mouse.overlaps(week7) && FlxG.mouse.justPressed)))
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

        if ((!selectedSomething) && (!selectedMainSomething) && (!selectedBonusSomething))
        {
            if (categorySelected > 2)
                categorySelected = 0;
            if (categorySelected < 0)
                categorySelected = 2;

            if (categorySelected == 0) //Main
            {
                FlxTween.tween(firstSpriteSelection, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
    
                FlxTween.tween(secondSpriteSelection, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(thirdSpriteSelection, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }
            
            if (categorySelected == 1) //Bonus
            {
                FlxTween.tween(firstSpriteSelection, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
    
                FlxTween.tween(secondSpriteSelection, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(thirdSpriteSelection, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }
    
            if (categorySelected == 2) //Xtra
            {
                FlxTween.tween(firstSpriteSelection, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
        
                FlxTween.tween(thirdSpriteSelection, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(secondSpriteSelection, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }
        }

        if (selectedSomething && (!selectedMainSomething) && freeplayName == "MAIN") //Inside Main Week Category
        {
            if (categorySelected > 2)
                categorySelected = 0;
            if (categorySelected < 0)
                categorySelected = 2;

            if (categorySelected == 0) //Week1
            {
                FlxTween.tween(week1, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
        
                FlxTween.tween(week2, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week3, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }
                
            if (categorySelected == 1) //Week2
            {
                FlxTween.tween(week1, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
        
                FlxTween.tween(week2, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week3, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }
        
            if (categorySelected == 2) //Week3
            {
                FlxTween.tween(week1, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            
                FlxTween.tween(week2, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week3, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }
        }

        if (selectedSomething && (!selectedBonusSomething) && freeplayName == "BONUS") //Inside Bonus Week Category
        {
            if (categorySelected > 3)
                categorySelected = 0;
            if (categorySelected < 0)
                categorySelected = 3;

            if (categorySelected == 0) //Week4
            {
                FlxTween.tween(week4, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
        
                FlxTween.tween(week5, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week6, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week7, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }
                
            if (categorySelected == 1) //Week5
            {
                FlxTween.tween(week4, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
        
                FlxTween.tween(week5, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week6, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week7, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }
        
            if (categorySelected == 2) //Week6
            {
                FlxTween.tween(week4, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            
                FlxTween.tween(week5, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week6, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week7, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }

            if (categorySelected == 3) //Week7
            {
                FlxTween.tween(week4, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            
                FlxTween.tween(week5, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week6, {alpha: 0.4}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(week7, {alpha: 1}, 0.4, {ease: FlxEase.circOut, type: PERSIST});
            }
        }
    }
}