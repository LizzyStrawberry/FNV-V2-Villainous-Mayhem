#if sys
package;

import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.ui.FlxBar;
import lime.app.Application;

import openfl.display.BitmapData;
import openfl.utils.Assets;
import haxe.Exception;
#if cpp
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class Cache extends MusicBeatState
{
	public static var bitmapData:Map<String,FlxGraphic>;
	public static var bitmapData2:Map<String,FlxGraphic>;

	var images = [];
	var music = [];
	var characters = [];
	var shitz:FlxText;
	var currentLoaded:Int = 0;
	var maxLoaded:Int = 300;
	var loadingBar:FlxBar;
	var tween:FlxTween;

	var text:String = "Loading Friday Night Villainy 2.0...";
	var move:Int = 0;
	
	override function create()
	{
		FlxG.mouse.visible = false;

		FlxG.worldBounds.set(0,0);
		
		PlayerSettings.init();
		ClientPrefs.loadPrefs();
		NotificationAlert.loadNotifications();

		bitmapData = new Map<String,FlxGraphic>();
		bitmapData2 = new Map<String,FlxGraphic>();

		var menuBG:FlxSprite;
		if (!ClientPrefs.firstTime)
			menuBG = new FlxSprite().loadGraphic(Paths.image('Gallery/titleScreens/loadingScreen-1'));
		else
			menuBG = new FlxSprite().loadGraphic(Paths.image('Gallery/titleScreens/loadingScreen-' + FlxG.random.int(1, 6)));
		menuBG.screenCenter();
		add(menuBG);

		shitz = new FlxText(12, 672, 0, text, 12);
		shitz.scrollFactor.set();
		shitz.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		shitz.borderSize = 3;
		add(shitz);

		new FlxTimer().start(0.1, function (tmr:FlxTimer) {
			moveColoredLetter();
		});

		tween = FlxTween.tween(shitz, {alpha: 0.6}, 1.2, {ease: FlxEase.cubeInOut, type: PINGPONG});

		loadingBar = new FlxBar(0, 677, LEFT_TO_RIGHT, 570, 24, this, 'currentLoaded', 0, maxLoaded);
        loadingBar.createFilledBar(0xFF2b2b2b, 0xFF2b6330);
    	loadingBar.screenCenter(X);
		loadingBar.x += 340;
    	loadingBar.visible = true;
        add(loadingBar);

		#if cpp
		for (i in FileSystem.readDirectory(FileSystem.absolutePath("mods/images/characters")))
		{
			if (!i.endsWith(".png"))
				continue;
			images.push(i);
		}
		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
		{
			if (!i.endsWith(".png"))
				continue;
			images.push(i);
		}
		for (i in FileSystem.readDirectory(FileSystem.absolutePath("mods/images")))
		{
			if (!i.endsWith(".png"))
				continue;
			images.push(i);
		}
		for (i in FileSystem.readDirectory(FileSystem.absolutePath("mods/songs")))
		{
			music.push(i);
		}
		#end

		sys.thread.Thread.create(() -> {
			cache();
		});

		super.create();
	}

	override function update(elapsed) 
	{
		super.update(elapsed);

		if (currentLoaded == maxLoaded)
			move = 37;
	}

	function moveColoredLetter()
	{
		if (move <= 35)
		{
			switch(move)
			{
				case 0:
					text = "<G>L<G>oading Friday Night Villainy 2.0...";
				case 1:
					text = "L<G>o<G>ading Friday Night Villainy 2.0...";
				case 2:
					text = "Lo<G>a<G>ding Friday Night Villainy 2.0...";
				case 3:
					text = "Loa<G>d<G>ing Friday Night Villainy 2.0...";
				case 4:
					text = "Load<G>i<G>ng Friday Night Villainy 2.0...";
				case 5:
					text = "Loadi<G>n<G>g Friday Night Villainy 2.0...";
				case 6:
					text = "Loadin<G>g<G> Friday Night Villainy 2.0...";
				case 7:
					text = "Loading Friday Night Villainy 2.0...";
				case 8:
					text = "Loading <G>F<G>riday Night Villainy 2.0...";
				case 9:
					text = "Loading F<G>r<G>iday Night Villainy 2.0...";
				case 10:
					text = "Loading Fr<G>i<G>day Night Villainy 2.0...";
				case 11:
					text = "Loading Fri<G>d<G>ay Night Villainy 2.0...";
				case 12:
					text = "Loading Frid<G>a<G>y Night Villainy 2.0...";
				case 13:
					text = "Loading Frida<G>y<G> Night Villainy 2.0...";
				case 14:
					text = "Loading Friday Night Villainy 2.0...";
				case 15:
					text = "Loading Friday <G>N<G>ight Villainy 2.0...";
				case 16:
					text = "Loading Friday N<G>i<G>ght Villainy 2.0...";
				case 17:
					text = "Loading Friday Ni<G>g<G>ht Villainy 2.0...";
				case 18:
					text = "Loading Friday Nig<G>h<G>t Villainy 2.0...";
				case 19:
					text = "Loading Friday Nigh<G>t<G> Villainy 2.0...";
				case 20:
					text = "Loading Friday Night <G>V<G>illainy 2.0...";
				case 21:
					text = "Loading Friday Night V<G>i<G>llainy 2.0...";
				case 22:
					text = "Loading Friday Night Vi<G>l<G>lainy 2.0...";
				case 23:
					text = "Loading Friday Night Vil<G>l<G>ainy 2.0...";
				case 24:
					text = "Loading Friday Night Vill<G>a<G>iny 2.0...";
				case 25:
					text = "Loading Friday Night Villa<G>i<G>ny 2.0...";
				case 26:
					text = "Loading Friday Night Villai<G>n<G>y 2.0...";
				case 27:
					text = "Loading Friday Night Villain<G>y<G> 2.0...";
				case 28:
					text = "Loading Friday Night Villainy 2.0...";
				case 29:
					text = "Loading Friday Night Villainy <G>2<G>.0...";
				case 30:
					text = "Loading Friday Night Villainy 2<G>.<G>0...";
				case 31:
					text = "Loading Friday Night Villainy 2.<G>0<G>...";
				case 32:
					text = "Loading Friday Night Villainy 2.0<G>.<G>..";
				case 33:
					text = "Loading Friday Night Villainy 2.0.<G>.<G>.";
				case 34:
					text = "Loading Friday Night Villainy 2.0..<G>.<G>";
				case 35:
					text = "Loading Friday Night Villainy 2.0...";
				
			}
			shitz.text = text;
			var goldHighlight = new FlxTextFormat(0xFFD700, true, false, null);
			shitz.applyMarkup(shitz.text, [new FlxTextFormatMarkerPair(goldHighlight, "<G>")]);
			move++;
		}

		if (move == 36)
			move = 0;
		new FlxTimer().start(0.1, function (tmr:FlxTimer) {
			moveColoredLetter();
		});
	}

	function cache()
	{
		#if !linux
			//var sound1:FlxSound;
			//sound1 = new FlxSound().loadEmbedded(Paths.voices('fresh'));
			//sound1.play();
			//sound1.volume = 0.00001;
			//FlxG.sound.list.add(sound1);

			//var sound2:FlxSound;
			//sound2 = new FlxSound().loadEmbedded(Paths.inst('fresh'));
			//sound2.play();
			//sound2.volume = 0.00001;
			//FlxG.sound.list.add(sound2);
		for (i in images)
		{
			var replaced = i.replace(".png","");
			var data:BitmapData = BitmapData.fromFile("mods/images/characters/" + i);
			var graph = FlxGraphic.fromBitmapData(data);
			graph.persist = true;
			graph.destroyOnNoUse = false;
			bitmapData.set(replaced,graph);
			trace("Character Cached: " + i);
			if (FlxG.random.int(1, 5) == 3)
				currentLoaded += 2;
			else
				currentLoaded++;
		}
		for (i in images)
		{
			var replaced = i.replace(".png","");
			var data:BitmapData = BitmapData.fromFile("assets/shared/images/characters/" + i);
			var graph = FlxGraphic.fromBitmapData(data);
			graph.persist = true;
			graph.destroyOnNoUse = false;
			bitmapData.set(replaced,graph);
			trace("Character Cached: " + i);
			if (FlxG.random.int(1, 5) == 3)
				currentLoaded += 2;
			else
				currentLoaded++;
		}


		for (i in music)
		{
			trace("Song Cached: " + i);
			if (FlxG.random.int(1, 5) == 3)
				currentLoaded += 2;
			else
				currentLoaded++;
			//FlxG.sound.cache(Paths.inst(i));
			//FlxG.sound.cache(Paths.voices(i));
		}


		#end

		tween.cancel();
		currentLoaded = maxLoaded;
		shitz.text = "Done!";
		shitz.color = FlxColor.WHITE;
		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxG.sound.play(Paths.sound('confirmMenu'));
		new FlxTimer().start(1.5, function(tmr:FlxTimer)
		{
			MusicBeatState.switchState(new TitleState());
		});
	}

}
#end