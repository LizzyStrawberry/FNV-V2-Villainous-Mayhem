package;

import flixel.group.FlxGroup;
import flixel.FlxCamera;
import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;

//Shit is definitely not like how the actual transition of FNF, but it works, so i don't give a fuck lmao
class CustomStickerTransition extends MusicBeatSubstate {
    public static var finishCallback:Void->Void;
    private var spawn:Bool;

    private var stickerCam:FlxCamera;
    public static var stickers:Array<FlxSprite> = [];
    public static var stickersBackup:Array<FlxSprite> = [];
    public static var stickersBackupVars:Array<Dynamic> = [];
    var numStickers:Int = 100;
    var stickerPaths:Array<String> = [
        "stickerPack/sticker-1",
        "stickerPack/sticker-2",
        "stickerPack/sticker-3",
        "stickerPack/sticker-4",
        "stickerPack/sticker-5",
        "stickerPack/sticker-6",
        "stickerPack/sticker-7",
        "stickerPack/sticker-8",
        "stickerPack/sticker-9"
    ];

    public function new(spawn:Bool) {
        super();
        this.spawn = spawn;

        stickerCam = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        stickerCam.scroll.x = 0;
        stickerCam.scroll.y = 0;
        stickerCam.bgColor = FlxG.camera.bgColor;

        FlxG.cameras.add(stickerCam);

        if (spawn)
            spawnStickers();
        else
            readdStickers();
    }

    public function spawnStickers():Void {
        for (i in 0...numStickers) {
            var sticker = new FlxSprite();
            var stickerPath = stickerPaths[FlxG.random.int(0, stickerPaths.length - 1)];
            sticker.loadGraphic(Paths.image(stickerPath));
            sticker.x = FlxG.random.float(-200, (FlxG.width - sticker.width) + 200);
            sticker.y = FlxG.random.float(-200, (FlxG.height - sticker.height) + 200);
            sticker.alpha = 0;
            sticker.angle = FlxG.random.float(-60, 70);
            sticker.scale.x = 1.3;
            sticker.scale.y = 1.3;
            sticker.updateHitbox();
            sticker.scale.x = 0.8;
            sticker.scale.y = 0.8;
            this.add(sticker);
            stickers.push(sticker);

            stickers[i].cameras = [stickerCam];

            stickersBackupVars[i] = [stickerPath, sticker.x, sticker.y, sticker.angle, sticker.scale.x];

            FlxTween.tween(sticker.scale, {x: 1.3, y: 1.3}, 0.03, {startDelay: i * 0.02, ease: FlxEase.bounceInOut, type: PERSIST});
            FlxTween.tween(sticker, {alpha: 1}, 0.03, {startDelay: i * 0.02, onComplete: function(twn:FlxTween) {
                FlxG.sound.play(Paths.sound('stickerSounds/keyClick' + FlxG.random.int(1, 9)));
                stickersBackupVars[i][1] = sticker.x;
                stickersBackupVars[i][2] = sticker.y;
                if (i == numStickers - 1)
                    {
                        //trace('hlelo');
                        new FlxTimer().start(0.14, function (tmr:FlxTimer) {
                            finishCallback();
                        });
                    }
            }});
        }
    }

    public function readdStickers():Void
    {
        //trace('readding stickmens');
        for (i in 0...numStickers)
        {
            var sticker = new FlxSprite();
            var stickerPath = stickersBackupVars[i][0];
            sticker.loadGraphic(Paths.image(stickerPath));
            sticker.x = stickersBackupVars[i][1];
            sticker.y = stickersBackupVars[i][2];
            sticker.alpha = 1;
            sticker.angle = stickersBackupVars[i][3];
            sticker.scale.x = 1.3;
            sticker.scale.y = 1.3;
            sticker.updateHitbox();
            this.add(sticker);
            stickersBackup.push(sticker);

            stickersBackup[i].cameras = [stickerCam];
        }
        new FlxTimer().start(0.05, function (tmr:FlxTimer) {
            despawnStickers();
        });
    }

    public function despawnStickers():Void {
        //trace('removing stickers!!1!');
        for (i in 0...stickersBackup.length) {
            FlxTween.tween(stickersBackup[i].scale, {x: stickersBackupVars[i][4], y: stickersBackupVars[i][4]}, 0.03, {startDelay: i * 0.02, ease: FlxEase.bounceInOut, type: PERSIST});
            FlxTween.tween(stickersBackup[i], {alpha: 0}, 0.03, {startDelay: i * 0.02, onComplete: function(twn:FlxTween) {
                FlxG.sound.play(Paths.sound('stickerSounds/keyClick' + FlxG.random.int(1, 9)));
                if (stickers[i] != null)
                {
                    stickers[i].kill();
                    stickersBackup[i].kill();
                    stickers[i].destroy();
                    stickersBackup[i].destroy();
                }
                //trace('removed sticker ' + i);
                if (i == numStickers - 1) {
                   // trace('removed stickers!!1!');
                    stickers = [];
                    stickersBackup = [];
                    stickersBackupVars = [];
                    MusicBeatState.transitionType = "fade";
                    close();
                }
            }});
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }

    override public function destroy():Void {
        super.destroy();

        if (stickerCam != null) {
            FlxG.cameras.remove(stickerCam, true);
            stickerCam.destroy();
        }
    }
}