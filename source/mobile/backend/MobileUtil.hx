package mobile.backend;

class MobileUtil {
	public static var scaleX:Float = 1;
	public static var scaleY:Float = 1;
	public static var offsetX:Float = 0;
	public static var offsetY:Float = 0;
	public static var zoom:Float = 1;

	public static function init(baseWidth:Int = 1280, baseHeight:Int = 720):Void {
		var realWidth:Int = FlxG.width;
		var realHeight:Int = FlxG.height;
		
		scaleX = realWidth / baseWidth;
		scaleY = realHeight / baseHeight;

		// Use uniform scaling to preserve aspect ratio (like letterboxing)
		zoom = Math.min(scaleX, scaleY);

		offsetX = (realWidth - baseWidth * zoom) / 2;
		offsetY = (realHeight - baseHeight * zoom) / 2;

        trace('MobileUtil initialized: realwidth = $realWidth, realheight = $realHeight, scaleX = $scaleX, scaleY = $scaleY, Zoom = $zoom, offsetX = $offsetX, offsetY = $offsetY');
	}

	public static inline function fixX(x:Float):Float return x * zoom + offsetX;
	public static inline function fixY(y:Float):Float return y * zoom + offsetY;

	public static inline function rawX(x:Float):Float return x * scaleX;
	public static inline function rawY(y:Float):Float return y * scaleY;
}