package;

import flixel.math.FlxRandom;
import lime.app.Promise;
import lime.app.Future;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import Section.SwagSection;
import Song.SwagSong;

import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;

import haxe.io.Path;

class LoadingState extends MusicBeatState
{
	inline static var MIN_TIME = 4.0;

	// Browsers will load create(), you can make your song load a custom directory there
	// If you're compiling to desktop (or something that doesn't use NO_PRELOAD_ALL), search for getNextState instead
	// I'd recommend doing it on both actually lol
	
	// TO DO: Make this easier
	
	var target:FlxState;
	var stopMusic = false;
	var directory:String;
	var callbacks:MultiCallback;
	var targetShit:Float = 0;
	var tipText:FlxText;

	var tips:Array<String> = [
		'TIP:\nPress the arrows to play. Seriously, you KNOW how to play, right?',
		'TIP:\nCheck out our shop(s), to unlock songs, weeks, charms, exclusive items and more!',
		'TIP:\nThe Mayhem Bar gives you temporary powers, so use it wisely!',
		'TIP:\nMarco\'s Note and Camera Movement is inverted on purpose, it was never a mistake!',
		'FUN FACT:\nEvelyn is a robot.',
		'FUN FACT:\nFNV has 3 shops in total!',
		'TIP:\nHaving a hard time on a song? Use a charm!',
		'TIP:\nNo tokens? Go grind by playing songs you dingus.',
		'TIP:\nYou can only use 1 buff at a time! Be sure you select it from your inventory first!',
		'TIP:\nAlmost close to losing? Use the Second Chance Buff as soon as you are about to die to gain your life back one more time!',
		'TIP:\nIn need of regeneration? The Health Regeneration Buff can get your health back up!',
		'TIP:\nPress I on the Main Menu (or the inventory icon on the right down corner) to open your inventory!',
		'TIP:\nYou can always play the songs without mechanics to progress too! ..Just not in Iniquitous Mode...or Injection Mode... or Mayhem Mode.',
		'TIP:\nMimiko LOVES tokens!',
		'TIP:\nAmong Us.',
		'TIP:\nPlay on 60 - 120 FPS for the best experience!',
		'TIP:\nRemember to set up your keybinds in the Options menu!',
		'TIP:\nCharms consume 1 token each time you use one, so make sure you have tokens before using one!',
		'TIP:\nThe Auto Dodge Charm helps in all songs that require some sort of dodging / avoiding etc etc!',
		'FUN FACT:\nMarco loves Manager-Chan from Lily in Engrave.',
		'TIP:\nThe Healing Charm grants you 25% of your HP back, but beware, it only has 10 uses each time you activate it!',
		'TIP:\nThe Resistance Charm can resist up to 50% of health drain!',
		'FUN FACT:\nDid you ever meet Zeel?',
		'FUN FACT:\nZeel really does sound like a backwards name, huh?',
		'TIP:\nIf you want to have some more challenge in your playthrough, try out Mayhem Mode, Injection Mode, or enable Trampoline Mode! (..if you purchased it.)',
		'FUN FACT:\nLustality used to be the hardest song we ever published in FNV!',
		'FUN FACT:\nVersion 1.0 of FNV was done in just a month, and Version 1.5 only took 2 months!',
		'FUN FACT:\n All the assets for this mod were drawn by JUST 1 person, StatureGuy!'
	];

	function new(target:FlxState, stopMusic:Bool, directory:String)
	{
		super();
		this.target = target;
		this.stopMusic = stopMusic;
		this.directory = directory;
	}

