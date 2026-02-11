package options;

import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import lime.utils.Assets;
import flash.text.TextField;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.input.keyboard.FlxKey;
import Controls;

class MiscellaneousSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Miscellaneous Settings';
		rpcTitle = 'Miscellaneous Menu'; //for Discord Rich Presence

		#if windows
		var option:Option = new Option('PC Changes Permanance', //Name
			'If checked, any change that occurs, such as Background changes and such, will stay, even if the mod closes.', //Description
			'allowPCChanges', //Save data variable name
			'bool', //Variable type
			true); //Default value
		addOption(option);
		#end

		var option:Option = new Option('Auto Pause',
			'If checked, when you tab out of the game, the game will freeze until you hop back on.',
			'autoPause',
			'bool',
			true);
		addOption(option);
		option.onChange = function ()
		{
			FlxG.autoPause = ClientPrefs.autoPause;
		};

		var option:Option = new Option('Timer Color Switch:', //Name
			'The Time Bar will switch colors according to the note colors.\nHow would you like this to work?', //Description
			'timeBarFlash',
			'string',
			'All Enabled',
			['All Enabled', 'Opponent Only', 'Player Only', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Optimization Mode', //Name
			'If checked, everything will be disabled.\nNo Visuals, No Backgrounds, No Modcharts, defaulted combos, No Shaders, disabled modes and more. Useful for Very Low-End Devices, at the cost of dealing with just a black screen with notes.', //Description
			'optimizationMode', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		var option:Option = new Option('Libidinousness Quality', //Name
			"Leave unchecked if you want to experience Libidinousness fully.\nIf your device can't handle the song, or you want to try the low quality version, keep this option checked.", //Description
			'performanceWarning', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		if (ClientPrefs.trampolineUnlocked)
		{
			var option:Option = new Option('Trampoline Mode', //Name
				'If Checked, you play with the cool trampoline on.\nCREDITS TO AFLAC FOR MAKING THE TRAMPOLINE SCRIPT!', //Description
				'trampolineMode', //Save data variable name
				'bool', //Variable type
				false); //Default value
			addOption(option);
		}

		super();
	}
}