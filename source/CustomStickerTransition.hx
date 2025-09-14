package;

import Conductor.BPMChangeEvent;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxGradient;

//Shit is definitely not like how the actual transition of FNF, but it works, so i don't give a fuck lmao
class CustomStickerTransition extends MusicBeatSubstate {
    public static var finishCallback:Void->Void;
    public static var nextCamera:FlxCamera;
    private var spawn:Bool;
    private var stickerTween:FlxTween;

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

        if (stickerTween != null)
            stickerTween.cancel();

        if (spawn)
        {
            resetStickers();
            spawnStickers();
        }
        else
            readdStickers();

		nextCamera = null;
    }

    public function spawnStickers():Void {
        var zoom:Float = CoolUtil.boundTo(FlxG.camera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);
        
        for (i in 0...numStickers) {
            if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);

            var sticker = new FlxSprite();
            var stickerPath = stickerPaths[FlxG.random.int(0, stickerPaths.length - 1)];
            sticker.loadGraphic(Paths.image(stickerPath));
            sticker.x = FlxG.random.float(-200, (width - sticker.width) + 200);
            sticker.y = FlxG.random.float(-200, (height - sticker.height) + 200);
            sticker.alpha = 0;
            sticker.angle = FlxG.random.float(-60, 70);
            sticker.scale.x = 1.3;
            sticker.scale.y = 1.3;
            sticker.updateHitbox();
            sticker.scale.x = 0.6;
            sticker.scale.y = 0.6;
            this.add(sticker);
            stickers.push(sticker);

            stickers[i].cameras = FlxG.cameras.list;

            stickersBackupVars[i] = [stickerPath, sticker.x, sticker.y, sticker.angle, sticker.scale.x];

            stickerTween = FlxTween.tween(sticker, {alpha: 1, "scale.x": 1.4, "scale.y": 1.4}, 0.02, {startDelay: i * 0.012, ease: FlxEase.bounceInOut, onComplete: function(twn:FlxTween) {
                FlxTween.tween(sticker, {"scale.x": 1.3, "scale.y": 1.3}, 0.02, {ease: FlxEase.cubeInOut, type: PERSIST});
                FlxG.sound.play(Paths.sound('stickerSounds/keyClick' + FlxG.random.int(1, 8)));
                stickersBackupVars[i][1] = sticker.x;
                stickersBackupVars[i][2] = sticker.y;
                if (i == numStickers - 1)
                {
                    new FlxTimer().start(0.24, function (tmr:FlxTimer) {
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

            if(nextCamera != null) stickersBackup[i].cameras = [nextCamera];
        }
        new FlxTimer().start(0.05, function (tmr:FlxTimer) {
            despawnStickers();
        });
    }

    public function despawnStickers():Void
    {
        //trace('removing stickers!!1!');
        if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
        for (i in 0...stickersBackup.length) {
            stickerTween = FlxTween.tween(stickersBackup[i], {alpha: 0, "scale.x": stickersBackupVars[i][4], "scale.y": stickersBackupVars[i][4]}, 0.02, {startDelay: i * 0.012, ease: FlxEase.bounceInOut, onComplete: function(twn:FlxTween) {
                FlxG.sound.play(Paths.sound('stickerSounds/keyClick' + FlxG.random.int(1, 8)));
                if (stickers[i] != null && stickersBackup[i] != null)
                {
                    stickers[i].kill();
                    stickersBackup[i].kill();
                    stickers[i].destroy();
                    stickersBackup[i].destroy();
                }
                //trace('removed sticker ' + i);
                if (i == numStickers - 1) {
                   // trace('removed stickers!!1!');
                    resetStickers();
                    MusicBeatState.transitionType = "fade";
                    close();
                }
            }});
        }
    }

    function resetStickers():Void
    {
        stickers = [];
        stickersBackup = [];
        stickersBackupVars = [];
    }
}