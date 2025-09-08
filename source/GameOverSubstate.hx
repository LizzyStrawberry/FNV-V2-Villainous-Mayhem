package;

import Song.SwagSong;

import flash.system.System;

class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Boyfriend;
	public static var SONG:SwagSong = null;
	var camFollow:FlxPoint;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";

	var blackOut:FlxSprite;

	public static var characterName:String = 'playablegf';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'haha you died';
	public static var endSoundName:String = 'gameOverEnd';

	public static var injected:Bool = false;
	public static var mayhemed:Bool = false;

	public static var instance:GameOverSubstate;
	public static var playerSelected:String = "";

	public static function resetVariables() {
		characterName = 'playablegf';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
	}

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		playerSelected = PlayState.SONG.player1;

		if (!initializedVideo)
		{
			switch(Paths.formatToSongPath(PlayState.SONG.song))
			{
				case "marauder" | "marauder-(old)":
					createDeathVideo('thereIsAProblem', true, true);

				case "jerry":
					lime.app.Application.current.window.title = "run.";
					createDeathVideo('run', false, true);

				case "negotiation":
					createDeathVideo('CrossSlap', false, false);

				case "slowflp" | "slowflp-(old)":
					createDeathVideo('NicDeathScreen', false, false);

				case "get-villaind":
					lime.app.Application.current.window.title = "HAHA, I aM MorKy, and I wiLL nOw CloSe uR gAem!! YoU cAn't Do ShIt nOW HAHAAAAAAAAAAAAAAAAAAAAAAAAAAA";
					createDeathVideo('oh my god you died NEW!', false, true);

				case "get-villaind-(old)":
					lime.app.Application.current.window.title = "HAHA, I aM MorKy, and I wiLL nOw CloSe uR gAem!! YoU cAn't Do ShIt nOW HAHAAAAAAAAAAAAAAAAAAAAAAAAAAA";
					createDeathVideo('oh my god you died!', false, true);
			}
		}

		if (PlayState.isInjectionMode)
		{
			PlayState.checkForPowerUp = true; //Don't give bonus!
			injected = true;
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;
			FlxTween.tween(blackOut, {alpha: 1}, 1.6, {ease: FlxEase.cubeInOut, type: PERSIST});
			new FlxTimer().start(2.5, function (tmr:FlxTimer) {
				MusicBeatState.switchState(new ResultsScreenState());
			});
		}

		if (PlayState.isMayhemMode)
		{
			if (PlayState.mayhemSongsPlayed < 1)
				PlayState.checkForPowerUp = true; //Don't give bonus!
			if (!PlayState.checkForPowerUp)
				PlayState.campaignScore += 25000;
			mayhemed = true;
			ClientPrefs.ghostTapping = true; //Reset this
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;
			FlxTween.tween(blackOut, {alpha: 1}, 1.6, {ease: FlxEase.cubeInOut, type: PERSIST});
			new FlxTimer().start(2.5, function (tmr:FlxTimer) {
				if (PlayState.mayhemSongsPlayed == 0)
					MusicBeatState.switchState(new ResultsScreenState());
				else
					MusicBeatState.switchState(new TokenAchievement());
			});
		}

		super.create();
	}

	public function new(x:Float, y:Float, camX:Float, camY:Float)
	{
		super();

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

		boyfriend = new Boyfriend(x, y, characterName);
		boyfriend.x += boyfriend.positionArray[0];
		boyfriend.y += boyfriend.positionArray[1];
		add(boyfriend);

		camFollow = new FlxPoint(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);

		if (deathSoundName != null && deathSoundName != "") FlxG.sound.play(Paths.sound(deathSoundName));
		Conductor.changeBPM(100);
		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		boyfriend.playAnim('firstDeath');

		camFollowPos = new FlxObject(0, 0, 1, 1);
		camFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2));
		add(camFollowPos);

		if (PlayState.isInjectionMode || PlayState.isMayhemMode)
		{
			blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFF000000);
			blackOut.alpha = 0;
			add(blackOut);
		}

		addTouchPad("NONE", "B");
		addTouchPadCamera();
	}

	var isFollowingAlready:Bool = false;
	var initializedVideo:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);
		if(updateCamera) {
			var lerpVal:Float = CoolUtil.boundTo(elapsed * 0.6, 0, 1);
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		}

		if (controls.ACCEPT || TouchUtil.pressAction(boyfriend))
		{
			if (!(initializedVideo || PlayState.isInjectionMode || PlayState.isMayhemMode))
				endBullshit();
		}

		if (controls.BACK)
		{
			if (!(initializedVideo || PlayState.isInjectionMode || PlayState.isMayhemMode))
			{
				if (PlayState.SONG.stage == "DV's BG")
				{
					if (PlayState.SONG.player1 == "cassettteGirl") // Casette Girl Death
						createDeathVideo("DVCrash", false, true);
					else
						createDeathVideo("DVCrashPico", false, true);
				}
				else
				{
					if (FlxG.sound.music != null)
						FlxG.sound.music.stop();

					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;
					PlayState.chartingMode = false;
					PlayState.checkForPowerUp = false;
					
					WeekData.loadTheFirstEnabledMod();

					ClientPrefs.lowQuality = false;
					if (PlayState.isStoryMode){
						ClientPrefs.ghostTapping = true;
						
						ClientPrefs.resetStoryModeProgress(true);

						if (PlayState.isIniquitousMode)
							MusicBeatState.switchState(new IniquitousMenuState());
						else
							MusicBeatState.switchState(new StoryMenuState());
					}else if(PlayState.isInjectionMode) {
						PlayState.isInjectionMode = false;
						MusicBeatState.switchState(new MainMenuState());
					}else if(PlayState.isMayhemMode) {
						PlayState.isMayhemMode = false;
						MusicBeatState.switchState(new MainMenuState());
					} else {
						if (ClientPrefs.onCrossSection)
							MusicBeatState.switchState(new CrossoverState()); //go to Crossover State
						else
							MusicBeatState.switchState(new FreeplayState()); // Back To Freeplay
					}
		
					if (ClientPrefs.iniquitousWeekUnlocked && !ClientPrefs.iniquitousWeekBeaten)
						FlxG.sound.playMusic(Paths.music('malumIctum'));
					else if (FlxG.random.int(1, 10) == 2)
						FlxG.sound.playMusic(Paths.music('AJDidThat'));
					else
						FlxG.sound.playMusic(Paths.music('freakyMenu'));
					PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
				}	
			}
		}

		if (boyfriend.animation.curAnim != null && boyfriend.animation.curAnim.name == 'firstDeath')
		{
			if(boyfriend.animation.curAnim.curFrame >= 12 && !isFollowingAlready)
			{
				FlxG.camera.follow(camFollowPos, LOCKON, 1);
				updateCamera = true;
				isFollowingAlready = true;
			}

			if (boyfriend.animation.curAnim.finished && !playingDeathSound)
			{
				coolStartDeath();
				boyfriend.startedDeath = true;
			}
		}

		if (FlxG.sound.music.playing)
			Conductor.songPosition = FlxG.sound.music.time;

		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();

		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;
	var endingDur:Float = 0.7;
	function coolStartDeath(?volume:Float = 1):Void
	{
		if (loopSoundName != null && loopSoundName != "") FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			checkForMechanics();
			
			isEnding = true;
			if (Paths.formatToSongPath(PlayState.SONG.song) != 'shuckle-fuckle') //Avoid playing the deathConfirm Animation
				boyfriend.playAnim('deathConfirm', true);

			if (PlayState.SONG.stage == 'TheFinale' || Paths.formatToSongPath(PlayState.SONG.song) == 'shuckle-fuckle')
				FlxG.sound.music.fadeOut(1.7);
			else
			{
				FlxG.sound.music.stop();
				if (endSoundName != null && endSoundName != "") FlxG.sound.play(Paths.music(endSoundName));
			}

			if (Paths.formatToSongPath(PlayState.SONG.song) == 'tactical-mishap')
				endingDur = 1.9;
			else if (PlayState.SONG.stage == 'FABG')
				endingDur = 1.4;

			new FlxTimer().start(endingDur, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}

	function createDeathVideo(videoPath:String = '', canSkip:Bool = true, crashGame:Bool = false)
	{
		videoPath = Paths.video(videoPath);
		initializedVideo = true;
	
		boyfriend.visible = false;

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		function onVideoEnd()
		{
			if (crashGame)
				System.exit(0);
			else if (!PlayState.isMayhemMode || !PlayState.isInjectionMode)
				MusicBeatState.resetState();
		}

		var video:VideoSprite = new VideoSprite(videoPath, false, canSkip, false);
		video.finishCallback = onVideoEnd;
		video.onSkip = onVideoEnd;
		add(video);
		video.play();
	}

	function checkForMechanics()
	{
		var songName:String = Paths.formatToSongPath(PlayState.SONG.song);
		switch(songName)
		{
			case "toxic-mishap":
				if (PlayState.storyDifficulty == 1)
				{
					if (ClientPrefs.mechanics == false)
					{
						trace('Its working! No mechanics for Toxic Mishap in Villainous!');
						PlayState.SONG = Song.loadFromJson('toxic-mishap-villainousMechanicless', 'toxic-mishap');
					}
					else
					{
						PlayState.SONG = Song.loadFromJson('toxic-mishap-villainous', 'toxic-mishap');
					}
				}

			case "villainy":
				if (PlayState.storyDifficulty == 0 || (PlayState.storyDifficulty == 1 && PlayState.isStoryMode)) //On Freeplay: 0, on Story Mode: 1
				{
					if (ClientPrefs.mechanics == false)
					{
						trace('Its working! No mechanics for Villainy in Villainous!');
						PlayState.SONG = Song.loadFromJson('villainy-villainousMechanicless', 'villainy');
					}
					else
					{
						trace('Its working! Mechanics for Villainy in Villainous!');
						PlayState.SONG = Song.loadFromJson('villainy-villainous', 'villainy');
					}
				}

			case "toybox":
				if (ClientPrefs.mechanics == false)
				{
					if (PlayState.storyDifficulty == 0)
					{
						trace('Its working! No mechanics for Toybox in Casual!');
						PlayState.SONG = Song.loadFromJson('toybox-casualMechanicless', 'toybox');
					}
					else if (PlayState.storyDifficulty == 1)
					{
						trace('Its working! No mechanics for Toybox in Villainous!');
						PlayState.SONG = Song.loadFromJson('toybox-villainousMechanicless', 'toybox');
					}
				}
				else if (ClientPrefs.mechanics == true)
				{
					if (PlayState.storyDifficulty == 0)
					{
						trace('Its working! Mechanics for Toybox in Casual!');
						PlayState.SONG = Song.loadFromJson('toybox', 'toybox');
					}
					else if (PlayState.storyDifficulty == 1)
					{
						trace('Its working! Mechanics for Toybox in Villainous!');
						PlayState.SONG = Song.loadFromJson('toybox-villainous', 'toybox');
					}
				}

			case "lustality-remix":
				if (ClientPrefs.mechanics == false)
				{
					if (PlayState.storyDifficulty == 0)
					{
						trace('Its working! No mechanics for Lustality Remix in Casual!');
						PlayState.SONG = Song.loadFromJson('lustality-remix-casualMechanicless', 'lustality-remix');
					}
					else if (PlayState.storyDifficulty == 1)
					{
						trace('Its working! No mechanics for Lustality Remix in Villainous!');
						PlayState.SONG = Song.loadFromJson('lustality-remix-villainousMechanicless', 'lustality-remix');
					}
				}
				else if (ClientPrefs.mechanics == true)
				{
					if (PlayState.storyDifficulty == 0)
					{
						trace('Its working! Mechanics for Lustality Remix in Casual!');
						PlayState.SONG = Song.loadFromJson('lustality-remix', 'lustality-remix');
					}
					else if (PlayState.storyDifficulty == 1)
					{
						trace('Its working! Mechanics for Lustality Remix in Villainous!');
						PlayState.SONG = Song.loadFromJson('lustality-remix-villainous', 'lustality-remix');
					}
					
				}

			case "lustality":
				if (ClientPrefs.mechanics == false)
				{
					if (PlayState.storyDifficulty == 0)
					{
						trace('Its working! No mechanics for Lustality in Casual!');
						PlayState.SONG = Song.loadFromJson('lustality-casualMechanicless', 'lustality');
					}
					else if (PlayState.storyDifficulty == 1)
					{
						trace('Its working! No mechanics for Lustality in Villainous!');
						PlayState.SONG = Song.loadFromJson('lustality-villainousMechanicless', 'lustality');
					}
				}
				else if (ClientPrefs.mechanics == true)
				{
					if (PlayState.storyDifficulty == 0)
					{
						trace('Its working! Mechanics for Lustality in Casual!');
						PlayState.SONG = Song.loadFromJson('lustality', 'lustality');
					}
					else if (PlayState.storyDifficulty == 1)
					{
						trace('Its working! Mechanics for Lustality in Villainous!');
						PlayState.SONG = Song.loadFromJson('lustality-villainous', 'lustality');
					}
				}

			case "lustality-v1":
				if (ClientPrefs.mechanics == false)
				{
					if (PlayState.storyDifficulty == 0)
					{
						trace('Its working! No mechanics for Lustality V1 in Casual!');
						PlayState.SONG = Song.loadFromJson('lustality-v1-casualMechanicless', 'lustality-v1');
					}
					else if (PlayState.storyDifficulty == 1)
					{
						trace('Its working! No mechanics for Lustality V1 in Villainous!');
						PlayState.SONG = Song.loadFromJson('lustality-v1-villainousMechanicless', 'lustality-v1');
					}
				}
				else if (ClientPrefs.mechanics == true)
				{
					if (PlayState.storyDifficulty == 0)
					{
						trace('Its working! Mechanics for Lustality V1 in Casual!');
						PlayState.SONG = Song.loadFromJson('lustality-v1', 'lustality-v1');
					}
					else if (PlayState.storyDifficulty == 1)
					{
						trace('Its working! Mechanics for Lustality V1 in Villainous!');
						PlayState.SONG = Song.loadFromJson('lustality-v1-villainous', 'lustality-v1');
					}
				}

			case "toxic-mishap-(legacy)":
				if (PlayState.storyDifficulty == 1)
				{
					if (ClientPrefs.mechanics == false)
					{
						trace('Its working! No mechanics for Toxic Mishap (Legacy) in Villainous!');
						PlayState.SONG = Song.loadFromJson('toxic-mishap-(legacy)-villainousMechanicless', 'toxic-mishap-(legacy)');
					}
					else
					{
						trace('Its working! Mechanics for Toxic Mishap (Legacy) in Villainous!');
						PlayState.SONG = Song.loadFromJson('toxic-mishap-(legacy)-villainous', 'toxic-mishap-(legacy)');
					}
				}
		}
	
		PlayState.SONG.player1 = playerSelected;
	}
}
