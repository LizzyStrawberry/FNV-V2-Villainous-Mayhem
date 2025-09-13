package;

import Conductor.BPMChangeEvent;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxGradient;

import mobile.objects.tap.TapCircleManager;

class MusicBeatState extends FlxUIState
{
	private var curSection:Int = 0;
	private var stepsToDo:Int = 0;

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

	public static var camBeat:FlxCamera;

	public static var transitionType:String = "fade"; // Default transition type

	private function get_controls()
		return Controls.instance;

	public function addTouchPad(DPad:String, Action:String)
	{
		touchPad = new TouchPad(DPad, Action);
		add(touchPad);
	}

	public function addTouchPadCamera(defaultDrawTarget:Bool = false):Void
	{
		if (touchPad != null)
		{
			if (!(getState() is PlayState))
			{
				touchPadCam = new FlxCamera();
				touchPadCam.bgColor.alpha = 0;
				FlxG.cameras.add(touchPadCam, defaultDrawTarget);
				touchPad.cameras = [touchPadCam];
			}
			else
			{
				touchPad.cameras = [PlayState.instance.camTouchPad];
			}
		}
	}

	public function addHitbox(defaultDrawTarget:Bool = false):Void
	{
		var extraMode = MobileData.extraActions.get(getExtraMode(PlayState.SONG.song));

		hitbox = new Hitbox(extraMode); // Best mode there is

		if (!(getState() is PlayState))
		{
			hitboxCam = new FlxCamera();
			hitboxCam.bgColor.alpha = 0;
			FlxG.cameras.add(hitboxCam, defaultDrawTarget);

			hitbox.instance.cameras = [hitboxCam];
		}
		else
			hitbox.instance.cameras = [PlayState.instance.camHitbox];
		
		hitbox.instance.visible = false;
		add(hitbox.instance);
	}

	public static function getExtraMode(songName:String):String
	{
		if (!ClientPrefs.mechanics) return "NONE";
		
		var songsWithDodge:Array<String> = ["Breacher", "Excrete", "Iniquitous", "Lustality", "Point Blank", "Viilain In Board"]; // Songs that only utilize Dodge
		var songsWithAttack:Array<String> = ["Lustality Remix", "Toybox", "Paycheck", "Paycheck (Legacy)"]; // Songs that Utilize Both Dodge and Attack
		
		for (song in songsWithDodge) 
		{
			if (song == songName)
				return "DODGE";
		}

		for (song in songsWithAttack) 
		{
			if (song == songName)
				return "ATTACK";
		}

		return "NONE";
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

		super.destroy();
	}

	override function create() {
		camBeat = FlxG.camera;
		var skip:Bool = FlxTransitionableState.skipNextTransOut;
		super.create();

		if (transitionType == 'fade')
			openSubState(new CustomFadeTransition(0.7, true));
		if (transitionType == 'stickers')
		{
			openSubState(new CustomStickerTransition(false));
			transitionType = "fade"; //Reset back to fade just in case
		}

		FlxTransitionableState.skipNextTransOut = false;

		#if mobile
		new FlxTimer().start(0.1, function(_) // Always add this a bit later than normal
		{
			try
			{
				if (!isInvalidState())
				{
					tapManager = new TapCircleManager();
					add(tapManager);
				}
			}
			catch {}	
		});
		#end
	}

	function isInvalidState()
		return (getState() is PlayState || getState() is TitleState);

	override function update(elapsed:Float)
	{
		//everyStep();
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep)
		{
			if(curStep > 0)
				stepHit();

			if(PlayState.SONG != null)
			{
				if (oldStep < curStep)
					updateSection();
				else
					rollbackSection();
			}
		}

		if(FlxG.save.data != null) FlxG.save.data.fullscreen = FlxG.fullscreen;

		super.update(elapsed);
	}

	private function updateSection():Void
	{
		if(stepsToDo < 1) stepsToDo = Math.round(getBeatsOnSection() * 4);
		while(curStep >= stepsToDo)
		{
			curSection++;
			var beats:Float = getBeatsOnSection();
			stepsToDo += Math.round(beats * 4);
			sectionHit();
		}
	}

	private function rollbackSection():Void
	{
		if(curStep < 0) return;

		var lastSection:Int = curSection;
		curSection = 0;
		stepsToDo = 0;
		for (i in 0...PlayState.SONG.notes.length)
		{
			if (PlayState.SONG.notes[i] != null)
			{
				stepsToDo += Math.round(getBeatsOnSection() * 4);
				if(stepsToDo > curStep) break;
				
				curSection++;
			}
		}

		if(curSection > lastSection) sectionHit();
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

	public static function switchState(nextState:FlxState, transition:String = 'fade'):Void {
		transitionType = transition;
		var curState:Dynamic = FlxG.state;
        var leState:MusicBeatState = curState;
        if (!FlxTransitionableState.skipNextTransIn) {
            if (transitionType == "stickers") {
                leState.openSubState(new CustomStickerTransition(true));
                CustomStickerTransition.finishCallback = function() {
                    if (nextState == FlxG.state) {
                        FlxG.resetState();
                    } else {
                        FlxG.switchState(nextState);
                    }
                };
            } else {
                leState.openSubState(new CustomFadeTransition(0.6, false));
                CustomFadeTransition.finishCallback = function() {
                    if (nextState == FlxG.state) {
                        FlxG.resetState();
                    } else {
                        FlxG.switchState(nextState);
                    }
                };
            }
            return;
        }

        FlxTransitionableState.skipNextTransIn = false;
        FlxG.switchState(nextState);
    }


	public static function resetState() {
		MusicBeatState.switchState(FlxG.state);
	}

	public static function getState():MusicBeatState {
		return cast (FlxG.state, MusicBeatState);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		//trace('Beat: ' + curBeat);
	}

	public function sectionHit():Void
	{
		//trace('Section: ' + curSection + ', Beat: ' + curBeat + ', Step: ' + curStep);
	}

	function getBeatsOnSection()
	{
		var val:Null<Float> = 4;
		if(PlayState.SONG != null && PlayState.SONG.notes[curSection] != null) val = PlayState.SONG.notes[curSection].sectionBeats;
		return val == null ? 4 : val;
	}
}
