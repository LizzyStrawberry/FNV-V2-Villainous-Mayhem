package;

import Controls.Control;
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxStringUtil;

class PauseSubState extends MusicBeatSubstate
{
	var options:Array<String> = ['Mechanics', 'Shaders', 'Buff To Use', 'Scroll Type', 'BotPlay', 'MoreOptions']; //Main Quick Options for Story Mode
	public static var pauseOptions:Bool = false;

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
	var pauseCam:FlxCamera;

	public static var levelInfo:FlxText;
	var timerInfo:FlxText;
	//var botplayText:FlxText;

	var tokenInfo:FlxText;

	//For Charms
	var charmText:FlxText;
	var charmIcon:FlxSprite;
	var showCharm:Bool = false;

	var leftBar:FlxSprite;
	var rightBar:FlxSprite;
	var bgGradient:FlxSprite;
	var pauseCard:FlxSprite;
	var arrows:FlxSprite;

	//Making Skip Time work with the change
	var skipTimeBG:FlxSprite;
	var skipTimeTitle:FlxText;

	public static var playerSelected:String = '';

	var buffs:Array<String> = ["None", "Health Regen.", "Second Chance", "Immunity"];
	var buffType:Int = 0;

	public static var songName:String = '';

	var accepted:Bool = false;
	var onQuickSettings:Bool = false;
	public function new(x:Float, y:Float)
	{
		super();

		pauseCam = new FlxCamera();
		pauseCam.bgColor = 0;
		pauseCam.zoom = 1;
		FlxG.cameras.add(pauseCam, false);
		cameras = [pauseCam];

		if(CoolUtil.difficulties.length < 2) menuItemsOG.remove('Change Difficulty'); //No need to change difficulty if there is only one!
		if(PlayState.isInjectionMode || PlayState.isMayhemMode) menuItemsOG.remove('Restart Song');
		if(ClientPrefs.getGameplaySetting('botplay', false)) menuItemsOG.remove('Quick Settings');

		//Setup Quick Settings for injection mode, mayhem mode
		if (PlayState.isInjectionMode || PlayState.isMayhemMode)
			options = ['Shaders', 'Cinematic Bars', 'Scroll Type', 'MoreOptions'];
		if (PlayState.isIniquitousMode)
			options = ['Shaders', 'Cinematic Bars', 'Scroll Type', 'BotPlay', 'MoreOptions'];

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
			case 'Scrouge' | 'Cheap Skate (Legacy)' | 'Toxic Mishap' | 'Villainy':
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xFF00a800;
			case 'Paycheck':
				bgGradient.color = 0xFF72cd6e;
				pauseCard.color = 0xFF72cd6e;

			case 'Nunday Monday' | 'Nunconventional' | 'Nunconventional Simp' | 'Point Blank':
				bgGradient.color = 0xFFfb000f;
				pauseCard.color = 0xFFfb000f;


			case 'Forsaken' | 'Forsaken (Picmixed)' | 'Partner':
				bgGradient.color = 0xFFa85ddb;
				pauseCard.color = 0xFFa85ddb;
			case 'Toybox':
				bgGradient.color = 0xFFd554c0;
				pauseCard.color = 0xFFd554c0;
			case 'Lustality Remix':
				bgGradient.color = 0xFFff59d8;
				pauseCard.color = 0xFFff59d8;
			case 'Libidinousness':
				bgGradient.color = 0xFFd12e6a;
				pauseCard.color = 0xFFd12e6a;

			case 'Iniquitous':
				bgGradient.color = 0xFFff0000;
				pauseCard.color = 0xFFff0000;

			case 'Sussus Marcus' | 'Villain In Board' | 'Excrete':
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
			case 'Lustality':
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
			case 'Negotiation':
				bgGradient.color = 0xFFfb000f;
				pauseCard.color = 0xFFfb000f;
			case 'Concert Chaos':
				bgGradient.color = 0xFF9b00ce;
				pauseCard.color = 0xFF9b00ce;

			// Bonus Songs
			case "It's Kiana":
				bgGradient.color = 0xFF03d5ff;
				pauseCard.color = 0xFF03d5ff;
			case "Shuckle Fuckle":
				bgGradient.color = 0xFF00a800;
				pauseCard.color = 0xff5e8503;

			default:
				bgGradient.loadGraphic(Paths.image('pauseGradient/gradient_Null'));
				pauseCard.loadGraphic(Paths.image('pauseMenu/pause_Default'));
		}
		bgGradient.screenCenter(XY);
		bgGradient.scale.x = 1.3;
		bgGradient.scale.y = 1.1;
		bgGradient.alpha = 0;
		bgGradient.scrollFactor.set();
		add(bgGradient);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		pauseCard.screenCenter(XY);
		pauseCard.alpha = 0;
		pauseCard.scrollFactor.set();
		pauseCard.antialiasing = ClientPrefs.globalAntialiasing;

