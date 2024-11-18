package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;

class PauseSubState extends MusicBeatSubstate
{
	var options:Array<String> = ['Mechanics', 'Shaders', 'Cinematic Bars', 'Scroll Type', 'BotPlay', 'FrameRate']; //Main Options for Story Mode
	private var grpOpts:FlxTypedGroup<Alphabet>;
	var curOption:Int = 0;
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = [];
	var menuItemsOG:Array<String> = ['Resume Song', 'Restart Song', 'Quick Settings', 'Give up']; //Main Selections
	var difficultyChoices = [];
	var curSelected:Int = 0;

	var pauseMusic:FlxSound;
	var practiceText:FlxText;
	var skipTimeText:FlxText;
	var skipTimeTracker:Alphabet;
	var curTime:Float = Math.max(0, Conductor.songPosition);

	public static var levelInfo:FlxText;
	var timerInfo:FlxText;
	//var botplayText:FlxText;

	var tokenInfo:FlxText;

	//For Charms
	var charmText:FlxText;
	var charmIcon:FlxSprite;
	var showCharm:Bool = false;

	var bgGradient:FlxSprite;
	var pauseCard:FlxSprite;
	var arrows:FlxSprite;

	//Making Skip Time work with the change
	var skipTimeBG:FlxSprite;
	var skipTimeTitle:FlxText;

	public static var changedSettings:Bool = false;
	public static var playerSelected:String = '';

	public static var songName:String = '';

