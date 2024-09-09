package;

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
import flixel.addons.display.FlxBackdrop;

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

class PromotionState extends MusicBeatState
{
    public static var curModSelected:Int = 0;

    var background:FlxSprite;
    var BGchecker:FlxBackdrop;
    var scaleObjectHatesMe:FlxSprite;
    var borders:FlxSprite;
    var currentImage:FlxSprite;
    var titleText:Alphabet;
    var textBG:FlxSprite;
    var Text:FlxText;

    var curNum:Int;
    var curColor:String;
    var previousColor:String;
    
    var arrowSelectorLeft:FlxSprite;
	var arrowSelectorRight:FlxSprite;
	var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;

    var colors:Array<String> = [ 
        '0xFF03fc20',
        '0xFF03fcc2',
        '0xFF0318fc',
        '0xFF9003fc',
        '0xFFfc03d2',
        '0xFFfc0303',
        '0xFFfc7303',
        '0xFFfcf403'
	];

    var modSelected:Array<String> = [
        'cross',
        'groovin',
        'secretGarden',
        'mutedMelodies',
        'virus',
        'goon',
        'ss',
        'kofi',
        'lily',
        'tsah',
        'rayna',
        'berrie',
        'km',
        'spacey',
        'giraffe',
        'fnt',
        'gt',
        'fr',
        'galaxy',
        'mad',
        'danke',
        'alice'
    ];

    override function create()
    {
        #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Mod Promotions", null);
		#end

        curNum = FlxG.random.int(0, 7);
        curColor = colors[curNum];
        previousColor = curColor;

        background = new FlxSprite(0, 0).loadGraphic(Paths.image('promotion/Background'));
        background.setGraphicSize(Std.int(background.width * 1.175));
		background.antialiasing = ClientPrefs.globalAntialiasing;
		add(background);

        BGchecker = new FlxBackdrop(Paths.image('promotion/BGgrid-' + FlxG.random.int(1, 8)), 0, 0, true, true); 
		BGchecker.updateHitbox(); 
		BGchecker.scrollFactor.set(0, 0); 
		BGchecker.alpha = 0; 
		BGchecker.screenCenter(X); 
		add(BGchecker);

        FlxTween.tween(BGchecker, {alpha: 1}, 2.2, {ease: FlxEase.cubeInOut, type: PERSIST});

        FlxTween.tween(background, {y: 0}, 20, {ease: FlxEase.quadInOut, type: PINGPONG});
		FlxTween.tween(background, {x: 0}, 20, {ease: FlxEase.quadInOut, type: PINGPONG});

        textBG = new FlxSprite(0, FlxG.height - 38).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

        Text = new FlxText(textBG.x + 1000, textBG.y + 8, FlxG.width + 1000, "LEFT - A / RIGHT - D: Change Mod | CLICK ON MOD / ENTER: Go to mod's download page | BACKSPACE: Go back to the Main Menu", 24);
		Text.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, RIGHT);
		Text.scrollFactor.set();
		add(Text);

        FlxTween.tween(Text, {x: textBG.x - 2500}, 20, {ease: FlxEase.linear, type: LOOPING});

        currentImage = new FlxSprite(0, -20).loadGraphic(Paths.image('promotion/prom_' + modSelected[curModSelected]));
		currentImage.antialiasing = ClientPrefs.globalAntialiasing;
		currentImage.scale.set(0.7, 0.7);
		add(currentImage);

        scaleObjectHatesMe = new FlxSprite(currentImage.x + 191, currentImage.y + 109).loadGraphic(Paths.image('promotion/transparentButtonBecauseUpdateHitbox()Sucks'));
        scaleObjectHatesMe.alpha = 0;
		scaleObjectHatesMe.antialiasing = ClientPrefs.globalAntialiasing;
		add(scaleObjectHatesMe);
 
