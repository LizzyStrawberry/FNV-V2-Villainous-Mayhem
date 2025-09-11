package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import lime.net.curl.CURLCode;
import WeekData;
import Achievements;

class IniquitousMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();
	private var camAchievement:FlxCamera;

	var scoreText:FlxText;

	var txtWeekTitle:FlxText;
	var bgSprite:FlxSprite;

	var background:FlxSprite;
	var cinematicBars:FlxSprite;
	var weekName:Alphabet;
	var weekCategory:Alphabet;

	var mechanicMessage:FlxSprite;
	var blackOut:FlxSprite;

	var libidiWarning:FlxText;

	var arrowSelectorLeft:FlxSprite;
	var arrowSelectorRight:FlxSprite;
	var getarrowSelectorLeftX:Float = 0;
	var getarrowSelectorRightX:Float = 0;
	var getLeftArrowX:Float = 0;
	var getRightArrowX:Float = 0;

	var messageNumber:Int = 0;

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	private static var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var loadedWeeks:Array<WeekData> = [];

	var weekCardBG:FlxSprite;
	var weekCard:FlxSprite;
	var understand:FlxSprite;
	var weekCardTitle:FlxSprite;
	var weekCardText:FlxText;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		//ClientPrefs.roadMapUnlocked = true;
		//ClientPrefs.iniquitousUnlocked = false;
		//ClientPrefs.saveSettings();
		FlxG.mouse.visible = true;
		PlayState.isStoryMode = true;
		PlayState.isIniquitousMode = true;
		WeekData.reloadWeekFiles(true);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		//persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 665, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("PhantomMuff 1.5", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

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

		#if desktop
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
		weekName.color = 0xFFFF0000;
		weekName.scaleX = 0.8;
		weekName.scaleY = 0.8;

		weekCategory = new Alphabet(175, 40, "This is a test", true);
		weekCategory.setAlignmentFromString('center');
		weekCategory.alpha = 0.7;
		weekCategory.scaleX = 0.6;
		weekCategory.scaleY = 0.6;

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

		if (ClientPrefs.performanceWarning)
		{
			libidiWarning = new FlxText(700, 100, 1000, "Warning:\nIs your PC strong enough to handle the week?\n(It is recommended to atleast have a graphics card installed)\n----------------------------
			\nY: Yes | N: No", 32);
			libidiWarning.setFormat("VCR OSD Mono", 50, FlxColor.RED, CENTER);
			libidiWarning.screenCenter(XY);
			libidiWarning.alpha = 0;
			add(libidiWarning);
		}

		mechanicMessage = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/message1'));
		mechanicMessage.antialiasing = ClientPrefs.globalAntialiasing;
		mechanicMessage.alpha = 0;
		add(mechanicMessage);

		messageNumber = FlxG.random.int(1, 4);

		weekCardBG = new FlxSprite(0, 0).loadGraphic(Paths.image('mainStoryMode/weekCards/weekCardBGIniquitous'));
		weekCardBG.antialiasing = ClientPrefs.globalAntialiasing;
		weekCardBG.screenCenter();
		add(weekCardBG);

		weekCard = new FlxSprite(80, 165).loadGraphic(Paths.image('mainStoryMode/weekCards/mainWeeks/iniquitousCard'));
		weekCard.antialiasing = ClientPrefs.globalAntialiasing;
		add(weekCard);

		weekCardText = new FlxText(560, 240, 710,
			"<R>Be warned!<R>\nThis Gamemode is <R>very harsh<R>, allowing you to play <G>ONLY THE MAIN 3 WEEKS<G> of the mod in Iniquitous Difficulty!\nBe cautious, as each week has it's own <R>quirks and differences<R> compared to the regular modes!
			\n<DR>Do you accept the Challenge?<DR>",
			25);
		weekCardText.setFormat("VCR OSD Mono", 30, FlxColor.WHITE, LEFT);
		add(weekCardText);

		weekCardTitle = new FlxSprite(0, 50).loadGraphic(Paths.image('mainStoryMode/weekCards/disclaimer'));
		weekCardTitle.antialiasing = ClientPrefs.globalAntialiasing;
		weekCardTitle.screenCenter(X);
		add(weekCardTitle);

		CustomFontFormats.addMarkers(weekCardText);

		understand = new FlxSprite(0, 610).loadGraphic(Paths.image('mainStoryMode/weekCards/understand'));
		understand.antialiasing = ClientPrefs.globalAntialiasing;
		understand.screenCenter(X);
		add(understand);

		weekCardBG.y += 1500;
		weekCard.y += 1500;
		understand.y += 1500;
		weekCardTitle.y += 1500;
		weekCardText.y += 1500;

		if (!ClientPrefs.viewedDisclaimer)
			new FlxTimer().start(2, function(tmr:FlxTimer){
				FlxTween.tween(weekCardBG, {y: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(weekCard, {y: 165}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(understand, {y: 610}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(weekCardTitle, {y: 50}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(weekCardText, {y: 240}, 0.7, {ease: FlxEase.circOut, type: PERSIST, onComplete: function(twn:FlxTween)
					{
						loadedDisclaimer = movedBack = true;
						
					}
				});
				ClientPrefs.viewedDisclaimer = true;
				ClientPrefs.saveSettings();
			});

		//check the save feature
		ClientPrefs.traceProgress("story");
		ClientPrefs.traceProgress("campaign");
		
		if (ClientPrefs.crashSongName == '') ClientPrefs.resetProgress(true);
		
		new FlxTimer().start(2, function(tmr:FlxTimer){
			if (ClientPrefs.crashSongName != '')
				selectWeek();
		});

		changeWeek();
		changeDifficulty();

		super.create();
	}

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

	var warning:Bool = false;
	var loadedDisclaimer:Bool = false;
	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		scoreText.text = "WEEK SCORE:" + lerpScore;

		if (loadedDisclaimer)
		{
			if (FlxG.mouse.overlaps(understand))
				understand.alpha = 1;
			else
				understand.alpha = 0.6;

			if ((FlxG.mouse.overlaps(understand) && FlxG.mouse.justPressed) || controls.ACCEPT)
			{
				loadedDisclaimer = false;
				FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxTween.tween(weekCardBG, {y: 2000}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
				FlxTween.tween(weekCard, {y: 2165}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
				FlxTween.tween(understand, {y: 2610}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
				FlxTween.tween(weekCardTitle, {y: 2050}, 0.7, {ease: FlxEase.circIn, type: PERSIST});
				FlxTween.tween(weekCardText, {y: 2240}, 0.7, {ease: FlxEase.circIn, type: PERSIST, onComplete: function(twn:FlxTween)
					{
						movedBack = false;
					}
				});
			}
		}

		if (!movedBack && !selectedWeek)
		{
			var upP = controls.UI_UP_P || (FlxG.mouse.overlaps(arrowSelectorLeft) && FlxG.mouse.justPressed);
			var downP = controls.UI_DOWN_P || (FlxG.mouse.overlaps(arrowSelectorRight) && FlxG.mouse.justPressed);

			if (!warning && !loadedDisclaimer)
			{
				if (upP)
				{
					changeWeek(-1);
					changeDifficulty();
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
		
				if (downP)
				{
					changeWeek(1);
					changeDifficulty();
					FlxG.sound.play(Paths.sound('scrollMenu'));
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
			else if (warning && FlxG.keys.justPressed.Y)
			{
				ClientPrefs.lowQuality = false;
				selectWeek();
			}
			else if (warning && FlxG.keys.justPressed.N)
			{
				ClientPrefs.lowQuality = true;
				selectWeek();
			}
			else if (controls.ACCEPT || (FlxG.mouse.overlaps(sprDifficulty) && FlxG.mouse.justPressed))
			{
				if (loadedWeeks[curWeek].storyName == "Kiana Week" && warning == false && ClientPrefs.performanceWarning == true)
				{
					warning = true;
					FlxTween.tween(blackOut, {alpha: 0.7}, 1.2, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(libidiWarning, {alpha: 1}, 1.2, {ease: FlxEase.circOut, type: PERSIST});
				}
				else
					selectWeek();
			}

		}

		//fancy tweens uwu
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

		if ((controls.BACK || FlxG.mouse.justPressedRight) && !movedBack && !selectedWeek)
		{
			if (warning)
			{
				FlxTween.tween(blackOut, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(libidiWarning, {alpha: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
				warning = false;
			}
			else
			{
				PlayState.isStoryMode = false;
				PlayState.isIniquitousMode = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				movedBack = true;
				MusicBeatState.switchState(new MainMenuState(), 'stickers');
			}
		}

		super.update(elapsed);

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
			lock.visible = (lock.y > FlxG.height / 2);
		});
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

			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;

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

			var diffic = CoolUtil.getDifficultyFilePath(curDifficulty);
			if(diffic == null) diffic = '';

			PlayState.storyDifficulty = curDifficulty;

			if ((PlayState.storyDifficulty == 2 || ClientPrefs.crashDifficulty == 2) && ClientPrefs.mechanics == false && (loadedWeeks[curWeek].storyName == 'Main Week' ||
				loadedWeeks[curWeek].storyName == 'Beatrice Week' || loadedWeeks[curWeek].storyName == 'Kiana Week'))
				{
					FlxG.sound.play(Paths.sound('confirmMenu'));
					selectedWeek = true;
					FlxTween.tween(blackOut, {alpha: 0.6}, 0.8, {ease: FlxEase.cubeInOut, type: PERSIST});
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
				if (stopspamming == false)
					{
						grpWeekText.members[curWeek].startFlashing();
		
						FlxFlicker.flicker(sprDifficulty, 1, 0.04, false);
		
						for (char in grpWeekCharacters.members)
						{
							if (char.character != '' && char.hasConfirmAnimation)
							{
								char.animation.play('confirm');
							}
						}
						stopspamming = true;
					}
					
				FlxG.sound.play(Paths.sound('confirmMenu'));
				MusicBeatState.switchState(new CrashAndLoadState());
			}
			else
			{
				if (ClientPrefs.nunWeekFound == false && loadedWeeks[curWeek].storyName == "Beatrice Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else if (ClientPrefs.kianaWeekFound == false && loadedWeeks[curWeek].storyName == "Kiana Week")
				{
					FlxG.camera.shake(0.01, 0.5, null, false, FlxAxes.XY);
					FlxG.sound.play(Paths.sound('accessDenied'));
				}
				else
				{
					if (stopspamming == false)
					{
						grpWeekText.members[curWeek].startFlashing();
			
						FlxFlicker.flicker(sprDifficulty, 1, 0.04, false);
			
						for (char in grpWeekCharacters.members)
						{
							if (char.character != '' && char.hasConfirmAnimation)
							{
								char.animation.play('confirm');
							}
						}
						stopspamming = true;
					}

					if (loadedWeeks[curWeek].storyName == "Beatrice Week")
						ClientPrefs.ghostTapping = false;

					FlxG.sound.play(Paths.sound('confirmMenu'));
					selectedWeek = true;
					FlxG.mouse.visible = false;
				
					PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
					PlayState.campaignScore = 0;
					PlayState.campaignMisses = 0;
	
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
		curDifficulty = 2;

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

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;
		//Weeks 1 - 3 [Main Weeks]

		if (curWeek >= 4)
			curWeek = 1;
		if (curWeek < 1)
			curWeek = 3;

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;
		txtWeekTitle.text = leName.toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		switch(leWeek.storyName)
		{
			case 'Main Week':
				background.loadGraphic(Paths.image('mainStoryMode/weekBanners/mainWeekBannerIniquitous'));
				weekName.text = "Week 1\nCheap Skate Villains";
				weekCategory.text = "Main Weeks";
					
			case 'Beatrice Week':
				background.loadGraphic(Paths.image('mainStoryMode/weekBanners/beatriceWeekBannerIniquitous'));
				weekName.text = "Week 2\nOrphanage Hustle";
				weekCategory.text = "Main Weeks";
	
			case 'Kiana Week':
				background.loadGraphic(Paths.image('mainStoryMode/weekBanners/kianaWeekBannerIniquitous'));
				weekName.text = "Week 3\nThe Unnamed Trinity";
				weekCategory.text = "Main Weeks";
	
			default:
				background.loadGraphic(Paths.image('mainStoryMode/Placeholder'));
				weekName.text = "Liz has the best hourglass body\nFight me bitch";
				weekCategory.text = "Weeks";
		}

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
		if(assetName == null || assetName.length < 1) {
			bgSprite.visible = false;
		} else {
			bgSprite.loadGraphic(Paths.image('menubackgrounds/menu_' + assetName));
		}
		PlayState.storyWeek = curWeek;

		CoolUtil.difficulties = CoolUtil.mainWeekDifficulties.copy();
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

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				CoolUtil.difficulties = diffs;
			}
		}
		
		if(CoolUtil.difficulties.contains(CoolUtil.mainWeekDifficulty))
		{
			curDifficulty = Math.round(Math.max(0, CoolUtil.mainWeekDifficulties.indexOf(CoolUtil.mainWeekDifficulty)));
		}
		else
		{
			curDifficulty = 0;
		}

		var newPos:Int = CoolUtil.difficulties.indexOf(lastDifficultyName);
		//trace('Pos of ' + lastDifficultyName + ' is ' + newPos);
		if(newPos > -1)
		{
			curDifficulty = newPos;
		}
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

		/*txtTracklist.text = '';
		for (i in 0...stringThing.length)
		{
			txtTracklist.text += stringThing[i] + '\n';
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;
		*/

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}
}
