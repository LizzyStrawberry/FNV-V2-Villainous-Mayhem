package mobile.objects.tap;

import flixel.input.touch.FlxTouch;
import flixel.util.FlxSpriteUtil;

#if mobile
class TapCircle extends FlxSprite
{
    public var instance:TapCircle;
    public var touchID:Int;
    private var fadeSpeed:Float = 5;
    private var trailTimer:Float = 0;
    private var trailCooldown:Float = 0.05; // seconds between trails

    public function new(touchID:Int) {
        super();

        this.touchID = touchID;
        instance = this;
        makeGraphic(32, 32, FlxColor.TRANSPARENT);

        // Draw circle
        var circle = FlxSpriteUtil.drawCircle(this, 16, 16, 15, FlxColor.CYAN);
        this.pixels = circle.pixels;
        updateHitbox();

        alpha = 0;
        visible = false;
        scrollFactor.set(); // stay in place on HUD
        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
    }

    public function updatePosition(touch:FlxTouch, elapsed:Float)
    {
        var pos = touch.getScreenPosition();
        setPosition(pos.x - width / 2, pos.y - height / 2);
        alpha = 0.75;
        visible = true;

        trailTimer += elapsed;
        if (trailTimer >= trailCooldown) {
            createTrail(pos);
            trailTimer = 0;
        }
    }

    public function fadeOut(elapsed:Float):Bool {
        alpha -= 2 * elapsed;
        if (alpha <= 0) {
            visible = false;
            return true;
        }

        return false;
    }

    private function createTrail(pos:flixel.math.FlxPoint):Void
    {
        var trail = new FlxSprite(pos.x - width / 2, pos.y - height / 2);
        trail.makeGraphic(32, 32, FlxColor.TRANSPARENT);
        FlxSpriteUtil.drawCircle(trail, 16, 16, 15, FlxColor.CYAN);
        trail.alpha = 0.5;
        trail.scrollFactor.set();
        trail.setGraphicSize(28, 28);
        trail.updateHitbox();
        trail.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

        if (FlxG.state.subState != null)
            FlxG.state.subState.add(trail);
        else
            FlxG.state.add(trail);

        FlxTween.tween(trail, { alpha: 0 }, 0.3, { onComplete: (_) ->  if (FlxG.state.subState != null) FlxG.state.subState.remove(trail) else FlxG.state.remove(trail) });
    }
}
#end
