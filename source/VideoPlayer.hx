package;

import flixel.FlxClickableSprite; // Custom Library
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.ui.FlxBar;
import lime.app.Application;
import flixel.input.mouse.FlxMouseEvent;
import hxvlc.flixel.FlxVideoSprite;
import haxe.Int64Helper;

class VideoPlayer extends MusicBeatState
{
    private var onPlayer:Bool = false;
    private var curCategory:String = null;
    private var curVideo:Int = 0;

    // Video Assets
    var videoPaths:Array<Array<String>> = [ // VideoName, Video Title, Category
        ["StoryIntro",                  "Introductory Video",                       "Main"],
        ["Week1_Song1Cutscene",         "Scrouge Cutscene",                         "Main Game Cutscenes"],
        ["Week1_Song4Cutscene",         "Villainy Cutscene",                        "Main Game Cutscenes"],
        ["Week1_NormalEnd",             "Week 1 Normal Ending",                     "Main Game Cutscenes"],
        ["Week1_SecretEnd",             "Week 1 Secret Ending (Casual)",            "Main Game Cutscenes"],
        ["Week2_Song1Cutscene",         "Nunday Monday Cutscene",                   "Main Game Cutscenes"],
        ["Week2_Song4Cutscene",         "Point Blank Cutscene",                     "Main Game Cutscenes"],
        ["Week2_NormalEnd",             "Week 2 Normal Ending",                     "Main Game Cutscenes"],
        ["Week2_TrueEnd",               "Week 2 True Ending",                       "Main Game Cutscenes"],
        ["Week3_Song1Cutscene",         "Forsaken Cutscene",                        "Main Game Cutscenes"],
        ["Week3_Song2Cutscene",         "Toybox Cutscene",                          "Main Game Cutscenes"],
        ["Week3_Song3Cutscene",         "Lustality Cutscene",                       "Main Game Cutscenes"],
        ["Week3_Song4Cutscene",         "Libidinousness Cutscene",                  "Main Game Cutscenes"],
        ["Week3_NormalEnd",             "Week 3 Normal Ending",                     "Main Game Cutscenes"],
        ["Week3_TrueEnd",               "Week 3 True Ending",                       "Main Game Cutscenes"],
        ["Finale_Intro",                "Finale Intro Cutscene",                    "Main Game Cutscenes"],
        ["WeekLegacy_Song1Cutscene",    "Cheap Skate Legacy Cutscene",              "Bonus Weeks Cutscenes"],
        ["WeekLegacy_Song2Cutscene",    "Toxic Mishap Legacy Cutscene",             "Bonus Weeks Cutscenes"],
        ["WeekLegacy_Song3Cutscene",    "Paycheck Legacy Cutscene",                 "Bonus Weeks Cutscenes"],
        ["WeekLegacy_End",              "Alpha Villains Ending",                    "Bonus Weeks Cutscenes"],
        ["oh my god you died NEW!",     "Get Villain'd Death Screen (NEW!)",        "Video-Type Death Screens"],
        ["oh my god you died!",         "Get Villain'd Death Screen (Old)",         "Video-Type Death Screens"],
        ["DVCrash",                     "Forsaken Death Screen",                    "Video-Type Death Screens"],
        ["DVCrashPico",                 "Forsaken Death Screen (Pico Edition)",     "Video-Type Death Screens"],
        ["thereIsAProblem",             "Marauder Death Screen",                    "Video-Type Death Screens"],
        ["NicDeathScreen",              "Slow.FLP Death Screen",                    "Video-Type Death Screens"],
        ["CrossSlap",                   "Negotiation Death Screen",                 "Video-Type Death Screens"],
        ["run",                         "Run.",                                     "Video-Type Death Screens"],
        ["Shucks Cutscene",             "Shuckle Fuckle Cutscene",                  "Extras"],
        ["thinkFastChucklenuts",        "\"7\" Secret",                             "Extras"]
    ];
    var videoBG:FlxSprite;

    var videoPlayerGroup:FlxGroup;
    var playButton:FlxClickableSprite;
    var video:FlxVideoSprite;

