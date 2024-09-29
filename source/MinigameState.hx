package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.math.FlxRandom;
import flixel.util.FlxBitmapDataUtil;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.text.FlxTypeText;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxAxes;

import editors.ChartingState;
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import flixel.FlxCamera;
import Achievements;
import WeekData;
#if MODS_ALLOWED
import sys.FileSystem;
#end

import vlc.MP4Handler;
import flash.system.System;

using StringTools;

class MinigameState extends MusicBeatState
{
	private var camAchievement:FlxCamera;

	//Basics
	var background:FlxSprite;
	var tipText:FlxText;
	var tipTween:FlxTween;
	var minigameTitle:Alphabet;
	var minigame:Int;

	//Coin Flip
	var coin:FlxSprite;
	var flipnum:Int;
	var answer:Alphabet;
	var timer:FlxTimer;
	var allowedToPlay:Bool = false;

	//Find The Token
	var token:FlxSprite;
	var tokenFollow:Int;
	var cups:FlxTypedGroup<FlxSprite>;
	var cupX:Array<Int> = [
		165,
		505,
		845
	];

	//Match The Cards
	var cards:FlxTypedGroup<FlxSprite>;
	var cardsHidden:FlxTypedGroup<FlxSprite>;
	var cardNames:Array<String> = [
		'jesterCard',
		'deathCard',
		'witchCard',
		'alchemistCard',
		'elQuesoCard'
	];
	var shuffledCards:Array<String> = new Array<String>();
	var cardsSelected:Int = 0;
	var selectedCards:Array<FlxSprite> = [];
	var selectedBlankCards:Array<FlxSprite> = [];
	var matchedPairs:Int = 0;

	var timerTextLeft:FlxText;
	var timerTextRight:FlxText;
	var gameTimer:FlxTimer;
	var totalTime:Int;
	var countdown:FlxSprite;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Playing Minigames", null);
		#end
		
		minigame = FlxG.random.int(1, 3);

		FlxG.sound.playMusic(Paths.music('shopTheme'), 0);
		FlxG.sound.music.fadeIn(7, 0, 0.6);

		persistentUpdate = true;

