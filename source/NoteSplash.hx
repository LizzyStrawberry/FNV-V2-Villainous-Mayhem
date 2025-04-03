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
			var whatSplashType:String = ClientPrefs.noteSplashMode;

			switch(PlayState.SONG.player1)
			{
				case 'aileenTofu' | "aileenTofuAlt":
					texture = 'noteSplashes/' + whatSplashType + '/AileenNoteSplashes' + whatSplashType;
				case 'TC' | 'TCAlt':
					texture = 'noteSplashes/' + whatSplashType + '/TCnoteSplashes' + whatSplashType;
				case 'GFwav':
					texture = 'noteSplashes/' + whatSplashType + '/NicNoteSplashes' + whatSplashType;
				case 'ourple':
					texture = 'noteSplashes/' + whatSplashType + '/ourpleNoteSplashes' + whatSplashType;
				case 'Kyu' | 'KyuAlt':
					texture = 'noteSplashes/' + whatSplashType + '/KyuNoteSplashes' + whatSplashType;
				case 'marcoFFFP1' | 'marcoFFFP2':
					texture = 'noteSplashes/' + whatSplashType + '/MarcoNoteSplashes' + whatSplashType;

				default:
					texture = "noteSplashes" + whatSplashType;
			}

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

	var noteColors:Array<String> = ["purple", "blue", "green", "red"];
	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
		switch(ClientPrefs.noteSplashMode)
		{
			case "Outwards":
				for (i in 1...3)
				{
					for (noteID in 0...4)
						animation.addByPrefix("note" + noteID + "-" + i, "note splash " + noteColors[noteID] + " " + i, 24, false);
				}
					
			case "Inwards":
				for (i in 1...3)
				{
					for (noteID in 0...4)
						animation.addByPrefix("note" + noteID + "-" + i, "note splash " + noteColors[noteID] + " 1", 24, false);
				}

			case "Diamonds":
				for (i in 1...3)
				{
					for (noteID in 0...4)
						animation.addByPrefix("note" + noteID + "-" + i, "note splash diamond " + noteColors[noteID] + " " + i, 24, false);
				}

			case "Sparkles":
				for (i in 1...3)
				{
					for (noteID in 0...4)
						animation.addByPrefix("note" + noteID + "-" + i, "note splash sparkle " + noteColors[noteID] + " 1", 24, false);
				}
		}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}