package mobile.backend;

import flixel.input.touch.FlxTouch;

/**
 * ...
 * @author: Karim Akra
 */
class TouchUtil {
	public static var pressed(get, never):Bool;
	public static var justPressed(get, never):Bool;
	public static var justReleased(get, never):Bool;
	public static var justMoved(get, never):Bool;
	public static var released(get, never):Bool;
	public static var touch(get, never):FlxTouch;

	public static function overlaps(object:FlxBasic, ?camera:FlxCamera):Bool {
		if (object == null || touch == null) return false;

		for (touch in FlxG.touches.list)
			if (touch.overlaps(object, camera ?? object.camera))
				return true;

		return false;
	}

	public static function overlapsComplex(object:FlxObject, ?camera:FlxCamera):Bool {
		if (object == null || touch == null) return false;

    	if (camera == null) camera = object.cameras[0];

		@:privateAccess
    	return object.overlapsPoint(touch.getWorldPosition(camera, object._point), true, camera);

		return false;
	}

	/**
   * Checks if the specified object overlaps with a specific point using precise point checks.
   *
   * @param object The FlxObject to check for overlap.
   * @param point The FlxPoint to check against the object.
   * @param inScreenSpace Whether to take scroll factors into account when checking for overlap.
   * @param camera Optional camera for the overlap check. Defaults to all cameras of the object.
   *
   * @return `true` if there is a precise overlap with the specified point; `false` otherwise.
   */
	public static function overlapsComplexPoint(?object:FlxObject, point:FlxPoint, ?inScreenSpace:Bool = false, ?camera:FlxCamera):Bool
	{
		if (object == null || point == null) return false;

		if (camera == null) camera = object.cameras[0];
		@:privateAccess
		if (object.overlapsPoint(point, inScreenSpace, camera))
		{
			point.putWeak();
			return true;
		}

		point.putWeak();

		return false;
	}

	/**
   * A helper function to check if the selection is pressed using touch.
   *
   * @param object The optional FlxBasic to check for overlap.
   * @param camera Optional camera for the overlap check. Defaults to all cameras of the object.
   * @param useOverlapsComplex If true and atleast the object is not null, the function will use complex overlaps method.
   */
	public static function pressAction(?object:FlxBasic, ?camera:FlxCamera, useOverlapsComplex:Bool = true):Bool
	{
		if (TouchUtil.touch == null || (TouchUtil.touch != null && TouchUtil.touch.ticksDeltaSincePress > 200)) return false;

		if (object == null && camera == null)
		{
		return justReleased;
		}
		else if (object != null)
		{
		final overlapsObject:Bool = useOverlapsComplex ? overlapsComplex(cast(object, FlxObject), camera) : overlaps(object, camera);
		return justReleased && overlapsObject;
		}

		return false;
	}

	@:noCompletion
	inline static function get_justMoved():Bool
		return touch != null && touch.justMoved;

	@:noCompletion
	inline static function get_pressed():Bool
		return touch != null && touch.pressed;

	@:noCompletion
	inline static function get_justPressed():Bool
		return touch != null && touch.justPressed;

	@:noCompletion
	inline static function get_justReleased():Bool
		return touch != null && touch.justReleased;

	@:noCompletion
	inline static function get_released():Bool
		return touch != null && touch.released;

	@:noCompletion
	static function get_touch():FlxTouch {
		for (touch in FlxG.touches.list)
			if (touch != null)
				return touch;

		return FlxG.touches.getFirst();
	}
}
