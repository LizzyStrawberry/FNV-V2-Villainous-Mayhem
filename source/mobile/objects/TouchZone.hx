package mobile.objects;

import flixel.math.FlxRect;

class TouchZone extends #if debug flixel.FlxSprite #else flixel.FlxObject #end {
    public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0, color:FlxColor = FlxColor.GREEN)
    {
        #if debug
            super(x,y);
            makeSolidColor(this, Std.int(width), Std.int(height), color);
            alpha = 0.2;
        #else
            super(x, y, width, height);
        #end
    }

    public static function makeSolidColor(sprite:FlxSprite, width:Int, height:Int, color:FlxColor = FlxColor.WHITE):FlxSprite
	{
		// Create a tiny solid color graphic and scale it up to the desired size.
		var graphic:FlxGraphic = FlxG.bitmap.create(2, 2, color, false, 'solid#${color.toHexString(true, false)}');
		sprite.frames = graphic.imageFrame;
		sprite.scale.set(width / 2.0, height / 2.0);
		sprite.updateHitbox();

		return sprite;
	}
}