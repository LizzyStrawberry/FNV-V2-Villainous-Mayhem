package;

import Song.SwagSong;
import haxe.Json;

import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import lime.net.curl.CURLCode;
import WeekData;
import Alphabet;

using StringTools;

class CrashAndLoadState extends MusicBeatState
{
    var background:FlxSprite;
    var text:Alphabet;
    var songText:Alphabet;
    var yes:Alphabet;
    var no:Alphabet;
    public static var curSelected:Int = 0;
    public static var isDebugMode:Bool = false;

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

        var songName:String = "Test Song";
        if (ClientPrefs.crashSongName != null && ClientPrefs.crashSongName != "") songName = ClientPrefs.crashSongName;
        switch(ClientPrefs.crashSongName)
        {
            //Week Morky
            case "Instrumentally Deranged":
                songName = "Inst. Deranged";
            case "Get Villain'd" | 'get villaind':
                songName = "Get Villain'd";

            default: //Testing Value
                songName = ClientPrefs.crashSongName; 
        }
        songText = new Alphabet(600, 375, "", true); 
        songText.text = songName + ((ClientPrefs.crashSongName == '') ? "\nDifficulty" : "\n" + ClientPrefs.crashDifficultyName + '-');
        songText.scaleX = 0.8;
        songText.scaleY = 0.8;
        songText.setAlignmentFromString('center');
        songText.x = 830;
		add(songText);

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

        changeSelection();
        super.create();
    }

    var selectedSomething:Bool = false;
    var overlapping:Bool = false;
    var mechanicless:String = '';
    override function update(elapsed:Float)
    {
        if ((controls.BACK || FlxG.mouse.justPressedRight) && !selectedSomething)
        {
            exitState(false);
        }
        
        if (!selectedSomething)
        {
            if (controls.UI_LEFT_P) changeSelection(-1);
            if (controls.UI_RIGHT_P) changeSelection(1);

            if (FlxG.mouse.overlaps(yes) && !overlapping && curSelected != 0)
            {
                curSelected = 0;
                changeSelection();
                overlapping = true;
            }
            if (FlxG.mouse.overlaps(no) && !overlapping && curSelected != 1)
            {
                curSelected = 1;
                changeSelection();
                overlapping = true;
            }
            
            if (!(FlxG.mouse.overlaps(no) || FlxG.mouse.overlaps(yes)) && overlapping) overlapping = false;

            if ((curSelected == 0 && controls.ACCEPT) || (FlxG.mouse.overlaps(yes) && FlxG.mouse.justPressed))
            {
                selectedSomething = true;
                FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);

                switch(ClientPrefs.crashSongName)
                {
                    //Main Week:
                    case 'Toxic Mishap':
                        if (!ClientPrefs.mechanics && ClientPrefs.crashDifficulty == 1) mechanicless = "Mechanicless";
                        if (ClientPrefs.crashDifficulty >= 1)
                            PlayState.storyPlaylist = ['Toxic Mishap', 'Paycheck', 'Villainy'];
                        else
                            PlayState.storyPlaylist = ['Toxic Mishap', 'Paycheck'];
                    case 'Paycheck':
                        if (ClientPrefs.crashDifficulty >= 1)
                            PlayState.storyPlaylist = ['Paycheck', 'Villainy'];
                        else
                            PlayState.storyPlaylist = ['Paycheck'];
                    case 'Villainy':
                        PlayState.storyPlaylist = ['Villainy'];

                    //Week 2
                    case 'Nunconventional':
                        if (ClientPrefs.crashDifficulty >= 1)
                        {
                            PlayState.storyPlaylist = ['Nunconventional', 'Point Blank'];
                            if (ClientPrefs.crashDifficulty == 2) ClientPrefs.ghostTapping = false;
                        } 
                        else
                            PlayState.storyPlaylist = ['Nunconventional'];
                        case 'Point Blank':
                            PlayState.storyPlaylist = ['Point Blank'];

                    //Week 3
                    case 'Toybox':
                        if (!ClientPrefs.mechanics && ClientPrefs.crashDifficulty <= 1) mechanicless = "Mechanicless";
                        if (ClientPrefs.crashDifficulty >= 1)
                            PlayState.storyPlaylist = ['Toybox', 'Lustality Remix', 'Libidinousness'];
                        else
                            PlayState.storyPlaylist = ['Toybox', 'Lustality Remix'];
                    case 'Lustality Remix':
                        if (!ClientPrefs.mechanics) mechanicless = "Mechanicless";
                        if (ClientPrefs.crashDifficulty >= 1) PlayState.storyPlaylist = ['Lustality Remix', 'Libidinousness'];
                        else PlayState.storyPlaylist = ['Lustality Remix'];
                    case 'Libidinousness':
                        if (ClientPrefs.optimizationMode || ClientPrefs.lowQuality) mechanicless = "optimized";
                        PlayState.storyPlaylist = ['Libidinousness'];

                    //Legacy Week
                    case 'Toxic Mishap (Legacy)':
                        if (!ClientPrefs.mechanics) mechanicless = "Mechanicless";
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
                        if (ClientPrefs.crashDifficulty == 1) PlayState.storyPlaylist = ['Villain In Board', 'Excrete'];
                        else PlayState.storyPlaylist = ['Villain In Board'];   
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
                PlayState.storyDifficulty = ClientPrefs.crashDifficulty;
                PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + ClientPrefs.crashDifficultyName + mechanicless, PlayState.storyPlaylist[0].toLowerCase());
                PlayState.campaignScore += ClientPrefs.crashScore;
                PlayState.campaignMisses += ClientPrefs.crashMisses;

                PlayState.storyWeek = ClientPrefs.crashWeek;

                ClientPrefs.traceProgress("story");
                ClientPrefs.traceProgress("campaign");

                if (ClientPrefs.crashWeekName == 'weeklegacy') //checking if it is the legacy week
                {   
                    PlayState.SONG.player1 = 'playablegf-old'; //change the player to the old version
                    if (ClientPrefs.crashSongName != 'Paycheck (Legacy)') PlayState.SONG.player2 = 'marco-old'; //change the opponent to the old version
                }

                exitState(true);
            }
        
            if ((curSelected == 1 && controls.ACCEPT) || (FlxG.mouse.overlaps(no) && FlxG.mouse.justPressed))
            {
                FlxG.sound.play(Paths.sound('confirmMenu'), 0.4);
                selectedSomething = true;

                exitState(false);
            }
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

    private function exitState(accepted:Bool)
    {
        if(accepted)
        {
            FlxG.camera.flash(FlxColor.WHITE, 1);
            new FlxTimer().start(1, function(tmr:FlxTimer)
            {
                FlxG.mouse.visible = false;
                LoadingState.loadAndSwitchState(new PlayState(), true);
                FreeplayState.destroyFreeplayVocals();
            });
        }
        else 
        {
            if (isDebugMode)
            {
                MusicBeatState.switchState(new MainMenuState());
                isDebugMode = false;
            }
            else 
            {
                ClientPrefs.resetProgress(true);

                ClientPrefs.campaignBestCombo = 0;
                ClientPrefs.campaignRating = 0;
                ClientPrefs.campaignHighScore = 0;
                ClientPrefs.campaignSongsPlayed = 0;
                ClientPrefs.saveSettings();

                MusicBeatState.switchState(new StoryMenuState());
            }
        }
    }
}