        borders = new FlxSprite(0, 0).loadGraphic(Paths.image('promotion/Borders'));
		borders.antialiasing = ClientPrefs.globalAntialiasing;
		add(borders);

        titleText = new Alphabet(currentImage.x + 630, currentImage.y + 30, "This is a test", true);
		titleText.setAlignmentFromString('center');
        titleText.scaleX = 0.8;
        titleText.scaleY = 0.8;
		add(titleText);

        FlxTween.tween(currentImage, {y: currentImage.y + 30}, 3.6, {ease: FlxEase.quadInOut, type: PINGPONG});
        FlxTween.tween(scaleObjectHatesMe, {y: scaleObjectHatesMe.y + 30}, 3.6, {ease: FlxEase.quadInOut, type: PINGPONG});
        FlxTween.tween(titleText, {y: titleText.y + 10}, 3.6, {ease: FlxEase.quadInOut, type: PINGPONG});

        switch(modSelected[curModSelected])
            {
                case 'cross':
                    titleText.text = "Head Honcho Havoc";
                case 'groovin':
                    titleText.text = "Graffiti Groovin'";
                case 'secretGarden':
                    titleText.text = "Secret Garden";
                case 'mutedMelodies':
                    titleText.text = "Muted Melodies Remastered";
                case 'virus':
                    titleText.text = "VS Virus R";
                case 'goon':
                    titleText.text = "Vs Cassette Goon";
                case 'ss':
                    titleText.text = "Singe and Sear";
                case 'kofi':
                    titleText.text = "Vs Kofi";
                case 'lily':
                    titleText.text = "Lily in Grave";
                case 'tsah':
                    titleText.text = "The Stakes are High";
                case 'rayna':
                    titleText.text = "Vs Rayna";
                case 'berrie':
                    titleText.text = "Vs Berrie";
                case 'km':
                    titleText.text = "Vs Kratos Messi";
                case 'spacey':
                    titleText.text = "Vs Spacey";
                case 'giraffe':
                    titleText.text = "Vs Girrafe";
                case 'fnt':
                    titleText.text = "Friday Night Troubleshooting";
                case 'gt':
                    titleText.text = "Vs Ghost Twins";
                case 'fr':
                    titleText.text = "Flavor Rave";
                case 'galaxy':
                    titleText.text = "Vs Galaxy";
                case 'mad':
                    titleText.text = "VS Mime and Dash";
                case 'danke':
                    titleText.text = "Vs Danke";
                case 'alice':
                    titleText.text = "Alice Mad & Hopeless";
            }

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
 
        FlxTween.color(background, 5, FlxColor.fromString(previousColor), FlxColor.fromString(curColor), {ease: FlxEase.cubeInOut});

        new FlxTimer().start(5, function (tmr:FlxTimer) 
        {
            previousColor = curColor;
            curNum = FlxG.random.int(0, 7);
            curColor = colors[curNum];
            new FlxTimer().start(1, function (tmr:FlxTimer)
            {
                changeColor();
            });
        });

