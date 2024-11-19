// This is completely re-typed out, I did this so I didn't just copy and paste so that HOPEFULLY it works better and doesn't need that many changes.
package;

import Section.SwagSection;

// These may be swapped depending on what may need it. Some older ones may need a different one based on the 'Song' TypeDef
import Song.SwagSong; // Usually Used One
// import Song.SongData; // What my version of Kade engine is apparently using

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import lime.utils.Assets;
import haxe.Json;
import Boyfriend.Boyfriend;
import Character.Character;
import HealthIcon.HealthIcon;
import flixel.ui.FlxBar;

import StringTools;
import FreeplayState;

class CharSelector extends MusicBeatState{
    // For Memory Usage (Check Freeplay States)
    public static var isSelectinChar:Bool = false;
    // Selectable Character Variables
    var selectableCharacters:Array<String> = ['playablegf', 'playablegf-old']; // Currently Selectable characters
    var selectableCharactersNames:Array<String> = ['Trespasser GF', 'Old Intruder GF']; // Characters names
    
    // Unlockable characters
    var unlockableChars:Array<String> = ['d-side gf']; // Unlockable Characters
    var unlockableCharsNames:Array<String> = ['D-side GF']; // Names of unlockable Characters
    
    // This is the characters that actually appear on the menu
    var unlockedCharacters:Array<String> = [];
    var unlockedCharactersNames:Array<String> = [];
    var unlockedCharactersBGs:Array<String> = [];

    // Folder locations
    var fontFolder:String = 'assets/fonts/'; // Please don't change unless font folder changes, leads to the fonts folder
    var sharedImagesFolder:String = Paths.mods('images/characters'); // Please don't change, leads to the shared folder

    // Variables for what is shown on screen
    var curSelected:Int = 0; // Which character is selected
    var icon:HealthIcon; // The healthicon of the selected character
    var menuBG:FlxSprite; // The background
    var Border:FlxSprite;
    private var imageArray:Array<Boyfriend> = []; // Array of all the selectable characters
    var selectedCharName:FlxText; // Name of selected character

    // Additional Variables
    var alreadySelected:Bool = false; // If the character is already selected
    var ifCharsAreUnlocked:Array<Bool> = FlxG.save.data.daUnlockedChars;

	var arrowSelectorLeft:FlxSprite;
	var arrowSelectorRight:FlxSprite;
    var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;
    var getIconY:Float = 0;

    var colors:Array<String> = [ 
        '0xFFa5004d', //New GF
        '0xFF9f004a', //Old GF
	];
    var curNum:Int;
    var curColor:String;
    var previousColor:String;