	var funkay:FlxSprite;
	var loadBar:FlxSprite;
	var bg:FlxSprite;
	var shitz:FlxText;
	var move:Int = 0;
	override function create()
	{
		bg = new FlxSprite(0, 0).loadGraphic(Paths.image('menuDesat'));
		bg.setGraphicSize(0, FlxG.height);
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		if (ClientPrefs.inMenu == true)
		{
			funkay = new FlxSprite(0, 0).loadGraphic(Paths.image('menuDesat'));
			//funkay.setGraphicSize(0, FlxG.height);
			funkay.scrollFactor.set();
			funkay.screenCenter();
			funkay.updateHitbox();
			add(funkay);
		}
		else
		{
			funkay = new FlxSprite(0, 0).loadGraphic(Paths.image('loadingScreens/' + PlayState.SONG.loadingScreen));
			//funkay.setGraphicSize(0, FlxG.height);
			funkay.scrollFactor.set();
			funkay.screenCenter();
			funkay.updateHitbox();
			add(funkay);
		}

		if (ClientPrefs.inMenu == false && Paths.formatToSongPath(PlayState.SONG.song) == 'iniquitous')
			loadBar = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xffff0000);
		else
			loadBar = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xff02ce18);
		loadBar.alpha = 1;
		loadBar.scale.x = 0.01;
		loadBar.screenCenter(X);
		loadBar.antialiasing = ClientPrefs.globalAntialiasing;
		add(loadBar);

		if (ClientPrefs.inMenu == false)
			if (Paths.formatToSongPath(PlayState.SONG.song) == 'iniquitous')
			{
				tipText = new FlxText(700, 960, FlxG.width, 'Death.', 24);
				tipText.setFormat("VCR OSD Mono", 24, FlxColor.RED, CENTER);
			}
			else
			{
				tipText = new FlxText(700, 960, FlxG.width, tips[FlxG.random.int(1, tips.length - 1)], 24);
				tipText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER);
			}
		else
		{
			tipText = new FlxText(700, 960, FlxG.width, tips[FlxG.random.int(1, tips.length - 1)], 24);
			tipText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER);
		}
		tipText.screenCenter(XY);
		tipText.y += 290;
		tipText.alpha = 1;
		add(tipText);

		FlxTween.tween(loadBar.scale, {x:1}, 3.9, {ease: FlxEase.cubeInOut, type: PERSIST});

		shitz = new FlxText(12, 12, 0, "Loading...", 12);
		shitz.scrollFactor.set();
		shitz.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		shitz.borderSize = 3;
		add(shitz);

		new FlxTimer().start(0.1, function (tmr:FlxTimer) {
			moveColoredLetter();
		});
		
		initSongsManifest().onComplete
		(
			function (lib)
			{
				callbacks = new MultiCallback(onLoad);
				var introComplete = callbacks.add("introComplete");
				/*if (PlayState.SONG != null) {
					checkLoadSong(getSongPath());
					if (PlayState.SONG.needsVoices)
						checkLoadSong(getVocalPath());
				}*/
				checkLibrary("shared");
				if(directory != null && directory.length > 0 && directory != 'shared') {
					checkLibrary(directory);
				}

				var fadeTime = 0.5;
				FlxG.camera.fade(FlxG.camera.bgColor, fadeTime, true);
				new FlxTimer().start(fadeTime + MIN_TIME, function(_) introComplete());
			}
		);
	}

	var text:String;
	function moveColoredLetter()
	{
		if (move <= 10)
		{
			switch(move)
			{
				case 0:
					text = "<GR>L<GR>oading...";
				case 1:
					text = "L<GR>o<GR>ading...";
				case 2:
					text = "Lo<GR>a<GR>ding...";
				case 3:
					text = "Loa<GR>d<GR>ing...";
				case 4:
					text = "Load<GR>i<GR>ng...";
				case 5:
					text = "Loadi<GR>n<GR>g...";
				case 6:
					text = "Loadin<GR>g<GR>...";
				case 7:
					text = "Loading<GR>.<GR>..";
				case 8:
					text = "Loading.<GR>.<GR>.";
				case 9:
					text = "Loading..<GR>.<GR>";
				case 10:
					text = "Loading...";		
			}
			shitz.text = text;
			CustomFontFormats.addMarkers(shitz);
			move++;
		}

		if (move == 11)
			move = 0;
		new FlxTimer().start(0.04, function (tmr:FlxTimer) {
			moveColoredLetter();
		});
	}
	
	function checkLoadSong(path:String)
	{
		if (!Assets.cache.hasSound(path))
		{
			var library = Assets.getLibrary("songs");
			final symbolPath = path.split(":").pop();
			// @:privateAccess
			// library.types.set(symbolPath, SOUND);
			// @:privateAccess
			// library.pathGroups.set(symbolPath, [library.__cacheBreak(symbolPath)]);
			var callback = callbacks.add("song:" + path);
			Assets.loadSound(path).onComplete(function (_) { callback(); });
		}
	}
	
	function checkLibrary(library:String) {
		trace(Assets.hasLibrary(library));
		if (Assets.getLibrary(library) == null)
		{
			@:privateAccess
			if (!LimeAssets.libraryPaths.exists(library))
				throw "Missing library: " + library;

			var callback = callbacks.add("library:" + library);
			Assets.loadLibrary(library).onComplete(function (_) { callback(); });
		}
	}
	
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		//funkay.setGraphicSize(Std.int(0.88 * FlxG.width + 0.9 * (funkay.width - 0.88 * FlxG.width)));
		//funkay.updateHitbox();
		//if(controls.ACCEPT)
		//{
		//	funkay.setGraphicSize(Std.int(funkay.width + 60));
		//	funkay.updateHitbox();
		//}

		if(callbacks != null) {
			targetShit = FlxMath.remapToRange(callbacks.numRemaining / callbacks.length, 1, 0, 0, 1);
			//loadBar.scale.x += 0.5 * (targetShit - loadBar.scale.x);
		}
	}
	
	function onLoad()
	{
		if (stopMusic && FlxG.sound.music != null)
			FlxG.sound.music.stop();
		
		MusicBeatState.switchState(target);
	}
	
	static function getSongPath()
	{
		return Paths.inst(PlayState.SONG.song);
	}
	
	static function getVocalPath()
	{
		return Paths.voices(PlayState.SONG.song);
	}
	
	inline static public function loadAndSwitchState(target:FlxState, stopMusic = false)
	{
		MusicBeatState.switchState(getNextState(target, stopMusic));
	}
	
	static function getNextState(target:FlxState, stopMusic = false):FlxState
	{
		var directory:String = 'shared';
		var weekDir:String = StageData.forceNextDirectory;
		StageData.forceNextDirectory = null;

		if(weekDir != null && weekDir.length > 0 && weekDir != '') directory = weekDir;

		Paths.setCurrentLevel(directory);
		trace('Setting asset folder to ' + directory);

		var loaded:Bool = false;
		if (PlayState.SONG != null) {
			loaded = isSoundLoaded(getSongPath()) && (!PlayState.SONG.needsVoices || isSoundLoaded(getVocalPath())) && isLibraryLoaded("shared") && isLibraryLoaded(directory);
		}
		
		if (!loaded)
			return new LoadingState(target, stopMusic, directory);
		if (stopMusic && FlxG.sound.music != null)
			FlxG.sound.music.stop();
		
		return target;
	}
	
	static function isSoundLoaded(path:String):Bool
	{
		return Assets.cache.hasSound(path);
	}
	
	static function isLibraryLoaded(library:String):Bool
	{
		return Assets.getLibrary(library) != null;
	}
	
	override function destroy()
	{
		super.destroy();
		
		callbacks = null;
	}
	
	static function initSongsManifest()
	{
		var id = "songs";
		var promise = new Promise<AssetLibrary>();

		var library = LimeAssets.getLibrary(id);

		if (library != null)
		{
			return Future.withValue(library);
		}

		var path = id;
		var rootPath = null;

		@:privateAccess
		var libraryPaths = LimeAssets.libraryPaths;
		if (libraryPaths.exists(id))
		{
			path = libraryPaths[id];
			rootPath = Path.directory(path);
		}
		else
		{
			if (StringTools.endsWith(path, ".bundle"))
			{
				rootPath = path;
				path += "/library.json";
			}
			else
			{
				rootPath = Path.directory(path);
			}
			@:privateAccess
			path = LimeAssets.__cacheBreak(path);
		}

		AssetManifest.loadFromFile(path, rootPath).onComplete(function(manifest)
		{
			if (manifest == null)
			{
				promise.error("Cannot parse asset manifest for library \"" + id + "\"");
				return;
			}

			var library = AssetLibrary.fromManifest(manifest);

			if (library == null)
			{
				promise.error("Cannot open library \"" + id + "\"");
			}
			else
			{
				@:privateAccess
				LimeAssets.libraries.set(id, library);
				library.onChange.add(LimeAssets.onChange.dispatch);
				promise.completeWith(Future.withValue(library));
			}
		}).onError(function(_)
		{
			promise.error("There is no asset library with an ID of \"" + id + "\"");
		});

		return promise.future;
	}
}

class MultiCallback
{
	public var callback:Void->Void;
	public var logId:String = null;
	public var length(default, null) = 0;
	public var numRemaining(default, null) = 0;
	
	var unfired = new Map<String, Void->Void>();
	var fired = new Array<String>();
	
	public function new (callback:Void->Void, logId:String = null)
	{
		this.callback = callback;
		this.logId = logId;
	}
	
	public function add(id = "untitled")
	{
		id = '$length:$id';
		length++;
		numRemaining++;
		var func:Void->Void = null;
		func = function ()
		{
			if (unfired.exists(id))
			{
				unfired.remove(id);
				fired.push(id);
				numRemaining--;
				
				if (logId != null)
					log('fired $id, $numRemaining remaining');
				
				if (numRemaining == 0)
				{
					if (logId != null)
						log('all callbacks fired');
					callback();
				}
			}
			else
				log('already fired $id');
		}
		unfired[id] = func;
		return func;
	}
	
	inline function log(msg):Void
	{
		if (logId != null)
			trace('$logId: $msg');
	}
	
	public function getFired() return fired.copy();
	public function getUnfired() return [for (id in unfired.keys()) id];
}