		if (minigame == 1)
		{
			flipnum = FlxG.random.int(0, 1);

			trace('Number: ' + flipnum);
	
			background = new FlxSprite(0, 0).loadGraphic(Paths.image('minigames/CFBG'));
			background.antialiasing = ClientPrefs.globalAntialiasing;
			add(background);
	
			//Coin Flip
			coin = new FlxSprite(0, 0).loadGraphic(Paths.image('minigames/Coin Flip'));
			coin.frames = Paths.getSparrowAtlas('minigames/Coin Flip');
			coin.antialiasing = ClientPrefs.globalAntialiasing;
			coin.animation.addByPrefix('flip', 'coinflip', 24, true);
			coin.animation.addByPrefix('heads', 'coinlandhead', 24, true);
			coin.animation.addByPrefix('tails', 'coinlandtails', 24, true);
			if (FlxG.random.int(0, 1) == 0)
				coin.animation.play('heads');
			else
				coin.animation.play('tails');
			coin.screenCenter();
			coin.updateHitbox();
			add(coin);
			
			tipText = new FlxText(700, 960, FlxG.width, "FLIP-A-COIN! Press LEFT or RIGHT to choose HEADS or TAILS, and then ENTER to see if it lands on your answer or not!\nIf you win, you get 1 token EXTRA!", 24);
			tipText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
			tipText.screenCenter(XY);
			tipText.y += 290;
			tipText.alpha = 0;
			tipText.borderSize = 3;
			add(tipText);
	
			answer = new Alphabet(645, 560, "", true);
			answer.setAlignmentFromString('center');
			answer.scaleX = 0.5;
			answer.scaleY = 0.5;
			answer.updateHitbox();
			add(answer);
	
			FlxTween.tween(tipText, {alpha: 1}, 1.7, {ease: FlxEase.cubeInOut, type: PERSIST, onComplete: function(twn:FlxTween)
				{
					allowedToPlay = true;
					timer = new FlxTimer().start(4, fix);
				}	
			});
			
			minigameTitle = new Alphabet(420, 10, "Coin Flip!", true);
			minigameTitle.alpha = 0;
			add(minigameTitle);
	
			FlxTween.tween(minigameTitle, {alpha: 0.6}, 1.7, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(minigameTitle, {y: minigameTitle.y + 10}, 3.2, {ease: FlxEase.cubeInOut, type: PINGPONG});
	
			changeSelection();
		}
		else if (minigame == 2)
		{
			//Mouse Support for this
			FlxG.mouse.visible = true;

			background = new FlxSprite(0, 0).loadGraphic(Paths.image('minigames/FTTBG'));
			background.antialiasing = ClientPrefs.globalAntialiasing;
			add(background);

			token = new FlxSprite(0, 0).loadGraphic(Paths.image('minigames/token'));
			token.screenCenter();
			token.y += 140;
			token.antialiasing = ClientPrefs.globalAntialiasing;
			add(token);

			cups = new FlxTypedGroup<FlxSprite>();
			add(cups);
			for (i in 0...3)
			{
				var cup = new FlxSprite(0, 0).loadGraphic(Paths.image('minigames/cup'));
				cup.screenCenter();
				cup.x = cupX[i];
				cup.ID = i;
				cup.y += 40;
				cup.antialiasing = ClientPrefs.globalAntialiasing;
				cups.add(cup);
				add(cup);
			}

			tokenFollow = FlxG.random.int(0, 2);
			token.x = cupX[tokenFollow] + 100;

			tipText = new FlxText(700, 960, FlxG.width, "Where did the token go?? You have a few seconds to memorize it's position, and then, select the cup that hides it!\nIf you win, you get 1 token EXTRA!", 24);
			tipText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
			tipText.screenCenter(XY);
			tipText.y += 290;
			tipText.borderSize = 3;
			tipText.alpha = 0;
			add(tipText);

			minigameTitle = new Alphabet(320, 10, "Find the Token!", true);
			minigameTitle.alpha = 0;
			add(minigameTitle);

			FlxTween.tween(minigameTitle, {alpha: 0.6}, 1.7, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(minigameTitle, {y: minigameTitle.y + 10}, 3.2, {ease: FlxEase.cubeInOut, type: PINGPONG});

			setUpFTT();
		}
		else if (minigame == 3)
		{
			//Mouse Support for this
			FlxG.mouse.visible = true;
			
			background = new FlxSprite(0, 0).loadGraphic(Paths.image('minigames/CFBG'));
			background.antialiasing = ClientPrefs.globalAntialiasing;
			add(background);

			var num:Int = FlxG.random.int(0, 4);
			cardNames.remove(cardNames[num]);

			cards = new FlxTypedGroup<FlxSprite>();
			add(cards);

			// Add each card to the stack three times
			for (cardName in cardNames)
			{
				shuffledCards.push(cardName);
				shuffledCards.push(cardName);
				shuffledCards.push(cardName);
			}

			// Shuffle the stack
			FlxG.random.shuffle(shuffledCards);

			for (i in 0...12)
			{
				var card = new FlxSprite(0, 0).loadGraphic(Paths.image('minigames/' + shuffledCards[i]));	
				card.screenCenter();
				card.ID = i;
				card.y += 15;
				card.x -= 110;
				if (card.ID == 0 || card.ID == 4 || card.ID == 8)
					card.x -= 220;
				else if (card.ID == 2 || card.ID == 6 || card.ID == 10)
					card.x += 220;
				else if (card.ID == 3 || card.ID == 7 || card.ID == 11)
					card.x += 440;

				if (card.ID >= 0 && card.ID <= 3)
					card.y -= 210;
				else if (card.ID >= 4 && card.ID <= 7)
				{
					// do Nothing to Height
				}	
				else
					card.y += 210;

				card.antialiasing = ClientPrefs.globalAntialiasing;
				cards.add(card);
				add(card);
			}

			cardsHidden = new FlxTypedGroup<FlxSprite>();
			add(cardsHidden);
			for (i in 0...12)
			{
				var card = new FlxSprite(0, 0).loadGraphic(Paths.image('minigames/backCard'));
				card.screenCenter();
				card.ID = i;
				card.y += 15;
				card.x -= 110;
				if (card.ID == 0 || card.ID == 4 || card.ID == 8)
					card.x -= 220;
				else if (card.ID == 2 || card.ID == 6 || card.ID == 10)
					card.x += 220;
				else if (card.ID == 3 || card.ID == 7 || card.ID == 11)
					card.x += 440;

				if (card.ID >= 0 && card.ID <= 3)
					card.y -= 210;
				else if (card.ID >= 4 && card.ID <= 7)
				{
					// do Nothing to Height
				}	
				else
					card.y += 210;

				card.antialiasing = ClientPrefs.globalAntialiasing;
				cardsHidden.add(card);
				add(card);
			}
			
			tipText = new FlxText(700, 960, FlxG.width, "Match all the flipped cards before the timer runs out!\nIf you win, you get 1 token EXTRA!", 24);
			tipText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
			tipText.screenCenter(XY);
			tipText.y += 290;
			tipText.borderSize = 3;
			tipText.alpha = 0;
			add(tipText);

			var selectTimer:Int = FlxG.random.int(1, 5);
			switch(selectTimer)
			{
				case 1:
					totalTime = 20;
				case 2:
					totalTime = 25;
				case 3:
					totalTime = 30;
				case 4:
					totalTime = 35;
				case 5:
					totalTime = 40;
			}
			
			timerTextLeft = new FlxText(10, 10, 200, "Time: " + totalTime);
			timerTextLeft.setFormat("VCR OSD Mono", 34, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			timerTextLeft.borderSize = 3;
			timerTextLeft.screenCenter(XY);
			timerTextLeft.x -= 520;
       		add(timerTextLeft);

			timerTextRight = new FlxText(10, 10, 200, "Time: " + totalTime);
			timerTextRight.setFormat("VCR OSD Mono", 34, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			timerTextRight.borderSize = 3;
			timerTextRight.screenCenter(XY);
			timerTextRight.x += 520;
       		add(timerTextRight);

			FlxTween.tween(tipText, {alpha: 1}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST});

        	gameTimer = new FlxTimer();
			var sound:Int = FlxG.random.int(1, 3);

			minigameTitle = new Alphabet(280, 10, "Match the Cards!", true);
			minigameTitle.alpha = 0;
			add(minigameTitle);

			countdown = new FlxSprite().loadGraphic(Paths.image('intros/normal/ready'));
			countdown.scrollFactor.set();
			countdown.updateHitbox();
			countdown.screenCenter(XY);

			new FlxTimer().start(3, function (tmr:FlxTimer) {
				FlxG.sound.play(Paths.sound('minigames/normalintros/' + sound + '/intro2'), 0.6);
				add(countdown);
				FlxTween.tween(countdown, {alpha: 0}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST});
			});
			new FlxTimer().start(4, function (tmr:FlxTimer) {
				FlxG.sound.play(Paths.sound('minigames/normalintros/' + sound + '/intro1'), 0.6);
				countdown.loadGraphic(Paths.image('intros/normal/set'));
				countdown.alpha = 1;
				FlxTween.tween(countdown, {alpha: 0}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST});
			});
			new FlxTimer().start(5, function (tmr:FlxTimer) {
				FlxG.sound.play(Paths.sound('minigames/normalintros/' + sound + '/introGo'), 0.6);
				countdown.loadGraphic(Paths.image('intros/normal/go'));
				countdown.alpha = 1;
				FlxTween.tween(countdown, {alpha: 0}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST});
				timer = new FlxTimer().start(0.7, fix);
			});

			FlxTween.tween(minigameTitle, {alpha: 0.6}, 1.7, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(minigameTitle, {y: minigameTitle.y + 10}, 3.2, {ease: FlxEase.cubeInOut, type: PINGPONG});
		}

		super.create();
	}

