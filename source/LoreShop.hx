package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.math.FlxRandom;
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
import flixel.FlxCamera;
import Achievements;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

import flash.system.System;

class LoreShop extends MusicBeatState
{
	private var camAchievement:FlxCamera;
    
	//Cellar Shop
    var shopTitle:Alphabet;
	var hermit:FlxSprite;
	var cellarLights:FlxSprite;
	var prizeEgg:FlxSprite;
    var blackOut:FlxSprite;
    var secondBlackOut:FlxSprite;
    var thirdBlackOut:FlxSprite;

	var dialogueNumberCellar:Int = 0;
	var dialogueTextCellar:FlxText;
	var cellarMerchantDialogue:FlxTypeText;

	var cellarOption:FlxSprite;

	var galleryIcon:FlxSprite;
	var loreScrollsIcon:FlxSprite;
    var checkMark:FlxSprite;
    var checkMarkLore:FlxSprite;

    var eggCounter:FlxText;
    var galleryItemCost:FlxText;
    var galleryItemInfo:FlxText;
    var scrollItemCost:FlxText;
    var scrollItemInfo:FlxText;

    var scrolls:Array<String> =[];

    var galleryTitle:Alphabet;
    var chests:FlxTypedGroup<FlxSprite>;
    var categoryPrices:FlxTypedGroup<FlxText>;
    var animChest:FlxSprite;
    var achievementText:FlxText;
    var achievementTextInfo:FlxText;
    var lightSpin:FlxSprite;
    override function create()
    {
        //Initialize scrolls array
        scrollsArrayUpdate(); 

        //Music
        FlxG.sound.playMusic(Paths.music('cellarShop'), 0);
		FlxG.sound.music.fadeIn(3.0);  

        // Cellar Shop
		hermit = new FlxSprite(400, 80).loadGraphic(Paths.image('shop/hermit'));//put your cords and image here
		hermit.frames = Paths.getSparrowAtlas('shop/hermit');//here put the name of the xml
		hermit.scale.x = 0.85;
        hermit.scale.y = 0.85;
		hermit.animation.addByPrefix('idle', 'hermit idle0', 24, true);//on 'idle normal' change it to your xml one
		hermit.animation.addByPrefix('intro', 'hermit intro0', 24, false);
		hermit.animation.addByPrefix('exit', 'hermit exit0', 24, false);
		hermit.animation.addByPrefix('give', 'hermit give0', 24, false);
		hermit.animation.play('idle');//you can rename the anim however you want to
		hermit.offset.set(-5, 0);
		hermit.scrollFactor.set();
		hermit.updateHitbox();
		hermit.alpha = 0;
		hermit.antialiasing = ClientPrefs.globalAntialiasing;
		add(hermit);

		cellarLights = new FlxSprite(-40, 300).loadGraphic(Paths.image('shop/hermitBG'));
		cellarLights.frames = Paths.getSparrowAtlas('shop/hermitBG');
		cellarLights.animation.addByPrefix('idle', 'bg0', 24, true);
		cellarLights.animation.play('idle');
		cellarLights.scrollFactor.set();
		cellarLights.updateHitbox();
		cellarLights.alpha = 0;
		cellarLights.antialiasing = ClientPrefs.globalAntialiasing;
		add(cellarLights);

		dialogueTextCellar = new FlxText(0, 0, FlxG.width, "", 32);

		cellarMerchantDialogue = new FlxTypeText(340, 0, 600, "Greetings, fellow traveler.", 32, true);
		cellarMerchantDialogue.font = 'VCR OSD Mono';
		cellarMerchantDialogue.color = FlxColor.WHITE;
        cellarMerchantDialogue.alignment = CENTER;
		cellarMerchantDialogue.setTypingVariation(0.55, true);
		cellarMerchantDialogue.sounds = [FlxG.sound.load(Paths.sound('shopDialogue'), 0.4)];
		add(cellarMerchantDialogue);

		cellarOption = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/cellarOption'));
		cellarOption.antialiasing = ClientPrefs.globalAntialiasing;
		cellarOption.screenCenter();
		cellarOption.x += 160;
		cellarOption.y += 320;
		cellarOption.scale.set(0.4, 0.4);
		cellarOption.updateHitbox();
		add(cellarOption);

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 0;
		add(blackOut);

        shopTitle = new Alphabet(400, 10, "Cellar Shop", true);
		shopTitle.alpha = 0;
		add(shopTitle);

		galleryIcon = new FlxSprite(0, 250).loadGraphic(Paths.image('shop/galleryIcon'));
		galleryIcon.screenCenter(X);
		galleryIcon.x -= 300;
		galleryIcon.antialiasing = ClientPrefs.globalAntialiasing;
        galleryIcon.alpha = 0;
		add(galleryIcon);

        galleryItemCost = new FlxText(galleryIcon.x - 450, galleryIcon.y + 250, FlxG.width, "Chests Available", 36);
		galleryItemCost.setFormat("VCR OSD Mono", 36, 0xFFFFFFFF, CENTER);
		galleryItemCost.alpha = 0;
		add(galleryItemCost);

        galleryItemInfo = new FlxText(galleryItemCost.x, galleryItemCost.y - 300, FlxG.width, "Gallery", 36);
		galleryItemInfo.setFormat("VCR OSD Mono", 36, 0xFFFFFFFF, CENTER);
		galleryItemInfo.alpha = 0;
		add(galleryItemInfo);

        loreScrollsIcon = new FlxSprite(0, 250).loadGraphic(Paths.image('shop/loreScrollsIcon'));
		loreScrollsIcon.screenCenter(X);
		loreScrollsIcon.x += 300;
		loreScrollsIcon.antialiasing = ClientPrefs.globalAntialiasing;
        loreScrollsIcon.alpha = 0;
		add(loreScrollsIcon);

        scrollItemCost = new FlxText(loreScrollsIcon.x - 450, loreScrollsIcon.y + 250, FlxG.width, "Cost: 5 Eggs", 36);
		scrollItemCost.setFormat("VCR OSD Mono", 36, 0xFFFFFFFF, CENTER);
		scrollItemCost.alpha = 0;
		add(scrollItemCost);

        scrollItemInfo = new FlxText(scrollItemCost.x, scrollItemCost.y - 300, FlxG.width, "Lore Scroll", 36);
		scrollItemInfo.setFormat("VCR OSD Mono", 36, 0xFFFFFFFF, CENTER);
		scrollItemInfo.alpha = 0;
		add(scrollItemInfo);

        checkMark = new FlxSprite(0, 250).loadGraphic(Paths.image('shop/checkmark'));
		checkMark.screenCenter(X);
		checkMark.x -= 300;
		checkMark.antialiasing = ClientPrefs.globalAntialiasing;
        checkMark.alpha = 0;
		add(checkMark);

        checkMarkLore = new FlxSprite(0, 250).loadGraphic(Paths.image('shop/checkmark'));
		checkMarkLore.screenCenter(X);
		checkMarkLore.x += 300;
		checkMarkLore.antialiasing = ClientPrefs.globalAntialiasing;
        checkMarkLore.alpha = 0;
		add(checkMarkLore);

        secondBlackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		secondBlackOut.alpha = 0;
		add(secondBlackOut);

        galleryTitle = new Alphabet(330, 10, "Gallery Items", true);
		galleryTitle.alpha = 0;
		add(galleryTitle);

        chests = new FlxTypedGroup<FlxSprite>();
		add(chests);
		for (i in 0...4)
		{
			var chest = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/chestIconClosed'));
			chest.screenCenter();
			chest.ID = i;
            switch (chest.ID)
            {
                case 0:
                    chest.x -= 450;
                case 1:
                    chest.x -= 150;
                case 2:
                    chest.x += 150;
                case 3:
                    chest.x += 450;
            }
			chest.y += 40;
            chest.alpha = 0;
			chest.antialiasing = ClientPrefs.globalAntialiasing;
			chests.add(chest);
			add(chest);
		}

        categoryPrices = new FlxTypedGroup<FlxText>();
		add(categoryPrices);
		for (i in 0...4)
		{
			var text = new FlxText(0, 0, FlxG.width, "Cost: ");
            text.setFormat("VCR OSD Mono", 32, 0xFFFFFFFF, CENTER);
			text.screenCenter();
			text.ID = i;
            switch (text.ID)
            {
                case 0:
                    text.x -= 450;
                    if (ClientPrefs.adMechanicScreensUnlocked == false)
                        text.text = "Cost: 20 Eggs";
                    else
                        text.text = "Purchased";
                case 1:
                    text.x -= 150;
                    if (ClientPrefs.oldLoadScreensUnlocked == false)
                        text.text = "Cost: 25 Eggs";
                    else
                        text.text = "Purchased";
                case 2:
                    text.x += 150;
                    if (ClientPrefs.fanartScreensUnlocked == false)
                        text.text = "Cost: 30 Eggs";
                    else
                        text.text = "Purchased";
                case 3:
                    text.x += 450;
                    if (ClientPrefs.randomArtScreensUnlocked == false)
                        text.text = "Cost: 50 Eggs";
                    else
                        text.text = "Purchased";
            }
			text.y += 150;
            text.alpha = 0;
			text.antialiasing = ClientPrefs.globalAntialiasing;
			categoryPrices.add(text);
			add(text);
		}

        prizeEgg = new FlxSprite(250, 560).loadGraphic(Paths.image('shop/prizes/prize_Egg'));
        prizeEgg.screenCenter(X);
        prizeEgg.x -= 50;
        prizeEgg.scale.set(0.4, 0.4);
        prizeEgg.alpha = 0;
		prizeEgg.antialiasing = ClientPrefs.globalAntialiasing;
        add(prizeEgg);

        eggCounter = new FlxText(prizeEgg.x - 500, prizeEgg.y + 60, FlxG.width, ": " + ClientPrefs.eggs, 36);
		eggCounter.setFormat("VCR OSD Mono", 25, 0xFFFFFFFF, CENTER);
		eggCounter.alpha = 0;
		add(eggCounter);

        thirdBlackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		thirdBlackOut.alpha = 0;
		add(thirdBlackOut);

        animChest = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/chestIconClosed'));
		animChest.screenCenter();
        trace(animChest.y);
		animChest.y -= 700;
        animChest.alpha = 0;
		animChest.antialiasing = ClientPrefs.globalAntialiasing;
		add(animChest);

        lightSpin = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/flashSpin'));
		lightSpin.frames = Paths.getSparrowAtlas('shop/flashSpin');
        lightSpin.screenCenter();
        lightSpin.y -= 50;
		lightSpin.animation.addByPrefix('spin', 'spin', 24, true);
		lightSpin.animation.play('spin');
		lightSpin.scrollFactor.set();
		lightSpin.updateHitbox();
		lightSpin.alpha = 0;
		lightSpin.antialiasing = ClientPrefs.globalAntialiasing;
		add(lightSpin);

        achievementText = new FlxText(0, 0, FlxG.width, "TEST");
        achievementText.setFormat("VCR OSD Mono", 50, 0xFFFFFF00, CENTER);
		achievementText.screenCenter();
        achievementText.alpha = 0;
        achievementText.borderSize = 4;
        add(achievementText);

        achievementTextInfo = new FlxText(0, 0, FlxG.width, "This category has been saved to your <G>gallery<G>!\nFeel free to go view its contents!");
        achievementTextInfo.setFormat("VCR OSD Mono", 30, 0xFFFFFFFF, CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
		achievementTextInfo.screenCenter();
        achievementTextInfo.y += 300;
        achievementTextInfo.alpha = 0;
        achievementTextInfo.borderSize = 3;
        CustomFontFormats.addMarkers(achievementTextInfo);
        add(achievementTextInfo);

        updateChests();

        new FlxTimer().start(0.3, function (tmr:FlxTimer) {
            FlxTween.tween(cellarLights, {alpha: 1}, 0.6, {ease: FlxEase.cubeInOut, type: PERSIST});
        });
        new FlxTimer().start(1, function (tmr:FlxTimer) {
            FlxTween.tween(hermit, {alpha: 1}, 0.1, {ease: FlxEase.cubeInOut, type: PERSIST});
            hermit.animation.play('intro');//you can rename the anim however you want to
        });
        new FlxTimer().start(1.18, function (tmr:FlxTimer) {
            hermit.animation.play('idle');
        });

        if (ClientPrefs.talkedToHermit == false)
        {
            goingBack = true;

            dialogueTextCellar.text = "Hello, stranger.\n[Press Enter To Continue]";	
            cellarMerchantDialogue.resetText(dialogueTextCellar.text);
            cellarMerchantDialogue.start(0.04, true);
        }
        else
        {
            cellarMerchantDialogue.start(0.04, true);
        }

        Achievements.loadAchievements();
		var achieveID:Int = Achievements.getAchievementIndex('hermit_found');
		if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
			Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
			giveAchievement();
		    ClientPrefs.saveSettings();
		}

        super.create();
    }

