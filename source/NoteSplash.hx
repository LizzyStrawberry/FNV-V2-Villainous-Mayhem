package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap = null;
	private var idleAnim:String;
	private var textureLoaded:String = null;

	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);

		var skin:String = 'noteSplashes';
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;

		loadAnims(skin);
		
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		setupNoteSplash(x, y, note);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		alpha = 0.6;

		if(texture == null) {
			if (ClientPrefs.noteSplashMode == 'Inwards')
				texture = 'noteSplashesInwards';
			else if (ClientPrefs.noteSplashMode == 'Outwards')
				texture = 'noteSplashes';
			else if (ClientPrefs.noteSplashMode == 'Diamonds')
				texture = 'noteSplashesDiamond';
			else if (ClientPrefs.noteSplashMode == 'Sparkles')
				texture = 'noteSplashesSparkle';

			if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
		}

		if(textureLoaded != texture) {
			loadAnims(texture);
		}
		colorSwap.hue = hueColor;
		colorSwap.saturation = satColor;
		colorSwap.brightness = brtColor;
		if (ClientPrefs.noteSplashMode == 'Outwards')
			offset.set(10, 10);
		if (ClientPrefs.noteSplashMode == 'Diamonds')
			offset.set(30, 0);
		if (ClientPrefs.noteSplashMode == 'Sparkles')
			offset.set(-15, -40);
		else if (ClientPrefs.noteSplashMode == 'Inwards')
			offset.set(55, 50);

		var animNum:Int = FlxG.random.int(1, 2);
		animation.play('note' + note + '-' + animNum, true);
		if(animation.curAnim != null)animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
	}

	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
		if (ClientPrefs.noteSplashMode == 'Outwards')
			for (i in 1...3) {
				animation.addByPrefix("note1-" + i, "note splash blue " + i, 24, false);
				animation.addByPrefix("note2-" + i, "note splash green " + i, 24, false);
				animation.addByPrefix("note0-" + i, "note splash purple " + i, 24, false);
				animation.addByPrefix("note3-" + i, "note splash red " + i, 24, false);
			}
		else if (ClientPrefs.noteSplashMode == 'Inwards')
			for (i in 1...3) {
				animation.addByPrefix("note1-" + i, "note splash blue 1", 24, false);
				animation.addByPrefix("note2-" + i, "note splash green 1", 24, false);
				animation.addByPrefix("note0-" + i, "note splash purple 1", 24, false);
				animation.addByPrefix("note3-" + i, "note splash red 1", 24, false);
			}
		else if (ClientPrefs.noteSplashMode == 'Diamonds')
			for (i in 1...3) {
				animation.addByPrefix("note1-" + i, "note splash diamond blue " + i, 24, false);
				animation.addByPrefix("note2-" + i, "note splash diamond green " + i, 24, false);
				animation.addByPrefix("note0-" + i, "note splash diamond purple " + i, 24, false);
				animation.addByPrefix("note3-" + i, "note splash diamond red " + i, 24, false);
			}
		else if (ClientPrefs.noteSplashMode == 'Sparkles')
			for (i in 1...3) {
				animation.addByPrefix("note1-" + i, "note splash sparkle blue 1", 24, false);
				animation.addByPrefix("note2-" + i, "note splash sparkle green 1", 24, false);
				animation.addByPrefix("note0-" + i, "note splash sparkle purple 1", 24, false);
				animation.addByPrefix("note3-" + i, "note splash sparkle red 1", 24, false);
			}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}