package mobile.objects.tap;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.touch.FlxTouch;
import haxe.ds.IntMap;

class TapCircleManager extends FlxTypedGroup<TapCircle> {
    private var circles:IntMap<TapCircle>;

    public function new() {
        super();
        circles = new IntMap();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        // Track used touch IDs this frame
        var usedIDs = [];

        for (touch in FlxG.touches.list) {
            if (touch != null && touch.pressed) {
                var id = touch.touchPointID;

                // Get or create circle
                var circle = circles.get(id);
                if (circle == null) {
                    circle = new TapCircle(id);
                    add(circle);
                    circles.set(id, circle);
                }

                // Update position
                circle.updatePosition(touch, elapsed);
                usedIDs.push(id);
            }
        }

        // Fade out circles not used this frame
        for (id in circles.keys()) {
            if (!usedIDs.contains(id)) {
                var circle = circles.get(id);
                if (circle != null && circle.visible) {
                    var shouldRemove = circle.fadeOut(elapsed);
                    if (shouldRemove) {
                        remove(circle, true);
                        circles.remove(id);
                    }
                }
            }
        }
    }
}
