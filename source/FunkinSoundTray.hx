package;

import flixel.system.ui.FlxSoundTray;
import openfl.display.Bitmap;
import openfl.utils.Assets;

/**
 *  Extends the default flixel soundtray, but with some art
 *  and lil polish!
 *
 *  Gets added to the game in Main.hx, right after FlxGame is new'd
 *  since it's a Sprite rather than Flixel related object
 */
class FunkinSoundTray extends FlxSoundTray
{
  var graphicScale:Float = 0.30;
  var lerpYPos:Float = 0;
  var alphaTarget:Float = 0;

  var volumeMaxSound:String;

  // What library should Paths search for the sounds and images.
  var library:String = "shared";

  // Image and Sound Paths to search
  var imagePath:String = "images/soundTray/";
  var soundPath:String = "sounds/soundTray/";

  public function new()
  {
    // calls super, then removes all children to add our own
    // graphics
    super();
    removeChildren();

    var fileImage = Paths.getPath('${imagePath}volumebox.png', IMAGE, library, false);

    var bg:Bitmap = new Bitmap(Assets.getBitmapData(fileImage));
    bg.scaleX = graphicScale;
    bg.scaleY = graphicScale;
    bg.smoothing = ClientPrefs.globalAntialiasing;
    addChild(bg);

    y = -height;
    visible = false;

    fileImage = Paths.getPath('${imagePath}bars_10.png', IMAGE, library, false);
    // makes an alpha'd version of all the bars (bar_10.png)
    var backingBar:Bitmap = new Bitmap(Assets.getBitmapData(fileImage));
    backingBar.x = 9;
    backingBar.y = 5;
    backingBar.scaleX = graphicScale;
    backingBar.scaleY = graphicScale;
    backingBar.smoothing = ClientPrefs.globalAntialiasing;
    addChild(backingBar);
    backingBar.alpha = 0.4;

    // clear the bars array entirely, it was initialized
    // in the super class
    _bars = [];

    // 1...11 due to how block named the assets,
    // we are trying to get assets bars_1-10
    for (i in 1...11)
    {
      fileImage = Paths.getPath('${imagePath}bars_$i.png', IMAGE, library, false);
      var bar:Bitmap = new Bitmap(Assets.getBitmapData(fileImage));
      bar.x = 9;
      bar.y = 5;
      bar.scaleX = graphicScale;
      bar.scaleY = graphicScale;
      bar.smoothing = ClientPrefs.globalAntialiasing;
      addChild(bar);
      _bars.push(bar);
    }

    y = -height;
    screenCenter();

    volumeUpSound = Paths.getPath('${soundPath}Volup.ogg', SOUND, library, false);
    volumeDownSound = Paths.getPath('${soundPath}Voldown.ogg', SOUND, library, false);
    volumeMaxSound = Paths.getPath('${soundPath}VolMAX.ogg', SOUND, library, false);

    trace("FunkinSoundTray: Custom tray added!");
  }

  override public function update(MS:Float):Void
  {
    y = FlxMath.lerp(y, lerpYPos, 0.1);
    alpha = FlxMath.lerp(alpha, alphaTarget, 0.25);

    // Animate sound tray thing
    if (_timer > 0)
    {
        _timer -= (MS / 1000);
        alphaTarget = 1;
    }
    else if (y >= -height)
    {
        lerpYPos = -height - 10;
        alphaTarget = 0;
    }

    if (y <= -height)
    {
        visible = false;
        active = false;

        #if FLX_SAVE
        // Save sound preferences
        if (FlxG.save.isBound)
        {
          FlxG.save.data.mute = FlxG.sound.muted;
          FlxG.save.data.volume = FlxG.sound.volume;
          FlxG.save.flush();
        }
        #end
    }
  }

  /**
   * Makes the little volume tray slide out.
   *
   * @param	up Whether the volume is increasing.
   */
  override public function show(up:Bool = false):Void
  {
    _timer = 1;
    lerpYPos = 10;
    visible = true;
    active = true;
    var globalVolume:Int = Math.round(FlxG.sound.volume * 10);

    if (FlxG.sound.muted) globalVolume = 0;

    if (!silent)
    {
      var sound = up ? volumeUpSound : volumeDownSound;

      if (globalVolume == 10) sound = volumeMaxSound;

      if (sound != null) FlxG.sound.load(sound).play();
    }

    for (i in 0..._bars.length) _bars[i].visible = (i < globalVolume) ? true : false;
  }
}
