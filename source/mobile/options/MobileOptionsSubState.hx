package mobile.options;

import flixel.input.keyboard.FlxKey;
import options.BaseOptionsMenu;
import options.Option;

class MobileOptionsSubState extends BaseOptionsMenu {
	#if android
	var storageTypes:Array<String> = ["INTERNAL", "EXTERNAL"];
	var externalPaths:Array<String> = StorageUtil.checkExternalPaths(true);
	final lastStorageType:String = ClientPrefs.storageType;
	#end
	final hintOptions:Array<String> = ["No Gradient", "No Gradient (Old)", "Gradient", "Hidden"];

	public function new() {
		#if android if (!externalPaths.contains('\n'))
			storageTypes = storageTypes.concat(externalPaths); #end

		title = 'Mobile Options';
		rpcTitle = 'Mobile Options Menu'; // for Discord Rich Presence, fuck it

		var option:Option = new Option('Mobile Controls Opacity',
			'Select the opacity for the mobile buttons in the menus.', 'controlsAlpha', 'percent', 0.6);
		option.scrollSpeed = 1;
		option.minValue = 0.1;
		option.maxValue = 1;
		option.changeValue = 0.05;
		option.decimals = 2;
		option.onChange = () -> {
			touchPad.alpha = curOption.getValue();
			ClientPrefs.reloadControls();
		};
		addOption(option);

		var option:Option = new Option('In-Game Controls Opacity',
			'Select the opacity for the mobile buttons that appear in the songs.', 'gameControlsAlpha', 'percent', 0.6);
		option.scrollSpeed = 1;
		option.minValue = 0.1;
		option.maxValue = 1;
		option.changeValue = 0.05;
		option.decimals = 2;
		addOption(option);

		#if mobile
		var option:Option = new Option('Allow Phone Screensaver',
			'If checked, the phone will sleep after going inactive for few seconds.\n(The time depends on your phone\'s options)',
			'screensaver',
			'bool',
			false);
		option.onChange = () -> lime.system.System.allowScreenTimeout = curOption.getValue();
		addOption(option);
		#end

		var option:Option = new Option('Haptic Feedback',
			'If checked, any button press will provide haptic feedback.\nWARNING: Will not work if your device doesn\'t have vibration support!',
			'haptics',
			'bool',
			true);
		option.onChange = () -> {
			if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		};
		addOption(option);

		var option:Option = new Option('Hitbox Design',
			'Choose how your hitbox should look like.',
			'hitboxType',
			'string',
			'Hidden',
			hintOptions);
		addOption(option);

		var option:Option = new Option('Hitbox Position',
			'If checked, the hitbox will be put at the bottom of the screen, otherwise will stay at the top.',
			'hitboxPos',
			'bool',
			false);
		addOption(option);

		#if android
		option = new Option('Storage Type',
			'Which folder should Psych Engine use?', 'storageType',
			'string',
			'EXTERNAL',
			storageTypes);
		addOption(option);
		#end

		super();
	}

	#if android
	function onStorageChange():Void
	{
		File.saveContent(lime.system.System.applicationStorageDirectory + 'storagetype.txt', ClientPrefs.storageType);

		var lastStoragePath:String = StorageType.fromStrForce(lastStorageType) + '/';

		try
		{
			Sys.command('rm', ['-rf', lastStoragePath]);
		}
		catch (e:haxe.Exception)
		{
			trace('Failed to remove last directory. (${e.message})');
		}
	}
	#end

	override public function destroy()
	{
		super.destroy();
		#if android
		if (ClientPrefs.storageType != lastStorageType)
		{
			ClientPrefs.saveSettings();
			onStorageChange();
			CoolUtil.showPopUp('Storage Type has been changed and you need to restart the game!!\nPress OK to close the game.', 'Warning!');
			lime.system.System.exit(0);
		}
		#end
	}
}