    // Video Player Assets
    var overlay:FlxSprite;
    var blackOut:FlxSprite;
    var progressBar:FlxBar;
    var closeButton:FlxSprite;
    var timeText:FlxText;
    var videoPlayerAssets:Array<FlxSprite> = [];

    // Desktop Shit
    var deskCategories:Array<Array<String>> = [ // Category Name, sprite
        ["Main Game Cutscenes", "folder"], ["Bonus Weeks Cutscenes", "folder"], ["Video-Type Death Screens", "folder"], ["Extras", "folder"], ["Recycle Bin", "bin"]
    ];
    var desktopIcons:FlxTypedGroup<FlxClickableSprite>;
    var deskNames:FlxTypedGroup<FlxText>;
    var DEFAULT_DESK_POSITIONS:Array<Array<Float>> = [];

    // Video Shit
    var vidIcons:FlxTypedGroup<FlxClickableSprite>;
    var vidNames:FlxTypedGroup<FlxText>;
    var DEFAULT_VID_POSITIONS:Array<Array<Float>> = [];

    // Windows
    var windowBG:FlxSprite;
    var windowOverlay:FlxSprite;
    var winCloseButton:FlxSprite;

    var appText:FlxText;
    var emptyText:FlxText;

    override public function create():Void {
        FlxG.mouse.visible = true;

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Marco's Desktop", null);
		#end

        // Set Basic BG
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mainMenuBgs/menu-1'));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

        // Adding Desktop Icons
        desktopIcons = new FlxTypedGroup<FlxClickableSprite>();
        add(desktopIcons);
        deskNames = new FlxTypedGroup<FlxText>();
        add(deskNames);

        addObjects("desktop", deskCategories, 25, 50, 7);

        // Set Scrolling Text
        var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 38).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		var Text:FlxText = new FlxText(textBG.x + 1000, textBG.y + 8, FlxG.width + 1000, "CLICK on folder: Open video category | CLICK on video: Boot up video player | BACKSPACE: Go back to the Main Menu", 24);
		Text.setFormat("VCR OSD Mono", 20, FlxColor.WHITE, RIGHT);
		Text.scrollFactor.set();
		add(Text);
	
		FlxTween.tween(Text, {x: textBG.x - 2500}, 20, {ease: FlxEase.linear, type: LOOPING});

        windowBG = new FlxSprite().loadGraphic(Paths.image('videoPlayer/windowBG'));
        windowBG.screenCenter();
		windowBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(windowBG);

