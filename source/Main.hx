package;

import flixel.FlxGame;
import openfl.Assets;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.system.System as LimeSystem;
#if mobile
import mobile.states.CopyState;
#end

import CrashHandler;

class Main extends Sprite
{
	public static final game = 
	{
		width: 1280, // Window Width
		height: 720, // Window Height
		initialState: CopyState, // The FlxState the game starts with.
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

		#if android
		StorageUtil.requestPermissions();
		#end

		#if mobile
		Sys.setCwd(StorageUtil.getStorageDirectory());

		#if sys
		trace("CWD: " + StorageUtil.getStorageDirectory());
		#end
		#end

		CrashHandler.init();
		trace("Main.hx: Crash handler is up!");

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
		addChild(gameObject);

		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) fpsVar.visible = ClientPrefs.showFPS;

		FlxG.game.focusLostFramerate = #if mobile 30 #else 60 #end;

		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end

		#if mobile
		LimeSystem.allowScreenTimeout = ClientPrefs.screensaver;
		#end

		#if hxvlc
		hxvlc.util.Handle.init(#if (hxvlc >= "1.8.0") ['--no-lua'] #end);
		#end
		
		// shader coords fix
		FlxG.signals.gameResized.add(function (w, h) {
			@:privateAccess
			{
				if (FlxG.cameras != null) {
					for (cam in FlxG.cameras.list) {
						if (cam != null && cam._filters != null)
							resetSpriteCache(cam.flashSprite);
					}
				}
			
				if (FlxG.game != null)
					resetSpriteCache(FlxG.game);
			}
		});
	}

	public static function repositionFPS()
	{
		fpsVar.x = MobileUtil.rawX(fpsVar.x);
	}

	static function resetSpriteCache(sprite:Sprite):Void {
		@:privateAccess {
		        sprite.__cacheBitmap = null;
			sprite.__cacheBitmapData = null;
		}
	}
}
