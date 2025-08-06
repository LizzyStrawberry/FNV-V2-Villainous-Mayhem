package;

import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.addons.text.FlxTypeText;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;

import editors.ChartingState;
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import openfl.utils.Assets as OpenFlAssets;
import Alphabet;

import flash.system.System;

class CrossoverState extends MusicBeatState
{
	var curSelected:Int = 0;
	var teleporter:FlxSprite;
	var effects:FlxSprite;
	var selectors:FlxSprite;
	var selections:FlxTypedGroup<FlxSprite>;
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

		selections = new FlxTypedGroup<FlxSprite>();
		add(selections);

		for (i in 0...6)
		{
			var selection:FlxSprite = new FlxSprite().loadGraphic(Paths.image('crossRoadMap/selection'));
			selection.antialiasing = ClientPrefs.globalAntialiasing;
			selection.ID = i;
			selections.add(selection);

			switch(i)
			{
				case 0:
					selection.x = 50;
					selection.y = 400;
				case 1:
					selection.x = 250;
					selection.y = 150;
				case 2:
					selection.x = 450;
					selection.y = 400;
				case 3:
					selection.x = 650;
					selection.y = 150;
				case 4:
					selection.x = 850;
					selection.y = 400;
				case 5:
					selection.x = 1050;
					selection.y = 150;
				case 6:
					selection.x = 1250;
					selection.y = 400;
			}
		}

		tipText = new FlxText(700, 960, FlxG.width, "The teleporter has gone unstable.\nYou can only press ENTER to dive in.\nEach Crystal will be unlocked and completed as you move on.\nIf you wish to go back, press BACKSPACE.", 24);
		tipText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER);
		tipText.screenCenter(XY);
		tipText.y += 290;
		tipText.alpha = 0;
		add(tipText);

		selectors = new FlxSprite().loadGraphic(Paths.image('crossRoadMap/selectors'));
		selectors.antialiasing = ClientPrefs.globalAntialiasing;
		add(selectors);

		whiteOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFFFFFFFF);
		whiteOut.alpha = 0;
		add(whiteOut);

		blackOut = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		blackOut.alpha = 1;
		add(blackOut);

		changeSelection();
		
		if (!endSequence)
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
		else
			FlxTween.tween(blackOut, {alpha: 0}, 2.7, {ease: FlxEase.cubeInOut, type: PERSIST});

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

			if (endSequence)
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
			case 1:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('fast-food-therapy', 'fast-food-therapy');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('fast-food-therapy-villainous', 'fast-food-therapy');
			case 2:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('tactical-mishap', 'tactical-mishap');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('tactical-mishap-villainous', 'tactical-mishap');
			case 3:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('breacher', 'breacher');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('breacher-villainous', 'breacher');
			case 4:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('negotiation', 'negotiation');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('negotiation-villainous', 'negotiation');
			case 5:
				if (ClientPrefs.storyModeCrashDifficultyNum == 0)
					PlayState.SONG = Song.loadFromJson('concert-chaos', 'concert-chaos');
				else if (ClientPrefs.storyModeCrashDifficultyNum == 1)
					PlayState.SONG = Song.loadFromJson('concert-chaos-villainous', 'concert-chaos');
		}
		PlayState.storyDifficulty = ClientPrefs.storyModeCrashDifficultyNum;
		FlxFlicker.flicker(selections.members[curSelected], 1, 0.04, false);

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
			if (ClientPrefs.ourpleFound) //	FIRST SONG
				curSelected = 0;
			if (ClientPrefs.ourplePlayed && Achievements.isAchievementUnlocked('vGuy_Beaten')) //SECOND SONG
				curSelected = 1;
			if (ClientPrefs.kyuPlayed && Achievements.isAchievementUnlocked('fastFoodTherapy_Beaten')) //THIRD SONG
				curSelected = 2;
			if (ClientPrefs.tacticalMishapPlayed && Achievements.isAchievementUnlocked('tacticalMishap_Beaten')) // FOURTH SONG
				curSelected = 3;
			if (ClientPrefs.breacherPlayed && Achievements.isAchievementUnlocked('breacher_Beaten')) //FIFTH SONG
				curSelected = 4;
			if (ClientPrefs.negotiationPlayed && Achievements.isAchievementUnlocked('negotiation_Beaten')) //END
				curSelected = 5;
			if (ClientPrefs.ccPlayed && Achievements.isAchievementUnlocked('concertChaos_Beaten')) //END
				curSelected = 6;
		}
		else
		{
			if (ClientPrefs.ourpleFound)
				curSelected = 0;
			if (ClientPrefs.ourplePlayed)
				curSelected = 1;
			if (ClientPrefs.kyuPlayed)
				curSelected = 2;
			if (ClientPrefs.tacticalMishapPlayed)
				curSelected = 3;
			if (ClientPrefs.breacherPlayed)
				curSelected = 4;
			if (ClientPrefs.negotiationPlayed)
				curSelected = 5;
			if (ClientPrefs.ccPlayed)
				curSelected = 6;
		}

		if (curSelected == 6)
			endSequence = true;
		else
		{
			selectors.x = selections.members[curSelected].x - 20;
			selectors.y = selections.members[curSelected].y + 44;
		}

		switch(curSelected)
		{
			case 0:
				selections.forEach(function (spr:FlxSprite)
				{
					if (spr.ID == curSelected)
						spr.loadGraphic(Paths.image('crossRoadMap/selectionSelected'));
					else
						spr.loadGraphic(Paths.image('crossRoadMap/selection'));
				});
			case 1 | 2 | 3 | 4 | 5:
				selections.forEach(function (spr:FlxSprite)
				{
					if (spr.ID == curSelected)
						spr.loadGraphic(Paths.image('crossRoadMap/selectionCompleted'));
					else if (spr.ID < curSelected)
						spr.loadGraphic(Paths.image('crossRoadMap/selectionSelected'));
					else
						spr.loadGraphic(Paths.image('crossRoadMap/selection'));
				});
			case 6:
				selectors.alpha = 0;
				selections.forEach(function (spr:FlxSprite)
				{
					spr.loadGraphic(Paths.image('crossRoadMap/selectionSelected'));
				});
		}
	}
}