package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class FNVSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Friday Night Villainy Settings';
		rpcTitle = 'FNV Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Mechanics', //Name
			'If checked, Mechanics are enabled. [HINT: DISABLE FOR SECRETS!]', //Description
			'mechanics', //Save data variable name
			'bool', //Variable type
			true); //Default value
		addOption(option);

		var option:Option = new Option('Shaders', //Name
			'If unchecked, disables shaders.\nIt\'s used for visual effects, but is CPU intensive for weaker PCs.', //Description
			'shaders', //Save data variable name
			'bool', //Variable type
			true); //Default value
		addOption(option);

		var option:Option = new Option('GPU Caching', //Name
			"If checked, allows the GPU to be used for caching textures, decreasing RAM usage.\nDon't turn this on if you have a shitty GPU.", //Description
			'cacheOnGPU',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('PC Changes Permanance', //Name
			'If checked, any change that occurs, such as Background changes and such, will stay, even if the mod closes.', //Description
			'allowPCChanges', //Save data variable name
			'bool', //Variable type
			true); //Default value
		addOption(option);

		var option:Option = new Option('Cinematic Bars', //Name
			'Pretty self explanatory. If checked, it adds cinematic bars to some songs.', //Description
			'cinematicBars', //Save data variable name
			'bool', //Variable type
			true); //Default value
		addOption(option);

		var option:Option = new Option('Note Splash Mode:',
			"How would you like your Note Splashes to be animated?\n[It won't work if you have them disabled.]",
			'noteSplashMode',
			'string',
			'Inwards',
			['Inwards', 'Outwards', 'Diamonds', 'Sparkles']);
		addOption(option);

		var option:Option = new Option('Timer Color Switch:', //Name
			'The Time Bar will switch colors according to the note colors.\nHow would you like this to work?', //Description
			'timeBarFlash',
			'string',
			'All Enabled',
			['All Enabled', 'Opponent Only', 'Player Only', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Combo Stacking',
			"If unchecked, Ratings and Combo won't stack, saving on System Memory and making them easier to read",
			'comboStacking',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Anti-Aliasing',
		'If unchecked, disables anti-aliasing, increases performance\nat the cost of sharper visuals.',
		'globalAntialiasing',
		'bool',
		true);
		option.showBoyfriend = true;
		option.onChange = onChangeAntiAliasing; //Changing onChange is only needed if you want to make a special interaction after it changes the value
		addOption(option);

		var option:Option = new Option('Optimization Mode', //Name
			'If checked, everything will be disabled.\nNo Visuals, No Backgrounds, No Modcharts, defaulted combos, No Shaders, disabled modes and more. Useful for Very Low-End PCS, at the cost of dealing with just a black screen with notes.', //Description
			'optimizationMode', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		var option:Option = new Option('Rating Position:',
			"In what camera do you want your ratings to show up?",
			'comboPosition',
			'string',
			'Hud',
			['Hud', 'Game']);
		addOption(option);

		var option:Option = new Option('Miss Related Combos',
			"If checked, Ratings and Combo will have different texture depending on your amount of misses.\nNo Misses = Gold Rating and Combo\n1 - 9 misses = Silver Rating and Combo\n10+ misses = Normal Rating and Combo",
			'missRelatedCombos',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Rating Sprites:',
			"If set to FNV, it loads the Custom Rating Sprites.\nIf set to FNF, it loads the Vanilla FNF Rating Sprites.\n[Both work with Miss Related Combos Above]",
			'customRating',
			'string',
			'FNV',
			['FNV', 'FNF']);
		addOption(option);

		var option:Option = new Option('Libidinousness Warning', //Name
			"Leave unchecked if you do not want to deal with Libidinousness's warning screen all the time.\nIf your PC can't handle the song though, or you want to try the low quality version, keep this option checked.", //Description
			'performanceWarning', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		if (ClientPrefs.trampolineUnlocked == true)
		{
			var option:Option = new Option('Trampoline Mode', //Name
				'If Checked, you play with the cool trampoline on\nCREDITS TO AFLAC FOR MAKING THE TRAMPOLINE SCRIPT!', //Description
				'trampolineMode', //Save data variable name
				'bool', //Variable type
				false); //Default value
			addOption(option);
		}

		#if !mobile
		var option:Option = new Option('FPS Counter',
			'If unchecked, the FPS Counter is hidden.',
			'showFPS',
			'bool',
			true);
		addOption(option);
		option.onChange = onChangeFPSCounter;

		var option:Option = new Option('Show Memory Usage',
			'If unchecked, Memory and Memory Peak will be hidden from the FPS Counter.',
			'showMemPeak',
			'bool',
			true);
		addOption(option);
		#end

		#if !html5 //Apparently other framerates isn't correctly supported on Browser? Probably it has some V-Sync shit enabled by default, idk
		var option:Option = new Option('Framerate:',
			"Pretty self explanatory, isn't it?\nMake sure to adjust it to however you prefer it to be.",
			'framerate',
			'int',
			120);
		addOption(option);

		option.minValue = 30;
		option.maxValue = 240;
		option.displayFormat = '%v FPS';
		option.onChange = onChangeFramerate;
		#end

		var option:Option = new Option('Pause Screen Song:',
		"What song do you prefer for the Pause Screen?",
		'pauseMusic',
		'string',
		'Interstellar',
		['None', 'Bounce', 'Interstellar', 'Rest', 'Leisure']);
		addOption(option);
		option.onChange = onChangePauseMusic;

		super();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end

	function onChangeAntiAliasing()
		{
			for (sprite in members)
			{
				var sprite:Dynamic = sprite; //Make it check for FlxSprite instead of FlxBasic
				var sprite:FlxSprite = sprite; //Don't judge me ok
				if(sprite != null && (sprite is FlxSprite) && !(sprite is FlxText)) {
					sprite.antialiasing = ClientPrefs.globalAntialiasing;
				}
			}
		}
	
	function onChangeFramerate()
	{
		if(ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
		}
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}
}