package;

#if desktop
import Discord.DiscordClient;
#end

import Song.SwagSong;
import haxe.Json;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.graphics.FlxGraphic;
import flixel.effects.FlxFlicker;
import WeekData;
import Alphabet;

using StringTools;

class CrashAndLoadState extends MusicBeatState
{
    var background:FlxSprite;
    var text:Alphabet;
    var songText:Alphabet;
    var songDifficultyText:Alphabet;
    var yes:Alphabet;
    var no:Alphabet;
    public static var curSelected:Int = 0;

    override function create()
    {
        PlayState.isStoryMode = true;

        background = new FlxSprite(0, 0).loadGraphic(Paths.image('mainMenuBgs/menu-1'));
		background.antialiasing = ClientPrefs.globalAntialiasing;
        background.alpha = 0.4;
		add(background);

        text = new Alphabet(200, 80, "Looks like your game closed!\n Would you like to continue\n   from where you left off?", true);
		text.setAlignmentFromString('center');
        text.scaleX = 0.8;
        text.scaleY = 0.8;
		add(text);

        switch(ClientPrefs.storyModeCrashMeasure)
        {
            //Main Week:
            case 'Toxic Mishap':
                songText = new Alphabet(540, 375, "Toxic Mishap", true);
            case 'Paycheck':
                songText = new Alphabet(540, 375, "Paycheck", true);
            case 'Villainy':
                songText = new Alphabet(635, 375, "Villainy", true);
            
            //Week 2
            case 'Nunconventional':
                songText = new Alphabet(465, 375, "Nunconventional", true);
            case 'Point Blank':
                songText = new Alphabet(560, 375, "Point Blank", true);

            //Week 3
            case 'Toybox':
                songText = new Alphabet(635, 375, "Toybox", true);
            case 'Lustality Remix':
                songText = new Alphabet(455, 375, "Lustality Remix", true);
            case 'Libidinousness':
                songText = new Alphabet(500, 375, "Libidinousness", true);

            //Legacy Week
            case 'Toxic Mishap (Legacy)':
                songText = new Alphabet(345, 375, "Toxic Mishap (Legacy)", true);
            case 'Paycheck (Legacy)':
                songText = new Alphabet(455, 375, "Paycheck (Legacy)", true);

                
            //Week Morky
            case "Instrumentally Deranged":
                songText = new Alphabet(515, 375, "Inst. Deranged", true);

            case "Get Villain'd" | 'get villaind':
                songText = new Alphabet(515, 375, "Get Villain'd", true);

            //Week Sus
            case 'Villain In Board':
                songText = new Alphabet(455, 375, "Villain In Board", true);
            case 'Excrete':
                songText = new Alphabet(655, 375, "Excrete", true);

            //Week D-sides
            case 'Cheque':
                songText = new Alphabet(665, 375, "Cheque", true);
            case "Get Gooned":
                songText = new Alphabet(585, 375, "Get Gooned", true);

            default: //Testing Value
                songText = new Alphabet(485, 375, "Test Song Name", true); 
        }
		songText.setAlignmentFromString('center');
        songText.scaleX = 0.8;
        songText.scaleY = 0.8;
		add(songText);

        if (ClientPrefs.storyModeCrashMeasure == '') //test purposes
            songDifficultyText = new Alphabet(600, 480, "Difficulty", true);
        else
            songDifficultyText = new Alphabet(600, 480, ClientPrefs.storyModeCrashDifficulty + '-', true);
		songDifficultyText.setAlignmentFromString('center');
        songDifficultyText.scaleX = 0.8;
        songDifficultyText.scaleY = 0.8;
        if (ClientPrefs.storyModeCrashDifficulty == '-villainous')
            songDifficultyText.x -= 50;
		add(songDifficultyText);

        yes = new Alphabet(340, 530, "yes", true);
		yes.setAlignmentFromString('center');
        yes.scaleX = 1.1;
        yes.scaleY = 1.1;
        yes.updateHitbox();
		add(yes);

        no = new Alphabet(960, 530, "no", true);
		no.setAlignmentFromString('center');
        no.scaleX = 1.1;
        no.scaleY = 1.1;
        no.updateHitbox();
		add(no);

        FlxTween.tween(text, {y: text.y + 10}, 5.7, {ease: FlxEase.cubeInOut, type: PINGPONG});
        FlxTween.tween(songText, {y: songText.y + 10}, 5.75, {ease: FlxEase.cubeInOut, type: PINGPONG});
        FlxTween.tween(songDifficultyText, {y: songDifficultyText.y + 10}, 5.8, {ease: FlxEase.cubeInOut, type: PINGPONG});

        changeSelection();
        super.create();
    }