		var margin:Int = Std.int(Math.max(0, (FlxG.width - pauseCard.width) * 0.5));
		if (margin > 0) {
			leftBar = new FlxSprite(0, 0).makeGraphic(margin, FlxG.height, FlxColor.BLACK);
			rightBar = new FlxSprite(FlxG.width - margin, 0).makeGraphic(margin, FlxG.height, FlxColor.BLACK);

			for (bar in [leftBar, rightBar])
			{
				bar.scrollFactor.set();
				bar.alpha = 0;
				add(bar);
			}
		}

		add(pauseCard);

		arrows = new FlxSprite(MobileUtil.fixX(0), 0).loadGraphic(Paths.image('pauseMenu/arrows'));
		arrows.alpha = 0;
		arrows.scrollFactor.set();
		arrows.antialiasing = ClientPrefs.globalAntialiasing;
		add(arrows);

		charmIcon = new FlxSprite(MobileUtil.fixX(70), 0).loadGraphic(Paths.image('inventory/charmN0'));
		charmIcon.alpha = 0;
		charmIcon.y += 70;
		charmIcon.scale.set(1.6, 1.6);
		charmIcon.scrollFactor.set();
		charmIcon.antialiasing = ClientPrefs.globalAntialiasing;
		add(charmIcon);

		add(levelInfo);

		var pad:Int = 26;
		var levelDifficulty:FlxText = new FlxText(pauseCard.x + pad, 15 + 48, 0, "", 32);
		if (PlayState.isMayhemMode)
			levelDifficulty.text += "Mayhem";
		else
			levelDifficulty.text += CoolUtil.difficultyString();
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		var blueballedTxt:FlxText = new FlxText(20, 15 + 82, 0, "", 32);
		if(levelInfo.text == 'Forsaken (Picmixed)' || levelInfo.text == "Partner" || levelInfo.text == "Get Pico'd" || levelInfo.text == 'Toybox')
			blueballedTxt.text = "Blueballed: " + PlayState.deathCounter;
		else
			blueballedTxt.text = "Redtitted: " + PlayState.deathCounter;
		blueballedTxt.scrollFactor.set();
		blueballedTxt.setFormat(Paths.font('vcr.ttf'), 32);
		blueballedTxt.updateHitbox();
		add(blueballedTxt);

		tokenInfo = new FlxText(MobileUtil.fixX(310), 15 + 98, 0, "", 32);
		if (ClientPrefs.tokens > 0)
			tokenInfo.text = "Tokens: <GR>" + ClientPrefs.tokens + "<GR>";
		else
			tokenInfo.text = "Tokens: <R>" + ClientPrefs.tokens + "<R>";
		tokenInfo.scrollFactor.set();
		tokenInfo.setFormat(Paths.font('vcr.ttf'), 32);
		tokenInfo.updateHitbox();
		add(tokenInfo);
		CustomFontFormats.addMarkers(tokenInfo);

		charmText = new FlxText(MobileUtil.fixX(290), 15 + 22, 0, "", 32);
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

		setBuff();

		practiceText = new FlxText(pauseCard.x + pad, 15 + 101, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('vcr.ttf'), 32);
		practiceText.x = 1280 - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.visible = PlayState.instance.practiceMode;
		add(practiceText);

		var chartingText:FlxText = new FlxText(pauseCard.x + pad, 15 + 101, 0, "CHARTING MODE", 32);
		chartingText.scrollFactor.set();
		chartingText.setFormat(Paths.font('vcr.ttf'), 32);
		chartingText.x = 1280 - (chartingText.width + 20);
		chartingText.y = FlxG.height - (chartingText.height + 20);
		chartingText.updateHitbox();
		chartingText.visible = PlayState.chartingMode;
		add(chartingText);