    function giveAchievement() {
		add(new AchievementObject('hermit_found', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "hermit_found"');
	}

    var pressedBack:Bool = false;
    var goingBack:Bool = false;
    var selectinItem:Bool = false;
    var pressedEnter:Int = 0;

    var completedGallery:Bool = false;
    var inChestRoom:Bool = false;
    var transitioning:Bool = false;

    var playingAnim:Bool = false;
    var shakeTween:FlxTween;
    var flashTween:FlxTween;
    var allowCompletion:Bool = false;
    override function update(elapsed:Float)
    {
        super.update(elapsed);
        //GALLERY OPTION CHECK
        if (ClientPrefs.oldLoadScreensUnlocked == true && ClientPrefs.adMechanicScreensUnlocked == true
        && ClientPrefs.fanartScreensUnlocked == true && ClientPrefs.randomArtScreensUnlocked == true)
        {
            completedGallery = true; 
            galleryItemCost.text = 'Chests Unavailable';
        } 

        if (ClientPrefs.eggs > 0)
            eggCounter.text = ': <G>' + ClientPrefs.eggs + '<G>';
        else
            eggCounter.text = ': <R>' + ClientPrefs.eggs + '<R>';
        CustomFontFormats.addMarkers(eggCounter);

        if (ClientPrefs.numberOfScrolls == 10)
            scrollItemCost.text = "Purchased";

        if (ClientPrefs.talkedToHermit == false)
            {
                if (FlxG.keys.justPressed.ENTER)
                {
                    trace ("Pressed Enter : " + pressedEnter);
                    switch (pressedEnter)
                    {
                        case 0:
                            dialogueTextCellar.text = "Not a lot of creatures like you visit this place, but if they do, they always want one thing.\n[Press Enter To Continue]";	
                        case 1:
                            dialogueTextCellar.text = "My scrolls.\n[Press Enter To Continue]";
                        case 2:
                            dialogueTextCellar.text = "if you want them, I'm generous enough to give you my scrolls, in exchange for eggs, so I can eat.\n[Press Enter To Continue]";
                        case 3:
                            dialogueTextCellar.text = "You can call me 'The Hermit' by the way. I'm just your humble scroll trader.\n[Press Enter To Continue]";
                        case 4:
                            dialogueTextCellar.text = "Each scroll contains history of the specific antagonist you'll fight through here.\n[Press Enter To Continue]";
                        case 5:
                            dialogueTextCellar.text = "Just give me some food if you want a scroll, since I haven't eaten in a while.\n[Press Enter To Continue]";
                        case 6:
                        {
                            goingBack = false;
                            ClientPrefs.talkedToHermit = true;
                            ClientPrefs.saveSettings();
                            trace('Changes Saved');

                            dialogueTextCellar.text = '';
                            cellarMerchantDialogue.resetText(dialogueTextCellar.text);
                            cellarMerchantDialogue.start(0.04, true);
                        }
                    }
                    pressedEnter += 1;
                    if (pressedEnter <= 6)
                    {
                        cellarMerchantDialogue.resetText(dialogueTextCellar.text);
                        cellarMerchantDialogue.start(0.04, true);
                    }
                }
            }
        
        if (!goingBack)
        {
            if (controls.BACK || FlxG.mouse.justPressedRight)
            {
                //Cellar Shop
                if (inChestRoom == true && pressedBack == false)
                {
                    pressedBack = true;
                    inChestRoom = false;
                    FlxG.sound.play(Paths.sound('cancelMenu'));

                    FlxTween.tween(galleryTitle, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(secondBlackOut, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    chests.forEach(function(chest:FlxSprite)
                    {
                        FlxTween.tween(chest, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    });
                    categoryPrices.forEach(function(text:FlxSprite)
                    {
                        FlxTween.tween(text, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    });
                    new FlxTimer().start(0.8, function (tmr:FlxTimer) {
                        pressedBack = false;	
                    });
                }
                else if (ClientPrefs.itemInfo == true && pressedBack == false)
                {
                    pressedBack = true;
                    selectinItem = false;
                    ClientPrefs.itemInfo = false;

                    FlxG.sound.play(Paths.sound('cancelMenu'));

                    FlxTween.tween(blackOut, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(shopTitle, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

                    FlxTween.tween(galleryIcon, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(galleryItemCost, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(galleryItemInfo, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    if (completedGallery)
                        FlxTween.tween(checkMarkLore, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

                    FlxTween.tween(loreScrollsIcon, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(scrollItemCost, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(scrollItemInfo, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    if (ClientPrefs.numberOfScrolls == 10)
                        FlxTween.tween(checkMarkLore, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

                    FlxTween.tween(eggCounter, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(prizeEgg, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

                    new FlxTimer().start(0.8, function (tmr:FlxTimer) {
                        pressedBack = false;	
                    });
                }
                else if (ClientPrefs.itemInfo == false && pressedBack == false)
                {
                    pressedBack = true;
                    goingBack = true;
                    FlxG.sound.play(Paths.sound('cancelMenu'));

                    //Resetting dialogue
                    dialogueTextCellar.text = '';
                    cellarMerchantDialogue.resetText(dialogueTextCellar.text);
                    cellarMerchantDialogue.start(0.04, true);
                    
                    hermit.animation.play('exit');
                    FlxTween.tween(cellarLights, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
                    FlxTween.tween(cellarOption, {alpha: 0}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});

                    FlxG.sound.music.fadeOut(1.2);  

                    new FlxTimer().start(0.18, function (tmr:FlxTimer) {
                        hermit.alpha = 0;
                    });
                    new FlxTimer().start(1.2, function (tmr:FlxTimer) {
                        MusicBeatState.switchState(new ShopState());
                    });
                }
            }

            if (!inChestRoom && !transitioning)
            {
                if(FlxG.mouse.overlaps(cellarOption) && !selectinItem)
                {
                    cellarOption.alpha = 1;
                }
                else
                {
                    cellarOption.alpha = 0.6;
                }
                //Dialogue
                if((!FlxG.mouse.overlaps(cellarOption)) && ClientPrefs.itemInfo == false && FlxG.mouse.overlaps(hermit) && FlxG.mouse.justPressed && !selectinItem)
                {
                    dialogueNumberCellar = FlxG.random.int(1, 30);
                        switch (dialogueNumberCellar)
                        {
                            case 1:
                                dialogueTextCellar.text = "Do you know the story of the God that became lowest of the low Humans, for everyone's salvation? It's Amazing!";
                            case 2:
                                dialogueTextCellar.text = "Why should I follow a Guy who promotes Bloodshed and weird arrange marriages?";
                            case 3:
                                dialogueTextCellar.text = "That Fat Guy they talk about is indeed peaceful, but he mentioned someone else that is more peaceful than him.";
                            case 4:
                                dialogueTextCellar.text = "There are so many gods, it's kinda confusing. I'll just stick to this Man-God they're all talking about.";
                            case 5:
                                dialogueTextCellar.text = "Genocide? Everyone who got killed by a benevolent being deserves it, especially when a lot of second chances have been given already.";
                            case 6:
                                dialogueTextCellar.text = "That scumbag scammer only thinks about himself and his tokens.";
                            case 7:
                                dialogueTextCellar.text = "That lady nearby that scumbag's shop is nice, I sometimes find her attractive in a way...";
                            case 8:
                                dialogueTextCellar.text = "For your information about how I got my scrolls, I just asked witnesses who witnessed the witnesses who witnessed the witnesses who witnessed the one they are witnessing, and then I wrote them down.";
                            case 9:
                                dialogueTextCellar.text = "I was inspired by alot of writers, especially the one who wrote the books called 'The Gospels'.";
                            case 10:
                                dialogueTextCellar.text = "'John' is really Good, I look up to him when it comes to writing stuff down.";
                            case 11:
                                dialogueTextCellar.text = "If Morality is subjective, then me killing you isn't wrong. It'll only wrong when someone has a different subjective morality against mine.";
                            case 12:
                                dialogueTextCellar.text = "I might be a female but I have this weird fascination towards girls..";
                            case 13:
                                dialogueTextCellar.text = "Your mind doesn't create your consciousness, there is something inside you that is much more than it.";
                            case 14:
                                dialogueTextCellar.text = "The universe is expanding, and something that always existed doesn't expand, therefore the universe had a beginning.";
                            case 15:
                                dialogueTextCellar.text = "The Almighty..";
                            case 16:
                                dialogueTextCellar.text = "How can the son and father be one being?";
                            case 17:
                                dialogueTextCellar.text = "Who moved the stone?";
                            case 18:
                                dialogueTextCellar.text = "I am no eternal being. I'm just a mere mortal, yet I'm not human.";
                            case 19:
                                dialogueTextCellar.text = "My real name isn't Hermit. It's just what my profession is.";
                            case 20:
                                dialogueTextCellar.text = "If you guess what my real name is, I'll give you a reward. Deal?";
                            case 21:
                                dialogueTextCellar.text = "Only Him shall I serve.";
                            case 22:
                                dialogueTextCellar.text = "The God that I Worship never asked to be worshipped, but here am I worshiping Him.";
                            case 23:
                                dialogueTextCellar.text = "You are free to do anything, but be aware that you're using this freedom on the right things.";
                            case 24:
                                dialogueTextCellar.text = "We are all evil in nature, that's why He came.";
                            case 25:
                                dialogueTextCellar.text = "I love eggs.";
                            case 26:
                                dialogueTextCellar.text = "Honor your mother and father.";
                            case 27:
                                dialogueTextCellar.text = "Everything you do is just glorifying him, it's either you use it right or use it defectively.";
                            case 28:
                                dialogueTextCellar.text = "I wish I was there 2000 years ago so I could see what He actually looks like.";
                            case 29:
                                dialogueTextCellar.text = "I like that red hair nun's way of serving her lord. Her lord is my lord.";
                            case 30:
                                dialogueTextCellar.text = "There is one thing you humans really want, and that is Love. Even though you deny it, your heart screams for it.";

                        }
                        FlxG.sound.play(Paths.sound('shop/mouseClick'));
                        cellarMerchantDialogue.resetText(dialogueTextCellar.text);
                        cellarMerchantDialogue.start(0.04, true);
                }
            
                if(FlxG.mouse.overlaps(cellarOption) && FlxG.mouse.justPressed && ClientPrefs.itemInfo == false)
                {
                    FlxG.sound.play(Paths.sound('scrollMenu'));
                    FlxG.sound.play(Paths.sound('shop/mouseClick'));
            
                    FlxTween.tween(blackOut, {alpha: 0.7}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(shopTitle, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

                    FlxTween.tween(galleryIcon, {alpha: 0.6}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(galleryItemCost, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(galleryItemInfo, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    if (completedGallery)
                        FlxTween.tween(checkMarkLore, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

                    FlxTween.tween(loreScrollsIcon, {alpha: 0.6}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(scrollItemCost, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(scrollItemInfo, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    if (ClientPrefs.numberOfScrolls == 10)
                        FlxTween.tween(checkMarkLore, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

                    FlxTween.tween(eggCounter, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(prizeEgg, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

                    ClientPrefs.itemInfo = true;

                    new FlxTimer().start(0.8, function (tmr:FlxTimer) {
                        if (!pressedBack)
                            selectinItem = true;
                    });
                }

                if (selectinItem)
                {
                    if(FlxG.mouse.overlaps(galleryIcon) && ClientPrefs.galleryUnlocked == true)
                    {
                        galleryIcon.alpha = 1;
                    }
                    else
                    {
                        galleryIcon.alpha = 0.6;
                    }

                    if(FlxG.mouse.overlaps(loreScrollsIcon) && ClientPrefs.numberOfScrolls != 10)
                    {
                        loreScrollsIcon.alpha = 1;
                    }
                    else
                    {
                        loreScrollsIcon.alpha = 0.6;
                    }

                    if (FlxG.mouse.overlaps(galleryIcon) && FlxG.mouse.justPressed && ClientPrefs.itemInfo == true && completedGallery)
                    {
                        if (ClientPrefs.eggs >= 1)
                        {
                            FlxG.sound.play(Paths.sound('shop/stolenEggs'));
                            dialogueTextCellar.text = "You've bought all the chests here, but I wouldn't mind taking some eggs from you.";
                            cellarMerchantDialogue.resetText(dialogueTextCellar.text);
                            cellarMerchantDialogue.start(0.04, true);

                            ClientPrefs.eggs -= FlxG.random.int(1, ClientPrefs.eggs);
                            ClientPrefs.saveSettings();
                        }
                        else
                        {
                            dialogueTextCellar.text = "You've bought all the chests here.";
                            cellarMerchantDialogue.resetText(dialogueTextCellar.text);
                            cellarMerchantDialogue.start(0.04, true);
                        }
                    }
                    if (FlxG.mouse.overlaps(loreScrollsIcon) && FlxG.mouse.justPressed && ClientPrefs.itemInfo == true && ClientPrefs.numberOfScrolls == 10)
                    {
                        if (ClientPrefs.eggs >= 1)
                        {
                            FlxG.sound.play(Paths.sound('shop/stolenEggs'));
                            dialogueTextCellar.text = "You've bought all the scrolls, but I wouldn't mind taking some eggs from you.";
                            cellarMerchantDialogue.resetText(dialogueTextCellar.text);
                            cellarMerchantDialogue.start(0.04, true);
        
                            ClientPrefs.eggs -= FlxG.random.int(1, ClientPrefs.eggs);
                            ClientPrefs.saveSettings();
                        }
                        else
                        {
                            dialogueTextCellar.text = "You've already bought that.";
                            cellarMerchantDialogue.resetText(dialogueTextCellar.text);
                            cellarMerchantDialogue.start(0.04, true);
                        }
                    }

                    if (FlxG.mouse.overlaps(loreScrollsIcon) && FlxG.mouse.justPressed && ClientPrefs.itemInfo == true && ClientPrefs.numberOfScrolls != 10)
                    {
                        if (ClientPrefs.eggs >= 5)
                        {
                            ClientPrefs.eggs -= 5;
                            ClientPrefs.saveSettings();
                            trace("Bought a scroll!");

                            randomizeScroll();

                            FlxG.sound.play(Paths.sound('confirmMenu'));
                            FlxG.sound.play(Paths.sound('shop/mouseClick'));

                            giveScroll();
                        }
                        else
                        {
                            FlxG.sound.play(Paths.sound('accessDenied'));
                            FlxG.camera.shake(0.02, 0.2, null, true, FlxAxes.XY);
                        }
                    }
                }

                if (FlxG.mouse.overlaps(galleryIcon) && FlxG.mouse.justPressed && ClientPrefs.itemInfo == true && !completedGallery && inChestRoom == false)
                {
                    transitioning = true;

                    inChestRoom = true;
                    FlxTween.tween(galleryTitle, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    FlxTween.tween(secondBlackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    chests.forEach(function(chest:FlxSprite)
                    {
                        FlxTween.tween(chest, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    });
                    categoryPrices.forEach(function(text:FlxSprite)
                    {
                        FlxTween.tween(text, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    });

                    new FlxTimer().start(0.8, function (tmr:FlxTimer) {
                        transitioning = false;
                        changeSelection();
                    });
                }
            }
            
            if (inChestRoom && !playingAnim && !transitioning)//In Chest Room
            {
                chests.forEach(function(spr:FlxSprite)
                {
                    if (FlxG.mouse.overlaps(spr))
                        switch(spr.ID)
                        {
                            case 0:
                                changeSelection(0);
                             case 1:
                                changeSelection(1);
                            case 2:
                                changeSelection(2);
                            case 3:
                                changeSelection(3);
                        }
                    
                    if (FlxG.mouse.overlaps(spr) && FlxG.mouse.justPressed && !completedGallery)
                    {
                        animChest.alpha = 1;
                        FlxG.sound.play(Paths.sound('shop/mouseClick'));
                        switch(spr.ID)
                        {
                            case 0:
                                if (ClientPrefs.adMechanicScreensUnlocked == false && ClientPrefs.eggs >= 20)
                                {
                                    giveCategory(0);
                                    ClientPrefs.eggs -= 20;
                                    FlxG.sound.play(Paths.sound('confirmMenu'));
                                    playingAnim = true;
                                    goingBack = true;
                                }
                                else
                                {
                                    FlxG.sound.play(Paths.sound('accessDenied'), 0.6);
                                }
                                    
                             case 1:
                                if (ClientPrefs.oldLoadScreensUnlocked == false && ClientPrefs.eggs >= 25)
                                {
                                    giveCategory(1);
                                    ClientPrefs.eggs -= 25;
                                    FlxG.sound.play(Paths.sound('confirmMenu'));
                                    playingAnim = true;
                                    goingBack = true;
                                }
                                else
                                {
                                    FlxG.sound.play(Paths.sound('accessDenied'), 0.6);
                                }

                            case 2:
                                if (ClientPrefs.fanartScreensUnlocked == false && ClientPrefs.eggs >= 30)
                                {
                                    giveCategory(2);
                                    ClientPrefs.eggs -= 30;
                                    FlxG.sound.play(Paths.sound('confirmMenu'));
                                    playingAnim = true;
                                    goingBack = true;
                                }
                                else
                                {
                                    FlxG.sound.play(Paths.sound('accessDenied'), 0.6);
                                }
                                
                            case 3:
                                if (ClientPrefs.randomArtScreensUnlocked == false && ClientPrefs.eggs >= 50)
                                {
                                    giveCategory(3);
                                    ClientPrefs.eggs -= 50;
                                    FlxG.sound.play(Paths.sound('confirmMenu'));
                                    playingAnim = true;
                                    goingBack = true;
                                }
                                else
                                {
                                    FlxG.sound.play(Paths.sound('accessDenied'), 0.6);
                                }
                        }
                    }               
                });
            }
        }

        if (controls.ACCEPT && allowCompletion)
        {
            flashTween.cancel();
            FlxTween.tween(lightSpin, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    
            FlxTween.tween(thirdBlackOut, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
            FlxTween.tween(animChest, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
            FlxTween.tween(achievementText, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
            FlxTween.tween(achievementTextInfo, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
            new FlxTimer().start(0.8, function (tmr:FlxTimer) {
                animChest.y -= 800;
                achievementText.y += 50;
                animChest.alpha = 1;
            });
                    

            allowCompletion = false;
            playingAnim = false;
            goingBack = false;

            updateChests();
        }
    }

    var selChest:Int = 0;
    function changeSelection(huh:Int = 0)
    {
        selChest = huh;

        chests.forEach(function(chest:FlxSprite)
        {
            if (chest.ID != selChest)
                chest.alpha = 0.3;
            else
                chest.alpha = 1;
        });
    }

    function giveCategory(huh:Int = 0)
    {
        selChest = huh;
        animChest.loadGraphic(Paths.image('shop/chestIconClosed'));

        FlxTween.tween(thirdBlackOut, {alpha: 0.8}, 0.8, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween)
            {
                FlxG.sound.play(Paths.sound('shop/chestOpen'));
                FlxTween.tween(animChest, {y: 368.5}, 0.8, {ease: FlxEase.cubeIn, onComplete: function(twn:FlxTween) //Frame 1 - Down
                    {
                        FlxTween.tween(animChest, {angle: 10}, 0.3, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween) //Rotate Left
                            {
                                FlxTween.tween(animChest, {angle: -10}, 1.2, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween) // Rotate Right
                                    {
                                        FlxTween.tween(animChest, {angle: 0}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween) // Rotate Reset
                                            {
                                                //Done :)
                                            }
                                        });
                                    }
                                });
                            }
                        });
                        FlxTween.tween(animChest, {y: -168.5}, 0.8, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                            {
                                FlxTween.tween(animChest, {y: 368.5}, 0.9, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween)
                                    {
                                        FlxTween.tween(animChest, {y: 318.5}, 0.5, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                                            {
                                                FlxTween.tween(animChest, {y: 368.5}, 0.6, {ease: FlxEase.quadInOut, type: PERSIST});
                                            }
                                        });
                                    }
                                });
                            }
                        });
                    }
                });
                new FlxTimer().start(5.5, function (tmr:FlxTimer) {
                    shakeTween = FlxTween.tween(animChest, {x: animChest.x - 5}, 0.05, {ease: FlxEase.circOut, type: PINGPONG});
                    new FlxTimer().start(2, function (tmr:FlxTimer) {
                        shakeTween.cancel();
                        animChest.loadGraphic(Paths.image('shop/chestIconOpened'));
                        FlxTween.tween(lightSpin, {alpha: 0.8}, 0.8, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                        {
                            flashTween = FlxTween.tween(lightSpin, {alpha: 0.8}, 0.8, {ease: FlxEase.cubeInOut, type: PINGPONG});
                        }
                        });
                        FlxTween.tween(achievementText, {y: achievementText.y - 50}, 1.3, {ease: FlxEase.cubeInOut, type: PERSIST});
                        switch (selChest)
                        {
                            case 0:
                                ClientPrefs.adMechanicScreensUnlocked = true;
                                achievementText.text = 'Ad Mechanic Screens Unlocked!';
                            case 1:
                                ClientPrefs.oldLoadScreensUnlocked = true;
                                achievementText.text = 'Old Loading Screens Unlocked!';
                            case 2:
                                ClientPrefs.fanartScreensUnlocked = true;
                                achievementText.text = 'Fanarts Unlocked!';
                            case 3:
                                ClientPrefs.randomArtScreensUnlocked = true;
                                achievementText.text = 'Random Arts Unlocked!';
                        }

                        ClientPrefs.saveSettings();

                        FlxTween.tween(achievementText, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween)
                        {
                            new FlxTimer().start(1.2, function (tmr:FlxTimer) {
                                FlxTween.tween(achievementTextInfo, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
                                allowCompletion = true;
                            });
                        }
                        });
                    });
                });
            }
        });
    }

    function updateChests()
    {
        categoryPrices.forEach(function(text:FlxText) //Update sprites
        {
            switch(text.ID)
            {
                case 0:
                    if (ClientPrefs.adMechanicScreensUnlocked == true)
                    {
                        chests.forEach(function(chest:FlxSprite) //Update sprites
                        {
                            if (chest.ID == text.ID)
                                chest.loadGraphic(Paths.image('shop/chestIconOpened'));
                        });
                        text.text = 'Purchased';
                    }
                 case 1:
                    if (ClientPrefs.oldLoadScreensUnlocked == true)
                    {
                        chests.forEach(function(chest:FlxSprite) //Update sprites
                        {
                            if (chest.ID == text.ID)
                                chest.loadGraphic(Paths.image('shop/chestIconOpened'));
                        });
                        text.text = 'Purchased';
                    }
                case 2:
                    if (ClientPrefs.fanartScreensUnlocked == true)
                    {
                        chests.forEach(function(chest:FlxSprite) //Update sprites
                        {
                            if (chest.ID == text.ID)
                                chest.loadGraphic(Paths.image('shop/chestIconOpened'));
                        });
                        text.text = 'Purchased';
                    }
                case 3:
                    if (ClientPrefs.randomArtScreensUnlocked == true)
                    {
                        chests.forEach(function(chest:FlxSprite) //Update sprites
                        {
                            if (chest.ID == text.ID)
                                chest.loadGraphic(Paths.image('shop/chestIconOpened'));
                        });
                        text.text = 'Purchased';
                    }
            }
        });
    }

    function randomizeScroll()
    {
        var num = FlxG.random.int(0, 9);
        switch(num)
        {
            case 0:
                if (ClientPrefs.marcoScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.marcoScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
            case 1:
                if (ClientPrefs.aileenScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.aileenScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
            case 2:
                if (ClientPrefs.beatriceScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.beatriceScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
            case 3:
                if (ClientPrefs.evelynScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.evelynScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
            case 4:
                if (ClientPrefs.yakuScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.yakuScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
            case 5:
                if (ClientPrefs.dvScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.dvScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
            case 6:
                if (ClientPrefs.kianaScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.kianaScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
            case 7:
                if (ClientPrefs.narrinScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.narrinScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
            case 8:
                if (ClientPrefs.morkyScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.morkyScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
            case 9:
                if (ClientPrefs.kaizokuScroll == true)
                    randomizeScroll();
                else
                {
                    ClientPrefs.kaizokuScroll = true;
                    ClientPrefs.numberOfScrolls += 1;
                }
        }
        ClientPrefs.saveSettings();
        scrollsArrayUpdate();
    }

    function giveScroll()
    {
        dialogueTextCellar.text = "";
        cellarMerchantDialogue.resetText(dialogueTextCellar.text);
        cellarMerchantDialogue.start(0.04, true);

        selectinItem = false;
        goingBack = true;

        hermit.animation.play('give');
        FlxG.sound.play(Paths.sound('shop/giveScroll'));

        ClientPrefs.itemInfo = false;

        FlxG.sound.play(Paths.sound('cancelMenu'));

        FlxTween.tween(blackOut, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        FlxTween.tween(shopTitle, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

         FlxTween.tween(galleryIcon, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        FlxTween.tween(galleryItemCost, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        FlxTween.tween(galleryItemInfo, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        if (ClientPrefs.galleryUnlocked == true)
            FlxTween.tween(checkMark, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

        FlxTween.tween(loreScrollsIcon, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        FlxTween.tween(scrollItemCost, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        FlxTween.tween(scrollItemInfo, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

        FlxTween.tween(eggCounter, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        FlxTween.tween(prizeEgg, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        FlxTween.tween(cellarOption, {alpha: 0}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

        //Animation takes over 10.40 something seconds.
        new FlxTimer().start(10.3, function (tmr:FlxTimer) {
            hermit.animation.play('intro');

            FlxTween.tween(cellarOption, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        });
        new FlxTimer().start(10.48, function (tmr:FlxTimer) {
            hermit.animation.play('idle');

            dialogueTextCellar.text = "Here's a random scroll I found. Go to your infodex to find it.";
            cellarMerchantDialogue.resetText(dialogueTextCellar.text);
            cellarMerchantDialogue.start(0.04, true);

            FlxTween.tween(cellarOption, {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        });
        new FlxTimer().start(11.3, function (tmr:FlxTimer) {
            goingBack = false;
        });
    }

    function scrollsArrayUpdate()
    {
        scrolls = [];
        if (ClientPrefs.marcoScroll == false)
            scrolls.push('marcoScroll');
        if (ClientPrefs.aileenScroll == false)
            scrolls.push('aileenScroll');
        if (ClientPrefs.beatriceScroll == false)
            scrolls.push('beatriceScroll');
        if (ClientPrefs.evelynScroll == false)
            scrolls.push('evelynScroll');
        if (ClientPrefs.yakuScroll == false)
            scrolls.push('yakuScroll');
        if (ClientPrefs.dvScroll == false)
            scrolls.push('dvScroll');
        if (ClientPrefs.kianaScroll == false)
            scrolls.push('kianaScroll');
        if (ClientPrefs.narrinScroll == false)
            scrolls.push('narrinScroll');
        if (ClientPrefs.morkyScroll == false)
            scrolls.push('morkyScroll');
        if (ClientPrefs.kaizokuScroll == false)
            scrolls.push('kaizokuScroll');

        for (i in 0...scrolls.length)
            trace(scrolls[i]);
    }
}