package;

import Conductor.BPMChangeEvent;
import mobile.objects.tap.TapCircleManager;

class MusicBeatSubstate extends FlxSubState
{
	public static var instance:MusicBeatSubstate;
	public function new()
	{
		instance = this;
		super();
	}

	private var lastBeat:Float = 0;
	private var lastStep:Float = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;

	private var curDecStep:Float = 0;
	private var curDecBeat:Float = 0;
	private var controls(get, never):Controls;

	public var touchPad:TouchPad;
	public var touchPadCam:FlxCamera;
	public var hitbox:IMobileControls;
	public var hitboxCam:FlxCamera;
	public var tapManager:TapCircleManager;

	inline function get_controls():Controls
		return Controls.instance;

	public function addTouchPad(DPad:String, Action:String)
	{
		Controls.instance.isInSubstate = true;
		touchPad = new TouchPad(DPad, Action);
		add(touchPad);
	}

	public function addTouchPadCamera(defaultDrawTarget:Bool = false):Void
	{
		if (touchPad != null)
		{
			touchPadCam = new FlxCamera();
			touchPadCam.bgColor.alpha = 0;
			FlxG.cameras.add(touchPadCam, defaultDrawTarget);
			touchPad.cameras = [touchPadCam];
		}
	}

	public function addHitbox(defaultDrawTarget:Bool = false):Void
	{
		var extraMode = MobileData.extraActions.get(ClientPrefs.extraHints);

		hitbox = new Hitbox(extraMode);

		hitboxCam = new FlxCamera();
		hitboxCam.bgColor.alpha = 0;
		FlxG.cameras.add(hitboxCam, defaultDrawTarget);

		hitbox.instance.cameras = [hitboxCam];
		hitbox.instance.visible = false;
		add(hitbox.instance);
	}

	public function removeHitbox()
	{
		if (hitbox != null)
		{
			remove(hitbox.instance);
			hitbox.instance = FlxDestroyUtil.destroy(hitbox.instance);
			hitbox = null;
		}

		if (hitboxCam != null)
		{
			FlxG.cameras.remove(hitboxCam);
			hitboxCam = FlxDestroyUtil.destroy(hitboxCam);
		}
	}

	public function removeTouchPad()
	{
		if (touchPad != null)
		{
			remove(touchPad);
			touchPad = FlxDestroyUtil.destroy(touchPad);
		}

		if(touchPadCam != null)
		{
			FlxG.cameras.remove(touchPadCam);
			touchPadCam = FlxDestroyUtil.destroy(touchPadCam);
		}
	}

	public function removeTapEffect()
	{
		if (tapManager != null)
		{
			remove(tapManager);
			tapManager = FlxDestroyUtil.destroy(tapManager);
		}
	}

	override function destroy()
	{
		removeTouchPad();
		removeHitbox();
		removeTapEffect();
		
		if (controls != null)
			Controls.instance.isInSubstate = false;
		super.destroy();
	}

	override function create()
	{
		super.create();

		#if mobile
		if (!(getSubState() is PauseSubState))
		{
			tapManager = new TapCircleManager();
			add(tapManager);
		}
		#end
	}
	
	override function update(elapsed:Float)
	{
		//everyStep();
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep && curStep > 0)
			stepHit();


		super.update(elapsed);
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
		curDecBeat = curDecStep/4;
	}

	private function updateCurStep():Void
	{
		var lastChange = Conductor.getBPMFromSeconds(Conductor.songPosition);

		var shit = ((Conductor.songPosition - ClientPrefs.noteOffset) - lastChange.songTime) / lastChange.stepCrochet;
		curDecStep = lastChange.stepTime + shit;
		curStep = lastChange.stepTime + Math.floor(shit);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		//do literally nothing dumbass
	}

	public static function getSubState():MusicBeatSubstate {
		return cast(FlxG.state.subState, MusicBeatSubstate);
	}
}