    override function create()
    {
        isSelectinChar = true;
        curNum = 0;
        curColor = colors[curNum];
        previousColor = curColor;

        // Useless for now
        if (ifCharsAreUnlocked == null) 
        {
            ifCharsAreUnlocked = [false];
            FlxG.save.data.daUnlockedChars = [false];
        }

        if (ClientPrefs.dsideWeekPlayed == true)
        {
            unlockedCharacters = selectableCharacters;
            unlockedCharacters[0] = PlayState.SONG.player1;
            unlockedCharactersNames = selectableCharactersNames;

            colors.push('0xFFfb7760'); //D-sides GF
            unlockedCharacters.push('d-side gf');
            unlockedCharactersNames.push('D-side GF');
        }

        if (ClientPrefs.nicPlayed == true)
        {
            unlockedCharacters = selectableCharacters;
            unlockedCharacters[0] = PlayState.SONG.player1;
            unlockedCharactersNames = selectableCharactersNames;

            colors.push('0xFFffffff'); //GF.WAV
            unlockedCharacters.push('GFwav');
            unlockedCharactersNames.push('GF.WAV');
        }

        if (ClientPrefs.susWeekPlayed == true)
          {
            unlockedCharacters = selectableCharacters;
            unlockedCharacters[0] = PlayState.SONG.player1;
            unlockedCharactersNames = selectableCharactersNames;
    
            colors.push('0xFFd83225'); //Crewmate GF
            unlockedCharacters.push('amongGF');
            unlockedCharactersNames.push('Crewmate GF');
          }
        
        if (ClientPrefs.debugPlayed == true)
        {
            unlockedCharacters = selectableCharacters;
            unlockedCharacters[0] = PlayState.SONG.player1;
            unlockedCharactersNames = selectableCharactersNames;
    
            colors.push('0xFF482b38'); //Debug GF
            unlockedCharacters.push('debugGF');
            unlockedCharactersNames.push('Debug GF');
        }
        if (ClientPrefs.morkyWeekPlayed == true)
        {
            unlockedCharacters = selectableCharacters;
            unlockedCharacters[0] = PlayState.SONG.player1;
            unlockedCharactersNames = selectableCharactersNames;
        
            colors.push('0xFFe61033'); //Spendthrift GF
            unlockedCharacters.push('Spendthrift GF');
            unlockedCharactersNames.push('Spendthrift GF');
         }

        // If the unlocked chars are empty, fill it with defaults
        if (unlockedCharacters == null) 
        {
            unlockedCharacters = selectableCharacters;
            unlockedCharacters[0] = PlayState.SONG.player1;
        } 
        // If names are empty, fill it with defaults
        if (unlockedCharactersNames == null) 
        {
            unlockedCharactersNames = selectableCharactersNames;
        }

        unlockedCharacters[0] = PlayState.SONG.player1;

        unlockedCharsCheck();

        // Making sure the background is added first to be in the back and then adding the character names and character images afterwords
        menuBG = new FlxSprite().loadGraphic(Paths.image('promotion/Background'));
        menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
        menuBG.updateHitbox();
        menuBG.screenCenter();
        menuBG.antialiasing = true;
        add(menuBG);

        // Adds the chars to the selection
        for (i in 0...unlockedCharacters.length)
        {
            var characterImage:Boyfriend = new Boyfriend(0, 0, unlockedCharacters[i]);
            if (StringTools.endsWith(unlockedCharacters[i], '-pixel'))
                characterImage.scale.set(5.5, 5.5);
            else
                characterImage.scale.set(0.8, 0.8);
                
            characterImage.screenCenter(XY);

            if (unlockedCharacters[i] == 'playablegf')
                characterImage.scale.set(1, 1);

            if (unlockedCharacters[i] == 'amongGF')
                characterImage.scale.set(0.6, 0.6);
                
            imageArray.push(characterImage);
            add(characterImage);
        }
  
        Border = new FlxSprite().loadGraphic(Paths.image('charSelect/borders'));
        Border.setGraphicSize(Std.int(menuBG.width * 1.1));
        Border.updateHitbox();
        Border.screenCenter();
        Border.antialiasing = true;
        add(Border);

        // Character select text at the top of the screen
        var selectionHeader:Alphabet = new Alphabet(0, 50, 'Character Select', true);
        selectionHeader.screenCenter(X);
        add(selectionHeader);

        // Old arrows
        // The left and right arrows on screen
        /*
        var arrows:FlxSprite = new FlxSprite().loadGraphic(Paths.image('arrowSelection', backgroundFolder));
        arrows.setGraphicSize(Std.int(arrows.width * 1.1));
        arrows.screenCenter();
        arrows.antialiasing = true;
        add(arrows);
        */

        // The currently selected character's name top right
        selectedCharName = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
        selectedCharName.setFormat(fontFolder + 'vcr.ttf', 32, FlxColor.WHITE, RIGHT);
        selectedCharName.alpha = 0.7;
        add(selectedCharName);

        arrowSelectorLeft = new FlxSprite(selectionHeader.x + 200, selectionHeader.y + 485).loadGraphic(Paths.image('freeplayStuff/arrowSelectorLeft'));
		arrowSelectorLeft.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorLeft.scale.set(0.5, 0.5);
		add(arrowSelectorLeft);

		arrowSelectorRight = new FlxSprite(selectionHeader.x + 420, selectionHeader.y + 485).loadGraphic(Paths.image('freeplayStuff/arrowSelectorRight'));
		arrowSelectorRight.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorRight.scale.set(0.5, 0.5);
		add(arrowSelectorRight);

		getRightArrowX = arrowSelectorRight.x;
		getLeftArrowX = arrowSelectorLeft.x;

        FlxTween.color(menuBG, 1.1, FlxColor.fromString(previousColor), FlxColor.fromString(curColor), {ease: FlxEase.cubeInOut});

        changeSelection();
        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
        super.create();
    }

