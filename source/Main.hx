package;

import flixel.FlxGame;
import openfl.Assets;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;

//crash handler stuff
#if CRASH_HANDLER
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.io.Process;
#end

#if linux
import lime.graphics.Image;
#end

#if linux
@:cppInclude('./external/gamemode_client.h')
@:cppFileCode('
	#define GAMEMODE_AUTO
')
#end

class Main extends Sprite
{
	public static final game = 
	{
		width: 1280, // Window Width
		height: 720, // Window Height
		initialState: #if STARTUP_CACHE Cache #else TitleState #end, // State to load
		fps: 60, // Framerate
		skipSplash: true, // Skip Haxeflixel logo splash
		startFullscreen: false // Full Screen
	}

	public static var fpsVar:FPS;

	// You can pretty much ignore everything from here on - your code should go in your states.
	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE)) removeEventListener(Event.ADDED_TO_STAGE, init);

		setupGame();
	}

	private function setupGame():Void
	{
		FlxG.save.bind('Friday Night Villainy', CoolUtil.getSavePath());
		ClientPrefs.loadDefaultKeys();

		// Add new gameObject
		var gameObject = new FlxGame(game.width, game.height, game.initialState, game.fps, game.fps, game.skipSplash, game.startFullscreen);
		// Setting up Custom Sound Tray
		// FlxG.game._customSoundTray wants just the class, it calls new from
		// create() in there, which gets called when it's added to stage
		// which is why it needs to be added before addChild(game) here
		@:privateAccess
		gameObject._customSoundTray = FunkinSoundTray;
		addChild(gameObject);

		#if !mobile
		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) fpsVar.visible = ClientPrefs.showFPS;
		#end

		#if html5
		FlxG.mouse.visible = false;
		#end

		prevVolume = FlxG.sound.volume;
		
		addEventListener(Event.ACTIVATE, onFocus);
		addEventListener(Event.DEACTIVATE, onFocusLost);

		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end
	}

	var prevVolume:Float = 1;
    var volumeTween:FlxTween;
	function onFocusLost(_):Void
    {
        if (!FlxG.autoPause)
        {
            prevVolume = FlxG.sound.volume;
            if (volumeTween != null)  volumeTween.cancel();
            volumeTween = FlxTween.num(FlxG.sound.volume, prevVolume * 0.25, 0.4, {ease: FlxEase.cubeInOut, type: PERSIST}, volFunc.bind());
        }
    }
    function onFocus(_):Void
    {
        if (!FlxG.autoPause)
        {
            if (volumeTween != null) volumeTween.cancel();
            volumeTween = FlxTween.num(FlxG.sound.volume, prevVolume, 0.4, {ease: FlxEase.cubeInOut, type: PERSIST}, volFunc.bind());
        }
    }
	function volFunc(v:Float) { FlxG.sound.volume = v; }

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "PsychEngine_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error + "\nPlease report this error to the GitHub page: https://github.com/ShadowMario/FNF-PsychEngine\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		DiscordClient.shutdown();
		Sys.exit(1);
	}
	#end
}
