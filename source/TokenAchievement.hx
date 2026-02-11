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

	var soundPlayed:Bool = false;
	var bonusSoundPlayed:Bool = false;
	var tweenPlayed:Bool = false;
	var twn:FlxTween;

	override function create()
	{
		tokenSub = ClientPrefs.tokens;
		if (tokenSub < 0) tokenSub = 0;

		currentTokens = new FlxText(FlxG.width - 910, FlxG.height - 570, FlxG.width, "Current Tokens: " + tokenSub, 48);
		currentTokens.alpha = 0;
		
		tokenIcon = new FlxSprite(FlxG.width - 830, FlxG.height - 220).loadGraphic(Paths.image('tokensAchieved'));
		tokenIcon.frames = Paths.getSparrowAtlas('tokensAchieved');
		tokenIcon.y -= 300;
		tokenIcon.scale.set(0.8, 0.8);
		tokenIcon.alpha = 0.001;
		tokenIcon.animation.addByPrefix('show', 'token0', 24, true);
		tokenIcon.scrollFactor.set();
		tokenIcon.updateHitbox();
		tokenIcon.antialiasing = ClientPrefs.globalAntialiasing;

		if (!PlayState.checkForPowerUp)
		{
			bonusTokens = new FlxText(FlxG.width - 940, FlxG.height - 590, FlxG.width, "No Power Up Bonus! -> +3", 40);
			bonusTokens.alpha = 0;
			bonusTokens.color = FlxColor.YELLOW;
		}

		bgGradient = new FlxSprite(FlxG.width - 1180, 0).loadGraphic(Paths.image('pauseGradient/gradient_Null'));
		bgGradient.color = 0xFF00a800;
		bgGradient.setGraphicSize(FlxG.width, FlxG.height);
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

		tokenIcon.animation.play('show');

		ClientPrefs.tokens += ClientPrefs.tokensAchieved;

		new FlxTimer().start(2.5, function (_)
		{
			currentTokens.text = "Current Tokens: " + ClientPrefs.tokens;
			
			if (!soundPlayed)
			{
				FlxG.sound.play(Paths.sound('tokensAchieved'));

				currentTokens.scale.x = currentTokens.scale.y = 1.075;
				tokenIcon.scale.x = tokenIcon.scale.y = 0.975;

				twn = FlxTween.tween(currentTokens.scale, {x: 1, y: 1}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
				FlxTween.tween(tokenIcon.scale, {x: 0.8, y: 0.8}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
				soundPlayed = true;
			}

			if (!PlayState.checkForPowerUp)
			{
				new FlxTimer().start(0.6, function (_) 
				{
					if (!bonusSoundPlayed)
					{
						ClientPrefs.tokens += 3;
						currentTokens.text = "Current Tokens: " + ClientPrefs.tokens;

						if (twn != null) twn.cancel();
		
						FlxG.sound.play(Paths.sound('bonusTokens'));

						bonusTokens.alpha = 1;
						bonusTokens.scale.x = bonusTokens.scale.y = 1.075;
						currentTokens.scale.x = currentTokens.scale.y = 1.075;
						tokenIcon.scale.x = tokenIcon.scale.y = 0.975;
		
						FlxTween.tween(bonusTokens, {alpha: 0, y: bonusTokens.y - 30, "scale.x": 1, "scale.y": 1}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
						FlxTween.tween(currentTokens.scale, {x: 1, y: 1}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
						FlxTween.tween(tokenIcon.scale, {x: 0.8, y: 0.8}, 0.6, {ease: FlxEase.cubeOut, type: PERSIST});
						bonusSoundPlayed = true;
					}
				});
			}

			new FlxTimer().start(2, function (_) 
			{
				trail.alpha = 0;
				if (!tweenPlayed)
				{
					FlxTween.tween(tokenIcon, {alpha: 0, y: tokenIcon.y - 100}, 1, {ease: FlxEase.quadInOut, type: PERSIST});
					FlxTween.tween(currentTokens, {alpha: 0}, 0.6, {ease: FlxEase.quadInOut, type: PERSIST});
					tweenPlayed = true;
				}

				new FlxTimer().start(0.7, function (_) 
				{
					ClientPrefs.tokensAchieved = 0;
					if (!ClientPrefs.onCrossSection) ClientPrefs.crashDifficulty = -1;
					ClientPrefs.saveSettings();
					if (editors.MasterEditorMenu.debugCheck)
					{
						MusicBeatState.switchState(new editors.MasterEditorMenu());
						editors.MasterEditorMenu.debugCheck = false;
					}
					else MusicBeatState.switchState(new ResultsScreenState());
				});
			});
		});
	}
}