package;

import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.text.FlxTypeText;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxBackdrop;

import editors.ChartingState;
import flixel.addons.display.FlxGridOverlay;
import openfl.utils.Assets as OpenFlAssets;
import Alphabet;

class ResultsScreenState extends MusicBeatState 
{
    var bg:FlxSprite;
	var BGchecker:FlxBackdrop;
    var char:FlxSprite;
    var resultsTitle:Alphabet;
    var info:FlxText;
    var newRecord:FlxText;
    var enterText:FlxText;
    var ratingText:FlxText;

    var mayhemPlayableChars:Array<String> = [
        'GFResults',
        'PicoInfo',
        'TCInfo',
        'LillieInfo',
        'KyuInfo',
        'LilyInfo',
        'ManagerInfo',
        'PorkchopInfo',
        'OurpleInfo',
        'UziInfo'
    ];
    var mayhemPlayableCharsSizes:Array<Float> = [
        2,
        1.5,
        1.5,
        1.5,
        1.5,
        1.7,
        1.7,
        2,
        1.5,
        2
    ];
    var mayhemPlayableCharsXY:Array<Array<Int>> = [
        [450, 400, -370],
        [550, 700, -40],
        [600, 700, -20],
        [620, 700, -10],
        [550, 700, -20],
        [500, 700, -70],
        [570, 800, -20],
        [500, 400, -470],
        [550, 700, -70],
        [450, 700, -300]
    ];
    var curChar:Int;

    var colors:Array<String> = [ 
        '0xFFff4570',
        '0xFF03fc20',
        '0xFF03fcc2',
        '0xFF0318fc',
        '0xFF9003fc',
        '0xFFfc03d2',
        '0xFFfc0303',
        '0xFFfc7303',
        '0xFFfcf403'
	];
    var curNum:Int;
    var curColor:String;
    var previousColor:String;
    var powerUpBonus:Int = 0;