        super.create();
    }

    var sidePressed:String = '';
    override function update(elapsed:Float)
    {
        BGchecker.x += 0.5*(elapsed/(1/120));
        BGchecker.y += 0.16 / (ClientPrefs.framerate / 60); 

        if (FlxG.mouse.overlaps(arrowSelectorLeft))
			FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

		if (FlxG.mouse.overlaps(arrowSelectorRight))
			FlxTween.tween(arrowSelectorRight, {x: getRightArrowX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(arrowSelectorRight, {x: getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

        if (controls.BACK || FlxG.mouse.justPressedRight)
        {
            FlxTween.tween(BGchecker, {alpha: 0}, 0.4, {ease: FlxEase.quadInOut, type: PERSIST});
            MusicBeatState.switchState(new MainMenuState(), 'stickers');
            FlxG.sound.play(Paths.sound('cancelMenu'));
        }

        if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A || (FlxG.mouse.overlaps(arrowSelectorLeft) && FlxG.mouse.justPressed))
		{
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			sidePressed = 'LEFT';
			changeMod(-1);	
		}

		if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D || (FlxG.mouse.overlaps(arrowSelectorRight) && FlxG.mouse.justPressed))
		{
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
			sidePressed = 'RIGHT';
			changeMod(1);
		}

        if (controls.ACCEPT || (FlxG.mouse.overlaps(scaleObjectHatesMe) && FlxG.mouse.justPressed))
        {
            switch(modSelected[curModSelected])
            {
                case 'cross':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/407057');
                case 'groovin':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/409366');
                case 'secretGarden':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/366043');
                case 'mutedMelodies':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/393813');
                case 'virus':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/377135');
                case 'goon':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/416623');
                case 'ss':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/323738');
                case 'kofi':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/378433');
                case 'lily':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/326933');
                case 'tsah':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/390469');
                case 'rayna':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/419429');
                case 'berrie':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/377627');
                case 'km':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/416935');
                case 'spacey':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/328996');
                case 'giraffe':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/417333');
                case 'fnt':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/320006');
                case 'gt':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/295291');
                case 'fr':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/410436');
                case 'galaxy':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/285489');
                case 'mad':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/406773');
                case 'danke':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/405356');
                case 'alice':
                    CoolUtil.browserLoad('https://gamebanana.com/mods/397012');
            }
        }
        super.update(elapsed);
    }

    function changeColor()
    {
        FlxTween.color(background, 5, FlxColor.fromString(previousColor), FlxColor.fromString(curColor), {ease: FlxEase.cubeInOut});

        new FlxTimer().start(5, function (tmr:FlxTimer) 
        {
            previousColor = curColor;
            curNum = FlxG.random.int(0, 7);
            curColor = colors[curNum];
            new FlxTimer().start(1, function (tmr:FlxTimer)
            {
                changeColor();
            });
        });
    }
    
    function changeMod(huh:Int = 0)
		{
			curModSelected += huh;
	
			if (curModSelected >= modSelected.length)
				curModSelected = 0;
			if (curModSelected < 0)
				curModSelected = modSelected.length - 1;

            currentImage.loadGraphic(Paths.image('promotion/prom_' + modSelected[curModSelected]));

            switch(modSelected[curModSelected])
            {
                case 'cross':
                    titleText.text = "Head Honcho Havoc";
                case 'groovin':
                    titleText.text = "Graffiti Groovin'";
                case 'secretGarden':
                    titleText.text = "Secret Garden";
                case 'mutedMelodies':
                    titleText.text = "Muted Melodies Remastered";
                case 'virus':
                    titleText.text = "VS Virus R";
                case 'goon':
                    titleText.text = "Vs Cassette Goon";
                case 'ss':
                    titleText.text = "Singe and Sear";
                case 'kofi':
                    titleText.text = "Vs Kofi";
                case 'lily':
                    titleText.text = "Lily in Grave";
                case 'tsah':
                    titleText.text = "The Stakes are High";
                case 'rayna':
                    titleText.text = "Vs Rayna";
                case 'berrie':
                    titleText.text = "Vs Berrie";
                case 'km':
                    titleText.text = "Vs Kratos Messi";
                case 'spacey':
                    titleText.text = "Vs Spacey";
                case 'giraffe':
                    titleText.text = "Vs Girrafe";
                case 'fnt':
                    titleText.text = "Friday Night Troubleshooting";
                case 'gt':
                    titleText.text = "Vs Ghost Twins";
                case 'fr':
                    titleText.text = "Flavor Rave";
                case 'galaxy':
                    titleText.text = "Vs Galaxy";
                case 'mad':
                    titleText.text = "VS Mime and Dash";
                case 'danke':
                    titleText.text = "Vs Danke";
                case 'alice':
                    titleText.text = "Alice Mad & Hopeless";
            }
        }
}