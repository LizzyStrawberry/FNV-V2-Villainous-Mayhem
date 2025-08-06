package mobile.backend;

class SwipeUtil
{
	public static var swipeDown(get, never):Bool;
	public static var swipeLeft(get, never):Bool;
	public static var swipeRight(get, never):Bool;
	public static var swipeUp(get, never):Bool;
	public static var swipeAny(get, never):Bool;

	@:noCompletion
	static function get_swipeDown():Bool
	{
		for (swipe in FlxG.swipes)
			if (swipe.degrees > 45 && swipe.degrees < 135 && swipe.distance > 20)
				return true;
		return false;
	}

	@:noCompletion
	static function get_swipeUp():Bool
	{
		for (swipe in FlxG.swipes)
			if (swipe.degrees > -135 && swipe.degrees < -45 && swipe.distance > 20)
				return true;
		return false;
	}

	@:noCompletion
	static function get_swipeLeft():Bool
	{
		for (swipe in FlxG.swipes)
			if (swipe.degrees > 135 || swipe.degrees < -135 && swipe.distance > 20)
				return true;
		return false;
	}

	@:noCompletion
	static function get_swipeRight():Bool
	{
		for (swipe in FlxG.swipes)
			if (swipe.degrees > -45 && swipe.degrees < 45 && swipe.distance > 20)
				return true;
		return false;
	}

	@:noCompletion
	static function get_swipeAny():Bool
		return swipeDown || swipeLeft || swipeRight || swipeUp;
}
