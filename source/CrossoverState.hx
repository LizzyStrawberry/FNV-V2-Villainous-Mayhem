package;

#if desktop
import Discord.DiscordClient;
#end
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
import Alphabet;
#if MODS_ALLOWED
import sys.FileSystem;
#end

import flash.system.System;

class CrossoverState extends MusicBeatState
{
	var curSelected:Int = 0;
	var teleporter:FlxSprite;
	var effects:FlxSprite;
	var selectors:FlxSprite;
	var selection1:FlxSprite;
	var selection2:FlxSprite;
	var selection3:FlxSprite;
	var selection4:FlxSprite;
	var selection5:FlxSprite;
	var blackOut:FlxSprite;
	var whiteOut:FlxSprite;
	var tipText:FlxText;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Work In Progress...", null);
		#end

		FlxG.sound.playMusic(Paths.music('ambience'), 0);
		FlxG.sound.music.fadeIn(4.0);

		effects = new FlxSprite(370, 40).loadGraphic(Paths.image('crossRoadMap/tpEffects'));
		effects.frames = Paths.getSparrowAtlas('crossRoadMap/tpEffects');
		effects.scale.set(2, 2);
		effects.animation.addByPrefix('effects', 'tpeffects0', 24, true);
		effects.animation.play('effects');
		effects.scrollFactor.set();
		effects.antialiasing = ClientPrefs.globalAntialiasing;
		add(effects);

		teleporter = new FlxSprite(500, 220).loadGraphic(Paths.image('crossRoadMap/roadMap'));
		teleporter.frames = Paths.getSparrowAtlas('crossRoadMap/roadMap');
		teleporter.scale.set(1, 1);
		teleporter.animation.addByPrefix('roadMap', 'roadMap0', 24, true);
		teleporter.animation.play('roadMap');
		teleporter.scrollFactor.set();
		teleporter.antialiasing = ClientPrefs.globalAntialiasing;
		add(teleporter);

		selection1 = new FlxSprite(170, 400).loadGraphic(Paths.image('crossRoadMap/selection'));
		selection1.antialiasing = ClientPrefs.globalAntialiasing;
		add(selection1);

		selection2 = new FlxSprite(370, 150).loadGraphic(Paths.image('crossRoadMap/selection'));
		selection2.antialiasing = ClientPrefs.globalAntialiasing;
		add(selection2);

		selection3 = new FlxSprite(570, 400).loadGraphic(Paths.image('crossRoadMap/selection'));
		selection3.antialiasing = ClientPrefs.globalAntialiasing;
		add(selection3);

		selection4 = new FlxSprite(770, 150).loadGraphic(Paths.image('crossRoadMap/selection'));
		selection4.antialiasing = ClientPrefs.globalAntialiasing;
		add(selection4);

		selection5 = new FlxSprite(970, 400).loadGraphic(Paths.image('crossRoadMap/selection'));
		selection5.antialiasing = ClientPrefs.globalAntialiasing;
		add(selection5);

