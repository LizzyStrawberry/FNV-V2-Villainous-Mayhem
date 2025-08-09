package;

import lime.app.Application;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.graphics.frames.FlxAtlasFrames;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxGridOverlay;
import openfl.utils.Assets as OpenFlAssets;

class TokenAchievement extends MusicBeatState
{
	var currentTokens:FlxText;
	var tokenIcon:FlxSprite;
	var tokenSub:Int = 0;
	var bgGradient:FlxSprite;
	var trail:FlxTrail;
	var bonusTokens:FlxText;

	override function create()
	{
		tokenSub = ClientPrefs.tokens;

		if (tokenSub < 0)
			tokenSub = 0;
		currentTokens = new FlxText(370, 150, FlxG.width, "Current Tokens: " + tokenSub, 48);

		currentTokens.alpha = 0;
		
		tokenIcon = new FlxSprite(450, 500).loadGraphic(Paths.image('tokensAchieved'));//put your cords and image here
		tokenIcon.frames = Paths.getSparrowAtlas('tokensAchieved');//here put the name of the xml
		tokenIcon.y -= 300;
		tokenIcon.scale.set(0.8, 0.8);
		tokenIcon.alpha = 0;
		tokenIcon.animation.addByPrefix('show', 'token0', 24, true);//on 'idle normal' change it to your xml one
		tokenIcon.scrollFactor.set();
		tokenIcon.updateHitbox();
		tokenIcon.antialiasing = ClientPrefs.globalAntialiasing;

		if (!PlayState.checkForPowerUp)
		{
			bonusTokens = new FlxText(340, 130, FlxG.width, "No Power Up Bonus! -> +3", 40);
			bonusTokens.alpha = 0;
			bonusTokens.color = FlxColor.YELLOW;
		}

		bgGradient = new FlxSprite(0, 0).loadGraphic(Paths.image('pauseGradient/gradient_Null'));
		bgGradient.color = 0xFF00a800;
		bgGradient.x = 100;
		bgGradient.scale.x = 1.3;
		bgGradient.scale.y = 1.1;
		bgGradient.alpha = 0.6;
		bgGradient.scrollFactor.set();
		
		add(bgGradient);
		add(tokenIcon);
		add(currentTokens);
		add(bonusTokens);

		trail = new FlxTrail(tokenIcon, null, 2, 3, 0.3, 0.069); //nice
		add(trail);

		super.create();

		FlxTween.tween(currentTokens, {alpha: 1}, 0.6, {ease: FlxEase.quadInOut, type: PERSIST});
		FlxTween.tween(tokenIcon, {y: tokenIcon.y + 100}, 0.6, {ease: FlxEase.quadInOut, type: PERSIST});
		FlxTween.tween(tokenIcon, {alpha: 1}, 0.6, {ease: FlxEase.quadInOut, type: PERSIST});
		FlxTween.tween(bgGradient, {alpha: 0.3}, 1.2, {ease: FlxEase.quadInOut, type: PINGPONG});

		tokenIcon.animation.play('show');//you can rename the anim however you want to

		new FlxTimer().start(2.5, function (tmr:FlxTimer) {
			ClientPrefs.tokens += ClientPrefs.tokensAchieved;
		});
	}

	var soundPlayed:Bool = false;
	var bonusSoundPlayed:Bool = false;
	var tweenPlayed:Bool = false;
	var twn:FlxTween;
	override function update(elapsed:Float)
	{
		new FlxTimer().start(2.5, function (tmr:FlxTimer) {
			currentTokens.text = "Current Tokens: " + ClientPrefs.tokens;
			
			if (!soundPlayed)
			{
				FlxG.sound.play(Paths.sound('tokensAchieved'));

				currentTokens.scale.x = 1.075;
				currentTokens.scale.y = 1.075;

				tokenIcon.scale.x = 0.975;
				tokenIcon.scale.y = 0.975;

				twn = FlxTween.tween(currentTokens.scale, {x: 1, y: 1}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
				FlxTween.tween(tokenIcon.scale, {x: 0.8, y: 0.8}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
				soundPlayed = true;
			}

			if (!PlayState.checkForPowerUp)
			{
				new FlxTimer().start(0.6, function (tmr:FlxTimer) {
					if (!bonusSoundPlayed)
					{
						ClientPrefs.tokens += 3;
						currentTokens.text = "Current Tokens: " + ClientPrefs.tokens;

						if (twn != null)
							twn.cancel();
		
						FlxG.sound.play(Paths.sound('bonusTokens'));
						bonusTokens.alpha = 1;
						bonusTokens.scale.x = 1.075;
						bonusTokens.scale.y = 1.075;

						currentTokens.scale.x = 1.075;
						currentTokens.scale.y = 1.075;
		
						tokenIcon.scale.x = 0.975;
						tokenIcon.scale.y = 0.975;
		
						FlxTween.tween(bonusTokens, {alpha: 0, y: bonusTokens.y - 30, "scale.x": 1, "scale.y": 1}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
						FlxTween.tween(currentTokens.scale, {x: 1, y: 1}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
						FlxTween.tween(tokenIcon.scale, {x: 0.8, y: 0.8}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
						bonusSoundPlayed = true;
					}
				});
			}

			new FlxTimer().start(2, function (tmr:FlxTimer) {
				trail.alpha = 0;
				if (!tweenPlayed)
				{
					FlxTween.tween(tokenIcon, {alpha: 0, y: tokenIcon.y - 100}, 1, {ease: FlxEase.quadInOut, type: PERSIST});
					FlxTween.tween(currentTokens, {alpha: 0}, 0.6, {ease: FlxEase.quadInOut, type: PERSIST});
					tweenPlayed = true;
				}

				new FlxTimer().start(0.7, function (tmr:FlxTimer) {
					ClientPrefs.tokensAchieved = 0;
					if (ClientPrefs.onCrossSection == false)
						ClientPrefs.storyModeCrashDifficultyNum = -1;
					ClientPrefs.saveSettings();
					if (editors.MasterEditorMenu.debugCheck)
					{
						MusicBeatState.switchState(new editors.MasterEditorMenu(), "stickers");
						editors.MasterEditorMenu.debugCheck = false;
					}
					else
						MusicBeatState.switchState(new ResultsScreenState(), "stickers");
				});
			});
		});
		super.update(elapsed);
	}
}

