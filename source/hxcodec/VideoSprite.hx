package hxcodec;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import hxcodec.VideoHandler;

/**
 * This class allows you to play videos using sprites (FlxSprite).
 */
class VideoSprite extends FlxSprite
{
	public var bitmap:VideoHandler;
	public var canvasWidth:Null<Int>;
	public var canvasHeight:Null<Int>;
	public var videoScale:Float = 1;

	public var openingCallback:Void->Void = null;
	public var graphicLoadedCallback:Void->Void = null;
	public var finishCallback:Void->Void = null;

	public function new(X:Float = 0, Y:Float = 0, scale:Float = 1, allowFocusChanges:Bool = true)
	{
		super(X, Y);

		videoScale = scale;
		makeGraphic(1, 1, FlxColor.TRANSPARENT);

		bitmap = new VideoHandler(0, allowFocusChanges);
		bitmap.canUseAutoResize = false;
		bitmap.visible = false;
		bitmap.openingCallback = function()
		{
			if (openingCallback != null)
				openingCallback();
		}
		bitmap.finishCallback = function()
		{
			oneTime = false;

			if (finishCallback != null)
				finishCallback();

			kill();
		}
	}

	private var oneTime:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (bitmap.isPlaying && bitmap.isDisplaying && bitmap.bitmapData != null && !oneTime)
		{
			var graphic:FlxGraphic = FlxG.bitmap.add(bitmap.bitmapData, false, bitmap.mrl);
			if (graphic.imageFrame.frame == null)
			{
				#if HXC_DEBUG_TRACE
				trace('the frame of the image is null?');
				#end
				return;
			}

			loadGraphic(graphic);

			if (videoScale != 1)
			{
				scale.set(videoScale, videoScale);
				updateHitbox();
			}
			else if (canvasWidth != null && canvasHeight != null)
			{
				setGraphicSize(canvasWidth, canvasHeight);
				updateHitbox();
			}

			if (graphicLoadedCallback != null)
				graphicLoadedCallback();

			oneTime = true;
		}
	}

	/**
	 * Native video support for Flixel & OpenFL
	 * @param Path Example: `your/video/here.mp4`
	 * @param Skippable Allow video skipping.
	 * @param Loop Loop the video.
	 * @param PauseMusic Pause music until the video ends.
	 */
	public function playVideo(Path:String, Skippable:Bool = true, Loop:Bool = false, PauseMusic:Bool = false):Void
		bitmap.playVideo(Path, Skippable, Loop, PauseMusic);

	// Used for video player
	public function getTimeStamp() // Get current timestamp in ms
		return bitmap.time;
	public function setTimeStamp(time:Int) // Set current timestamp in ms
		bitmap.setTime(time);
	public function getDuration() // get total duration of video in ms
		return bitmap.duration;
	public function dispose() // Dispose of the video
		bitmap.dispose();
	public function playing() // Check if video is playing
		return bitmap.isPlaying;
	public function pause() // Pause the video
		bitmap.pause();
	public function resume() // Resume the video
		bitmap.resume();
}
