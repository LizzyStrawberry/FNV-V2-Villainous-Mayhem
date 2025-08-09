package;

import flixel.addons.display.FlxPieDial;

#if hxvlc
import hxvlc.flixel.FlxVideoSprite;
#end

class VideoSprite extends FlxSpriteGroup {
	#if VIDEOS_ALLOWED
	public var finishCallback:Void->Void = null;
	public var onSkip:Void->Void = null;

	final _timeToSkip:Float = 1;
	public var holdingTime:Float = 0;

	public var videoSprite:FlxVideoSprite;
	public var skipSprite:FlxPieDial;
	public var cover:FlxSprite;

	public var canSkip(default, set):Bool = false;
	private var videoName:String;

	public var waiting:Bool = false;

	public function new(videoName:String, isWaiting:Bool, canSkip:Bool = false, shouldLoop:Dynamic = false) {
		super();

		this.videoName = videoName;
		scrollFactor.set();
		cameras = [(PlayState.inPlayState) ? PlayState.instance.camOther : FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		waiting = isWaiting;
		if (!waiting) {
			cover = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
			cover.scale.set(FlxG.width + 100, FlxG.height + 100);
			cover.screenCenter();
			cover.scrollFactor.set();
			add(cover);
		}

		videoSprite = new FlxVideoSprite();
		videoSprite.antialiasing = ClientPrefs.globalAntialiasing;
		add(videoSprite);
		if (canSkip) this.canSkip = true;

		// natural end → finishVideo
		if (!shouldLoop) videoSprite.bitmap.onEndReached.add(finishVideo);

		videoSprite.bitmap.onFormatSetup.add(function() {
			videoSprite.setGraphicSize(FlxG.width);
			videoSprite.updateHitbox();
			videoSprite.screenCenter();
		});

		// start video
		videoSprite.load(videoName, shouldLoop ? ['input-repeat=65545'] : null);
	}

	var alreadyDestroyed:Bool = false;
	override function destroy() {
		if (alreadyDestroyed) return;

		// unhook listeners first
		if (videoSprite != null && videoSprite.bitmap != null) {
			videoSprite.bitmap.onEndReached.remove(finishVideo);
		}

		if (cover != null) {
			remove(cover);
			cover.destroy();
			cover = null;
		}
		if (skipSprite != null) {
			remove(skipSprite);
			skipSprite.destroy();
			skipSprite = null;
		}

		finishCallback = null;
		onSkip = null;

		if (FlxG.state != null) {
			if (FlxG.state.members.contains(this)) FlxG.state.remove(this);
			if (FlxG.state.subState != null && FlxG.state.subState.members.contains(this))
				FlxG.state.subState.remove(this);
		}

		super.destroy();
		alreadyDestroyed = true;
	}

	function finishVideo():Void {
		if (alreadyDestroyed) return;
		if (finishCallback != null) finishCallback();
		destroy();
	}

	override function update(elapsed:Float)
	{
		if (canSkip && (MusicBeatState.getState() is PlayState)) 
		{
			skipControl(elapsed);

			if(holdingTime >= _timeToSkip) return;
		}

		super.update(elapsed);
	}

	// public instance method – call this from other classes if you want
	public function skipControl(elapsed:Float):Void {
		if (!canSkip) return;

		if (FlxG.keys.pressed.ENTER || FlxG.keys.pressed.SPACE #if mobile || TouchUtil.touch.pressed #end) {
			holdingTime = Math.max(0, Math.min(_timeToSkip, holdingTime + elapsed));
		} else if (holdingTime > 0) {
			holdingTime = Math.max(0, FlxMath.lerp(holdingTime, -0.1, FlxMath.bound(elapsed * 3, 0, 1)));
		}

		updateSkipAlpha();

		if (holdingTime >= _timeToSkip) {
			skipNow();
		}
	}

	// expose a one-shot skip you can trigger from anywhere (e.g., BACK button)
	public function skipNow():Void {
		if (alreadyDestroyed) return;

		if (onSkip != null) onSkip(); // let the owner handle state/music/etc.

		// prevent finishVideo from firing after we destroy
		if (videoSprite != null && videoSprite.bitmap != null) {
			videoSprite.bitmap.onEndReached.remove(finishVideo);
		}

		destroy();
	}

	function set_canSkip(newValue:Bool):Bool {
		canSkip = newValue;
		if (canSkip) {
			if (skipSprite == null) {
				skipSprite = new FlxPieDial(0, 0, 40, FlxColor.WHITE, 40, true, 24);
				skipSprite.replaceColor(FlxColor.BLACK, FlxColor.TRANSPARENT);
				skipSprite.x = FlxG.width - (skipSprite.width + 80);
				skipSprite.y = FlxG.height - (skipSprite.height + 72);
				skipSprite.amount = 0;
				add(skipSprite);
			}
		} else if (skipSprite != null) {
			remove(skipSprite);
			skipSprite.destroy();
			skipSprite = null;
		}
		return canSkip;
	}
	
	// now an instance method (not static)
	function updateSkipAlpha():Void {
		if (skipSprite == null) return;
		skipSprite.amount = Math.min(1, Math.max(0, (holdingTime / _timeToSkip) * 1.025));
		skipSprite.alpha = FlxMath.remapToRange(skipSprite.amount, 0.025, 1, 0, 1);
	}

	public function play()  videoSprite?.play();
	public function resume() videoSprite?.resume();
	public function pause()  videoSprite?.pause();
	#end
}