		if (PlayState.chartingMode || PlayState.instance.practiceMode)
			timerInfo = new FlxText(pauseCard.x + pad, 15 + 135, 0, "", 32);
		else
			timerInfo = new FlxText(pauseCard.x + pad, 15 + 115, 0, "", 32);

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

		levelInfo.x = pauseCard.x + pauseCard.width - levelInfo.width - pad;
		if (ClientPrefs.timeBarType == 'Song Name' || ClientPrefs.timeBarType == 'Disabled')
			timerInfo.x = pauseCard.x + pauseCard.width - timerInfo.width - pad;
		levelDifficulty.x = pauseCard.x + pauseCard.width - levelDifficulty.width - pad;
		blueballedTxt.x = pauseCard.x + pauseCard.width - blueballedTxt.width - pad;

		for (bar in [leftBar, rightBar]) FlxTween.tween(bar, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(bgGradient, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(pauseCard, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(arrows, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		if (showCharm) FlxTween.tween(charmIcon, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: levelInfo.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(charmText, {alpha: 1, y: charmText.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});
		FlxTween.tween(tokenInfo, {alpha: 1, y: tokenInfo.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.9});
		
		
		if (ClientPrefs.timeBarType == 'Song Name' || ClientPrefs.timeBarType == 'Disabled')
			FlxTween.tween(timerInfo, {alpha: 1, y: timerInfo.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 1.1});

		if((levelInfo.text == 'Forsaken' || levelInfo.text == 'Forsaken (Picmixed)' || levelInfo.text == 'Partner') && !ClientPrefs.getGameplaySetting('botplay', false))
		{
			menuItemsOG.remove('Give up');
			menuItemsOG.insert(3, 'You cannot escape.');
		}

		regenMenu();

		var scroll = new ScrollableObject(0.004, 50, 100, FlxG.width, FlxG.height, "Y");
		scroll.onFullScroll.add(delta -> {
			if (!onQuickSettings) changeSelection(delta);
		});

		var scrollOptions = new ScrollableObject(0.004, 50, 100, FlxG.width, FlxG.height, "Y");
		scrollOptions.onFullScroll.add(delta -> {
			if (onQuickSettings) changeOption(delta);
		});

		var scrollOptions2 = new ScrollableObject(0.004, 50, 100, FlxG.width, FlxG.height, "X");
		scrollOptions2.onFullScroll.add(delta -> {
			if (onQuickSettings) applyOption(delta);
		});
		add(scroll);
		add(scrollOptions);
		add(scrollOptions2);

		addTouchPad("NONE", "A_B");
		addTouchPadCamera();
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

	var optionsBG:FlxSprite;
	var quickSettingsTweenFadeIn:FlxTween;
	var quickSettingsTweenFadeOut:FlxTween;
	var optionsBGTweenFadeIn:FlxTween;
	var optionsBGTweenFadeOut:FlxTween;
	var optionInfoTweenFadeIn:FlxTween;
	var optionInfoTweenFadeOut:FlxTween;
	var optionInfo:FlxText;

	var botplayOn:Bool = false;

	override function update(elapsed:Float)
	{
		cantUnpause -= elapsed;
		if (pauseMusic.volume < 0.5) pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (!onSkipTime && !onQuickSettings)
		{
			if (upP) changeSelection(-1);
			if (downP) changeSelection(1);
		}

		var daSelected:String = menuItems[curSelected];
		if (onSkipTime)
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
						if(holdTime > 0.5) curTime += 45000 * elapsed * (controls.UI_LEFT ? -1 : 1);

						if(curTime >= FlxG.sound.music.length) curTime -= FlxG.sound.music.length;
						else if(curTime < 0) curTime += FlxG.sound.music.length;
						updateSkipTimeText();
					}

					if (controls.BACK)
					{
						if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
						onSkipTime = false;
						if (skipTimeTweenFadeIn != null) skipTimeTweenFadeIn.cancel();
						skipTimeTweenFadeOut = FlxTween.tween(skipTimeText, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});

						if (skipTimeTweenTitleFadeIn != null) skipTimeTweenTitleFadeIn.cancel();
						skipTimeTweenTitleFadeOut = FlxTween.tween(skipTimeTitle, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});

						if (skipTimeBGTweenFadeIn != null) skipTimeBGTweenFadeIn.cancel();
						skipTimeBGTweenFadeOut = FlxTween.tween(skipTimeBG, {alpha: 0}, 0.4, {ease: FlxEase.quartInOut});
					}
					
					if (accepted || controls.ACCEPT)
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
		
		if (onQuickSettings)
		{
			if (controls.UI_UP_P) changeOption(-1, true);
			if (controls.UI_DOWN_P) changeOption(1, true);

			if (options[curOption].toLowerCase() != "moreoptions")
			{
				if (controls.UI_LEFT_P) applyOption(-1);
				if (controls.UI_RIGHT_P) applyOption(1);
			}

			// Exclusively for "More Options.."
			if (options[curOption].toLowerCase() == "moreoptions" && controls.ACCEPT)
			{
				PlayState.instance.paused = true;
				PlayState.instance.vocals.volume = 0;

				pauseOptions = true;
				MusicBeatState.switchState(new options.OptionsState());
			}

			if (controls.BACK)
			{
				if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
				onQuickSettings = accepted = false;
					
				if (optionsBGTweenFadeIn != null) optionsBGTweenFadeIn.cancel();
				optionsBGTweenFadeOut = FlxTween.tween(optionsBG, {alpha: 0}, 0.4, {ease: FlxEase.quartOut});

				if (optionInfoTweenFadeIn != null) optionInfoTweenFadeIn.cancel();
				optionInfoTweenFadeOut = FlxTween.tween(optionInfo, {alpha: 0}, 0.4, {ease: FlxEase.quartOut});

				for (item in grpOpts.members)
				{
					if (quickSettingsTweenFadeIn != null) quickSettingsTweenFadeIn.cancel();
					quickSettingsTweenFadeOut = FlxTween.tween(item, {alpha: 0}, 0.4, {ease: FlxEase.quartOut});
				}

				if (botplayOn || (curBuffType != buffType))
				{
					if (botplayOn) ClientPrefs.tokensAchieved = 0;
					restartSong();
				}
					
				ClientPrefs.saveSettings();
			}
		}

		if ((TouchUtil.pressAction(mainItem, pauseCam) || controls.ACCEPT) && (cantUnpause <= 0 || !ClientPrefs.controllerMode) && !onSkipTime && onQuickSettings!)
		{
			if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.35, 0.5);
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
					PlayState.inPlayState = false;
					PlayState.checkForPowerUp = false;
					WeekData.loadTheFirstEnabledMod();

					ClientPrefs.lowQuality = false;
					ClientPrefs.tokensAchieved = 0;
					ClientPrefs.ghostTapping = true;
					
					if(PlayState.isStoryMode) {
						//Reset the crash detector to 0, since it means you've returned back to the menu
						PlayState.isStoryMode = false;
						ClientPrefs.resetProgress(true);
						if (PlayState.isIniquitousMode == true)
						{
							PlayState.isIniquitousMode = false;
							MusicBeatState.switchState(new IniquitousMenuState(), "stickers");
						}
						else
							MusicBeatState.switchState(new StoryMenuState(), "stickers");
					}else if(PlayState.isInjectionMode) {
						PlayState.isInjectionMode = false;
						MusicBeatState.switchState(new MainMenuState(), "stickers");
					}else if(PlayState.isMayhemMode) {
						PlayState.isMayhemMode = false;
						PlayState.mayhemNRMode = "";
						MusicBeatState.switchState(new MainMenuState(), "stickers");
					} else {
						if (ClientPrefs.onCrossSection)
							MusicBeatState.switchState(new CrossoverState()); //go to Crossover State
						else
							MusicBeatState.switchState(new FreeplayState(), "stickers"); // Back To Freeplay
					}
					PlayState.cancelMusicFadeTween();
					if (ClientPrefs.onCrossSection == false)
						if (ClientPrefs.iniquitousWeekUnlocked && !ClientPrefs.iniquitousWeekBeaten)
							FlxG.sound.playMusic(Paths.music('malumIctum'));
						else if (FlxG.random.int(1, 10) == 2)
							FlxG.sound.playMusic(Paths.music('AJDidThat'));
						else
							FlxG.sound.playMusic(Paths.music('freakyMenu'));
					PlayState.changedDifficulty = false;
					PlayState.chartingMode = false;
				case "You cannot escape.":
					//Do Nothing. We do not want to let the player escape. Exclusive for Forsaken.
			}
		}
	}