		tipText = new FlxText(700, 960, FlxG.width, "The teleporter has gone unstable.\nYou can only press ENTER to dive in.\nEach Crystal will be unlocked and completed as you move on.\nIf you wish to go back, press BACKSPACE.", 24);
		tipText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER);
		tipText.screenCenter(XY);
		tipText.y += 290;
		tipText.alpha = 0;
		add(tipText);

		selectors = new FlxSprite(selection1.x - 20, selection1.y + 44).loadGraphic(Paths.image('crossRoadMap/selectors'));
		selectors.antialiasing = ClientPrefs.globalAntialiasing;
		add(selectors);

		whiteOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFFFFFFFF);
		whiteOut.alpha = 0;
		add(whiteOut);

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 1;
		add(blackOut);

		changeSelection();
		
		if (endSequence == false)
		{
			FlxTween.tween(blackOut, {alpha: 0}, 4.7, {ease: FlxEase.cubeInOut, type: PERSIST});
			new FlxTimer().start(4, function(tmr:FlxTimer)
			{
				FlxTween.tween(tipText, {alpha: 1}, 2.7, {ease: FlxEase.cubeInOut, type: PERSIST});
				new FlxTimer().start(14, function(tmr:FlxTimer)
				{
					FlxTween.tween(tipText, {alpha: 0}, 4.7, {ease: FlxEase.cubeInOut, type: PERSIST});
				});
			});
		}
		else if (endSequence == true)
		{
			FlxTween.tween(blackOut, {alpha: 0}, 2.7, {ease: FlxEase.cubeInOut, type: PERSIST});
		}

		super.create();
	}

	var selectedSomething:Bool = false;
	var endSequence = false;
	override function update(elapsed:Float)
	{
		if (!selectedSomething)
		{
			if (controls.BACK || FlxG.mouse.justPressedRight)
			{
				selectedSomething = true;
				FlxG.sound.music.fadeOut(3.0);
				FlxTween.tween(blackOut, {alpha: 1}, 3, {ease: FlxEase.cubeInOut, type: PERSIST});
				ClientPrefs.onCrossSection = false;
				ClientPrefs.saveSettings();
				FlxG.sound.play(Paths.sound('cancelMenu'));
				new FlxTimer().start(3, function(tmr:FlxTimer)
				{
					FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
					FlxG.sound.music.fadeIn(2.0);
					MusicBeatState.switchState(new StoryMenuState());
				});
			}

			if(controls.ACCEPT)
			{
				selectedSomething = true;
				selectSong();
			}

			if (endSequence == true)
			{
				selectedSomething = true;
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxG.sound.play(Paths.sound('teleporterOverload'));
					FlxG.camera.shake(0.01, 10.3, null, false, FlxAxes.XY);
					FlxTween.tween(whiteOut, {alpha: 1}, 10.3, {ease: FlxEase.cubeIn, type: PERSIST});
				});
				new FlxTimer().start(11.3, function(tmr:FlxTimer)
				{
					FlxTween.tween(blackOut, {alpha: 1}, 2.0, {ease: FlxEase.circOut, type: PERSIST});
				});
				new FlxTimer().start(12.3, function(tmr:FlxTimer)
				{
					FlxG.sound.music.fadeOut(2.0);
				});
				new FlxTimer().start(15.5, function(tmr:FlxTimer)
				{
					ClientPrefs.onCrossSection = false;
					ClientPrefs.roadMapUnlocked = false;
					ClientPrefs.crossoverUnlocked = true;
					ClientPrefs.saveSettings();

					if (ClientPrefs.iniquitousWeekUnlocked == true && ClientPrefs.iniquitousWeekBeaten == false)
						FlxG.sound.playMusic(Paths.music('malumIctum'));
					else if (FlxG.random.int(1, 10) == 2)
						FlxG.sound.playMusic(Paths.music('AJDidThat'));
					else
						FlxG.sound.playMusic(Paths.music('freakyMenu'));
					FlxG.sound.music.fadeIn(2.0);
					MusicBeatState.switchState(new StoryMenuState());
				});
			}
		}

		super.update(elapsed);
	}

	function selectSong()
	{
		FlxG.sound.play(Paths.sound('confirmMenu'));
		switch(curSelected)
		{
			case 0:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('vguy', 'vguy');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('vguy-villainous', 'vguy');
				PlayState.storyDifficulty = ClientPrefs.storyModeCrashDifficultyNum;
				FlxFlicker.flicker(selection1, 1, 0.04, false);
			case 1:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('fast-food-therapy', 'fast-food-therapy');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('fast-food-therapy-villainous', 'fast-food-therapy');
				PlayState.storyDifficulty = ClientPrefs.storyModeCrashDifficultyNum;
				FlxFlicker.flicker(selection2, 1, 0.04, false);
			case 2:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('tactical-mishap', 'tactical-mishap');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('tactical-mishap-villainous', 'tactical-mishap');
				PlayState.storyDifficulty = ClientPrefs.storyModeCrashDifficultyNum;
				FlxFlicker.flicker(selection3, 1, 0.04, false);
			case 3:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('breacher', 'breacher');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('breacher-villainous', 'breacher');
				PlayState.storyDifficulty = ClientPrefs.storyModeCrashDifficultyNum;
				FlxFlicker.flicker(selection4, 1, 0.04, false);
			case 4:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('concert-chaos', 'concert-chaos');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('concert-chaos-villainous', 'concert-chaos');
				PlayState.storyDifficulty = ClientPrefs.storyModeCrashDifficultyNum;
				FlxFlicker.flicker(selection5, 1, 0.04, false);
		}
		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxG.sound.music.volume = 0;
		ClientPrefs.inMenu = false;
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			LoadingState.loadAndSwitchState(new PlayState());
		});
	}

	function changeSelection()
	{
		if (ClientPrefs.storyModeCrashDifficultyNum == 1) //FOR VILLAINOUS MODE
		{
			if (ClientPrefs.ourpleFound == true) //	FIRST SONG
				curSelected = 0;
			if (ClientPrefs.ourplePlayed == true && Achievements.isAchievementUnlocked('vGuy_Beaten')) //SECOND SONG
				curSelected = 1;
			if (ClientPrefs.kyuPlayed == true && Achievements.isAchievementUnlocked('fastFoodTherapy_Beaten')) //THIRD SONG
				curSelected = 2;
			if (ClientPrefs.tacticalMishapPlayed == true && Achievements.isAchievementUnlocked('tacticalMishap_Beaten')) // FOURTH SONG
				curSelected = 3;
			if (ClientPrefs.breacherPlayed == true && Achievements.isAchievementUnlocked('breacher_Beaten')) //FIFTH SONG
				curSelected = 4;
			if (ClientPrefs.ccPlayed == true && Achievements.isAchievementUnlocked('concertChaos_Beaten')) //END
				curSelected = 5;
		}
		else
		{
			if (ClientPrefs.ourpleFound == true)
				curSelected = 0;
			if (ClientPrefs.ourplePlayed == true)
				curSelected = 1;
			if (ClientPrefs.kyuPlayed == true)
				curSelected = 2;
			if (ClientPrefs.tacticalMishapPlayed == true)
				curSelected = 3;
			if (ClientPrefs.breacherPlayed == true)
				curSelected = 4;
			if (ClientPrefs.ccPlayed == true)
				curSelected = 5;
		}

		if (curSelected == 5)
			endSequence = true;

		switch(curSelected)
		{
			case 0:
				selectors.x = selection1.x - 20;
				selectors.y = selection1.y + 44;
				selection1.loadGraphic(Paths.image('crossRoadMap/selectionSelected'));
				selection2.loadGraphic(Paths.image('crossRoadMap/selection'));
				selection3.loadGraphic(Paths.image('crossRoadMap/selection'));
				selection4.loadGraphic(Paths.image('crossRoadMap/selection'));
				selection5.loadGraphic(Paths.image('crossRoadMap/selection'));
			case 1:
				selectors.x = selection2.x - 20;
				selectors.y = selection2.y + 44;
				selection1.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection2.loadGraphic(Paths.image('crossRoadMap/selectionSelected'));
				selection3.loadGraphic(Paths.image('crossRoadMap/selection'));
				selection4.loadGraphic(Paths.image('crossRoadMap/selection'));
				selection5.loadGraphic(Paths.image('crossRoadMap/selection'));
			case 2:
				selectors.x = selection3.x - 20;
				selectors.y = selection3.y + 44;
				selection1.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection2.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection3.loadGraphic(Paths.image('crossRoadMap/selectionSelected'));
				selection4.loadGraphic(Paths.image('crossRoadMap/selection'));
				selection5.loadGraphic(Paths.image('crossRoadMap/selection'));
			case 3:
				selectors.x = selection4.x - 20;
				selectors.y = selection4.y + 44;
				selection1.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection2.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection3.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection4.loadGraphic(Paths.image('crossRoadMap/selectionSelected'));
				selection5.loadGraphic(Paths.image('crossRoadMap/selection'));
			case 4:
				selectors.x = selection5.x - 20;
				selectors.y = selection5.y + 44;
				selection1.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection2.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection3.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection4.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection5.loadGraphic(Paths.image('crossRoadMap/selectionSelected'));
			case 5:
				selectors.alpha = 0;
				selection1.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection2.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection3.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection4.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
				selection5.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
		}
	}
}