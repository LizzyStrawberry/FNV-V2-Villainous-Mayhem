package;

import flixel.graphics.frames.FlxAtlasFrames;

class Boyfriend extends Character
{
	public var startedDeath:Bool = false;

	public function new(x:Float, y:Float, ?char:String = 'bf')
	{
		super(x, y, char, true);
	}

	override function update(elapsed:Float)
	{
		if (!debugMode && animation.curAnim != null)
		{
			if (animation.curAnim.name.startsWith('sing') || (animation.curAnim.name.startsWith('sing') && animation.curAnim.name.endsWith('ass')))
			{
				holdTimer += elapsed;
			}
			else
				holdTimer = 0;

			if (animation.curAnim.name.endsWith('miss') && animation.curAnim.finished && !debugMode)
			{
				if (PlayState.SONG.player1 == 'playablegf' && PlayState.healthCheck <= .399 && PlayState.inPlayState)
					playAnim('idleass', true, false, 10);
				else
					playAnim('idle', true, false, 10);
			}

			if (animation.curAnim.name == 'firstDeath' && animation.curAnim.finished && startedDeath)
			{
				playAnim('deathLoop');
			}
		}

		super.update(elapsed);
	}
}