        emptyText = new FlxText(50, 0, FlxG.width - 100, "Bitch there's nothing here lmao");
        emptyText.scrollFactor.set();
		emptyText.alpha = 0;
        emptyText.setFormat(Paths.font("charybdis.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
        emptyText.borderSize = 2;
        add(emptyText);

        vidIcons = new FlxTypedGroup<FlxClickableSprite>(); 
        add(vidIcons);
        vidNames = new FlxTypedGroup<FlxText>();
        add(vidNames);
        
        windowOverlay = new FlxSprite().loadGraphic(Paths.image('videoPlayer/windowOverlay'));
        windowOverlay.screenCenter();
        windowOverlay.scale.set(1, 0);
		windowOverlay.antialiasing = ClientPrefs.globalAntialiasing;
        add(windowOverlay);

        winCloseButton = new FlxSprite(windowBG.x + 850, windowBG.y + 10).loadGraphic(Paths.image('videoPlayer/closeButton'));
        winCloseButton.origin.y = windowBG.origin.y;
		winCloseButton.antialiasing = ClientPrefs.globalAntialiasing;
		add(winCloseButton);

        appText = new FlxText(windowBG.x + 60, winCloseButton.y + 5, FlxG.width - 100, "This is a test app text lmao");
        appText.scrollFactor.set();
        appText.alpha = 0;
        appText.setFormat(Paths.font("charybdis.ttf"), 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, 0xFF000000);
        appText.borderSize = 2;
        add(appText);

        // Video Assets
        videoBG = new FlxSprite().makeGraphic(960, 540, FlxColor.BLACK);
        videoBG.scale.set(0, 1);
        videoBG.screenCenter(XY);
        add(videoBG);

        video = new FlxVideoSprite();
        video.scale.set(0.75, 0.75);
        video.updateHitbox();
        video.antialiasing = ClientPrefs.globalAntialiasing;
        video.bitmap.onEndReached.add(function (){
            video.bitmap.time = video.bitmap.length;
            paused = true;
            playButton.isChanged = false;
            setVideo(curVideo, false);
        });

        // Group to sort out the video with the playButton and overlay
        videoPlayerGroup = new FlxGroup();
        add(videoPlayerGroup);
        
        overlay = new FlxSprite().makeGraphic(960, 95, FlxColor.BLACK);
        overlay.screenCenter(XY);
        overlay.origin.x = videoBG.origin.x;
        videoPlayerAssets.push(overlay);
        overlay.alpha = 0;
        overlay.y += 220;

        playButton = new FlxClickableSprite(161, FlxG.height - 181, "videoPlayer/playButtons", "playButton", false, true, playOrPause);
        playButton.antialiasing = ClientPrefs.globalAntialiasing;
        playButton.setHitbox();
        playButton.origin.x = videoBG.origin.x;
        playButton.alpha = 0;
        videoPlayerAssets.push(playButton);
        add(playButton);

        progressBar = new FlxBar(playButton.x + 100, playButton.y + 50, LEFT_TO_RIGHT, 800, 10, this, 'progress', 0, 0.00001);
        progressBar.createFilledBar(0xFF2b2b2b, 0xFFff0000);
        progressBar.alpha = 0;
        progressBar.origin.x = videoBG.origin.x;
        videoPlayerAssets.push(progressBar);
        add(progressBar);

        closeButton = new FlxSprite(videoBG.x, videoBG.y).loadGraphic(Paths.image('mainStoryMode/weekCards/closeButton'));
		closeButton.antialiasing = ClientPrefs.globalAntialiasing;
        closeButton.alpha = 0;
        closeButton.origin.x = videoBG.origin.x;
        videoPlayerAssets.push(closeButton);
		add(closeButton);
        
        // Time text
        timeText = new FlxText(progressBar.x, progressBar.y - 20, 120, "0:00 / 0:00");
        timeText.setFormat("VCR OSD Mono", 14, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
        timeText.borderSize = 2;
        timeText.origin.x = videoBG.origin.x;
        videoPlayerAssets.push(closeButton);
        add(timeText);

        videoPlayerGroup.add(videoBG);
        videoPlayerGroup.add(video);
        videoPlayerGroup.add(overlay);
        videoPlayerGroup.add(playButton);
        videoPlayerGroup.add(progressBar);
        videoPlayerGroup.add(closeButton);
        videoPlayerGroup.add(timeText);

        // Mouse input for seeking
        FlxMouseEvent.add(progressBar, onBarClick, onBarClick, onBarClick, onBarClick);

        if (ClientPrefs.shaders)
        {
            var scanline:ShaderEffect = new CRTEffect(1.25, 0.75);
            var camFilter:Array<BitmapFilter> = [new ShaderFilter(scanline.shader)];
            FlxG.camera.setFilters(camFilter);
        }

        blackOut = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
        add(blackOut);
        new FlxTimer().start(0.25, startBootUp);

        super.create();
    }

    private function startBootUp(tmr:FlxTimer)
    {
        var whiteFlash:FlxSprite = new FlxSprite().makeGraphic(1280, 720, FlxColor.WHITE);
        whiteFlash.scale.set(1, 0);
		add(whiteFlash);
        
        new FlxTimer().start(0.25, function (tmr:FlxTimer) { FlxG.sound.play(Paths.sound('pcBoot'), 0.6);  });
        FlxTween.tween(whiteFlash, {"scale.y": 1}, 0.5, {ease: FlxEase.circIn, onComplete: function (twn:FlxTween)
            {
                FlxTween.tween(whiteFlash, {alpha: 0}, 0.5, {ease: FlxEase.cubeInOut, startDelay: 1.25, onComplete: function (twn:FlxTween)
                    {
                        whiteFlash.kill();
                    }
                });

                blackOut.kill();
                onPlayer = true;
            }
        });
    }

    function addObjects(variant:String = "desktop", array:Array<Array<String>>, xStart:Float = 25, yStart:Float = 50, amount:Int = 7, xOffset:Int = 185)
    {
        var y:Float = yStart;
        var rowCounter:Int = 0;
        var id:Int = 0;

        for (i in 0...array.length)
        {
            if (variant == "videos")
            {
                if (videoPaths[i][2] != curCategory)
                    continue; // Skip the loop, continue to next item 
            }
             
            if (i > 0 && id % amount == 0)
            {
                y += 150;
                rowCounter = 0;
            }
            var x:Float = (rowCounter * xOffset) + xStart;
                
            if (variant == "desktop" && deskCategories[i][1] == "bin") { x = 1150; y = 500; }
            var icon:FlxClickableSprite = new FlxClickableSprite(x, y, 'videoPlayer/desktopIcons', (variant == "videos") ? 'vidIcon' : deskCategories[i][1], true, function(){
                switch(variant)
                {
                    case "videos":
                        if (!viewingVideo) setVideo(i);

                    case "desktop":
                        curCategory = appText.text = deskCategories[i][0]; // Make sure the category name is set properly
                        openWindow(deskCategories[i][1]);
                }
                
            });
            if (variant == "videos") 
            {
                icon.alpha = 0;
                icon.addBoundaries(windowBG.x + 50, windowBG.y + 25, windowBG.width - 100, windowBG.height - 75);
            }
            else
                icon.addBoundaries(0, 0, 1280, 720);
            icon.ID = id;
            icon.antialiasing = ClientPrefs.globalAntialiasing;

            rowCounter++;

            var text:FlxText = new FlxText(icon.x - 20, icon.y + 105, 150, (variant == "videos") ? videoPaths[i][1] : deskCategories[i][0]);
            text.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
            text.ID = id;
            text.borderSize = 2;

            switch(variant)
            {
                case "videos":
                    vidIcons.add(icon);
                    vidNames.add(text);
                    DEFAULT_VID_POSITIONS.push([icon.x, icon.y]);
                    FlxTween.tween(icon, {alpha: 1}, 0.4 + (id * .05), {ease: FlxEase.circInOut, type: PERSIST});

                case "desktop":
                    desktopIcons.add(icon);
                    deskNames.add(text);
                    DEFAULT_DESK_POSITIONS.push([icon.x, icon.y]);
            }
            id++; // Incfease ID
        }
    }

    private function openWindow(asset:String)
    {
        FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
        transitioning = true;
        FlxTween.tween(windowOverlay, {"scale.y": 1}, 0.4, {ease: FlxEase.circInOut, onComplete: function(twn: FlxTween)
            {
                FlxTween.tween(appText, {alpha: 1}, 0.25, {ease: FlxEase.circInOut, type: PERSIST});
                if (asset != "bin")
                    addObjects("videos", videoPaths, 205, 15, 6, 150);
                else
                {
                    emptyText.screenCenter(Y);
                    FlxTween.tween(emptyText, {alpha: 1}, 0.4, {ease: FlxEase.circInOut, type: PERSIST});
                } 
                openedFolder = true;   
                transitioning = false;    
            }
        });
    }

    function checkDragging(group:FlxTypedGroup<FlxClickableSprite>)
    {
        group.forEach(function(icon:FlxClickableSprite)
        {
            if (!openedFolder)
                icon.hoverable = true;
            else
                icon.hoverable = false;
        });
    }

    var isUIVisible:Bool = false;
    var paused:Bool = true;

    var viewingVideo:Bool = false;
    var videoStarted:Bool = false;
    var transitioning:Bool = false;
    var openedFolder:Bool = false;
    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        checkDragging(desktopIcons);
        checkScales();
        moveIcons();
        checkUIVisibility(elapsed);

        // Get time for the video (Int64 to float using int64helper etc etc)
        if (viewingVideo && video.bitmap != null) {
            var curTimeInFloat = int64toMSFloat(video.bitmap.time);
            var lengthInFloat = int64toMSFloat(video.bitmap.length);

            if (lengthInFloat > 0 && progressBar.max != lengthInFloat) progressBar.setRange(0, lengthInFloat);
            progressBar.value = curTimeInFloat;

            timeText.text = formatTime(curTimeInFloat) + " / " + formatTime(lengthInFloat);
        } else {
            timeText.text = "00:00 / 00:00";
            progressBar.value = 0;
        }

        // Messing with Alphas
        progressBar.alpha = timeText.alpha = playButton.alpha; // Everything follows the playButton
        if(FlxG.mouse.overlaps(videoBG) && viewingVideo)
            isUIVisible = true;
        else
            isUIVisible = false;

        if (onPlayer)
        {
            var back = controls.BACK || ((FlxG.mouse.overlaps(closeButton) || FlxG.mouse.overlaps(winCloseButton)) && FlxG.mouse.justPressed);

            if (!transitioning && back) // make sure you're not transitioning
            {
                transitioning = true;

                FlxG.sound.play(Paths.sound('cancelMenu'));
                if (viewingVideo)
                {
                    if (video.bitmap != null) video.stop();
                    video.alpha = 0;

                    viewingVideo = playButton.isChanged = false;

                    FlxTween.tween(videoBG, {"scale.x": 0}, 0.4, {ease: FlxEase.circInOut, onComplete: function(twn: FlxTween)
                        {
                            transitioning = false;
                        }
                    });
                }
                else if (openedFolder)
                {
                    FlxTween.tween(emptyText, {alpha: 0}, 0.25, {ease: FlxEase.circInOut, type: PERSIST}); // Fade out just in case
                    FlxTween.tween(appText, {alpha: 0}, 0.25, {ease: FlxEase.circInOut, type: PERSIST}); // Fade out just in case

                    vidIcons.forEach(function(spr:FlxSprite)
                    {
                        FlxTween.tween(spr, {alpha: 0}, 0.4, {ease: FlxEase.circInOut, onComplete: function(twn:FlxTween)
                            {
                                remove(spr, true);
                            }
                        });
                    });
                    new FlxTimer().start((curCategory == "Recycle Bin") ? 0.001 : 0.4, function (tmr:FlxTimer)
                    {
                        openedFolder = false;
                        if (curCategory != "Recycle Bin")
                        {
                            vidNames.clear();
                            vidIcons.clear();
                            DEFAULT_VID_POSITIONS = [];
                        }
                    
                        FlxTween.tween(windowOverlay, {"scale.y": 0}, 0.4, {ease: FlxEase.circInOut, onComplete: function(twn: FlxTween)
                            {
                                transitioning = false;
                            }
                        });
                    });
                    curCategory = null;
                }
                else
                {
                    FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
                    FlxG.sound.music.fadeIn(4, 0, 1);
                    MusicBeatState.switchState(new MainMenuState());
                }
            }  
        }
    }
    
    function checkScales()
    {
        // Automatically set scales
        windowBG.scale.set(windowOverlay.scale.x, windowOverlay.scale.y);
        winCloseButton.scale.set(windowOverlay.scale.x, windowOverlay.scale.y);

        for (obj in videoPlayerGroup.members)
        {
            if (obj != videoBG && obj != video)
            {
                if (Std.isOfType(obj, FlxSprite))
                {
                    var spr = cast(obj, FlxSprite);
                    spr.scale.set(videoBG.scale.x, videoBG.scale.y);
                    spr.updateHitbox();
                } else if (Std.isOfType(obj, FlxText)) 
                {
                    var txt = cast(obj, FlxText);
                    txt.scale.set(videoBG.scale.x, videoBG.scale.y);
                    txt.updateHitbox(); // Optional, if you want accurate bounds
                }
            }
        }
    }

    function moveIcons()
    {
        // Texts with icons move together
        if (!openedFolder && !viewingVideo)
            deskNames.forEach(function(spr:FlxText)
            {
                spr.x = desktopIcons.members[spr.ID].x - 20;
                spr.y = desktopIcons.members[spr.ID].y + 105;
                spr.alpha = desktopIcons.members[spr.ID].alpha;

                if (FlxG.mouse.justPressedRight && !viewingVideo) // Reset shits back to their place LMAO
                    desktopIcons.forEach(function(deskIcon:FlxClickableSprite)
                    {
                        FlxTween.tween(deskIcon, {x: DEFAULT_DESK_POSITIONS[deskIcon.ID][0], y: DEFAULT_DESK_POSITIONS[deskIcon.ID][1]}, 0.4, {ease: FlxEase.circInOut, type: PERSIST});
                    });
            });
        else if (openedFolder && !viewingVideo)
            vidNames.forEach(function(spr:FlxText)
            {
                spr.x = vidIcons.members[spr.ID].x - 20;
                spr.y = vidIcons.members[spr.ID].y + 105;
                spr.alpha = vidIcons.members[spr.ID].alpha;

                if (FlxG.mouse.justPressedRight && !viewingVideo) // Reset shits back to their place LMAO
                    vidIcons.forEach(function(vidSprite:FlxClickableSprite)
                    {
                        FlxTween.tween(vidSprite, {x: DEFAULT_VID_POSITIONS[vidSprite.ID][0], y: DEFAULT_VID_POSITIONS[vidSprite.ID][1]}, 0.4, {ease: FlxEase.circInOut, type: PERSIST});
                    });
            });
    }

    function checkUIVisibility(elapsed:Float)
    {
        if (isUIVisible)
        {
            for (i in 0...videoPlayerAssets.length)
                if (videoPlayerAssets[i].alpha < 0.6)
                    videoPlayerAssets[i].alpha += 5 * elapsed;

            if (FlxG.mouse.overlaps(closeButton))
                closeButton.alpha = 1;
            else if (closeButton.alpha > 0.6)
                closeButton.alpha -= 5 * elapsed;
        }
        else
        {
            for (i in 0...videoPlayerAssets.length)
                if (videoPlayerAssets[i].alpha > 0)
                    videoPlayerAssets[i].alpha -= 5 * elapsed;
        }

        if (openedFolder)
        {
            if (FlxG.mouse.overlaps(winCloseButton))
                winCloseButton.alpha = 1;
            else if (winCloseButton.alpha > 0.6)
                winCloseButton.alpha -= 5 * elapsed;
        }
    }

    function setVideo(vidToLoad:Int = 0, ?playSound:Bool = true)
    {
        if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.6);
        
        curVideo = vidToLoad;
        viewingVideo = transitioning = true;

        FlxTween.tween(videoBG, {"scale.x": 1}, 0.25, {ease: FlxEase.circOut, onComplete: function (_)
        {
            // Video gets paused, applying new video
            paused = true;
            videoStarted = transitioning = false;

            if (video.bitmap != null && video.bitmap.isPlaying) video.stop(); 
            video.alpha = 0;
        }
        });
    }