    override public function create()
    {
        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Results!", null);
		#end

        if (PlayState.checkForPowerUp == false)
        {
            if (PlayState.isInjectionMode)
                powerUpBonus = 25000;
            else if (PlayState.isMayhemMode)
                powerUpBonus = 25000;
            else if (PlayState.isStoryMode)
                powerUpBonus = 35000;
            else if (!PlayState.isStoryMode && !PlayState.isIniquitousMode && !PlayState.isInjectionMode && !PlayState.isMayhemMode)
                powerUpBonus = 15000;
        }
        else
            powerUpBonus = 0;
        
        curNum = 0;
        curColor = colors[curNum];
        previousColor = curColor;

        bg = new FlxSprite().loadGraphic(Paths.image('promotion/Background'));
		bg.color = 0xFFe1e1e1;
        bg.flipX = true;
        bg.scale.set(2, 2);
		bg.alpha = 1;
		add(bg);

		BGchecker = new FlxBackdrop(Paths.image('promotion/BGgrid-' + FlxG.random.int(1, 8)), FlxAxes.XY, 0, 0); 
		BGchecker.updateHitbox(); 
		BGchecker.scrollFactor.set(0, 0); 
		BGchecker.alpha = 0; 
		BGchecker.screenCenter(X); 
		add(BGchecker);

        ratingText = new FlxText(0, 0, FlxG.width + 1000,
            "",
            35);
        ratingText.setFormat("SF Atarian System Bold Italic", 70, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
        ratingText.alpha = 0;
        ratingText.screenCenter(XY);
        ratingText.x += 650;
        ratingText.y += 100;
        ratingText.borderSize = 3;
        ratingText.angle = -90;
        add(ratingText);

        if (PlayState.isInjectionMode)
        {
            if (FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) == 100.00)
                ratingText.text = "PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!";
            else if ((FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) >= 90.00) && (FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) <= 99.99))
                ratingText.text = "Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!";   
            else if ((FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2)>= 80.00) && (FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) <= 89.99))
                ratingText.text = "Great!   Great!   Great!   Great!   Great!   Great!   Great!   Great!   Great!";
            else if ((FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2)>= 70.00) && (FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) <= 79.99))
                ratingText.text = "Good!   Good!   Good!   Good!   Good!   Good!   Good!   Good!   Good!";
            else if ((FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2)>= 69.00) && (FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) <= 69.99))
                ratingText.text = "Sussy~   Sussy~   Sussy~   Sussy~   Sussy~   Sussy~   Sussy~   Sussy~";
            else if ((FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) >= 60.00) && (FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2)<= 68.99))
                ratingText.text = "Okay..?   Okay..?   Okay..?   Okay..?   Okay..?   Okay..?   Okay..?   Okay..?";
            else if ((FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) >= 50.00) && (FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) <= 59.99))
                ratingText.text = "Passable..   Passable..   Passable..   Passable..   Passable..   Passable..   Passable..   Passable..";
            else
                ratingText.text = "Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..";
        }
        else if (PlayState.isMayhemMode)
        {
            if (FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) == 100.00)
                ratingText.text = "PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!";
            else if ((FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) >= 90.00) && (FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) <= 99.99))
                ratingText.text = "Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!";   
            else if ((FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) >= 80.00) && (FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) <= 89.99))
                ratingText.text = "Great!   Great!   Great!   Great!   Great!   Great!   Great!   Great!   Great!";
            else if ((FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) >= 70.00) && (FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) <= 79.99))
                ratingText.text = "Good!   Good!   Good!   Good!   Good!   Good!   Good!   Good!   Good!";
            else if ((FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) >= 69.00) && (FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) <= 69.99))
                ratingText.text = "Sussy~   Sussy~   Sussy~   Sussy~   Sussy~   Sussy~   Sussy~   Sussy~";
            else if ((FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) >= 60.00) && (FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) <= 68.99))
                ratingText.text = "Okay..?   Okay..?   Okay..?   Okay..?   Okay..?   Okay..?   Okay..?   Okay..?";
            else if ((FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) >= 50.00) && (FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) <= 59.99))
                ratingText.text = "Passable..   Passable..   Passable..   Passable..   Passable..   Passable..   Passable..   Passable..";
            else
                ratingText.text = "Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..";
        }
        else
        {
            if (FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) == 100.00)
                ratingText.text = "PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!   PERFECT!";
            else if ((FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) >= 90.00) && (FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) <= 99.99))
                ratingText.text = "Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!   Wahoohie!";   
            else if ((FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) >= 80.00) && (FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) <= 89.99))
                ratingText.text = "Great!   Great!   Great!   Great!   Great!   Great!   Great!   Great!   Great!";
            else if ((FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) >= 70.00) && (FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) <= 79.99))
                ratingText.text = "Good!   Good!   Good!   Good!   Good!   Good!   Good!   Good!   Good!";
            else if ((FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) >= 69.00) && (FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) <= 69.99))
                ratingText.text = "Sussy~   Sussy~   Sussy~   Sussy~   Sussy~   Sussy~   Sussy~   Sussy~";
            else if ((FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) >= 60.00) && (FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) <= 68.99))
                ratingText.text = "Okay..?   Okay..?   Okay..?   Okay..?   Okay..?   Okay..?   Okay..?   Okay..?";
            else if ((FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) >= 50.00) && (FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) <= 59.99))
                ratingText.text = "Passable..   Passable..   Passable..   Passable..   Passable..   Passable..   Passable..   Passable..";
            else
                ratingText.text = "Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..";
        }

        if (PlayState.isInjectionMode || PlayState.isStoryMode)
        {
            char = new FlxSprite(0, 0).loadGraphic(Paths.image('characterInfo/GFResults'));
            char.scrollFactor.set(0, 0);
            char.scale.set(2, 2);
            char.x = 400;
            char.y = 400;
            char.alpha = 1;
            char.color = 0xFF000000;
            char.updateHitbox();
            char.antialiasing = ClientPrefs.globalAntialiasing;
            add(char);

            if ((PlayState.isInjectionMode && PlayState.injectionSongsPlayed != PlayState.injectionPlaylistTotal) || ratingText.text = "Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..")
            {
                char.loadGraphic(Paths.image('characterInfo/bad'));
                char.scrollFactor.set(0, 0);
                char.scale.set(1.3, 1.3);
                char.x = 525;
                char.y = 500;
                char.alpha = 1;
                char.color = 0xFF000000;
                char.updateHitbox();
                char.antialiasing = ClientPrefs.globalAntialiasing;
            }

            if (PlayState.isStoryMode)
            {
                switch(ClientPrefs.crashWeek)
                {
                    case 0 | 1 | 2 | 3 | 7:
                        curChar = 0;
                    case 4:
                        curChar = 1;
                    case 5:
                        curChar = 2;
                    case 6:
                        curChar = 3;
                    default:
                        curChar = 0;

                    char.loadGraphic(Paths.image('characterInfo/' + mayhemPlayableChars[curChar]));
                    char.scale.set(mayhemPlayableCharsSizes[curChar], mayhemPlayableCharsSizes[curChar]);
                    char.x = mayhemPlayableCharsXY[curChar][0];
                    char.y = mayhemPlayableCharsXY[curChar][1];
                }
            }
        }      
        else
        {
            if ((PlayState.isMayhemMode && PlayState.mayhemSongsPlayed == 0) || ratingText.text = "Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..")
            {
                char = new FlxSprite(0, 0).loadGraphic(Paths.image('characterInfo/bad'));
                char.scrollFactor.set(0, 0);
                char.scale.set(1.3, 1.3);
                char.x = 525;
                char.y = 500;
                char.alpha = 1;
                char.color = 0xFF000000;
                char.updateHitbox();
                char.antialiasing = ClientPrefs.globalAntialiasing;
                add(char);
            }
            else
            {
                curChar = FlxG.random.int(0, mayhemPlayableChars.length - 1);
                char = new FlxSprite(0, 0).loadGraphic(Paths.image('characterInfo/' + mayhemPlayableChars[curChar]));
                char.scrollFactor.set(0, 0);
                char.scale.set(mayhemPlayableCharsSizes[curChar], mayhemPlayableCharsSizes[curChar]);
                char.x = mayhemPlayableCharsXY[curChar][0];
                char.y = mayhemPlayableCharsXY[curChar][1];
                char.alpha = 1;
                char.color = 0xFF000000;
                char.updateHitbox();
                char.antialiasing = ClientPrefs.globalAntialiasing;
                add(char);
            }
        }

        if (PlayState.isInjectionMode)
            info = new FlxText(20, 240, FlxG.width,
               "Total Score: \nTotal Misses: \nAverage Rating: \nBest Note Combo: \nTotal Songs Played:",
               25);
        else if (PlayState.isMayhemMode)
            info = new FlxText(20, 240, FlxG.width,
                "Total Score: \nAverage Rating: \nBest Note Combo: \nTotal Challenges Completed: \nTotal Songs Beaten:",
                25);
        else if (PlayState.isStoryMode)
            info = new FlxText(20, 240, FlxG.width,
                "Total Score: \nTotal Misses: \nAverage Rating: \nBest Note Combo:",
                25);
        else if (!PlayState.isStoryMode && !PlayState.isIniquitousMode && !PlayState.isInjectionMode && !PlayState.isMayhemMode)
            info = new FlxText(20, 240, FlxG.width,
                "Total Score: \nTotal Misses: \nTotal Rating: \nBest Note Combo:",
                25);
        info.setFormat("SF Atarian System Bold Italic", 60, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
        info.alpha = 1;
        info.borderSize = 3.5;
        info.y += 600;
		add(info);

        resultsTitle = new Alphabet(45, 10, "Results", true);
		resultsTitle.y -= 100;
		add(resultsTitle);

        enterText = new FlxText(20, 640, FlxG.width,
            "Press ENTER to go back to Main Menu!",
            35);
        enterText.setFormat("SF Atarian System Bold Italic", 50, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
        enterText.alpha = 0;
        enterText.borderSize = 3;
        add(enterText);

        if (PlayState.isStoryMode)
            enterText.text = "Press <G>ENTER<G> to go back to Story Mode Selection!";
        else if (PlayState.isInjectionMode || PlayState.isMayhemMode)
            enterText.text = "Press <G>ENTER<G> to go back to Main Menu!";
        else
            enterText.text = "Press <G>ENTER<G> to go back to Freeplay Selection!";
        CustomFontFormats.addMarkers(enterText);

        FlxTween.tween(resultsTitle, {y: 120}, 1, {ease: FlxEase.circOut, type: PERSIST});

        FlxTween.tween(BGchecker, {alpha: 1}, 2.2, {ease: FlxEase.cubeInOut, type: PERSIST});

        new FlxTimer().start(1.35, function(tmr:FlxTimer)
        {
             FlxTween.tween(info, {y: 240}, 1, {ease: FlxEase.circOut, type: PERSIST});
        });

        new FlxTimer().start(2.15, function(tmr:FlxTimer)
        {
            if ((PlayState.isMayhemMode && PlayState.mayhemSongsPlayed == 0) || (PlayState.isInjectionMode && PlayState.injectionSongsPlayed != PlayState.injectionPlaylistTotal))
                FlxTween.tween(char, {y: -100}, 1, {ease: FlxEase.circOut, type: PERSIST});
            else
                FlxTween.tween(char, {y: mayhemPlayableCharsXY[curChar][2]}, 1, {ease: FlxEase.circOut, type: PERSIST});
        });
        
        new FlxTimer().start(3.3, function(tmr:FlxTimer)
        {
            FlxG.camera.flash(FlxColor.WHITE, 1);
            bg.color = 0xFFff4570;
            char.color = 0xFFFFFFFF;
            playRatingTween();

            if (PlayState.isInjectionMode)
            {
                if (PlayState.injectionSongsPlayed < 1)
                    info.text = "Total Score: <R>" + (PlayState.injectionScore - powerUpBonus) + "<R>\nTotal Misses: <R>0<R>\nAverage Rating: <R>0%<R>\nBest Note Combo: <R>0<R>\nTotal Songs Played: <R>0 / " + PlayState.injectionPlaylistTotal + "<R>";
                else
                    info.text = "Total Score: <G>" + (PlayState.injectionScore - powerUpBonus) + "<G>\nTotal Misses: <G>" + PlayState.injectionMisses + "<G>\nAverage Rating: <G>" + FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) + "%<G>\nBest Note Combo: <G>" + PlayState.injectionBestCombo + "<G>\nTotal Songs Played: <G>" + PlayState.injectionSongsPlayed + " / " + PlayState.injectionPlaylistTotal + "<G>";
            }
            else if (PlayState.isMayhemMode)
            {
                if (PlayState.mayhemSongsPlayed < 1)
                    info.text = "Total Score: <R>" + (PlayState.mayhemScore - powerUpBonus) +"<R>\nAverage Rating: <R>0%<R>\nBest Note Combo: <R>0<R>\nTotal Challenges Beaten: <R>0<R>\nTotal Songs Beaten: <R>0<R>";
                else
                    info.text = "Total Score: <G>" + (PlayState.mayhemScore - powerUpBonus) +"<G>\nAverage Rating: <G>" + FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) + "%<G>\nBest Note Combo: <G>" + PlayState.mayhemBestCombo + "<G>\nTotal Challenges Beaten: <G>" + PlayState.mayhemTotalChallenges + "<G>\nTotal Songs Beaten: <G>" + PlayState.mayhemSongsPlayed + "<G>";
            }
            else if (PlayState.isStoryMode)
            {
                 info.text = "Total Score: <G>" + (PlayState.campaignScore - powerUpBonus) + "<G>\nTotal Misses: <G>" + PlayState.campaignMisses + "<G>\nAverage Rating: <G>" + FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) + "%<G>\nBest Note Combo: <G>" + ClientPrefs.campaignBestCombo + "<G>";
            }
            else if (!PlayState.isStoryMode && !PlayState.isIniquitousMode && !PlayState.isInjectionMode && !PlayState.isMayhemMode)
            {
                 info.text = "Total Score: <G>" + (PlayState.freeplayScore - powerUpBonus) + "<G>\nTotal Misses: <G>" + PlayState.freeplayMisses + "<G>\nTotal Rating: <G>" + FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) + "%<G>\nBest Note Combo: <G>" + ClientPrefs.campaignBestCombo + "<G>";
            }
            CustomFontFormats.addMarkers(info);
            FlxTween.tween(char, {y: char.y + 10}, 2.2, {ease: FlxEase.cubeInOut, type: PINGPONG});
        });

        if (powerUpBonus != 0) //Power up hasn't been used!
        {
            new FlxTimer().start(3.6, function(tmr:FlxTimer)
            {
                var bonusText:FlxText = new FlxText(info.x + 50, info.y - 50, FlxG.width,
                "No Power Up Bonus! -> +" + powerUpBonus,
                26);
                bonusText.setFormat("SF Atarian System Bold Italic", 50, FlxColor.YELLOW, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
                bonusText.alpha = 1;
                bonusText.borderSize = 3;
                add(bonusText);
                FlxG.sound.play(Paths.sound('bonusPoints'));
                FlxFlicker.flicker(bonusText, 999, 0.08, false, false);

                FlxTween.tween(bonusText, {y: bonusText.y - 20}, 1.5, {ease: FlxEase.circOut, type: PERSIST});
                FlxTween.tween(bonusText, {alpha: 0}, 1.5, {ease: FlxEase.circOut, type: PERSIST});

                if (PlayState.isInjectionMode)
                {
                    PlayState.injectionScore += powerUpBonus;
                    if (PlayState.injectionSongsPlayed < 1)
                        info.text = "Total Score: <R>" + PlayState.injectionScore + "<R>\nTotal Misses: <R>0<R>\nAverage Rating: <R>0%<R>\nBest Note Combo: <R>0<R>\nTotal Songs Played: <R>0 / " + PlayState.injectionPlaylistTotal + "<R>";
                    else
                        info.text = "Total Score: <G>" + PlayState.injectionScore + "<G>\nTotal Misses: <G>" + PlayState.injectionMisses + "<G>\nAverage Rating: <G>" + FlxMath.roundDecimal((PlayState.injectionRating / PlayState.injectionSongsPlayed) * 100, 2) + "%<G>\nBest Note Combo: <G>" + PlayState.injectionBestCombo + "<G>\nTotal Songs Played: <G>" + PlayState.injectionSongsPlayed + " / " + PlayState.injectionPlaylistTotal + "<G>";
                }
                else if (PlayState.isMayhemMode)
                {
                    PlayState.mayhemScore += powerUpBonus;
                    if (PlayState.mayhemSongsPlayed < 1)
                        info.text = "Total Score: <R>" + PlayState.mayhemScore +"<R>\nAverage Rating: <R>0%<R>\nBest Note Combo: <R>0<R>\nTotal Challenges Beaten: <R>0<R>\nTotal Songs Beaten: <R>0<R>";
                    else
                        info.text = "Total Score: <G>" + PlayState.mayhemScore +"<G>\nAverage Rating: <G>" + FlxMath.roundDecimal((PlayState.mayhemRating / PlayState.mayhemSongsPlayed) * 100, 2) + "%<G>\nBest Note Combo: <G>" + PlayState.mayhemBestCombo + "<G>\nTotal Challenges Beaten: <G>" + PlayState.mayhemTotalChallenges + "<G>\nTotal Songs Beaten: <G>" + PlayState.mayhemSongsPlayed + "<G>";
                }
                else if (PlayState.isStoryMode)
                {
                    info.text = "Total Score: <G>" + PlayState.campaignScore + "<G>\nTotal Misses: <G>" + PlayState.campaignMisses + "<G>\nAverage Rating: <G>" + FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) + "%<G>\nBest Note Combo: <G>" + ClientPrefs.campaignBestCombo + "<G>";
                }
                else if (!PlayState.isStoryMode && !PlayState.isIniquitousMode && !PlayState.isInjectionMode && !PlayState.isMayhemMode)
                {
                    info.text = "Total Score: <G>" + PlayState.freeplayScore + "<G>\nTotal Misses: <G>" + PlayState.freeplayMisses + "<G>\nTotal Rating: <G>" + FlxMath.roundDecimal((ClientPrefs.campaignRating / ClientPrefs.campaignSongsPlayed) * 100, 2) + "%<G>\nBest Note Combo: <G>" + ClientPrefs.campaignBestCombo + "<G>";
                }
                CustomFontFormats.addMarkers(info);

                info.scale.set(1.075, 1.075);
                FlxTween.tween(info.scale, {x: 1, y: 1}, 1.5, {ease: FlxEase.circOut, type: PERSIST});
            });
        }

        new FlxTimer().start(4, function(tmr:FlxTimer)
        {
            FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)), 0);
			FlxG.sound.music.fadeIn(6.0);

            FlxTween.tween(enterText, {alpha: 1}, 1.6, {ease: FlxEase.cubeInOut, type: PINGPONG});
            
            //New Record!
            if ((PlayState.isStoryMode && (ClientPrefs.campaignHighScore <= PlayState.campaignScore))
                || ((!PlayState.isStoryMode && !PlayState.isIniquitousMode && !PlayState.isInjectionMode && !PlayState.isMayhemMode) && (ClientPrefs.campaignHighScore <= PlayState.freeplayScore)))
            {
                newRecord = new FlxText(20, 500, FlxG.width,
                "New Record!",
                 35);
                 newRecord.setFormat("SF Atarian System Bold Italic", 50, FlxColor.YELLOW, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
                 newRecord.alpha = 1;
                 newRecord.borderSize = 3;
                add(newRecord);
                FlxG.sound.play(Paths.sound('newRecord'));
                FlxFlicker.flicker(newRecord, 999, 0.3, false, false);
            }
            else if ((PlayState.mayhemSongsPlayed > ClientPrefs.mayhemEndScore))
            {
                newRecord = new FlxText(20, 550, FlxG.width,
                "New Record!",
                 35);
                 newRecord.setFormat("SF Atarian System Bold Italic", 50, FlxColor.YELLOW, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
                 newRecord.alpha = 1;
                 newRecord.borderSize = 3;
                add(newRecord);
                FlxG.sound.play(Paths.sound('newRecord'));
                FlxFlicker.flicker(newRecord, 999, 0.3, false, false);
            }
            else if ((PlayState.injectionScore > ClientPrefs.injectionEndScore && PlayState.storyDifficulty == 0) || (PlayState.injectionScore > ClientPrefs.injectionVilEndScore && PlayState.storyDifficulty == 1))
            {
                newRecord = new FlxText(20, 550, FlxG.width,
                 "New Record!",
                35);
                newRecord.setFormat("SF Atarian System Bold Italic", 50, FlxColor.YELLOW, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
                newRecord.alpha = 1;
                newRecord.borderSize = 3;
                add(newRecord);
                FlxG.sound.play(Paths.sound('newRecord'));
                FlxFlicker.flicker(newRecord, 999, 0.3, false, false);
            }
        });

        new FlxTimer().start(5, function (tmr:FlxTimer) 
        {
            curNum = FlxG.random.int(0, 8);
            curColor = colors[curNum];
            new FlxTimer().start(0.5, function (tmr:FlxTimer)
            {
                changeColor();
            });
        });

        var playFailSequence:Bool = GameOverSubstate.injected || (GameOverSubstate.mayhemed && PlayState.mayhemSongsPlayed < 1) || ratingText.text = "Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..   Fail..";
        if (playFailSequence) FlxG.sound.play(Paths.sound('resultsJingleFail'));
        else FlxG.sound.play(Paths.sound('resultsJingle'));
        super.create();
    }

    var tweening:Bool = false;
    override public function update(elapsed:Float)
    {
        BGchecker.x += 0.5*(elapsed/(1/120));
        BGchecker.y += 0.16 / (ClientPrefs.framerate / 60); 

        if (controls.ACCEPT)
        {
            if (!ClientPrefs.onCrossSection) ClientPrefs.resetProgress(true);
            FlxG.sound.music.fadeOut(0.2);
            FlxG.sound.play(Paths.sound('confirmMenu'));

            new FlxTimer().start(0.2, function(tmr:FlxTimer)
            {
                if (ClientPrefs.iniquitousWeekUnlocked == true && ClientPrefs.iniquitousWeekBeaten == false)
                    FlxG.sound.playMusic(Paths.music('malumIctum'));
                else if (FlxG.random.int(1, 10) == 2)
                    FlxG.sound.playMusic(Paths.music('AJDidThat'));
                else
                    FlxG.sound.playMusic(Paths.music('freakyMenu'));
                FlxG.sound.music.fadeIn(2.0);
            });

            PlayState.checkForPowerUp = false;

            if (PlayState.isStoryMode)
            {
                if (PlayState.isIniquitousMode == true)
                    MusicBeatState.switchState(new IniquitousMenuState(), 'stickers');
                else
                    MusicBeatState.switchState(new StoryMenuState(), 'stickers');

                ClientPrefs.campaignBestCombo = 0;
                ClientPrefs.campaignRating = 0;
                ClientPrefs.campaignHighScore = 0;
                ClientPrefs.campaignSongsPlayed = 0;
                ClientPrefs.saveSettings();
            }
            else if (PlayState.isInjectionMode)
            {
                GameOverSubstate.injected = false;
                if (PlayState.storyDifficulty == 0)
                {
                    if (PlayState.injectionScore > ClientPrefs.injectionEndScore)                
                        ClientPrefs.injectionEndScore = PlayState.injectionScore;
                }
                else if (PlayState.storyDifficulty == 1)
                {
                    if (PlayState.injectionScore > ClientPrefs.injectionVilEndScore)                
                        ClientPrefs.injectionVilEndScore = PlayState.injectionScore;
                }
                PlayState.isInjectionMode = false;

			    MusicBeatState.switchState(new MainMenuState(), 'stickers');
            }
            else if (PlayState.isMayhemMode)
            {
                GameOverSubstate.mayhemed = false;
                if (PlayState.mayhemSongsPlayed > ClientPrefs.mayhemEndScore)                
                    ClientPrefs.mayhemEndScore = PlayState.mayhemSongsPlayed;
                ClientPrefs.mayhemEndTotalScore = PlayState.mayhemScore;
                PlayState.isMayhemMode = false;
                PlayState.mayhemNRMode = "";
			    MusicBeatState.switchState(new MainMenuState(), 'stickers');
            }
            else
            {
                PlayState.freeplayMisses = 0;
                PlayState.freeplayScore = 0;
                ClientPrefs.campaignBestCombo = 0;
                ClientPrefs.campaignHighScore = 0;
                ClientPrefs.campaignRating = 0;
                ClientPrefs.campaignSongsPlayed = 0;
                ClientPrefs.saveSettings();

                if (ClientPrefs.onCrossSection)
					MusicBeatState.switchState(new CrossoverState()); //go to Crossover State
				else
					MusicBeatState.switchState(new FreeplayState(), "stickers"); // Back To Freeplay
            }
                
            FlxTween.tween(BGchecker, {alpha: 0}, 0.4, {ease: FlxEase.quadInOut, type: PERSIST});
        }

        super.update(elapsed);
    }

    function playRatingTween()
    {
        FlxTween.tween(ratingText, {alpha: 1}, 0.9, {ease: FlxEase.cubeInOut, type: PERSIST});
        FlxTween.tween(ratingText, {x: ratingText.x - 50}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
        FlxTween.tween(ratingText, {y: ratingText.y + 219}, 5, {ease: FlxEase.linear, type: PERSIST});
        new FlxTimer().start(4, function (tmr:FlxTimer) 
        {
            FlxTween.tween(ratingText, {alpha: 0}, 0.9, {ease: FlxEase.cubeInOut, type: PERSIST});
            FlxTween.tween(ratingText, {x: ratingText.x + 50}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
            new FlxTimer().start(1.205, function (tmr:FlxTimer) 
            {
                ratingText.y -= 219;
                playRatingTween();
            });
        });
    }

    function changeColor()
    {
        FlxTween.color(bg, 3, FlxColor.fromString(previousColor), FlxColor.fromString(curColor), {ease: FlxEase.cubeInOut});

        new FlxTimer().start(3, function (tmr:FlxTimer) 
        {
            previousColor = curColor;
            curNum = FlxG.random.int(0, 8);
            curColor = colors[curNum];
            new FlxTimer().start(1, function (tmr:FlxTimer)
            {
                changeColor();
            });
        });
    }
}