	function openQuickSettings()
	{
		optionsBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		optionsBG.alpha = 0;
		optionsBG.scrollFactor.set();
		add(optionsBG);

		if (optionsBGTweenFadeOut != null) optionsBGTweenFadeOut.cancel();
		optionsBGTweenFadeIn = FlxTween.tween(optionsBG, {alpha: 0.6}, 0.4, {ease: FlxEase.quartOut});

		optionInfo = new FlxText(750, 340, FlxG.width - 800, "TEST", 25);
		optionInfo.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, CENTER);
		optionInfo.scrollFactor.set();
		optionInfo.alpha = 0;
		add(optionInfo);

		if (optionInfoTweenFadeOut != null) optionInfoTweenFadeOut.cancel();
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

	var curBuffType:Int = -2;
	function setBuff(wah:Int = -2)
	{
		if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.35, 0.5);
		if (wah == -2)
		{
			if (!ClientPrefs.mechanics)
			{
				buffType = 0;
				return;
			}

			if (ClientPrefs.buff1Selected) buffType = 1;
			else if (ClientPrefs.buff2Selected) buffType = 2;
			else if (ClientPrefs.buff3Selected) buffType = 3;
			else buffType = 0;

			curBuffType = buffType;
		}
		else
		{
			var optiMode:Bool = ClientPrefs.optimizationMode;
			buffType += wah;

			if (buffType > buffs.length - 1) buffType = 0;
			if (buffType < 0) buffType = buffs.length - 1;
			if (optiMode || !ClientPrefs.mechanics) buffType = 0; // Disable all the time if these parameters are met

			ClientPrefs.buff1Selected = (buffType == 1);
			ClientPrefs.buff2Selected = (buffType == 2);
			ClientPrefs.buff3Selected = (buffType == 3);
		}
	}

	function applyOption(wah:Int = 0)
	{
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.2);

		var optiMode:Bool = ClientPrefs.optimizationMode;
		
		switch(options[curOption].toLowerCase())
		{
			case "mechanics": 
				ClientPrefs.mechanics = (optiMode) ? false : !ClientPrefs.mechanics;
				setBuff();
			case "shaders": ClientPrefs.shaders = (optiMode) ? false : !ClientPrefs.shaders;
			case "buff to use": ClientPrefs.mechanics ? setBuff(wah) : setBuff();

			case "cinematic bars": ClientPrefs.cinematicBars = (optiMode) ? false : !ClientPrefs.cinematicBars;
			case "scroll type": ClientPrefs.downScroll = !ClientPrefs.downScroll;
			case "botplay": 
				botplayOn = !botplayOn;
				ClientPrefs.gameplaySettings.set('botplay', botplayOn);
		}

		changeOption();	
	}

	var dur:Float = 0.25;
	function changeOption(change:Int = 0, ?playSound:Bool = false)
	{
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		curOption += change;

		if (curOption < 0) curOption = options.length - 1;
		if (curOption > options.length - 1) curOption = 0;

		var text:String = null;
		switch (options[curOption].toLowerCase())
		{
			case "buff to use":
				optionInfo.y = 285;
				text = (ClientPrefs.mechanics) ? "Choose what buff you want to use in-game.\n\n<R>WARNING:<R>\nIf you change this setting, the song will restart to apply the new buff." : "This is disabled by default since mechanics are turned off.";
			case 'scroll type':
				optionInfo.y = 285;
				text = "Determine whether you want your notes to be scrolled upwards or downwards.";
			case "botplay":
				optionInfo.y = 275;
				text = "Determine whether you want to turn botplay on or off.\n\n<R>WARNING:<R>\nTurning botplay <G>ON<G> will reset your gameplay, aswell as your progress.\nTo disable, press CTRL on the Story Mode / Freeplay Menu.";
			case "moreoptions":
				optionInfo.y = 320;
				text = "Press ENTER to access all of FNV's settings.\nNo progress will be lost.";
		
			default:
				optionInfo.y = 285;
				text = (!ClientPrefs.optimizationMode) ? "Determine whether you want " + options[curOption] + " to be turned on or off." : "This is disabled by default since optimization mode is turned on.";
		}

		optionInfo.text = text;
		if (options[curOption].toLowerCase() != "buff to use" && options[curOption].toLowerCase() != "botplay" && options[curOption].toLowerCase() != "moreoptions") 
			optionInfo.text += "\n\n(Settings are applied once you restart or move to the next song.)";
		
		for (item in grpOpts.members)
		{
			quickSettingsTweenFadeIn = FlxTween.tween(item, {alpha: (curOption == item.ID) ? 1 : 0.6}, dur, {ease: FlxEase.quartOut});
		
			switch(item.ID)
			{
				case 0:
					if (options[item.ID].toLowerCase() == "mechanics")
						item.text = "Mechanics (" + (ClientPrefs.mechanics ? "Enabled" : "Disabled") + ")";
					else
						item.text = "Shaders (" + (ClientPrefs.shaders ? "Enabled" : "Disabled") + ")";
					
				case 1:
					if (options[item.ID].toLowerCase() == "shaders")
						item.text = "Shaders (" + (ClientPrefs.shaders ? "Enabled" : "Disabled") + ")";
					else
						item.text = "Cinematic Bars (" + (ClientPrefs.cinematicBars ? "Enabled" : "Disabled") + ")";
			
				case 2:
					if (options[item.ID].toLowerCase() == "buff to use")
						item.text = "Buff (" + buffs[buffType] + ")";
					else
						item.text = "Scroll Type (" + (ClientPrefs.downScroll ? "Downwards" : "Upwards") + ")";

				case 3:
					if (options[item.ID].toLowerCase() == "scroll type")
						item.text = "Scroll Type (" + (ClientPrefs.downScroll ? "Downwards" : "Upwards") + ")";
					else
						item.text = "Botplay (" + (botplayOn ? "Enabled" : "Disabled") + ")";

				case 4:
					if (options[item.ID].toLowerCase() == "botplay")
						item.text = "Botplay (" + (botplayOn ? "Enabled" : "Disabled") + ")";
					else
						item.text = "More Options..";

				default: item.text = "More Options..";
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

		if (skipTimeTweenFadeOut != null) skipTimeTweenFadeOut.cancel();
		skipTimeTweenFadeIn = FlxTween.tween(skipTimeText, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		if (skipTimeTweenTitleFadeOut != null) skipTimeTweenTitleFadeOut.cancel();
		skipTimeTweenTitleFadeIn = FlxTween.tween(skipTimeTitle, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		if (skipTimeBGTweenFadeOut != null) skipTimeBGTweenFadeOut.cancel();
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
		var appliedChanges:Bool = false;
		var currentPlayer:String = PlayState.SONG.player1;
		var diff:String = '-${CoolUtil.difficultyString().toLowerCase()}';

		appliedChanges = PlayState.checkSongBeforeSwitching("LowQuality", PlayState.SONG.song, diff);
		if (!appliedChanges) appliedChanges = PlayState.checkSongBeforeSwitching("Optimization", PlayState.SONG.song, diff);
		if (!appliedChanges) appliedChanges = PlayState.checkSongBeforeSwitching("Mechanics", PlayState.SONG.song, diff);

		if (appliedChanges)
		{
			PlayState.SONG.player1 = currentPlayer;
			trace("Song has been modified successfully.");
		}
		else 
		{
			PlayState.SONG = Song.loadFromJson(Paths.formatToSongPath(PlayState.SONG.song) + diff, Paths.formatToSongPath(PlayState.SONG.song));
			trace("No modifications needed. -> " + Paths.formatToSongPath(PlayState.SONG.song) + diff);
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
		else MusicBeatState.resetState();
	}

	override function destroy()
	{
		pauseMusic.destroy();
		FlxG.cameras.remove(pauseCam, true);

		super.destroy();
	}

	var disappearTween:FlxTween;
	var appearTween:FlxTween;
	function changeSelection(change:Int = 0):Void
	{
		if (ClientPrefs.haptics) Haptic.vibrateOneShot(0.05, 0.25, 0.5);
		curSelected += change;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		mainItem.text = menuItems[curSelected];
		if(mainItem == skipTimeTracker)
		{
			curTime = Math.max(0, Conductor.songPosition);
			updateSkipTimeText();
		}
	}

	var mainItem:Alphabet;
	function regenMenu():Void {
		item = new Alphabet(MobileUtil.fixX(1250), 550, menuItems[curSelected], true);
		item.setAlignmentFromString('right');
		item.alpha = 0;
		add(item);

		FlxTween.tween(mainItem, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		curSelected = 0;
		changeSelection();
	}

	function updateSkipTimeText()
	{
		skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
}