    function playOrPause():Void
    {
        paused = !paused;

        if (videoStarted) // If video is already playing
        {
            playButton.isChanged = paused;
            if (paused) video.pause(); else video.resume();
        }
        else
        {
            videoStarted = true;

            var vidPath:String = Paths.video(videoPaths[curVideo][0]);
            video.load(vidPath, null);
            video.play();
            video.alpha = 1;

            var lengthInFloat = int64toMSFloat(video.bitmap.length);
            progressBar.setRange(0, Math.max(1, lengthInFloat));

            trace("Playing video: " + vidPath);
            playButton.isChanged = paused = false;
        }
    }   

    function onBarClick(sprite:FlxSprite):Void
    {
        if (!videoStarted) return;

        if (FlxG.mouse.justReleased)
        {
            var lengthInFloat = int64toMSFloat(video.bitmap.length);
            if (lengthInFloat <= 0) return;

            // Get mouse position on bar
            var mouseXPos:Float = FlxG.mouse.x - progressBar.x;
            var progress:Float = mouseXPos / progressBar.width;
            var newMsF = progress * lengthInFloat;

            // Float -> Int64 (safe for long media)
            video.bitmap.time = Int64Helper.fromFloat(newMsF);

            trace("New Time: " + formatTime(newMsF) + " | " + video.bitmap.time);
        }
    }

    inline function int64toMSFloat(x:haxe.Int64):Float
    {
        // treat negatives (e.g. -1 before metadata) as 0 for UI
        if (x < 0) return 0.;
        // hi * 2^32 + unsigned(low)
        return x.high * 4294967296.0 + (x.low >>> 0);
    }

    inline function formatTime(msF:Float):String {
        var ms = Std.int(msF);
        var s  = Std.int(ms / 1000);
        var m  = Std.int(s / 60);
        s %= 60;
        return StringTools.lpad('' + m, '0', 2) + ":" + StringTools.lpad('' + s, '0', 2);
    }
}