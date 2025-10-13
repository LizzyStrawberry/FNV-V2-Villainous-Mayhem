package;

import haxe.macro.Type.ClassKind;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import lime.net.curl.CURLCode;

import WeekData;
import Achievements;

class StoryMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();
	public static var categorySelected:Int = 0;
	public var camAchievement:FlxCamera;

	var scoreText:FlxText;

	var bgSprite:FlxSprite;

	var background:FlxSprite;
	var cinematicBars:FlxSprite;
	var weekName:Alphabet;
	var weekCategory:Alphabet;

	var mechanicMessage:FlxSprite;
	var blackOut:FlxSprite;
	var blackOutMessage:FlxSprite;

	var arrowSelectorLeft:FlxSprite;
	var arrowSelectorRight:FlxSprite;
	var getarrowSelectorLeftX:Float = 0;
	var getarrowSelectorRightX:Float = 0;
	var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;

	var categoryNum1:FlxSprite;
	var categoryNum2:FlxSprite;
	var categoryNum3:FlxSprite;
	var categoryNum4:FlxSprite;

	var messageNumber:Int = 0;

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	private static var curWeek:Int = 0;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var weekCardBG:FlxSprite;
	var weekCard:FlxSprite;
	var play:FlxSprite;
	var closeButton:FlxSprite;
	var weekCardTitle:FlxSprite;
	var weekCardText:FlxText;

	var loadedWeeks:Array<WeekData> = [];

	public static var instance:StoryMenuState;

	override function create()
	{
		instance = this;

		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		FlxG.mouse.visible = true;
		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		//persistentUpdate = persistentDraw = true;
		Achievements.loadAchievements();
		
		//check if all 3 main weeks are unlocked and beaten (IN VILLAINOUS MODE!!!)
		if (ClientPrefs.iniquitousWeekUnlocked == false
			&& Achievements.isAchievementUnlocked('WeekMarcoVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekNunVillainous_Beaten')
			&& Achievements.isAchievementUnlocked('WeekKianaVillainous_Beaten'))
		{
			ClientPrefs.iniquitousWeekUnlocked = true;
			NotificationAlert.sendCategoryNotification = true;
			NotificationAlert.sendMessage = true;
			ClientPrefs.saveSettings();

			FlxG.sound.music.fadeOut(0.2);
			new FlxTimer().start(0.2, function(tmr:FlxTimer)
            {
                FlxG.sound.playMusic(Paths.music('malumIctum'));
                FlxG.sound.music.fadeIn(2.0);
            });
		}

		scoreText = new FlxText(10, 665, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("PhantomMuff 1.5", 32);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var bgYellow:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 386, 0xFFF9CF51);
		bgSprite = new FlxSprite(0, 56);
		bgSprite.antialiasing = ClientPrefs.globalAntialiasing;

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Story Mode", null);
		#end

		var num:Int = 0;
		for (i in 0...WeekData.weeksList.length)
		{
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			if(!isLocked || !weekFile.hiddenUntilUnlocked)
			{
				loadedWeeks.push(weekFile);
				WeekData.setDirectoryFromWeek(weekFile);
				var weekThing:MenuItem = new MenuItem(0, bgSprite.y + 396, WeekData.weeksList[i]);
				weekThing.y += ((weekThing.height + 20) * num);
				weekThing.targetY = num;
				grpWeekText.add(weekThing);

				weekThing.screenCenter(X);
				weekThing.antialiasing = ClientPrefs.globalAntialiasing;
				// weekThing.updateHitbox();

				// Needs an offset thingie
				if (isLocked)
				{
					var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
					lock.frames = ui_tex;
					lock.animation.addByPrefix('lock', 'lock');
					lock.animation.play('lock');
					lock.ID = i;
					lock.antialiasing = ClientPrefs.globalAntialiasing;
					grpLocks.add(lock);
				}
				num++;
			}
		}

		WeekData.setDirectoryFromWeek(loadedWeeks[0]);
		var charArray:Array<String> = loadedWeeks[0].weekCharacters;
		for (char in 0...3)
		{
			var weekCharacterThing:MenuCharacter = new MenuCharacter((FlxG.width * 0.25) * (1 + char) - 150, charArray[char]);
			weekCharacterThing.y += 70;
			grpWeekCharacters.add(weekCharacterThing);
		}

		weekName = new Alphabet(640, 80, "This is a test", true);
		weekName.setAlignmentFromString('center');
		weekName.scaleX = 0.8;
		weekName.scaleY = 0.8;

		weekCategory = new Alphabet(175, 40, "This is a test", true);
		weekCategory.setAlignmentFromString('center');
		weekCategory.alpha = 0.7;
		weekCategory.scaleX = 0.6;
		weekCategory.scaleY = 0.6;

		categoryNum1 = new FlxSprite(930, 20).loadGraphic(Paths.image('mainStoryMode/categoryNum_1'));
		categoryNum1.antialiasing = ClientPrefs.globalAntialiasing;
		categoryNum1.updateHitbox();

		categoryNum2 = new FlxSprite(categoryNum1.x + 90, 20).loadGraphic(Paths.image('mainStoryMode/categoryNum_2'));
		categoryNum2.antialiasing = ClientPrefs.globalAntialiasing;
		categoryNum2.updateHitbox();

		categoryNum3 = new FlxSprite(categoryNum1.x + 180, 20).loadGraphic(Paths.image('mainStoryMode/categoryNum_3'));
		categoryNum3.antialiasing = ClientPrefs.globalAntialiasing;
		categoryNum3.updateHitbox();

		if (!ClientPrefs.crossoverUnlocked)
		{
			categoryNum4 = new FlxSprite(categoryNum1.x + 270, 20).loadGraphic(Paths.image('mainStoryMode/categoryNum_4'));
			categoryNum4.antialiasing = ClientPrefs.globalAntialiasing;
			categoryNum4.updateHitbox();
		}	

		background = new FlxSprite(0, 0);
		background.antialiasing = ClientPrefs.globalAntialiasing;
		//background.alpha = 0.6;

		FlxTween.tween(background, {y: background.y + 20}, 5.7, {ease: FlxEase.cubeInOut, type: PINGPONG});
		FlxTween.tween(weekName, {y: weekName.y + 13}, 5.7, {ease: FlxEase.cubeInOut, type: PINGPONG});

		cinematicBars = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/Cinematic_Bars'));
		cinematicBars.antialiasing = ClientPrefs.globalAntialiasing;
		add(background);
		add(cinematicBars);
		add(weekName);
		add(weekCategory);
		add(categoryNum1);
		add(categoryNum2);
		add(categoryNum3);
		if (!ClientPrefs.crossoverUnlocked)
			add(categoryNum4);

		//Notifications on categories
		if (NotificationAlert.sendCategoryNotification == true)
		{
			if ((ClientPrefs.mainWeekFound == true && ClientPrefs.mainWeekPlayed == false) || (ClientPrefs.nunWeekFound == true && ClientPrefs.nunWeekPlayed == false)
				|| (ClientPrefs.kianaWeekFound == true && ClientPrefs.kianaWeekPlayed == false))
				NotificationAlert.addNotification(this, categoryNum1, -15, 45);
			if ((ClientPrefs.morkyWeekFound == true && ClientPrefs.morkyWeekPlayed == false) || (ClientPrefs.dsideWeekFound == true && ClientPrefs.dsideWeekPlayed == false)
				|| (ClientPrefs.susWeekFound == true && ClientPrefs.susWeekPlayed == false) || (ClientPrefs.legacyWeekFound == true && ClientPrefs.legacyWeekPlayed == false))
				NotificationAlert.addNotification(this, categoryNum2, -15, 45);
			if (ClientPrefs.iniquitousWeekUnlocked == true && !Achievements.isAchievementUnlocked('weekIniquitous_Beaten'))
				NotificationAlert.addNotification(this, categoryNum3, -15, 45);
			if (ClientPrefs.roadMapUnlocked == true)
				NotificationAlert.addNotification(this, categoryNum4, -15, 45);

			NotificationAlert.sendCategoryNotification = false;
			NotificationAlert.saveNotifications();
		}

		arrowSelectorLeft = new FlxSprite(-20, 230).loadGraphic(Paths.image('freeplayStuff/arrowSelectorLeft'));
		arrowSelectorLeft.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorLeft.scale.set(0.5, 0.5);
		add(arrowSelectorLeft);

		arrowSelectorRight = new FlxSprite(1160, 230).loadGraphic(Paths.image('freeplayStuff/arrowSelectorRight'));
		arrowSelectorRight.antialiasing = ClientPrefs.globalAntialiasing;
		arrowSelectorRight.scale.set(0.5, 0.5);
		add(arrowSelectorRight);

		getarrowSelectorRightX = arrowSelectorRight.x;
		getarrowSelectorLeftX = arrowSelectorLeft.x;

		add(scoreText);

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftArrow = new FlxSprite(grpWeekText.members[0].x + grpWeekText.members[0].width - 440, grpWeekText.members[0].y + 130);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(leftArrow);

		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		if(lastDifficultyName == '')
		{
			lastDifficultyName = CoolUtil.defaultDifficulty;
		}
		curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(lastDifficultyName)));
		
		sprDifficulty = new FlxSprite(0, leftArrow.y);
		sprDifficulty.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(leftArrow.x + 376, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(rightArrow);

		getRightArrowX = rightArrow.x;
		getLeftArrowX = leftArrow.x;

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 0;
		add(blackOut);

		weekCardBG = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/weekCards/weekCardBG'));
		weekCardBG.antialiasing = ClientPrefs.globalAntialiasing;
		weekCardBG.screenCenter();
		add(weekCardBG);

		weekCard = new FlxSprite(80, 165).loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/marcoCard'));
		weekCard.antialiasing = ClientPrefs.globalAntialiasing;
		add(weekCard);

		play = new FlxSprite(0, 610).loadGraphic(Paths.image('mainStoryMode/weekCards/play'));
		play.antialiasing = ClientPrefs.globalAntialiasing;
		play.screenCenter(X);
		add(play);

		closeButton = new FlxSprite(1200, 30).loadGraphic(Paths.image('mainStoryMode/weekCards/closeButton'));
		closeButton.antialiasing = ClientPrefs.globalAntialiasing;
		add(closeButton);

		weekCardTitle = new FlxSprite(0, 50).loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/marcoTitle'));
		weekCardTitle.antialiasing = ClientPrefs.globalAntialiasing;
		weekCardTitle.screenCenter(X);
		add(weekCardTitle);

		weekCardText = new FlxText(560, 230, 710,
			"TESTING",
			25);
		weekCardText.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, LEFT);
		add(weekCardText);

		weekCardBG.y += 1500;
		weekCard.y += 1500;
		play.y += 1500;
		closeButton.y += 1500;
		weekCardTitle.y += 1500;
		weekCardText.y += 1500;

		messageNumber = FlxG.random.int(1, 4);

		blackOutMessage = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOutMessage.alpha = 0;
		add(blackOutMessage);

		mechanicMessage = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/message1'));
		mechanicMessage.antialiasing = ClientPrefs.globalAntialiasing;
		mechanicMessage.alpha = 0;
		add(mechanicMessage);

		// Check the save feature
		ClientPrefs.traceProgress("story");
		ClientPrefs.traceProgress("campaign");

		if (ClientPrefs.crashSongName == '') ClientPrefs.resetProgress(true);

		if (NotificationAlert.sendTutorialNotification == true) NotificationAlert.showMessage(this, 'Tutorial');
		
		new FlxTimer().start(2, function(tmr:FlxTimer){
			if (ClientPrefs.crashSongName != '')
			{
				selectWeek();
			};
		});

		changeCategory();
		changeWeek();
		changeDifficulty();

		NotificationAlert.checkForNotifications(this);

		//Notification alert
		if (NotificationAlert.sendMessage)
		{
			NotificationAlert.showMessage(this, 'Normal');
			NotificationAlert.sendMessage = false;
			NotificationAlert.saveNotifications();
		}
		super.create();
	}

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

	var notSwitched:Bool = false;
	var loadedWeekInfo:Bool = false;
	var switchingScreens:Bool = false;
	var stopMoving:Bool = false;
	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		scoreText.text = "WEEK SCORE:" + lerpScore;

		// FlxG.watch.addQuick('font', scoreText.font);

		if (FlxG.mouse.overlaps(categoryNum1) || categorySelected == 0)
			categoryNum1.alpha = 1;
		else
			categoryNum1.alpha = 0.5;
		if (FlxG.mouse.overlaps(categoryNum2) || categorySelected == 1)
			categoryNum2.alpha = 1;
		else
			categoryNum2.alpha = 0.5;
		if (FlxG.mouse.overlaps(categoryNum3) || categorySelected == 2)
			categoryNum3.alpha = 1;
		else
			categoryNum3.alpha = 0.5;
		if (!ClientPrefs.crossoverUnlocked)
			if (FlxG.mouse.overlaps(categoryNum4) || categorySelected == 3)
				categoryNum4.alpha = 1;
			else
				categoryNum4.alpha = 0.5;

		if (!movedBack && !selectedWeek && !loadedWeekInfo && !switchingScreens)
		{
			var upP = controls.UI_UP_P;
			var downP = controls.UI_DOWN_P;

			if (!stopMoving)
			{
				if (upP || (FlxG.mouse.overlaps(arrowSelectorLeft) && FlxG.mouse.justPressed))
				{
					changeWeek(-1);
					changeDifficulty();
					FlxG.sound.play(Paths.sound('scrollMenu'));
					stopMoving = true;
					new FlxTimer().start(0.05, function (tmr:FlxTimer) {
						stopMoving = false;
					});
				}

				if (downP || (FlxG.mouse.overlaps(arrowSelectorRight) && FlxG.mouse.justPressed))
				{
					changeWeek(1);
					changeDifficulty();
					FlxG.sound.play(Paths.sound('scrollMenu'));
					stopMoving = true;
					new FlxTimer().start(0.05, function (tmr:FlxTimer) {
						stopMoving = false;
					});
				}

				//Category Changing
				if (FlxG.keys.justPressed.ONE || (FlxG.mouse.overlaps(categoryNum1) && FlxG.mouse.justPressed))
				{
					changeCategory(0);
					changeWeek(0);
					changeDifficulty();
					FlxG.sound.play(Paths.sound('scrollMenu'));
					scoreText.visible = true;
				}
				if (FlxG.keys.justPressed.TWO || (FlxG.mouse.overlaps(categoryNum2) && FlxG.mouse.justPressed))
				{
					changeCategory(1);
					changeWeek(0);
					changeDifficulty();
					FlxG.sound.play(Paths.sound('scrollMenu'));
					scoreText.visible = true;
				}
				if (FlxG.keys.justPressed.THREE || (FlxG.mouse.overlaps(categoryNum3) && FlxG.mouse.justPressed))
				{
					changeCategory(2);
					changeWeek(0);
					changeDifficulty();
					FlxG.sound.play(Paths.sound('scrollMenu'));
					scoreText.visible = true;
				}
				if (ClientPrefs.crossoverUnlocked == false && (FlxG.keys.justPressed.FOUR || (FlxG.mouse.overlaps(categoryNum4) && FlxG.mouse.justPressed)))
				{
					changeCategory(3);
					changeWeek(0);
					changeDifficulty();
					FlxG.sound.play(Paths.sound('scrollMenu'));
					scoreText.visible = false;
				}

				if(FlxG.mouse.wheel != 0)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					changeWeek(-FlxG.mouse.wheel);
					changeDifficulty();
				}

				if (controls.UI_RIGHT || (FlxG.mouse.overlaps(rightArrow) && FlxG.mouse.pressed))
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.UI_LEFT || (FlxG.mouse.overlaps(leftArrow) && FlxG.mouse.pressed))
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.UI_RIGHT_P || (FlxG.mouse.overlaps(rightArrow) && FlxG.mouse.justPressed))
					changeDifficulty(1);
				else if (controls.UI_LEFT_P || (FlxG.mouse.overlaps(leftArrow) && FlxG.mouse.justPressed))
					changeDifficulty(-1);
				else if (upP || downP)
					changeDifficulty();
			}

			if(FlxG.keys.justPressed.CONTROL)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			else if(controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, curWeek));
				//FlxG.sound.play(Paths.sound('scrollMenu'));
			}
			else if (!stopMoving && !loadedWeekInfo && (controls.ACCEPT || (FlxG.mouse.overlaps(sprDifficulty) && FlxG.mouse.justPressed)))
			{
				if (ClientPrefs.mainWeekFound == false && loadedWeeks[curWeek].storyName == "Main Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (ClientPrefs.nunWeekFound == false && loadedWeeks[curWeek].storyName == "Beatrice Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (ClientPrefs.kianaWeekFound == false && loadedWeeks[curWeek].storyName == "Kiana Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (ClientPrefs.dsideWeekFound == false && loadedWeeks[curWeek].storyName == "D-side Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (ClientPrefs.morkyWeekFound == false && loadedWeeks[curWeek].storyName == "Morky Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (ClientPrefs.susWeekFound == false && loadedWeeks[curWeek].storyName == "Sus Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (ClientPrefs.legacyWeekFound == false && loadedWeeks[curWeek].storyName == "Legacy Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (ClientPrefs.iniquitousWeekUnlocked == false && loadedWeeks[curWeek].storyName == "Iniquitous Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (ClientPrefs.roadMapUnlocked == false && loadedWeeks[curWeek].storyName == "Crossover Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (loadedWeeks[curWeek].storyName == "Tutorial Week")
				{
					stopMoving = true;
					selectWeek();
				}
				else if (loadedWeeks[curWeek].storyName != 'Crossover Week')
				{
					switchingScreens = true;
					stopMoving = true;
					loadWeek(false);
				}
				else
				{
					stopMoving = true;
					selectWeek();
				}
			}
		}
		if (loadedWeekInfo && (controls.ACCEPT || (FlxG.mouse.overlaps(play) && FlxG.mouse.justPressed))) selectWeek();

		if (!switchingScreens && loadedWeekInfo && (controls.BACK || FlxG.mouse.justPressedRight || (FlxG.mouse.overlaps(closeButton) && FlxG.mouse.justPressed)))
		{
			switchingScreens = true;
			loadWeek(true);
		}
		else if (!switchingScreens && (controls.BACK || FlxG.mouse.justPressedRight) && !movedBack && !selectedWeek && !loadedWeekInfo)
		{
			PlayState.isStoryMode = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			MusicBeatState.switchState(new MainMenuState(), 'stickers');
		}

		//fancy tweens uwu
		if (FlxG.mouse.overlaps(closeButton))
			closeButton.alpha = 1;
		else
			closeButton.alpha = 0.6;

		if (FlxG.mouse.overlaps(play))
			play.alpha = 1;
		else
			play.alpha = 0.6;

		if (FlxG.mouse.overlaps(leftArrow))
			FlxTween.tween(leftArrow, {x: getLeftArrowX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(leftArrow, {x: getLeftArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

		if (FlxG.mouse.overlaps(rightArrow))
			FlxTween.tween(rightArrow, {x: getRightArrowX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(rightArrow, {x: getRightArrowX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

		if (FlxG.mouse.overlaps(arrowSelectorLeft))
			FlxTween.tween(arrowSelectorLeft, {x: getarrowSelectorLeftX - 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(arrowSelectorLeft, {x: getarrowSelectorLeftX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

		if (FlxG.mouse.overlaps(arrowSelectorRight))
			FlxTween.tween(arrowSelectorRight, {x: getarrowSelectorRightX + 2}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		else
			FlxTween.tween(arrowSelectorRight, {x: getarrowSelectorRightX}, 0.7, {ease: FlxEase.circOut, type: PERSIST});

		super.update(elapsed);

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
			lock.visible = (lock.y > FlxG.height / 2);
		});
	}

	function loadWeek(unload:Bool)
	{
		if (!unload)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));

			FlxTween.tween(weekCardBG, {y: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(weekCard, {y: 165}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(play, {y: 610}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(closeButton, {y: 30}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(weekCardTitle, {y: 50}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
			FlxTween.tween(weekCardText, {y: 230}, 0.7, {ease: FlxEase.circOut, type: PERSIST, onComplete: function(twn:FlxTween)
				{
					switchingScreens = false;
					loadedWeekInfo = true;
				}
			});
		}
		else
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));

			FlxTween.tween(weekCardBG, {y: 2000}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
			FlxTween.tween(weekCard, {y: 2165}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
			FlxTween.tween(play, {y: 2610}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
			FlxTween.tween(closeButton, {y: 2030}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
			FlxTween.tween(weekCardTitle, {y: 2050}, 0.7, {ease: FlxEase.circIn, type: PERSIST});

			FlxTween.tween(weekCardText, {y: 2230}, 0.7, {ease: FlxEase.circIn, type: PERSIST, onComplete: function(twn:FlxTween)
				{
					loadedWeekInfo = false;
					switchingScreens = false;
					stopMoving = false;
				}
			});
		}
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;
	function selectWeek()
	{
		if (!weekIsLocked(loadedWeeks[curWeek].fileName))
		{
			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			// If difficulty >= 1, then add Boss Songs to the mix (for Main Weeks)
			if (curDifficulty >= 1)
			{
				switch(loadedWeeks[curWeek].storyName)
				{
					case 'Main Week':
						songArray.push('Villainy');
					case 'Beatrice Week':
						songArray.push('Point Blank');
					case 'Kiana Week':
						songArray.push('Libidinousness');
					case 'Sus Week':
						songArray.push('Excrete');
				}
			}	

			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';
			if(diffic == '' && curDifficulty == 0) diffic = '-casual'; //For some reason on week 1 it doesn't regognize it??????

			PlayState.storyDifficulty = curDifficulty;

			if ((PlayState.storyDifficulty == 0 || ClientPrefs.crashDifficulty == 0) && ClientPrefs.optimizationMode == true && !ClientPrefs.mechanics && loadedWeeks[curWeek].storyName == 'Iniquitous Week')
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				selectedWeek = true;
				FlxTween.tween(blackOutMessage, {alpha: 0.6}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				ClientPrefs.inMenu = true;
					
				mechanicMessage.loadGraphic(Paths.image('mainStoryMode/message' + messageNumber));
				FlxTween.tween(mechanicMessage, {alpha: 1}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new options.OptionsState());
					FreeplayState.destroyFreeplayVocals();
				});
			}
			else if (ClientPrefs.crashSongName != '')
			{
				if (!stopspamming)
				{
					FlxFlicker.flicker(sprDifficulty, 1, 0.04, false);
					stopspamming = true;
				}
					
				FlxG.sound.play(Paths.sound('confirmMenu'));
				MusicBeatState.switchState(new CrashAndLoadState());
			}
			else
			{
				if (!stopspamming)
				{
					FlxFlicker.flicker(sprDifficulty, 1, 0.04, false);
					FlxFlicker.flicker(play, 1, 0.04, false);
					stopspamming = true;
				}
				
				var distort:String = "";
				switch (loadedWeeks[curWeek].storyName)
				{
					case "Main Week":
						ClientPrefs.mainWeekPlayed = true;
						ClientPrefs.saveSettings();

					case "Beatrice Week":
						ClientPrefs.nunWeekPlayed = true;
						ClientPrefs.saveSettings();

					case "Kiana Week":
						ClientPrefs.kianaWeekPlayed = true;
						ClientPrefs.saveSettings();

					case "D-side Week":
						ClientPrefs.dsideWeekPlayed = true;
						ClientPrefs.saveSettings();

					case "Morky Week":
						ClientPrefs.morkyWeekPlayed = true;
						ClientPrefs.saveSettings();

					case "Sus Week":
						ClientPrefs.susWeekPlayed = true;
						ClientPrefs.saveSettings();

					case "Legacy Week":
						ClientPrefs.legacyWeekPlayed = true;
						ClientPrefs.saveSettings();

					case "Iniquitous Week":
						FlxG.sound.music.stop();
						distort = "Distorted";
				}

				FlxG.sound.play(Paths.sound('confirmMenu' + distort));
				selectedWeek = true;
				FlxG.mouse.visible = false;
				if (ClientPrefs.roadMapUnlocked && loadedWeeks[curWeek].storyName == "Crossover Week")
				{
					FlxG.camera.flash(FlxColor.WHITE, 1);
					FlxG.sound.music.volume = 0;
					ClientPrefs.crashDifficulty = PlayState.storyDifficulty;
					ClientPrefs.saveSettings();
					ClientPrefs.onCrossSection = true;
					PlayState.isStoryMode = false;
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
							MusicBeatState.switchState(new CrossoverState());
					});
				}
				else
				{
					PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
					PlayState.campaignScore = 0;
					PlayState.campaignMisses = 0;

					if (WeekData.getWeekFileName() == 'weeklegacy') //checking if it is the legacy week
						PlayState.SONG.player1 = 'playablegf-old'; //change the player to the old version
					if (WeekData.getWeekFileName() == 'weekmorky') //checking if it is the Morky week
						PlayState.SONG.player1 = 'Spendthrift GF'; //change the player to the Spendthrift version
	
					//Crash / Save detection reset
					ClientPrefs.resetProgress(true, false); //Also reset tokens, no trace!

					ClientPrefs.crashDifficultyName = diffic; //Difficulty Name
					ClientPrefs.crashDifficulty = curDifficulty; //Difficulty Number
					ClientPrefs.crashWeek = curWeek; //Week Number
					ClientPrefs.crashWeekName = WeekData.getWeekFileName(); //Week Name
				
					ClientPrefs.campaignBestCombo = 0;
					ClientPrefs.campaignRating = 0;
					ClientPrefs.campaignHighScore = 0;
					ClientPrefs.campaignSongsPlayed = 0;
					ClientPrefs.saveSettings();

					ClientPrefs.traceProgress("story");
					ClientPrefs.traceProgress("campaign");
		
					FlxG.camera.flash(FlxColor.WHITE, 1);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						LoadingState.loadAndSwitchState(new PlayState(), true);
						FreeplayState.destroyFreeplayVocals();
					});
				}
			}
		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	var tweenDifficulty:FlxTween;
	var tweenImage:FlxTween;
	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curWeek == 0 || curWeek == 8) //Check if the selected week is TUTORIAL or INIQUITOUS
		{
			if (curDifficulty < 0)
				curDifficulty = CoolUtil.difficulties.length-1;
			if (curDifficulty >= CoolUtil.difficulties.length)
				curDifficulty = 0;
		}
		else
		{
			if (curDifficulty < 0)
				curDifficulty = 1;
			if (curDifficulty > 1)
				curDifficulty = 0;
		}
		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = CoolUtil.difficulties[curDifficulty];
		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));
		//trace(Paths.currentModDirectory + ', menudifficulties/' + Paths.formatToSongPath(diff));
		
		if(sprDifficulty.graphic != newImage)
		{
			sprDifficulty.loadGraphic(newImage);
			sprDifficulty.x = leftArrow.x + 60;
			sprDifficulty.x += (308 - sprDifficulty.width) / 3;
			sprDifficulty.alpha = 0;
			sprDifficulty.y = leftArrow.y - 15;

			if(tweenDifficulty != null) tweenDifficulty.cancel();
			tweenDifficulty = FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07, {onComplete: function(twn:FlxTween)
			{
				tweenDifficulty = null;
			}});
		}
		lastDifficultyName = diff;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeCategory(huh:Int = 0):Void
	{
		categorySelected = huh;
		switch(categorySelected)
		{
			case 0:
				categoryNum1.alpha = 1;
				categoryNum2.alpha = 0.5;
				categoryNum3.alpha = 0.5;
				if (ClientPrefs.crossoverUnlocked == false)
					categoryNum4.alpha = 0.5;
				curWeek = 0;
			case 1:
				categoryNum1.alpha = 0.5;
				categoryNum2.alpha = 1;
				categoryNum3.alpha = 0.5;
				if (ClientPrefs.crossoverUnlocked == false)
					categoryNum4.alpha = 0.5;
				curWeek = 3;
			case 2:
				categoryNum1.alpha = 0.5;
				categoryNum2.alpha = 0.5;
				categoryNum3.alpha = 1;
				if (ClientPrefs.crossoverUnlocked == false)
					categoryNum4.alpha = 0.5;
				curWeek = 7;
			case 3:
				categoryNum1.alpha = 0.5;
				categoryNum2.alpha = 0.5;
				categoryNum3.alpha = 0.5;
				if (ClientPrefs.crossoverUnlocked == false)
					categoryNum4.alpha = 1;
				curWeek = 8;
		}
	}

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		switch(categorySelected)
		{
			case 0:
				//Weeks 0 - 4 [Main Weeks]
				if (curWeek >= 4)
					curWeek = 0;
				if (curWeek < 0)
					curWeek = 3;
			case 1:
				//Weeks 5 - 9 [Bonus Weeks]
				if (curWeek >= 8)
					curWeek = 4;
				if (curWeek < 4)
					curWeek = 7;
			case 2:
				//Week Iniquitous
				if (curWeek >= 9)
					curWeek = 8;
				if (curWeek < 8)
					curWeek = 8;
			case 3:
				//Crossovers
				if (curWeek >= 10)
					curWeek = 9;
				if (curWeek < 9)
					curWeek = 9;
		}
		

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;

		weekCardBG.loadGraphic(Paths.image('mainStoryMode/weekCards/weekCardBG'));
		play.loadGraphic(Paths.image('mainStoryMode/weekCards/play'));

		switch(leWeek.storyName)
		{
			case 'Tutorial Week':
				background.loadGraphic(Paths.image('mainStoryMode/weekBanners/tutWeekBanner'));
				weekName.text = "Tutorial\nCouple Clash";
				weekCategory.text = "Main Weeks";

			case 'Main Week':
				if (ClientPrefs.mainWeekFound == true)
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/mainWeekBanner'));
					weekName.text = "Week 1\nThe Cheap Skate Villain";
					weekCategory.text = "Main Weeks";
					weekCardText.text = "Play as Girlfriend, as she gets teleported to the Cheapskate, Asshole, Infamous Walmart Smartass Marco Isavilan's Lair, and challenge him to a rap battle (cause why not).";
					weekCard.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/marcoCard'));
					weekCardTitle.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/marcoTitle'));
				}
				else
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/questionMark'));
					weekName.text = "Week 1\nLocked.";
				}
				

			case 'Beatrice Week':
				if (ClientPrefs.nunWeekFound == false)
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/questionMark'));
					weekName.text = "Week 2\nLocked.";
				}
				else
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/beatriceWeekBanner'));
					weekName.text = "Week 2\nOrphanage Hustle";
					weekCardText.text = "Looks like that teleporter brings GF to a place that smells like charcoal and baby powder..\nIt's an orphanage!\nMaybe she can ask some people there on how she can get back to her big dick'd Boyfriend.";
					weekCard.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/beatriceCard'));
					weekCardTitle.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/beatriceTitle'));
				}
				weekCategory.text = "Main Weeks";
	
			case 'Kiana Week':
				if (ClientPrefs.kianaWeekFound == false)
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/questionMark'));
					weekName.text = "Week 3\nLocked.";
				}
				else
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/kianaWeekBanner'));
					weekName.text = "Week 3\nInto The Unnamed";
					weekCardText.text = "That teleporter's merged to GF's powers, and now she can teleport everywhere unwillingly.\nThis newfound power brings her to a very unfamiliar dimension that no human has ever stepped on before..\n\n<R>WARNING!\nLibidinousness can potentially fail to load certain sprites on low-end hardware due to sprite sizes. It needed, enable the \"Performance Warning\" Version through options.<R>";
					weekCard.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/kianaCard'));
					weekCardTitle.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/kianaTitle'));
				}
				weekCategory.text = "Main Weeks";
	
			case 'D-side Week':
				if (ClientPrefs.dsideWeekFound == false)
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/questionMarkBlue'));
					weekName.text = "Week D-sides\nLocked.";
				}
				else
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/dsideWeekBanner'));
					weekName.text = "Week D-sides\n4 side Villainy";
					weekCardText.text = "This new teleportation power is getting wild over time!\nGirlfriend's apparently now into an alternate universe?!";
					weekCard.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/dsideCard'));
					weekCardTitle.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/dsideTitle'));
				}
				weekCategory.text = "Bonus Weeks";

			case 'Morky Week':
				if (ClientPrefs.morkyWeekFound == false)
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/questionMarkBlue'));
					weekName.text = "Week Morky\nLocked.";
				}
				else
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/morkyWeekBanner'));
					weekName.text = "Week Morky\nThe Entertainers";
					weekCardText.text = "At this point, I have no idea anymore.
					\n<R>WARNING:\nThis week contains shaders, fast moving objects and a few flashy colors that could potentially cause weak epilepsy.\nIf you're sensitive enough, please disable both mechanics and shaders from the options menu.<R>";
					weekCard.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/morkCard'));
					weekCardTitle.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/morkTitle'));
				}
				weekCategory.text = "Bonus Weeks";

			case 'Sus Week':
				if (ClientPrefs.susWeekFound == false)
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/questionMarkBlue'));
					weekName.text = "Week Sus\nLocked.";
				}
				else
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/susWeekBanner'));
					weekName.text = "Week Sus\nA Villain is among us";
					weekCardText.text = "This teleporter is surely messing with GF's brain every time she teleports.. she's apparently seeing things that aren't even there.\nIS THAT SUSSY AMONG US IMPOSTOR?!?\nIt's " + Date.now().getFullYear() + ", how is this meme still relevant?!";
					weekCard.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/susCard'));
					weekCardTitle.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/susTitle'));
				}
				weekCategory.text = "Bonus Weeks";

			case 'Legacy Week':
				if (ClientPrefs.legacyWeekFound == false)
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/questionMarkBlue'));
					weekName.text = "Week Legacy\nLocked.";
				}
				else
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/legacyWeekBanner'));
					weekName.text = "Week Legacy\nToxic Legacy";
					weekCardText.text = "Looks like GF's new 'out of control' teleporting ability teleports her BACK AT TIME!!\nShe now has to rap battle against.. Marco Again!!??\nI was expecting Dinosaurs... god damn it.";
					weekCard.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/legacyCard'));
					weekCardTitle.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/legacyTitle'));
				}
				weekCategory.text = "Bonus Weeks";

			case 'Iniquitous Week':
				if (ClientPrefs.iniquitousWeekUnlocked == false)
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/questionMarkRed'));
					weekName.text = "Locked.";
				}
				else
				{
					if (Achievements.isAchievementUnlocked('weekIniquitous_Beaten'))
					{
						background.loadGraphic(Paths.image('mainStoryMode/weekBanners/iniquitousWeekBannerBeaten'));
						weekName.text = "Iniquitous";
						weekCardText.text = "<R>...<R>";
					}
					else
					{
						background.loadGraphic(Paths.image('mainStoryMode/weekBanners/iniquitousWeekBanner'));
						weekName.text = "Iniquitous";
						weekCardText.text = "After GF's many Teleportations, she finally lands on a very obscure place, where hope is non-existent and constant fear is present.\nA realm where the embodiment of <R>Iniquity<R> is within.\nAfter many attempts, your demon powers finally give up and respond on my call. <R>COME AND FACE ME, Spawn of Dearest...<R>\n<DR>It's time to claim what I've been promised...<DR>";
					}
					
					weekCard.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/iniquitousCard'));
					weekCardTitle.loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/iniquitousTitle'));
					
					weekCardBG.loadGraphic(Paths.image('mainStoryMode/weekCards/weekCardBGIniquitous'));
					play.loadGraphic(Paths.image('mainStoryMode/weekCards/playIniquitous'));
				}
				weekCategory.text = "The Final\nJudgement";

			case 'Crossover Week':
				if (ClientPrefs.roadMapUnlocked == false)
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/questionMarkWhite'));
					weekName.text = "Locked.";
				}
				else
				{
					background.loadGraphic(Paths.image('mainStoryMode/weekBanners/crossoverBanner'));
					weekName.text = "Beyond Reality";
				}
				weekCategory.text = "Crossovers";

			default:
				background.loadGraphic(Paths.image('mainStoryMode/Placeholder'));
				weekName.text = "Lizzy Strawberry is a good coder\nFight me bitch";
				weekCategory.text = "Weeks";
		}
		CustomFontFormats.addMarkers(weekCardText);

		var bullShit:Int = 0;

		var unlocked:Bool = !weekIsLocked(leWeek.fileName);
		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && unlocked)
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		bgSprite.visible = true;
		var assetName:String = leWeek.weekBackground;
		if(assetName == null || assetName.length < 1) bgSprite.visible = false; 
		else bgSprite.loadGraphic(Paths.image('menubackgrounds/menu_' + assetName));

		PlayState.storyWeek = curWeek;

		if (curWeek >= 1 && curWeek <= 3) //Main Weeks
			CoolUtil.difficulties = CoolUtil.mainWeekDifficulties.copy();
		else if (curWeek == 8) //Iniquitous
			CoolUtil.difficulties = CoolUtil.iniquitousDifficulties.copy();
		else //Remaining Weeks
			CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();

		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5
		difficultySelectors.visible = unlocked;

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0) CoolUtil.difficulties = diffs;
		}

		if(CoolUtil.difficulties.contains(CoolUtil.mainWeekDifficulty)) curDifficulty = Math.round(Math.max(0, CoolUtil.mainWeekDifficulties.indexOf(CoolUtil.mainWeekDifficulty)));
		else curDifficulty = 0;
		
		if(CoolUtil.difficulties.contains(CoolUtil.defaultDifficulty)) curDifficulty = Math.round(Math.max(0, CoolUtil.defaultDifficulties.indexOf(CoolUtil.defaultDifficulty)));
		else curDifficulty = 0;

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		if(newPos > -1) curDifficulty = newPos;

		updateText();
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText()
	{
		var weekArray:Array<String> = loadedWeeks[curWeek].weekCharacters;
		for (i in 0...grpWeekCharacters.length) {
			grpWeekCharacters.members[i].changeCharacter(weekArray[i]);
		}

		var leWeek:WeekData = loadedWeeks[curWeek];
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length) {
			stringThing.push(leWeek.songs[i][0]);
		}

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}
}