    var selectedSomething:Bool = false;
    var overlapping:Bool = false;
    var mechanicless:String = '';
    override function update(elapsed:Float)
    {
        if ((controls.BACK || FlxG.mouse.justPressedRight) && selectedSomething == false)
            {
                MusicBeatState.switchState(new StoryMenuState());
                FlxG.sound.play(Paths.sound('cancelMenu'));
            }
        
        if ((FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A) && selectedSomething == false)
            {
                changeSelection(-1);
            }

        if (FlxG.mouse.overlaps(yes) && selectedSomething == false && overlapping == false && curSelected != 0)
            {
                curSelected = 0;
                changeSelection();
                overlapping = true;
            }

        if (FlxG.mouse.overlaps(no) && selectedSomething == false && overlapping == false && curSelected != 1)
            {
                curSelected = 1;
                changeSelection();
                overlapping = true;
            }
        
        if (!(FlxG.mouse.overlaps(no) || FlxG.mouse.overlaps(yes)) && selectedSomething == false && overlapping == true)
            {
                overlapping = false;
            }
        
        if ((FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D) && selectedSomething == false)
            {
                changeSelection(1);
            }

        if (((curSelected == 0 && controls.ACCEPT) || (FlxG.mouse.overlaps(yes) && FlxG.mouse.justPressed)) && selectedSomething == false)
            {
                selectedSomething = true;
                FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);

                switch(ClientPrefs.storyModeCrashMeasure)
                {
                    //Main Week:
                    case 'Toxic Mishap':
                        if (ClientPrefs.mechanics == false && ClientPrefs.storyModeCrashDifficultyNum == 1)
                            mechanicless = "Mechanicless";
                        if (ClientPrefs.storyModeCrashDifficultyNum >= 1)
                            PlayState.storyPlaylist = ['Toxic Mishap', 'Paycheck', 'Villainy'];
                        else
                            PlayState.storyPlaylist = ['Toxic Mishap', 'Paycheck'];
                    case 'Paycheck':
                        if (ClientPrefs.storyModeCrashDifficultyNum >= 1)
                            PlayState.storyPlaylist = ['Paycheck', 'Villainy'];
                        else
                            PlayState.storyPlaylist = ['Paycheck'];
                    case 'Villainy':
                        PlayState.storyPlaylist = ['Villainy'];

                    //Week 2
                    case 'Nunconventional':
                        if (ClientPrefs.storyModeCrashDifficultyNum >= 1)
                        {
                            PlayState.storyPlaylist = ['Nunconventional', 'Point Blank'];
                            if (ClientPrefs.storyModeCrashDifficultyNum == 2)
                                ClientPrefs.ghostTapping = false;
                        } 
                        else
                            PlayState.storyPlaylist = ['Nunconventional'];
                    case 'Point Blank':
                        PlayState.storyPlaylist = ['Point Blank'];

                    //Week 3
                    case 'Toybox':
                        if (ClientPrefs.mechanics == false && ClientPrefs.storyModeCrashDifficultyNum <= 1)
                            mechanicless = "Mechanicless";
                        if (ClientPrefs.storyModeCrashDifficultyNum >= 1)
                            PlayState.storyPlaylist = ['Toybox', 'Lustality Remix', 'Libidinousness'];
                        else
                            PlayState.storyPlaylist = ['Toybox', 'Lustality Remix'];
                    case 'Lustality Remix':
                        if (ClientPrefs.mechanics == false)
                            mechanicless = "Mechanicless";
                        if (ClientPrefs.storyModeCrashDifficultyNum >= 1)
                            PlayState.storyPlaylist = ['Lustality Remix', 'Libidinousness'];
                        else
                            PlayState.storyPlaylist = ['Lustality Remix'];
                    case 'Libidinousness':
                        if (ClientPrefs.optimizationMode == true || ClientPrefs.lowQuality == true)
                            mechanicless = "optimized";
                        PlayState.storyPlaylist = ['Libidinousness'];

                    //Legacy Week
                    case 'Toxic Mishap (Legacy)':
                        if (ClientPrefs.mechanics == false)
                            mechanicless = "Mechanicless";
                        PlayState.storyPlaylist = ['Toxic Mishap (Legacy)', 'Paycheck (Legacy)'];
                    case 'Paycheck (Legacy)':
                        PlayState.storyPlaylist = ['Paycheck (Legacy)'];

                    //Week Morky
                    case "Instrumentally Deranged":
                        PlayState.storyPlaylist = ["Instrumentally Deranged", "Get Villain'd"];
                    case "Get Villain'd" | 'get villaind':
                        PlayState.storyPlaylist = ["Get Villain'd"];

                    //Week Sus
                    case 'Villain In Board':
                        if (ClientPrefs.storyModeCrashDifficultyNum == 1)
                            PlayState.storyPlaylist = ['Villain In Board', 'Excrete'];
                        else
                            PlayState.storyPlaylist = ['Villain In Board'];   
                    case 'Excrete':
                        PlayState.storyPlaylist = ['Excrete'];

                    //Week D-sides
                    case 'Cheque':
                        PlayState.storyPlaylist = ['Cheque', "Get Gooned"];
                    case "Get Gooned":
                        PlayState.storyPlaylist = ["Get Gooned"];
                }

                CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
                
                FlxFlicker.flicker(yes, 1, 0.04, false);
                PlayState.storyDifficulty = ClientPrefs.storyModeCrashDifficultyNum;
                PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + ClientPrefs.storyModeCrashDifficulty + mechanicless, PlayState.storyPlaylist[0].toLowerCase());
				PlayState.campaignScore += ClientPrefs.storyModeCrashScore;
				PlayState.campaignMisses += ClientPrefs.storyModeCrashMisses;