    override function update(elapsed:Float)
    {
        selectedCharName.text = unlockedCharactersNames[curSelected].toUpperCase();
        selectedCharName.x = FlxG.width - (selectedCharName.width + 10);
        if (selectedCharName.text == '')
        {
            trace('');
            selectedCharName.text = '';
        }

        // Must be changed depending on how an engine uses its own controls
        var leftPress = controls.UI_LEFT_P; // Psych
        var rightPress = controls.UI_RIGHT_P; // Psych
        var accepted = controls.ACCEPT; // Should be Universal
        var goBack = controls.BACK; // Should be Universal

        // Testing only DO NOT USE
        var unlockTest = FlxG.keys.justPressed.U;
        
        if (!alreadySelected)
        {
            if (FlxG.mouse.overlaps(icon))
                FlxTween.tween(icon, {y: getIconY - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
            else
                FlxTween.tween(icon, {y: getIconY}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

            if (FlxG.mouse.overlaps(arrowSelectorLeft))
				FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			else
				FlxTween.tween(arrowSelectorLeft, {x: getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
	
			if (FlxG.mouse.overlaps(arrowSelectorRight))
				FlxTween.tween(arrowSelectorRight, {x: getRightArrowX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			else
				FlxTween.tween(arrowSelectorRight, {x: getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

            if (leftPress || (FlxG.mouse.overlaps(arrowSelectorLeft) && FlxG.mouse.justPressed))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                changeSelection(-1);
            }
            if (rightPress || ((FlxG.mouse.overlaps(arrowSelectorRight)) && FlxG.mouse.justPressed))
            {
                FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
                changeSelection(1);
            }
            if (accepted || (FlxG.mouse.overlaps(icon) && (!FlxG.mouse.overlaps(arrowSelectorRight)) && FlxG.mouse.justPressed))
            {
                isSelectinChar = false;
                alreadySelected = true;
                var daSelected:String = unlockedCharacters[curSelected];
                if (unlockedCharacters[curSelected] != PlayState.SONG.player1)
                    PlayState.SONG.player1 = daSelected;

                FlxG.sound.play(Paths.sound('confirmMenu'));

                imageArray[curSelected].playAnim('hey', false);

                FlxFlicker.flicker(imageArray[curSelected], 0);

                FlxTween.tween(icon, {y: icon.y + 200}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
                FlxTween.tween(icon, {angle: 5}, 0.9, {ease: FlxEase.cubeInOut, type: PERSIST});

                FlxTween.tween(arrowSelectorLeft, {x: arrowSelectorLeft.x + 10}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
                FlxTween.tween(arrowSelectorLeft, {y: arrowSelectorLeft.y + 200}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
                FlxTween.tween(arrowSelectorLeft, {angle: 7}, 0.9, {ease: FlxEase.cubeInOut, type: PERSIST});

                FlxTween.tween(arrowSelectorRight, {x: arrowSelectorRight.x + 10}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
                FlxTween.tween(arrowSelectorRight, {y: arrowSelectorRight.y + 200}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
                FlxTween.tween(arrowSelectorRight, {angle: -7}, 0.9, {ease: FlxEase.cubeInOut, type: PERSIST});

                // This is to make the audio stop when leaving to PlayState
                FlxG.sound.music.volume = 0;

                // This is used in Psych for playing music by pressing space, but the line below stops it once the PlayState is entered
				FreeplayState.destroyFreeplayVocals();

                new FlxTimer().start(1.4, function(tmr:FlxTimer)
                {
                    FlxG.mouse.visible = false;
                    LoadingState.loadAndSwitchState(new PlayState()); // Gonna try this for Psych
                });
            }
            if (goBack || FlxG.mouse.justPressedRight)
            {
                FlxG.sound.play(Paths.sound('cancelMenu'));
                if (PlayState.isStoryMode)
                    FlxG.switchState(new StoryMenuState());
                else
                    if (ClientPrefs.onCrossSection == true)
                        MusicBeatState.switchState(new CrossoverState()); //go to Crossover State
                    else if (FreeplayCategoryState.freeplayName == 'MAIN') //go to Main Freeplay
                        MusicBeatState.switchState(new FreeplayState());
                    else if (FreeplayCategoryState.freeplayName == 'BONUS') //go to Bonus Freeplay
                        MusicBeatState.switchState(new FreeplayBonusState());
                    else if (FreeplayCategoryXtraState.freeplayName == 'XTRASHOP') //go to Xtra Freeplay [Using Shop songs]
                        MusicBeatState.switchState(new FreeplayXtraState());
                    else if (FreeplayCategoryXtraState.freeplayName == 'XTRACROSSOVER') //go to Xtra Freeplay [Using Crossover Songs]
                        MusicBeatState.switchState(new FreeplayXtraCrossoverState());
                    else if (FreeplayCategoryXtraState.freeplayName == 'XTRABONUS') //go to Xtra Freeplay [Using Bonus Songs]
						MusicBeatState.switchState(new FreeplayXtraBonusState());
            }
            if (unlockTest)
                {
                    FlxG.save.data.daUnlockedChars[0] = !FlxG.save.data.daUnlockedChars[0];
                    if (FlxG.save.data.daUnlockedChars[0] == true)
                        trace("Unlocked Secret");
                    else
                        trace("Locked Secret");
                }
    
            if (!alreadySelected)
                for (i in 0...imageArray.length)
                {
                    imageArray[i].dance();
                }

            super.update(elapsed);
        }
    }

    // Changes the currently selected character
    function changeSelection(changeAmount:Int = 0):Void
    {
        // This just ensures you don't go over the intended amount
        curSelected += changeAmount;
        if (curSelected < 0)
            curSelected = unlockedCharacters.length - 1;
        if (curSelected >= unlockedCharacters.length)
            curSelected = 0;

        curNum += changeAmount;
        if (curNum < 0)
            curNum = unlockedCharacters.length - 1;
        if (curNum >= unlockedCharacters.length)
            curNum = 0;
        
        curColor = colors[curNum];
        FlxTween.color(menuBG, 1.1, FlxColor.fromString(previousColor), FlxColor.fromString(curColor), {ease: FlxEase.cubeInOut});
        previousColor = curColor;

        for (i in 0...imageArray.length)
        {
            // Sets the unselected characters to a more transparent form
            FlxTween.tween(imageArray[i], {alpha: 0.4}, 0.8, {ease: FlxEase.circOut, type: PERSIST});

            // These adjustments for Pixel characters may break for different ones, but eh, I am just making it for bf-pixel anyway
            if (StringTools.endsWith(imageArray[i].curCharacter, '-pixel'))
            {
                imageArray[i].x = (FlxG.width / 2) + ((i - curSelected - 1) * 400) + 325;
                imageArray[i].y = (FlxG.height / 2) - 60;
            }
            else
            {
                if (unlockedCharacters[i] == 'playablegf')
                {
                    FlxTween.tween(imageArray[i], {x: (FlxG.width / 2) + ((i - curSelected - 1) * 400) + 240}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    imageArray[i].y = (FlxG.height / 2) - (imageArray[i].height / 2) + 80;
                }
                else if (unlockedCharacters[i] == 'd-side gf')
                {
                    FlxTween.tween(imageArray[i], {x: (FlxG.width / 2) + ((i - curSelected - 1) * 400) + 175}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    imageArray[i].y = (FlxG.height / 2) - (imageArray[i].height / 2) + 80;
                }
                else if (unlockedCharacters[i] == 'GFwav')
                {
                    FlxTween.tween(imageArray[i], {x: (FlxG.width / 2) + ((i - curSelected - 1) * 400) + 140}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    imageArray[i].y = (FlxG.height / 2) - (imageArray[i].height / 2) + 50;
                }
                else if (unlockedCharacters[i] == 'amongGF')
                {
                    FlxTween.tween(imageArray[i], {x: (FlxG.width / 2) + ((i - curSelected - 1) * 400) + 150}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    imageArray[i].y = (FlxG.height / 2) - (imageArray[i].height / 2) + 10;
                }
                else if (unlockedCharacters[i] == 'debugGF')
                {
                    FlxTween.tween(imageArray[i], {x: (FlxG.width / 2) + ((i - curSelected - 1) * 400) + 140}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    imageArray[i].y = (FlxG.height / 2) - (imageArray[i].height / 2) + 50;
                }
                else if (unlockedCharacters[i] == 'Spendthrift GF')
                {
                    FlxTween.tween(imageArray[i], {x: (FlxG.width / 2) + ((i - curSelected - 1) * 400) + 140}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    imageArray[i].y = (FlxG.height / 2) - (imageArray[i].height / 2) + 50;
                }
                else
                {
                    FlxTween.tween(imageArray[i], {x: (FlxG.width / 2) + ((i - curSelected - 1) * 400) + 50}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
                    imageArray[i].y = (FlxG.height / 2) - (imageArray[i].height / 2);
                }      
            }
        }

        // Makes sure the character you ave selected is indeed visible
        FlxTween.tween(imageArray[curSelected], {alpha: 1}, 0.8, {ease: FlxEase.circOut, type: PERSIST});
        
        charCheck();
    }

    // Checks for what char is selected and creates an icon for it
    function charCheck()
    {
        remove(icon);

        var barBG:FlxSprite = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(sharedImagesFolder + 'healthBar.png');
        barBG.screenCenter(X);
        barBG.scrollFactor.set();
        barBG.visible = false;
        add(barBG);

        var bar:FlxBar = new FlxBar(barBG.x + 4, barBG.y + 4, RIGHT_TO_LEFT, Std.int(barBG.width - 8), Std.int(barBG.height - 8), this, 'health', 0, 2);
        bar.scrollFactor.set();
        bar.createFilledBar(0xFFFF0000, 0xFF66FF33);
        bar.visible = false;
        add(bar);

        icon = new HealthIcon(unlockedCharacters[curSelected], true);

        // This code is for Psych but if necessary can be use on other engines too
        if (unlockedCharacters[curSelected] == 'bf-car' || unlockedCharacters[curSelected] == 'bf-christmas' || unlockedCharacters[curSelected] == 'bf-holding-gf')
            icon.changeIcon('bf');
        if (unlockedCharacters[curSelected] == 'pico-player')
            icon.changeIcon('pico');
        if (unlockedCharacters[curSelected] == 'tankman-player')
            icon.changeIcon('tankman');

        //for icons that do not load in
        if (unlockedCharacters[curSelected] == 'd-side gf')
            icon.changeIcon('dsidegf');
        if (unlockedCharacters[curSelected] == 'Spendthrift GF')
            icon.changeIcon('playablegf');

        icon.screenCenter(X);
        icon.setGraphicSize(-4);
        icon.x += 50;
        icon.y = (bar.y - (icon.height / 3)) - 10;
        getIconY = icon.y;
        add(icon);
    }
    
    function unlockedCharsCheck()
    {
        // Resets all values to ensure that nothing is broken
        resetCharacterSelectionVars();

        // Makes this universal value equal the save data
        ifCharsAreUnlocked = FlxG.save.data.daUnlockedChars;

        // If you have managed to unlock a character, set it as unlocked here
        for (i in 0...ifCharsAreUnlocked.length)
        {
            if (ifCharsAreUnlocked[i] == true)
            {
                unlockedCharacters.push(unlockableChars[i]);
                unlockedCharactersNames.push(unlockableCharsNames[i]);
            }
        }
    }

    function resetCharacterSelectionVars() 
    {
        // Just resets all things to defaults
        ifCharsAreUnlocked = [false];

        // Ensures the characters are reset and that the first one is the default character
        unlockedCharacters = selectableCharacters;
        unlockedCharacters[0] = PlayState.SONG.player1; 

        // Grabs default character names
        unlockedCharactersNames = selectableCharactersNames;
    }
}