	public function new(x:Float, y:Float)
	{
		super();
		if(CoolUtil.difficulties.length < 2) menuItemsOG.remove('Change Difficulty'); //No need to change difficulty if there is only one!
		if(PlayState.isInjectionMode || PlayState.isMayhemMode) menuItemsOG.remove('Restart Song');
		if(ClientPrefs.getGameplaySetting('botplay', false)) menuItemsOG.remove('Quick Settings');

		//Setup Quick Settings for injection mode, mayhem mode
		if (PlayState.isInjectionMode || PlayState.isMayhemMode)
			options = ['Shaders', 'Cinematic Bars', 'Scroll Type', 'FrameRate'];
		if (PlayState.isIniquitousMode)
			options = ['Shaders', 'Cinematic Bars', 'Scroll Type', 'BotPlay', 'FrameRate'];
		changedSettings = false;
		playerSelected = PlayState.SONG.player1;

		if(PlayState.chartingMode)
		{
			menuItemsOG.insert(2, 'Leave Charting Mode');
			
			var num:Int = 0;
			if(!PlayState.instance.startingSong)
			{
				num = 1;
				menuItemsOG.insert(3, 'Skip Time');
			}
			menuItemsOG.insert(3 + num, 'End Song');
			menuItemsOG.insert(4 + num, 'Toggle Practice Mode');
			menuItemsOG.insert(5 + num, 'Toggle Botplay');
		}
		menuItems = menuItemsOG;

		for (i in 0...CoolUtil.difficulties.length) {
			var diff:String = '' + CoolUtil.difficulties[i];
			difficultyChoices.push(diff);
		}
		difficultyChoices.push('BACK');


		pauseMusic = new FlxSound();
		if(songName != null) {
			pauseMusic.loadEmbedded(Paths.music(songName), true, true);
		} else if(Paths.formatToSongPath(PlayState.SONG.song) == 'iniquitous') {
			pauseMusic.loadEmbedded(Paths.music("iniquitousPause"), true, true);
		} else if (songName != 'None') {
			pauseMusic.loadEmbedded(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)), true, true);
		}
		pauseMusic.volume = 0;
		pauseMusic.pitch = PlayState.instance.playbackRate;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		levelInfo = new FlxText(20, 15 + 11, 0, "", 32);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();


		bgGradient = new FlxSprite(0, 0).loadGraphic(Paths.image('pauseGradient/gradient_Null'));
		pauseCard = new FlxSprite(0, 0).loadGraphic(Paths.image('pauseMenu/pause_Default'));
		switch (levelInfo.text) //Add your song's name shown in the pause menu (Case Sensitive), and add the color of the gradient and the pause card you want
		{
			case 'Couple Clash':
				bgGradient.color = 0xFF52a5eb;
				pauseCard.color = 0xFF52a5eb;

			//Main Week Songs
			case 'Scrouge' | 'Cheap Skate (Legacy)':
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;
			case 'Toxic Mishap':
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;
			case 'Paycheck':
				bgGradient.color = 0xFF72cd6e;
				pauseCard.color = 0xFF72cd6e;
			case 'Villainy':
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;

			case 'Nunday Monday':
				bgGradient.color = 0xFFfb000f;
				pauseCard.color = 0xFFfb000f;
			case 'Nunconventional' | 'Nunconventional Simp':
				bgGradient.color = 0xFFfb000f;
				pauseCard.color = 0xFFfb000f;
			case 'Point Blank':
				bgGradient.color = 0xFFfb000f;
				pauseCard.color = 0xFFfb000f;


			case 'Forsaken' | 'Forsaken (Picmixed)' | 'Partner':
				bgGradient.color = 0xFFa85ddb;
				pauseCard.color = 0xFFa85ddb;
			case 'Toybox':
				bgGradient.color = 0xFFd554c0;
				pauseCard.color = 0xFFd554c0;
			case 'Lustality' | 'Lustality Remix':
				bgGradient.color = 0xFFff59d8;
				pauseCard.color = 0xFFff59d8;
			case 'Libidinousness':
				bgGradient.color = 0xFFd12e6a;
				pauseCard.color = 0xFFd12e6a;

			case 'Iniquitous':
				bgGradient.color = 0xFFff0000;
				pauseCard.color = 0xFFff0000;

			case 'Sussus Marcus' | 'Villain In Board':
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;
			case 'Excrete':
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;

			case 'Toxic Mishap (Legacy)':
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;
			case 'Paycheck (Legacy)':
				bgGradient.color = 0xFF72cd6e;
				pauseCard.color = 0xFF72cd6e;

			case "Unpaid Catastrophe":
				bgGradient.color = 0xFF72cd6e;
				pauseCard.color = 0xFF72cd6e;
			case 'Cheque':
				bgGradient.color = 0xFF6ae9fd;
				pauseCard.color = 0xFF6ae9fd;
			case "Get Pico'd" | "Get Gooned":
				bgGradient.color = 0xFF1499ff;
				pauseCard.color = 0xFF1499ff;

			case 'Spendthrift':
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;
			case "Get Villain'd" | "Get Villain'd (Old)":
				bgGradient.color = 0xFF72cd6e;
				pauseCard.color = 0xFF72cd6e;
			
			//Shop Songs
			case 'Nunsational' | 'Nunsational Simp':
				bgGradient.color = 0xFFfb000f;
				pauseCard.color = 0xFFfb000f;
			case 'Marcochrome':
				bgGradient.loadGraphic(Paths.image('pauseGradient/gradient_Null'));
				pauseCard.loadGraphic(Paths.image('pauseMenu/pause_Default'));
			case 'Lustality V1':
				bgGradient.color = 0xFFff04ed;
				pauseCard.color = 0xFFff04ed;
			case 'Tofu':
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;
			case 'Marauder' | 'Marauder (Old)':
				bgGradient.color = 0xFF448b47;
				pauseCard.color = 0xFF448b47;
			case 'Rainy Daze':
				bgGradient.color = 0xFFffb2ed;
				pauseCard.color = 0xFFffb2ed;
			case 'Slow.FLP' | 'Slow.FLP (Old)':
				bgGradient.color = 0xFFffffff;
				pauseCard.color = 0xFFffffff;
			case 'Instrumentally Deranged':
				bgGradient.color = 0xFF824bf4;
				pauseCard.color = 0xFF824bf4;
			case 'FNV':
				bgGradient.color = 0xFF930097;
				pauseCard.loadGraphic(Paths.image('pauseMenu/pause_FNV'));
			case 'Fanfuck Forever':
				bgGradient.color = 0xFF6d0618;
				pauseCard.color = 0xFF6d0618;
			case "0.0015":
				bgGradient.color = 0xFFffffff;
				pauseCard.color = 0xFFffffff;

			// Crossover Songs
			case 'Tactical Mishap':
				bgGradient.color = 0xFFdc047c;
				pauseCard.loadGraphic(Paths.image('pauseMenu/pause_TC'));
			case "VGuy":
				bgGradient.color = 0xFF730dff;
				pauseCard.color = 0xFF730dff;
			case 'Fast Food Therapy':
				bgGradient.color = 0xFFffef0b;
				pauseCard.color = 0xFFffef0b;	
			case 'Breacher':
				bgGradient.color = 0xFF7a3189;
				pauseCard.color = 0xFF7a3189;
			case 'Concert Chaos':
				bgGradient.color = 0xFF9b00ce;
				pauseCard.color = 0xFF9b00ce;

			// Bonus Songs
			case "It's Kiana":
				bgGradient.color = 0xFF03d5ff;
				pauseCard.color = 0xFF03d5ff;
			case "Shucks V2":
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;

			default:
				bgGradient.loadGraphic(Paths.image('pauseGradient/gradient_Null'));
				pauseCard.loadGraphic(Paths.image('pauseMenu/pause_Default'));
		}
		bgGradient.x = 100;
		bgGradient.scale.x = 1.3;
		bgGradient.scale.y = 1.1;
		bgGradient.alpha = 0;
		bgGradient.scrollFactor.set();
		add(bgGradient);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		pauseCard.alpha = 0;
		pauseCard.scrollFactor.set();
		pauseCard.antialiasing = ClientPrefs.globalAntialiasing;
		add(pauseCard);

		arrows = new FlxSprite(0, 0).loadGraphic(Paths.image('pauseMenu/arrows'));
		arrows.alpha = 0;
		arrows.scrollFactor.set();
		arrows.antialiasing = ClientPrefs.globalAntialiasing;
		add(arrows);

		charmIcon = new FlxSprite(0, 0).loadGraphic(Paths.image('shop/prizes/prize_Charm_1'));
		charmIcon.alpha = 0;
		charmIcon.x += 70;
		charmIcon.y += 70;
		charmIcon.scale.set(1.6, 1.6);
		charmIcon.scrollFactor.set();
		charmIcon.antialiasing = ClientPrefs.globalAntialiasing;
		add(charmIcon);

		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 48, 0, "", 32);
		if (PlayState.isMayhemMode)
			levelDifficulty.text += "Mayhem";
		else
			levelDifficulty.text += CoolUtil.difficultyString();
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		var blueballedTxt:FlxText = new FlxText(20, 15 + 82, 0, "", 32);
		if(levelInfo.text == 'Forsaken (Picmixed)' || levelInfo.text == "Get Pico'd" || levelInfo.text == 'Toybox')
			blueballedTxt.text = "Blueballed: " + PlayState.deathCounter;
		else
			blueballedTxt.text = "Redtitted: " + PlayState.deathCounter;
		blueballedTxt.scrollFactor.set();
		blueballedTxt.setFormat(Paths.font('vcr.ttf'), 32);
		blueballedTxt.updateHitbox();
		add(blueballedTxt);

		tokenInfo = new FlxText(310, 15 + 98, 0, "", 32);
		if (ClientPrefs.tokens > 0)
			tokenInfo.text = "Tokens: <GR>" + ClientPrefs.tokens + "<GR>";
		else
			tokenInfo.text = "Tokens: <R>" + ClientPrefs.tokens + "<R>";
		tokenInfo.scrollFactor.set();
		tokenInfo.setFormat(Paths.font('vcr.ttf'), 32);
		tokenInfo.updateHitbox();
		add(tokenInfo);
		CustomFontFormats.addMarkers(tokenInfo);

		charmText = new FlxText(290, 15 + 22, 0, "", 32);
		charmText.text = "Charm: None";
		charmText.scrollFactor.set();
		charmText.setFormat(Paths.font('vcr.ttf'), 32);
		charmText.updateHitbox();
		add(charmText);
			
		if (ClientPrefs.resistanceCharm == 1)	
		{
			charmText.text = "Charm: Resistance";
			charmIcon.loadGraphic(Paths.image('inventory/charmN0'));
			showCharm = true;
		}
		else if (ClientPrefs.autoCharm == 1)
		{
			charmText.text = "Charm: Auto Dodge";
			charmIcon.loadGraphic(Paths.image('inventory/charmN1'));
			showCharm = true;
		}
		else if (ClientPrefs.healingCharm > 0 && ClientPrefs.healingCharm <= 9)
		{
			charmText.text = "Charm: Healing (" + ClientPrefs.healingCharm + "x)";
			charmIcon.loadGraphic(Paths.image('inventory/charmN2'));
			showCharm = true;
		}
		else if (ClientPrefs.healingCharm == 0)
		{
			charmText.text = "Charm: Healing (Off)";
			charmIcon.loadGraphic(Paths.image('inventory/charmN2'));
			showCharm = true;
		}
		else
			charmText.text = "Charm: None";

		practiceText = new FlxText(20, 15 + 101, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('vcr.ttf'), 32);
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.visible = PlayState.instance.practiceMode;
		add(practiceText);

		var chartingText:FlxText = new FlxText(20, 15 + 101, 0, "CHARTING MODE", 32);
		chartingText.scrollFactor.set();
		chartingText.setFormat(Paths.font('vcr.ttf'), 32);
		chartingText.x = FlxG.width - (chartingText.width + 20);
		chartingText.y = FlxG.height - (chartingText.height + 20);
		chartingText.updateHitbox();
		chartingText.visible = PlayState.chartingMode;
		add(chartingText);

		if (PlayState.chartingMode || PlayState.instance.practiceMode)
			timerInfo = new FlxText(20, 15 + 135, 0, "", 32);
		else
			timerInfo = new FlxText(20, 15 + 115, 0, "", 32);

		timerInfo.text += "Time Left: " + PlayState.timeTxtPause.text;
		timerInfo.scrollFactor.set();
		timerInfo.setFormat(Paths.font("vcr.ttf"), 32);
		timerInfo.updateHitbox();
		

		if (ClientPrefs.timeBarType == 'Song Name' || ClientPrefs.timeBarType == 'Disabled')
		{
			timerInfo.alpha = 0;
			add(timerInfo);
		}
		
		blueballedTxt.alpha = 0;
		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;
		tokenInfo.alpha = 0;
		charmText.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 40);
		if (ClientPrefs.timeBarType == 'Song Name' || ClientPrefs.timeBarType == 'Disabled')
			timerInfo.x = FlxG.width - (timerInfo.width + 40);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 40);
		blueballedTxt.x = FlxG.width - (blueballedTxt.width + 40);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(bgGradient, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(pauseCard, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(arrows, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		if (showCharm == true)
			FlxTween.tween(charmIcon, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: levelInfo.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(charmText, {alpha: 1, y: charmText.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});
		FlxTween.tween(tokenInfo, {alpha: 1, y: tokenInfo.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.9});
		
		
		if (ClientPrefs.timeBarType == 'Song Name' || ClientPrefs.timeBarType == 'Disabled')
			FlxTween.tween(timerInfo, {alpha: 1, y: timerInfo.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 1.1});

		if(levelInfo.text == 'Forsaken' || levelInfo.text == 'Forsaken (Picmixed)' || levelInfo.text == 'Partner')
		{
			menuItemsOG.remove('Give up');
			menuItemsOG.insert(3, 'You cannot escape.');
		}
		if(levelInfo.text == 'Iniquitous')
		{
			menuItemsOG.remove('Quick Settings');
		}

		regenMenu();
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	var holdTime:Float = 0;
	var cantUnpause:Float = 0.1;
	var onSkipTime:Bool = false;
	var skipTimeTweenFadeIn:FlxTween;
	var skipTimeTweenFadeOut:FlxTween;
	var skipTimeBGTweenFadeIn:FlxTween;
	var skipTimeBGTweenFadeOut:FlxTween;
	var skipTimeTweenTitleFadeIn:FlxTween;
	var skipTimeTweenTitleFadeOut:FlxTween;

	var onQuickSettings:Bool = false;
	var optionsBG:FlxSprite;
	var quickSettingsTweenFadeIn:FlxTween;
	var quickSettingsTweenFadeOut:FlxTween;
	var optionsBGTweenFadeIn:FlxTween;
	var optionsBGTweenFadeOut:FlxTween;
	var optionInfoTweenFadeIn:FlxTween;
	var optionInfoTweenFadeOut:FlxTween;
	var optionInfo:FlxText;

	var botplayOn:Bool = false;
	var huh = 0;
	var delay:Bool = false;

	override function update(elapsed:Float)
	{
		cantUnpause -= elapsed;
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP && (onSkipTime == false && onQuickSettings == false))
		{
			changeSelection(-1);
		}
		if (downP && (onSkipTime == false && onQuickSettings == false))
		{
			changeSelection(1);
		}

		var daSelected:String = menuItems[curSelected];
		if (onSkipTime == true)
			switch (daSelected)
			{
				case 'Skip Time':
					if (controls.UI_LEFT_P)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
						curTime -= 1000;
						holdTime = 0;
					}
					if (controls.UI_RIGHT_P)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
						curTime += 1000;
						holdTime = 0;
					}

					if(controls.UI_LEFT || controls.UI_RIGHT)
					{
						holdTime += elapsed;
						if(holdTime > 0.5)
						{
							curTime += 45000 * elapsed * (controls.UI_LEFT ? -1 : 1);
						}

						if(curTime >= FlxG.sound.music.length) curTime -= FlxG.sound.music.length;
						else if(curTime < 0) curTime += FlxG.sound.music.length;
						updateSkipTimeText();
					}

					if (controls.BACK)
					{
						onSkipTime = false;
						if (skipTimeTweenFadeIn != null)
							skipTimeTweenFadeIn.cancel();
						skipTimeTweenFadeOut = FlxTween.tween(skipTimeText, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});

						if (skipTimeTweenTitleFadeIn != null)
							skipTimeTweenTitleFadeIn.cancel();
						skipTimeTweenTitleFadeOut = FlxTween.tween(skipTimeTitle, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});

						if (skipTimeBGTweenFadeIn != null)
							skipTimeBGTweenFadeIn.cancel();
						skipTimeBGTweenFadeOut = FlxTween.tween(skipTimeBG, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});
					}
					
					if (accepted)
					{
						if(curTime < Conductor.songPosition)
						{
							PlayState.startOnTime = curTime;
							restartSong(true);
						}
						else
						{
							if (curTime != Conductor.songPosition)
							{
								PlayState.instance.clearNotesBefore(curTime);
								PlayState.instance.setSongTime(curTime);
							}
							close();
						}
					}
			}
		
		if (onQuickSettings == true)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				changeOption(-1);
			}
			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				changeOption(1);
			}

			if (!delay)
			{
				if (controls.UI_LEFT_P)
				{
					applyOption(-1);
				}

				if (controls.UI_RIGHT_P)
				{
					applyOption(1);
				}
			}

			if (controls.BACK)
			{
				onQuickSettings = false;
					
				if (optionsBGTweenFadeIn != null)
					optionsBGTweenFadeIn.cancel();
				optionsBGTweenFadeOut = FlxTween.tween(optionsBG, {alpha: 0}, 0.4, {ease: FlxEase.quartOut});

				if (optionInfoTweenFadeIn != null)
					optionInfoTweenFadeIn.cancel();
				optionInfoTweenFadeOut = FlxTween.tween(optionInfo, {alpha: 0}, 0.4, {ease: FlxEase.quartOut});

				for (item in grpOpts.members)
				{
					if (quickSettingsTweenFadeIn != null)
						quickSettingsTweenFadeIn.cancel();
					quickSettingsTweenFadeOut = FlxTween.tween(item, {alpha: 0}, 0.4, {ease: FlxEase.quartOut});
				}

				if (botplayOn == true)
				{
					ClientPrefs.tokensAchieved = 0;
					restartSong();
				}
					
				ClientPrefs.saveSettings();
			}
		}

		if (accepted && (cantUnpause <= 0 || !ClientPrefs.controllerMode) && (onSkipTime == false && onQuickSettings == false))
		{
			if (menuItems == difficultyChoices)
			{
				if(menuItems.length - 1 != curSelected && difficultyChoices.contains(daSelected)) {
					var name:String = PlayState.SONG.song;
					var poop = Highscore.formatSong(name, curSelected);
					PlayState.SONG = Song.loadFromJson(poop, name);
					PlayState.storyDifficulty = curSelected;
					MusicBeatState.resetState();
					FlxG.sound.music.volume = 0;
					PlayState.changedDifficulty = true;
					PlayState.chartingMode = false;
					return;
				}

				menuItems = menuItemsOG;
				regenMenu();
			}

			switch (daSelected)
			{
				case "Resume Song":
					close();
				case 'Toggle Practice Mode':
					PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
					PlayState.changedDifficulty = true;
					practiceText.visible = PlayState.instance.practiceMode;
				case "Restart Song":
					PlayState.checkForPowerUp = false;
					restartSong();
				case "Quick Settings":
					openQuickSettings();
					onQuickSettings = true;
				case "Leave Charting Mode":
					restartSong();
					PlayState.chartingMode = false;
				case 'Skip Time':
					openSkipTimeMenu();
					onSkipTime = true;
				case "End Song":
					close();
					PlayState.instance.finishSong(true);
				case 'Toggle Botplay':
					PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
					PlayState.changedDifficulty = true;
					PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
					PlayState.instance.botplayTxt.alpha = 1;
					PlayState.instance.botplaySine = 0;
				case "Give up":
					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;
					PlayState.checkForPowerUp = false;
					WeekData.loadTheFirstEnabledMod();

					ClientPrefs.lowQuality = false;
					ClientPrefs.tokensAchieved = 0;
					ClientPrefs.ghostTapping = true;
					
					if(PlayState.isStoryMode) {
						//Reset the crash detector to 0, since it means you've returned back to the menu
						PlayState.isStoryMode = false;
						ClientPrefs.resetStoryModeProgress(true);
						if (PlayState.isIniquitousMode == true)
						{
							PlayState.isIniquitousMode = false;
							MusicBeatState.switchState(new IniquitousMenuState());
						}
						else
							MusicBeatState.switchState(new StoryMenuState());
					}else if(PlayState.isInjectionMode) {
						PlayState.isInjectionMode = false;
						MusicBeatState.switchState(new MainMenuState());
					}else if(PlayState.isMayhemMode) {
						PlayState.isMayhemMode = false;
						PlayState.mayhemNRMode = "";
						MusicBeatState.switchState(new MainMenuState());
					} else {
						if (ClientPrefs.onCrossSection == true)
							MusicBeatState.switchState(new CrossoverState()); //go to Crossover State
						else if (FreeplayCategoryState.freeplayName == 'MAIN') //go to Main Freeplay
							MusicBeatState.switchState(new FreeplayState());
						else if (FreeplayCategoryState.freeplayName == 'BONUS') //go to Bonus Freeplay
							MusicBeatState.switchState(new FreeplayBonusState());
						else if (FreeplayCategoryXtraState.freeplayName == 'XTRASHOP') //go to Xtra Freeplay [Using Shop songs]
							MusicBeatState.switchState(new FreeplayXtraState());
						else if (FreeplayCategoryXtraState.freeplayName == 'XTRACROSSOVER') //go to Xtra Freeplay [Using Crossover Songs]
							MusicBeatState.switchState(new FreeplayXtraCrossoverState());
						else if (FreeplayCategoryXtraState.freeplayName == 'XTRABONUS') //go to Xtra Freeplay [Using Bonus Songs]
							MusicBeatState.switchState(new FreeplayXtraBonusState());
					}
					PlayState.cancelMusicFadeTween();
					if (ClientPrefs.onCrossSection == false)
						if (ClientPrefs.iniquitousWeekUnlocked == true && ClientPrefs.iniquitousWeekBeaten == false)
							FlxG.sound.playMusic(Paths.music('malumIctum'));
						else if (FlxG.random.int(1, 10) == 2)
							FlxG.sound.playMusic(Paths.music('AJDidThat'));
						else
							FlxG.sound.playMusic(Paths.music('freakyMenu'));
					PlayState.changedDifficulty = false;
					PlayState.chartingMode = false;
				case "You cannot escape.":
					//Do Nothing. We do not want to let the player escape. Exclusive for Forsaken and Get Villain'd
			}
		}
	}

	function openQuickSettings()
	{
		optionsBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		optionsBG.alpha = 0;
		optionsBG.scrollFactor.set();
		add(optionsBG);

		if (optionsBGTweenFadeOut != null)
			optionsBGTweenFadeOut.cancel();
		optionsBGTweenFadeIn = FlxTween.tween(optionsBG, {alpha: 0.6}, 0.4, {ease: FlxEase.quartOut});

		optionInfo = new FlxText(750, 340, FlxG.width - 800,
			"TEST",
			25);
		optionInfo.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, CENTER);
		optionInfo.scrollFactor.set();
		optionInfo.alpha = 0;
		add(optionInfo);

		if (optionInfoTweenFadeOut != null)
			optionInfoTweenFadeOut.cancel();
		optionInfoTweenFadeIn = FlxTween.tween(optionInfo, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});

		grpOpts = new FlxTypedGroup<Alphabet>();
		add(grpOpts);
	
		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(60, 320, options[i], true);
			optionText.scaleY = 0.6;
			optionText.scaleX = 0.6;
			optionText.screenCenter(Y);
			optionText.ID = i;
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			optionText.alpha = 0;
			grpOpts.add(optionText);
		}

		changeOption();
	}

	function applyOption(wah:Int = 0)
		{
			huh += wah;
			if (huh > 1)
				huh = 1;
			if (huh < 0)
				huh = 0;
			FlxG.sound.play(Paths.sound('ConfirmMenu'), 0.2);

			if ((PlayState.isStoryMode && !PlayState.isIniquitousMode)
				|| (!PlayState.isStoryMode && !PlayState.isIniquitousMode && !PlayState.isInjectionMode && !PlayState.isMayhemMode)) //STORY MODE OR FREEPLAY
			{
				for (item in grpOpts.members)
				{
					if (huh == 0 && !delay)
					{
						switch (curOption)
						{
							case 0:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.mechanics = false;
									changedSettings = true;
									trace ("Mechanics: False");
								}
							case 1:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.shaders = false;
									trace ("Shaders: False");
								}
							case 2:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.cinematicBars = false;
									trace ("Cinematic Bars: False");
								}
							case 3:
								ClientPrefs.downScroll = false;
								trace ("Downscroll: False");
							case 4:
								ClientPrefs.gameplaySettings.set('botplay', false);
								botplayOn = false;
								trace ("Botplay: False.");
							case 5:
								if (ClientPrefs.framerate > 30)
								{
									ClientPrefs.framerate -= 1;
									onChangeFramerate();
								}
						}
						delay = true;
						new FlxTimer().start(0.05, function (tmr:FlxTimer) {
							delay = false;
						});
					}
					else if (huh == 1 && !delay)
					{
						switch (curOption)
						{
							case 0:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.mechanics = true;
									changedSettings = true;
									trace ("Mechanics: True");
								}
							case 1:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.shaders = true;
									trace ("Shaders: True");
								}
							case 2:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.cinematicBars = true;
									trace ("Cinematic Bars: True");
								}
							case 3:
								ClientPrefs.downScroll = true;
								trace ("Downscroll: True");
							case 4:
								ClientPrefs.gameplaySettings.set('botplay', true);
								botplayOn = true;
								trace ("Botplay: True.");
							case 5:
								if (ClientPrefs.framerate < 240)
								{
									ClientPrefs.framerate += 1;
									onChangeFramerate();
								}
						}
						delay = true;
						new FlxTimer().start(0.05, function (tmr:FlxTimer) {
							delay = false;
						});
					}
				}
			}

			if (PlayState.isInjectionMode || PlayState.isMayhemMode)
			{
				for (item in grpOpts.members)
				{
					if (huh == 0 && !delay)
					{
						switch (curOption)
						{
							case 0:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.shaders = false;
									trace ("Shaders: False");
								}
							case 1:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.cinematicBars = false;
									trace ("Cinematic Bars: False");
								}
							case 2:
								ClientPrefs.downScroll = false;
								trace ("Downscroll: False");
							case 3:
								if (ClientPrefs.framerate > 30)
								{
									ClientPrefs.framerate -= 1;
									onChangeFramerate();
								}
						}
						delay = true;
						new FlxTimer().start(0.05, function (tmr:FlxTimer) {
							delay = false;
						});
					}
					else if (huh == 1 && !delay)
					{
						switch (curOption)
						{
							case 0:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.shaders = true;
									trace ("Shaders: True");
								}
							case 1:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.cinematicBars = true;
									trace ("Cinematic Bars: True");
								}
							case 2:
								ClientPrefs.downScroll = true;
								trace ("Downscroll: True");
							case 3:
								if (ClientPrefs.framerate < 240)
								{
									ClientPrefs.framerate += 1;
									onChangeFramerate();
								}
						}
						delay = true;
						new FlxTimer().start(0.05, function (tmr:FlxTimer) {
							delay = false;
						});
					}
				}
			}

			if (PlayState.isIniquitousMode)
			{
				for (item in grpOpts.members)
				{
					if (huh == 0 && !delay)
					{
						switch (curOption)
						{
							case 0:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.shaders = false;
									trace ("Shaders: False");
								}
							case 1:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.cinematicBars = false;
									trace ("Cinematic Bars: False");
								}
							case 2:
								ClientPrefs.downScroll = false;
								trace ("Downscroll: False");
							case 3:
								ClientPrefs.gameplaySettings.set('botplay', false);
								botplayOn = false;
								trace ("Botplay: False.");
							case 4:
								if (ClientPrefs.framerate > 30)
								{
									ClientPrefs.framerate -= 1;
									onChangeFramerate();
								}
						}
						delay = true;
						new FlxTimer().start(0.05, function (tmr:FlxTimer) {
							delay = false;
						});
					}
					else if (huh == 1 && !delay)
					{
						switch (curOption)
						{
							case 0:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.shaders = true;
									trace ("Shaders: True");
								}
							case 1:
								if (ClientPrefs.optimizationMode == false)
								{
									ClientPrefs.cinematicBars = true;
									trace ("Cinematic Bars: True");
								}
							case 2:
								ClientPrefs.downScroll = true;
								trace ("Downscroll: True");
							case 3:
								ClientPrefs.gameplaySettings.set('botplay', true);
								botplayOn = true;
								trace ("Botplay: True.");
							case 4:
								if (ClientPrefs.framerate < 240)
								{
									ClientPrefs.framerate += 1;
									onChangeFramerate();
								}
						}
						delay = true;
						new FlxTimer().start(0.05, function (tmr:FlxTimer) {
							delay = false;
						});
					}
				}
			}
			changeOption();	
		}

	function changeOption(change:Int = 0)
		{
			curOption += change;

			if ((PlayState.isStoryMode && !PlayState.isIniquitousMode)
				|| (!PlayState.isStoryMode && !PlayState.isIniquitousMode && !PlayState.isInjectionMode && !PlayState.isMayhemMode))
			{
				if (curOption < 0)
					curOption = 5;
				if (curOption > 5)
					curOption = 0;
	
				for (item in grpOpts.members)
				{
					if (curOption == item.ID)
						quickSettingsTweenFadeIn = FlxTween.tween(item, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});
					else
						quickSettingsTweenFadeIn = FlxTween.tween(item, {alpha: 0.6}, 0.4, {ease: FlxEase.quartOut});
	
					switch (curOption)
					{
						case 0:
							optionInfo.y = 285;
							if (ClientPrefs.optimizationMode == false)
								optionInfo.text = "Determine whether you want mechanics to be turned on or off.\n\n(Settings are applied once you restart or move to the next song.)";
							else
								optionInfo.text = "This is disabled by default since optimization mode is turned on.";
						case 1:
							optionInfo.y = 285;
							if (ClientPrefs.optimizationMode == false)
								optionInfo.text = "Determine whether you want shaders to be turned on or off.\n\n(Settings are applied once you restart or move to the next song.)";
							else
								optionInfo.text = "This is disabled by default since optimization mode is turned on.";
						case 2:
							optionInfo.y = 285;
							if (ClientPrefs.optimizationMode == false)
								optionInfo.text = "Determine whether you want cinematic bars to be turned on or off.\n\n(Settings are applied once you restart or move to the next song.)";
							else
								optionInfo.text = "This is disabled by default since optimization mode is turned on.";
						case 3:
							optionInfo.y = 285;
							optionInfo.text = "Determine whether you want your notes to be scrolled upwards or downwards.\n\n(Settings are applied once you restart or move to the next song.)";
						case 4:
							optionInfo.y = 275;
							optionInfo.text = "Determine whether you want to turn botplay on or off.\n\n<R>WARNING:<R>\nTurning botplay <G>ON<G> will reset your gameplay, aswell as your progress.\nTo disable, press CTRL on the Story Mode / Freeplay Menu.";
						case 5:
							optionInfo.y = 320;
							optionInfo.text = "Set up how many frames per second you want.\nJust as simple as that.";
					}
	
					
					if (ClientPrefs.mechanics == true)
					{
						if (item.ID == 0)
						{
							item.text = "Mechanics (Enabled)";
						}
					}		
					else
					{
						if (item.ID == 0)
						{
							item.text = "Mechanics (Disabled)";
						}
					}	
					if (ClientPrefs.shaders == true)
					{
						if (item.ID == 1)
						{
							item.text = "Shaders (Enabled)";
						}
					}		
					else
					{
						if (item.ID == 1)
						{
							item.text = "Shaders (Disabled)";
						}
					}
					if (ClientPrefs.cinematicBars == true)
					{
						if (item.ID == 2)
						{
							item.text = "Cinematic Bars (Enabled)";
						}
					}		
					else
					{
						if (item.ID == 2)
						{
							item.text = "Cinematic Bars (Disabled)";
						}
					}
					if (ClientPrefs.downScroll == true)
					{
						if (item.ID == 3)
						{
							item.text = "Scroll Type (Downwards)";
						}
					}		
					else
					{
						if (item.ID == 3)
						{
							item.text = "Scroll Type (Upwards)";
						}
					}
					if (!ClientPrefs.getGameplaySetting('botplay', false))
					{
						if (item.ID == 4)
						{
							item.text = "Botplay (Disabled)";
						}
					}		
					else
					{
						if (item.ID == 4)
						{
							item.text = "Botplay (Enabled)";
						}
					}
					if (item.ID == 5)
						item.text = "Frame Rate (" + ClientPrefs.framerate + ")";
				}
			}
			
			if (PlayState.isInjectionMode || PlayState.isMayhemMode)
			{
				if (curOption < 0)
					curOption = 3;
				if (curOption > 3)
					curOption = 0;
	
				for (item in grpOpts.members)
				{
					if (curOption == item.ID)
						quickSettingsTweenFadeIn = FlxTween.tween(item, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});
					else
						quickSettingsTweenFadeIn = FlxTween.tween(item, {alpha: 0.6}, 0.4, {ease: FlxEase.quartOut});
	
					switch (curOption)
					{
						case 0:
							optionInfo.y = 285;
							if (ClientPrefs.optimizationMode == false)
								optionInfo.text = "Determine whether you want shaders to be turned on or off.\n\n(Settings are applied once you restart or move to the next song.)";
							else
								optionInfo.text = "This is disabled by default since optimization mode is turned on.";
							optionInfo.y = 285;
							if (ClientPrefs.optimizationMode == false)
								optionInfo.text = "Determine whether you want cinematic bars to be turned on or off.\n\n(Settings are applied once you restart or move to the next song.)";
							else
								optionInfo.text = "This is disabled by default since optimization mode is turned on.";
						case 2:
							optionInfo.y = 285;
							optionInfo.text = "Determine whether you want your notes to be scrolled upwards or downwards.\n\n(Settings are applied once you move to the next song.)";
						case 3:
							optionInfo.y = 320;
							optionInfo.text = "Set up how many frames per second you want.\nJust as simple as that.";
					}
	
					if (ClientPrefs.shaders == true)
					{
						if (item.ID == 0)
						{
							item.text = "Shaders (Enabled)";
						}
					}		
					else
					{
						if (item.ID == 0)
						{
							item.text = "Shaders (Disabled)";
						}
					}
					if (ClientPrefs.cinematicBars == true)
					{
						if (item.ID == 1)
						{
							item.text = "Cinematic Bars (Enabled)";
						}
					}		
					else
					{
						if (item.ID == 1)
						{
							item.text = "Cinematic Bars (Disabled)";
						}
					}
					if (ClientPrefs.downScroll == true)
					{
						if (item.ID == 2)
						{
							item.text = "Scroll Type (Downwards)";
						}
					}		
					else
					{
						if (item.ID == 2)
						{
							item.text = "Scroll Type (Upwards)";
						}
					}
					if (item.ID == 3)
						item.text = "Frame Rate (" + ClientPrefs.framerate + ")";
				}
			}

			if (PlayState.isIniquitousMode)
			{
				if (curOption < 0)
					curOption = 4;
				if (curOption > 4)
					curOption = 0;
	
				for (item in grpOpts.members)
				{
					if (curOption == item.ID)
						quickSettingsTweenFadeIn = FlxTween.tween(item, {alpha: 1}, 0.4, {ease: FlxEase.quartOut});
					else
						quickSettingsTweenFadeIn = FlxTween.tween(item, {alpha: 0.6}, 0.4, {ease: FlxEase.quartOut});
	
					switch (curOption)
					{
						case 0:
							optionInfo.y = 285;
							if (ClientPrefs.optimizationMode == false)
								optionInfo.text = "Determine whether you want shaders to be turned on or off.\n\n(Settings are applied once you restart or move to the next song.)";
							else
								optionInfo.text = "This is disabled by default since optimization mode is turned on.";
						case 1:
							optionInfo.y = 285;
							if (ClientPrefs.optimizationMode == false)
								optionInfo.text = "Determine whether you want cinematic bars to be turned on or off.\n\n(Settings are applied once you restart or move to the next song.)";
							else
								optionInfo.text = "This is disabled by default since optimization mode is turned on.";
						case 2:
							optionInfo.y = 285;
							optionInfo.text = "Determine whether you want your notes to be scrolled upwards or downwards.\n\n(Settings are applied once you restart or move to the next song.)";
						case 3:
							optionInfo.y = 275;
							optionInfo.text = "Determine whether you want to turn botplay on or off.\n\n<R>WARNING:<R>\nTurning botplay <G>ON<G> will reset your gameplay, aswell as your progress.\nTo disable, press CTRL on the Story Mode / Freeplay Menu.";
						case 4:
							optionInfo.y = 320;
							optionInfo.text = "Set up how many frames per second you want.\nJust as simple as that.";
					}
	
					if (ClientPrefs.shaders == true)
					{
						if (item.ID == 0)
						{
							item.text = "Shaders (Enabled)";
						}
					}		
					else
					{
						if (item.ID == 0)
						{
							item.text = "Shaders (Disabled)";
						}
					}
					if (ClientPrefs.cinematicBars == true)
					{
						if (item.ID == 1)
						{
							item.text = "Cinematic Bars (Enabled)";
						}
					}		
					else
					{
						if (item.ID == 1)
						{
							item.text = "Cinematic Bars (Disabled)";
						}
					}
					if (ClientPrefs.downScroll == true)
					{
						if (item.ID == 2)
						{
							item.text = "Scroll Type (Downwards)";
						}
					}		
					else
					{
						if (item.ID == 2)
						{
							item.text = "Scroll Type (Upwards)";
						}
					}
					if (!ClientPrefs.getGameplaySetting('botplay', false))
					{
						if (item.ID == 3)
						{
							item.text = "Botplay (Disabled)";
						}
					}		
					else
					{
						if (item.ID == 3)
						{
							item.text = "Botplay (Enabled)";
						}
					}
					if (item.ID == 4)
						item.text = "Frame Rate (" + ClientPrefs.framerate + ")";
				}
			}

			CustomFontFormats.addMarkers(optionInfo);
		}

	function openSkipTimeMenu()
	{
		skipTimeBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		skipTimeBG.alpha = 0;
		skipTimeBG.scrollFactor.set();
		add(skipTimeBG);

		skipTimeTitle = new FlxText(0, 0, 0, 'Skip To:', 64);
		skipTimeTitle.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		skipTimeTitle.scrollFactor.set();
		skipTimeTitle.screenCenter(XY);
		skipTimeTitle.y -= 100;
		skipTimeTitle.alpha = 0;

		skipTimeTitle.borderSize = 5;
		add(skipTimeTitle);

		skipTimeText = new FlxText(0, 0, 0, '', 64);
		skipTimeText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		skipTimeText.scrollFactor.set();
		skipTimeText.screenCenter(XY);
		skipTimeText.alpha = 0;

		//failsafe to not crash
		skipTimeTweenFadeOut = FlxTween.tween(skipTimeText, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});
		skipTimeTweenTitleFadeOut = FlxTween.tween(skipTimeTitle, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});
		skipTimeBGTweenFadeOut = FlxTween.tween(skipTimeBG, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});

		skipTimeText.x -= 200;
		skipTimeText.borderSize = 5;
		add(skipTimeText);

		if (skipTimeTweenFadeOut != null)
			skipTimeTweenFadeOut.cancel();
		skipTimeTweenFadeIn = FlxTween.tween(skipTimeText, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		if (skipTimeTweenTitleFadeOut != null)
			skipTimeTweenTitleFadeOut.cancel();
		skipTimeTweenTitleFadeIn = FlxTween.tween(skipTimeTitle, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		if (skipTimeBGTweenFadeOut != null)
			skipTimeBGTweenFadeOut.cancel();
		skipTimeBGTweenFadeIn = FlxTween.tween(skipTimeBG, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
	
		updateSkipTimeText();
	}

	function deleteSkipTimeText()
	{
		if(skipTimeText != null)
		{
			skipTimeText.kill();
			remove(skipTimeText);
			skipTimeText.destroy();
		}
		skipTimeText = null;
		skipTimeTracker = null;
	}

	public static function restartSong(noTrans:Bool = false)
	{
		if (changedSettings) //If you changed your settings in quick settings (mainly Mechanics)
		{
			switch(levelInfo.text)
			{
				case "Toxic Mishap":
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

				case "Villainy":
					if (PlayState.storyDifficulty == 0 || PlayState.storyDifficulty == 1) //On Freeplay: 0, on Story Mode: 1
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

				case "Toybox":
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

				case "Lustality Remix":
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

				case "Lustality":
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

				case "Lustality V1":
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

				case "Toxic Mishap (Legacy)":
					if (PlayState.storyDifficulty == 1)
					{
						if (ClientPrefs.mechanics == true)
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
			if (levelInfo.text != 'Concert Chaos')
				PlayState.SONG.player1 = playerSelected;
		}
		
		
		// Do not touch lmao
		PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if(noTrans)
		{
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
		}
		else
		{
			MusicBeatState.resetState();
		}
	}

	function onChangeFramerate()
	{
		if(ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	var disappearTween:FlxTween;
	var appearTween:FlxTween;
	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		item.text = menuItems[curSelected];
		if(item == skipTimeTracker)
		{
			curTime = Math.max(0, Conductor.songPosition);
			updateSkipTimeText();
		}
	}

	var item:Alphabet;
	function regenMenu():Void {
		item = new Alphabet(1250, 550, menuItems[curSelected], true);
		item.setAlignmentFromString('right');
		item.alpha = 0;
		add(item);

		FlxTween.tween(item, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		curSelected = 0;
		changeSelection();
	}

	function updateSkipTimeText()
	{
		skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
}