                PlayState.storyWeek = ClientPrefs.storyModeCrashWeek;

                trace('Saved Score :' + ClientPrefs.storyModeCrashScore);
				trace('Saved Misses: ' + ClientPrefs.storyModeCrashMisses);
				trace('Saved Week: ' + ClientPrefs.storyModeCrashWeek);
				trace('Saved Week Name: ' + ClientPrefs.storyModeCrashWeekName);
				trace('Saved Song: ' + ClientPrefs.storyModeCrashMeasure);
				trace('Saved Difficulty: ' + ClientPrefs.storyModeCrashDifficulty);
                trace('Saved Difficulty Number: ' + ClientPrefs.storyModeCrashDifficultyNum);
				trace('Saved High Score for Week: ' + ClientPrefs.campaignHighScore);
				trace('Saved Total Rating for the Week: ' + ClientPrefs.campaignRating);
				trace('Saved Best Combo for the Week so far: ' + ClientPrefs.campaignBestCombo);
				trace('Saved Songs Played For Week: ' + ClientPrefs.campaignSongsPlayed);
                trace('CURRENT WEEK: ' + WeekData.getWeekFileName() + ' - ' + ClientPrefs.storyModeCrashWeek);

                if (ClientPrefs.storyModeCrashWeekName == 'weeklegacy') //checking if it is the legacy week
                {   
                    PlayState.SONG.player1 = 'playablegf-old'; //change the player to the old version
                    if (ClientPrefs.storyModeCrashMeasure != 'Paycheck (Legacy)')
                    PlayState.SONG.player2 = 'marco-old'; //change the opponent to the old version
                }

                FlxG.camera.flash(FlxColor.WHITE, 1);
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
                    FlxG.mouse.visible = false;
					LoadingState.loadAndSwitchState(new PlayState(), true);
					FreeplayState.destroyFreeplayVocals();
				});
            }
    
         if (((curSelected == 1 && controls.ACCEPT) || (FlxG.mouse.overlaps(no) && FlxG.mouse.justPressed)) && selectedSomething == false)
            {
                FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
                selectedSomething = true;

                ClientPrefs.resetStoryModeProgress(true);

                ClientPrefs.campaignBestCombo = 0;
                ClientPrefs.campaignRating = 0;
                ClientPrefs.campaignHighScore = 0;
                ClientPrefs.campaignSongsPlayed = 0;
				ClientPrefs.saveSettings();

                MusicBeatState.switchState(new StoryMenuState());
            }

        super.update(elapsed);
    }

    function changeSelection(huh:Int = 0)
		{
			curSelected += huh;
            FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

            if (curSelected > 1)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = 1;
        
            if (curSelected == 0)
            {
                yes.alpha = 1;
                yes.text = '>yes<';

                no.alpha = 0.6;
                no.text = 'no';
            }
            if (curSelected == 1)
            {
                no.alpha = 1;
                no.text = '>no<';

                yes.alpha = 0.6;
                yes.text = 'yes';
            }
        }
}