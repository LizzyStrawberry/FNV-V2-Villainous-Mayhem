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
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = #if (mobile && MODS_ALLOWED) !CopyState.checkExistingFiles() ? CopyState #end : #if STARTUP_CACHE Cache #else TitleState #end; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 120; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
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
		trace("CWD IS " + StorageUtil.getStorageDirectory());
		#end

		CrashHandler.init();

		if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
			removeEventListener(Event.ADDED_TO_STAGE, init);

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}
	
		ClientPrefs.loadDefaultKeys();
		addChild(new FlxGame(gameWidth, gameHeight, initialState, #if (flixel < "5.0.0") zoom, #end framerate, framerate, skipSplash, startFullscreen));

		fpsVar = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.showFPS;
		}

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