	function fix(timer:FlxTimer)
	{
		tipTween = FlxTween.tween(tipText, {alpha: 0}, 1.7, {ease: FlxEase.cubeInOut, type: PERSIST, onComplete: function(twn:FlxTween)
			{
				allowedToPlay = true;
				if (minigame == 2)
				{
					FlxG.sound.play(Paths.sound('confirmMenu'));
					changeSelection();
				}	
				if (minigame == 3)
				{
					tipText.text = "Go!";
		        	gameTimer.start(totalTime, onTimerComplete);
					FlxG.sound.play(Paths.sound('confirmMenu'), 0.6);
					changeSelection();
				}
			}
		});
	}

	var switchPos:FlxTimer;
	var switchPosAgain:FlxTimer;
	function setUpFTT()
	{
		cups.forEach(function(spr:FlxSprite)
		{
			FlxTween.tween(spr, {y: spr.y - 150}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		});

		FlxTween.tween(tipText, {alpha: 1}, 1.7, {ease: FlxEase.cubeInOut, type: PERSIST});

		new FlxTimer().start(5.5, function (tmr:FlxTimer) {
			cups.forEach(function(spr:FlxSprite)
			{
				FlxTween.tween(spr, {y: spr.y + 150}, 0.7, {ease: FlxEase.circOut, type: PERSIST, onComplete: function(twn:FlxTween)
					{
						switchPos = new FlxTimer().start(0.45, switchCups);
						new FlxTimer().start(FlxG.random.int(3, 6), function (tmr:FlxTimer) {
							token.alpha = 0;
							timer = new FlxTimer().start(1, fix);
						});
					}
				});
			});
		});
	}

	function switchCups(timer:FlxTimer)
	{	
		if (allowedToPlay == false)
		{
			// Shuffle the cupX array to determine the new X positions for the cups to tween
			cupX = shuffleArray(cupX);

			cups.forEach(function(spr:FlxSprite)
			{
				var newX = cupX[spr.ID];
				
				// Tween the cup to the new X position
				FlxTween.tween(spr, {x: newX}, 0.3, {ease: FlxEase.cubeInOut, type: PERSIST});
			});
			FlxTween.tween(token, {x: cupX[tokenFollow] + 100}, 0.3, {ease: FlxEase.cubeInOut, type: PERSIST});
			switchPosAgain = new FlxTimer().start(0.4, switchCupsRepeat);
		}
	}

	function switchCupsRepeat(timer:FlxTimer)
		{
			if (allowedToPlay == false)
			{
				// Shuffle the cupX array to determine the new X positions for the cups to tween
				cupX = shuffleArray(cupX);
					
				cups.forEach(function(spr:FlxSprite)
				{	
					var newX = cupX[spr.ID];
				
					// Tween the cup to the new X position
					FlxTween.tween(spr, {x: newX}, 0.3, {ease: FlxEase.cubeInOut, type: PERSIST});
				});
				FlxTween.tween(token, {x: cupX[tokenFollow] + 50}, 0.3, {ease: FlxEase.cubeInOut, type: PERSIST});
				switchPos = new FlxTimer().start(0.4, switchCups);
			}
		}

	var flipped:Bool = false;
	var selectedSomethin:Bool = false;
	var selection:Int = 0;
	override function update(elapsed:Float)
	{
		if (minigame == 1)
		{
			if (allowedToPlay == true)
			{
					if (controls.UI_LEFT_P)
						changeSelection(-1);
					if (controls.UI_RIGHT_P)
						changeSelection(1);
			
					if (controls.ACCEPT && flipped == false)
					{
						flipped = true;
						coin.animation.play('flip');
			
						if (timer != null)
							timer.cancel();
			
						if (tipTween != null)
							tipTween.cancel();
			
						FlxTween.tween(tipText, {alpha: 0}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(coin.scale, {x: 1.3, y: 1.3}, 1.2, {ease: FlxEase.circOut, type: PERSIST, onComplete: function(twn:FlxTween)
							{
								FlxTween.tween(coin.scale, {x: 1, y: 1}, 1.2, {ease: FlxEase.circIn, type: PERSIST, onComplete: function(twn:FlxTween)
									{
										setCoinLand();
									}
								});
							}
						});
					}
			}
		}
		else if (minigame == 2)
		{
			if (allowedToPlay == true)
			{
				if (selectedSomethin == false)
					cups.forEach(function(spr:FlxSprite)
					{
						if (FlxG.mouse.overlaps(spr))
							switch(spr.ID)
							{
								case 0:
									changeSelection(0);
								case 1:
									changeSelection(1);
								case 2:
									changeSelection(2);
							}
						
					});
			
					if (FlxG.mouse.justPressed && selectedSomethin == false)
					{
						selectedSomethin = true;
						token.alpha = 1;

						if (tipTween != null)
							tipTween.cancel();

						cups.forEach(function(spr:FlxSprite)
						{
							spr.alpha = 1;
							if (spr.ID == selection)
								FlxTween.tween(spr, {y: spr.y - 150}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
							else
							{
								new FlxTimer().start(1, function (tmr:FlxTimer) {
									FlxTween.tween(spr, {y: spr.y - 150}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
								});
							}
						});
			
						if (tokenFollow == selection)
						{
							tipText.text = "Congratulations! You found the token! Your prize has been added in!";
							FlxG.sound.play(Paths.sound('hooray'), 0.5);

							if (PlayState.isStoryMode == true)
							{
								ClientPrefs.tokens += 1;
								ClientPrefs.tokensAchieved += 1;
							}
							else
								ClientPrefs.tokensAchieved += 1;
						}
						else
						{
							tipText.text = "Better luck next time!";
							FlxG.sound.play(Paths.sound('awh'), 0.5);
						}

						FlxTween.tween(tipText, {alpha: 1}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST});

						new FlxTimer().start(3, function (tmr:FlxTimer) {
							FlxG.mouse.visible = false;
							FlxG.sound.music.fadeOut(1);
							LoadingState.loadAndSwitchState(new PlayState());
						});
					}
			}
		}
		else if (minigame == 3)
		{
			if (allowedToPlay == true)
			{
				timerTextLeft.text = "Time: " + Math.ceil(gameTimer.timeLeft);
				timerTextRight.text = "Time: " + Math.ceil(gameTimer.timeLeft);
				if (selectedSomethin == false)
					cardsHidden.forEach(function(spr:FlxSprite)
					{
						if (FlxG.mouse.overlaps(spr))
							switch(spr.ID)
							{
								case 0:
									changeSelection(0);
								case 1:
									changeSelection(1);
								case 2:
									changeSelection(2);
								case 3:
									changeSelection(3);
								case 4:
									changeSelection(4);
								case 5:
									changeSelection(5);
								case 6:
									changeSelection(6);
								case 7:
									changeSelection(7);
								case 8:
									changeSelection(8);
								case 9:
									changeSelection(9);
								case 10:
									changeSelection(10);
								case 11:
									changeSelection(11);
							}
					});
				
					if (FlxG.mouse.justPressed && selectedSomethin == false)
					{
						selectedSomethin = true;
						FlxG.sound.play(Paths.sound('minigames/flipCard'));

						cardsHidden.forEach(function(spr:FlxSprite)
						{
							if (spr.ID == selection)
								flippedCardFix(spr);
						});
						cards.forEach(function(spr:FlxSprite)
						{
							if (spr.ID == selection)
								onCardSelected(spr);
						});
					}
			}
		}
		super.update(elapsed);
	}

	function onTimerComplete(timer:FlxTimer):Void
	{
		allowedToPlay = false;
		FlxG.sound.play(Paths.sound('awh'), 0.5);

		timerTextLeft.text = "Time: 0";
		timerTextRight.text = "Time: 0";
		timerTextLeft.color = FlxColor.RED;
		timerTextRight.color = FlxColor.RED;

		tipText.text = "Uh oh! The timer ran out!\nBetter Luck Next Time!";
		FlxTween.tween(tipText, {alpha: 1}, 1, {ease: FlxEase.cubeInOut, type: PERSIST});
		
		new FlxTimer().start(3, function (tmr:FlxTimer) {
			FlxG.mouse.visible = false;
			FlxG.sound.music.fadeOut(1);
			LoadingState.loadAndSwitchState(new PlayState());
		});

		trace("Time's up!");
	}

	var isCancelled:Bool = false;
	function flippedCardFix(card:FlxSprite)
	{
		// Add the card to the selectedCards array
		selectedBlankCards.push(card);
		// Check if the card is already flipped or matched
		if (card.scale.x == 0)
		{
			trace("Already clicked it.");
			isCancelled = true;
			return;
		}
		else
			FlxTween.tween(card.scale, {x: 0}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
	}

	function onCardSelected(card:FlxSprite)
	{
		if (isCancelled)
		{
			trace("Cancelling Function!");
			isCancelled = false;
			selectedSomethin = false;
			return;
		}
		// Add the card to the selectedCards array
		selectedCards.push(card);

		 // Check if two or three cards have been selected
		 if (selectedCards.length == 1)
			selectedSomethin = false;
		 else if (selectedCards.length == 2) {
			// If two cards are selected, check for a match
			checkForMatch();
		} else if (selectedCards.length == 3) {
			// If three cards are selected, check for a match and update the game stats
			checkForMatch();
			//updateGameState();
		}
	}

	function checkForMatch()
	{
		// Ensure there are exactly two or three cards selected
		if (selectedCards.length != 2 && selectedCards.length != 3) {
			return;
		}
	
		/// Get the sprites for the selected cards
		var sprite1:String = getImageKey(selectedCards[0]);
		var sprite2:String = getImageKey(selectedCards[1]);
		var sprite3:String = (selectedCards.length == 3) ?  getImageKey(selectedCards[2]) : null;

		// Debug prints to check the values of image keys
		trace("Image Key 1: " + sprite1);
		trace("Image Key 2: " + sprite2);
		trace("Image Key 3: " + sprite3);

		// Compare the images of the selected cards
		var areImagesEqual:Bool = false;
		var numOfCards:Int = 0;
	
		if (sprite3 == null) {
			// Compare two cards
			trace("Checking 2 cards..");
			if (sprite1 == sprite2)
			{
				areImagesEqual = true;
				numOfCards = 2;
			}
		} else {
			// Compare three cards
			trace("Checking 3 cards..");
			if (sprite1 == sprite2 && sprite2 == sprite3)
			{
				areImagesEqual = true;
				numOfCards = 3;
			}
		}
	
		// Handle the logic based on whether the images match or not
		if (areImagesEqual) {
			// Handle successful match
			trace('Calling Successful Match');
			handleSuccessfulMatch(numOfCards);
		} else {
			// Handle failed match
			trace('Calling Failed Match');
			handleFailedMatch();
		}
	}

	function handleFailedMatch(){
		FlxG.sound.play(Paths.sound('accessDenied'));
		trace('You suck lmao');
	
		// Reset selected cards after a delay
		new FlxTimer().start(1, function(timer:FlxTimer) {
			cardsHidden.forEach(function(spr:FlxSprite)
			{
				fixCards(spr);
			});
		});
		
	}

	function fixCards(card:FlxSprite)
	{
		for (card in selectedBlankCards) {
			FlxTween.tween(card.scale, {x: 1}, 0.7, {ease: FlxEase.circOut, type: PERSIST});
		}
		selectedBlankCards = [];
		selectedCards = [];
		new FlxTimer().start(0.8, function(timer:FlxTimer) {
			selectedSomethin = false;
		});
	}

	function handleSuccessfulMatch(numOfCards:Int)
	{
		if (numOfCards == 2)
			trace('You Matched 2 cards!');
		else
			trace('You Matched 3 cards!');
	
		// Reset selected cards
		if (selectedCards.length == 3 && numOfCards == 3)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			matchedPairs++;
			selectedBlankCards = [];
			selectedCards = [];
			trace('resetting!');
			trace("Matched Pairs:", matchedPairs, "Total Pairs:", shuffledCards.length / 3);
		}
	
		if (matchedPairs == shuffledCards.length / 3) 
		{
			trace("Minigame Finished!");
			tipText.text = "Congratulations! You matched all the cards! Your prize has been added in!";
			FlxTween.tween(tipText, {alpha: 1}, 0.7, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxG.sound.play(Paths.sound('hooray'), 0.5);

			gameTimer.active = false;

			timerTextLeft.color = FlxColor.GREEN;
			timerTextRight.color = FlxColor.GREEN;

			if (PlayState.isStoryMode == true)
			{
				ClientPrefs.tokens += 1;
				ClientPrefs.tokensAchieved += 1;
			}
			else
				ClientPrefs.tokensAchieved += 1;

			new FlxTimer().start(3, function (tmr:FlxTimer) {
				FlxG.mouse.visible = false;
				FlxG.sound.music.fadeOut(1);
				LoadingState.loadAndSwitchState(new PlayState());
			});
		}
		else
			selectedSomethin = false;
	}

	private function getImageKey(sprite:FlxSprite):String {
		// Retrieve the image key for the sprite
		return sprite.graphic.assetsKey;
	}

	function changeSelection(huh:Int = 0)
	{
		if (minigame == 1)
		{
			selection += huh;

			if (selection > 1)
				selection = 0;
			if (selection < 0)
				selection = 1;
	
			if (selection == 0)
				answer.text = 'Heads';
			if (selection == 1)
				answer.text = 'Tails';
		}
		else if (minigame == 2)
		{
			selection = huh;

			if (selection > 2)
				selection = 0;
			if (selection < 0)
				selection = 2;

			cups.forEach(function(spr:FlxSprite)
			{
				if (selection != spr.ID)
					spr.alpha = 0.6; 
				else
					spr.alpha = 1;
			});
		}
		else if (minigame == 3)
		{
			selection = huh;

			if (selection > 11)
				selection = 0;
			if (selection < 0)
				selection = 11;

			cardsHidden.forEach(function(hiddenCard:FlxSprite)
			{
				if (selection != hiddenCard.ID)
					hiddenCard.alpha = 1; 
				else
					hiddenCard.alpha = 0.6;
			});
		}
	}

	function setCoinLand()
	{
		if (flipnum == 0)
			coin.animation.play('heads');
		else if (flipnum == 1)
			coin.animation.play('tails');

		if (flipnum == 0 && selection == 0)
		{
			trace('Heads!');
			FlxG.sound.play(Paths.sound('hooray'), 0.5);

			ClientPrefs.tokensAchieved += 1;

			tipText.text = "You guessed HEADS correctly! Your Prize has been added in!";
		}	
		else if (flipnum == 1 && selection == 1)
		{
			trace('Tails!');
			FlxG.sound.play(Paths.sound('hooray'), 0.5);
			
			ClientPrefs.tokensAchieved += 1;

			tipText.text = "You guessed TAILS correctly! Your Prize has been added in!";

		}
		else if (flipnum == 0 && selection == 1)
		{
			trace('NOT A MATCH!');
			FlxG.sound.play(Paths.sound('awh'), 0.5);
			tipText.text = "Incorrect Answer! Better Luck Next Time!";
		}	
		else if (flipnum == 1 && selection == 0)
		{
			trace('NOT A MATCH!');
			FlxG.sound.play(Paths.sound('awh'), 0.5);
			tipText.text = "Incorrect Answer! Better Luck Next Time!";
		}

		FlxTween.tween(tipText, {alpha: 1}, 1, {ease: FlxEase.cubeInOut, type: PERSIST});

		new FlxTimer().start(3, function (tmr:FlxTimer) {
			FlxG.mouse.visible = false;
			FlxG.sound.music.fadeOut(1);
			LoadingState.loadAndSwitchState(new PlayState());
		});
	}

	private function shuffleArray<T>(array:Array<T>):Array<T>
		{
			var currentIndex = array.length;
			var temporaryValue:T;
			var randomIndex:Int;
	
			// While there remain elements to shuffle...
			while (currentIndex != 0)
			{
				// Pick a remaining element...
				randomIndex = Math.floor(Math.random() * currentIndex);
				currentIndex--;
	
				// And swap it with the current element.
				temporaryValue = array[currentIndex];
				array[currentIndex] = array[randomIndex];
				array[randomIndex] = temporaryValue;
			}
	
			return array;
		}
}