import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class Achievements {
	public static var achievementsStuff:Array<Dynamic> = [ //Name, Description, Achievement save tag, Hidden achievement
		["Freaky on a Friday Night",	"Play on a Friday... Night.",						'friday_night_play',	 true],
		["Banging now or later?",		"Beat the tutorial.",				'Tutorial_Beaten',			false],
		["Get the fuck out.",		"Beat Week 1 (Cheap Skate Villains).",				'WeekMarco_Beaten',			false],
		["Villanous Performance!",		"Beat Week 1 (Cheap Skate Villains) in Villainous Mode.",				'WeekMarcoVillainous_Beaten',			false],
		["Toxic Flashbacks!",		"Beat Week 1 (Cheap Skate Villains) in Iniquitous Mode.",				'WeekMarcoIniquitous_Beaten',			false],
		["Divined Victory!",		"Beat Week 2 (Orphanage Hustle).",				'WeekNun_Beaten',			false],
		["Nun-Controllable!",		"Beat Week 2 (Orphanage Hustle) in Villainous Mode.",				'WeekNunVillainous_Beaten',			false],
		["Relieved Memories!",		"Beat Week 2 (Orphanage Hustle) in Iniquitous Mode.",				'WeekNunIniquitous_Beaten',			false],
		["Pro Dweller!",		"Beat Week 3 (The Unnamed Trinity).",				'WeekKiana_Beaten',			false],
		["Unnamed No More!",		"Beat Week 3 (The Unnamed Trinity) in Villainous Mode.",				'WeekKianaVillainous_Beaten',			false],
		["Not Herself Anymore.",		"Beat Week 3 (The Unnamed Trinity) in Iniquitous Mode.",				'WeekKianaIniquitous_Beaten',			false],
		["You're Done For!",		"Beat Iniquitous.",				'weekIniquitous_Beaten',			false],
		["GRAHH MORKY",		"Beat Week Morky (Goofy Ah Villains).",				'WeekMorky_Beaten',			false],
		["IT'S MORE THAN MORKY",		"Beat Week Morky (Goofy Ah Villains) in Villainous Mode.",				'WeekMorkyVillainous_Beaten',			false],
		["Sussy Escapade!",		"Beat Week Sus (A Villain Is Among Us).",				'WeekSus_Beaten',			false],
		["Ejected!",		"Beat Week Sus (A Villain Is Among Us) in Villainous Mode.",				'WeekSusVillainous_Beaten',			false],
		["Deja Vu!",		"Beat Week Legacy (Alpha Villains).",				'WeekLegacy_Beaten',			false],
		["IT'S HAPPENING AGAIN!",		"Beat Week Legacy (Alpha Villains) in Villainous Mode.",				'WeekLegacyVillainous_Beaten',			false],
		["Gooned and Quirk'd!",		"Beat Week D-Sides (4 Side Villainy).",				'WeekDside_Beaten',			false],
		["Underpaid Victory!",		"Beat Week D-Sides (4 Side Villainy) in Villainous Mode.",				'WeekDsideVillainous_Beaten',			false],
		// Shop Songs
		["Bets are gone!",		"Beat Tofu in Villainous Mode.",				'tofu_Beaten',			false],
		["Lunacy.",		"Beat Marcochrome in Villainous Mode.",				'marcochrome_Beaten',			false],
		["Retrolust!",		"Beat Lustality in Villainous Mode.",				'lustality_Beaten',			false],
		["Legacy Retrolust!",		"Beat Lustality V1 in Villainous Mode.",				'lustalityV1_Beaten',			false],
		["Nun of our problem!",		"Beat Nunsational in Villainous Mode.",				'nunsational_Beaten',			false],
		["FNV",		"Beat FNV in Villainous Mode.",				'FNV_Beaten',			false],
		["WORLD RECORD!",		"Play the shortest song in the entirety of FNF!",				'short_Beaten',			false],
		["I am not God.",		"Beat Slow.FLP in Villainous Mode.",				'nic_Beaten',			false],
		["ME LIKEY YOU",		"Beat FanFuck Forever in Villainous Mode.",				'fanfuck_Beaten',			false],
		["Come again another day!",		"Beat Rainy Daze in Villainous Mode.",				'rainyDaze_Beaten',			false],
		["Virus Terminated.",		"Beat Marauder in Villainous Mode.",				'marauder_Beaten',			false],
		// Crossover Songs
		["Die in a fire!",		"Beat VGuy in Villainous Mode.",				'vGuy_Beaten',			false],
		["Unconventional Encounter!",		"Beat Fast Food Therapy in Villainous Mode.",				'fastFoodTherapy_Beaten',			false],
		["BOOM BABY!",		"Beat Tactical Mishap in Villainous Mode.",				'tacticalMishap_Beaten',			false],
		["Absolute No-Solver!",		"Beat Breacher in Villainous Mode.",				'breacher_Beaten',			false],
		["World Wide!",		"Beat Concert Chaos in Villainous Mode.",				'concertChaos_Beaten',			false],
		["Dimension Traveller!",		"Finish Beyond Reality.",				'crossover_Beaten',			false],
		//Extra Shit
		["You shouldn't be here.",		"Beat It's Kiana.",				'itsKiana_Beaten',			false],
		["Very Concerning.",		"Find Hermit and The Cellar.",				'hermit_found',			false],
		["Who is she?",		"Find Zeel and her Illegal Shop.",				'zeel_found',			false],
		["Caught on 4K.",		"Touch Merchant Zeel's Boobies.",				'pervert',			false],
		["Certified Pervert.",		"Touch Merchant Zeel's Boobies 25 times in a row.",				'pervertX25',			false],
		["Shopalic!",		"Buy/Obtain all Song/Week Items in the shop.",				'shop_completed',			false],
		["THINK FAST!!",		"Get flashbanged.",				'flashbang',			false],
		["FNV!!",		"Get all of the achievements!",				'FNV_Completed',			false],
		["You found me.",	"Huh?",						'secret',	 true]
	];
	public static var achievementsMap:Map<String, Bool> = new Map<String, Bool>();

	public static var achievementsStuffBackUp:Array<Dynamic> = [ //Name, Description, Achievement save tag, Hidden achievement
		["Freaky on a Friday Night",	"Play on a Friday... Night.",						'friday_night_play',	 true],
		["Banging now or later?",		"Beat the tutorial.",				'Tutorial_Beaten',			false],
		["Get the fuck out.",		"Beat Week 1 (Cheap Skate Villains).",				'WeekMarco_Beaten',			false],
		["Villanous Performance!",		"Beat Week 1 (Cheap Skate Villains) in Villainous Mode.",				'WeekMarcoVillainous_Beaten',			false],
		["Toxic Flashbacks!",		"Beat Week 1 (Cheap Skate Villains) in Iniquitous Mode.",				'WeekMarcoIniquitous_Beaten',			false],
		["Divined Victory!",		"Beat Week 2 (Orphanage Hustle).",				'WeekNun_Beaten',			false],
		["Nun-Controllable!",		"Beat Week 2 (Orphanage Hustle) in Villainous Mode.",				'WeekNunVillainous_Beaten',			false],
		["Relieved Memories!",		"Beat Week 2 (Orphanage Hustle) in Iniquitous Mode.",				'WeekNunIniquitous_Beaten',			false],
		["Pro Dweller!",		"Beat Week 3 (The Unnamed Trinity).",				'WeekKiana_Beaten',			false],
		["Unnamed No More!",		"Beat Week 3 (The Unnamed Trinity).",				'WeekKianaVillainous_Beaten',			false],
		["Not Herself Anymore.",		"Beat Week 3 (The Unnamed Trinity) in Iniquitous Mode.",				'WeekKianaIniquitous_Beaten',			false],
		["You're Done For!",		"Beat Iniquitous.",				'weekIniquitous_Beaten',			false],
		["GRAHH MORKY",		"Beat Week Morky (Goofy Ah Villains).",				'WeekMorky_Beaten',			false],
		["IT'S MORE THAN MORKY",		"Beat Week Morky (Goofy Ah Villains) in Villainous Mode.",				'WeekMorkyVillainous_Beaten',			false],
		["Sussy Escapade!",		"Beat Week Sus (A Villain Is Among Us).",				'WeekSus_Beaten',			false],
		["Ejected!",		"Beat Week Sus (A Villain Is Among Us) in Villainous Mode.",				'WeekSusVillainous_Beaten',			false],
		["Deja Vu!",		"Beat Week Legacy (Alpha Villains).",				'WeekLegacy_Beaten',			false],
		["IT'S HAPPENING AGAIN!",		"Beat Week Legacy (Alpha Villains) in Villainous Mode.",				'WeekLegacyVillainous_Beaten',			false],
		["Gooned and Quirk'd!",		"Beat Week D-Sides (4 Side Villainy).",				'WeekDside_Beaten',			false],
		["Underpaid Victory!",		"Beat Week D-Sides (4 Side Villainy) in Villainous Mode.",				'WeekDsideVillainous_Beaten',			false],
		// Shop Songs
		["Bets are gone!",		"Beat Tofu in Villainous Mode.",				'tofu_Beaten',			false],
		["Lunacy.",		"Beat Marcochrome in Villainous Mode.",				'marcochrome_Beaten',			false],
		["Retrolust!",		"Beat Lustality in Villainous Mode.",				'lustality_Beaten',			false],
		["Legacy Retrolust!",		"Beat Lustality V1 in Villainous Mode.",				'lustalityV1_Beaten',			false],
		["Nun of our problem!",		"Beat Nunsational in Villainous Mode.",				'nunsational_Beaten',			false],
		["FNV",		"Beat FNV in Villainous Mode.",				'FNV_Beaten',			false],
		["WORLD RECORD!",		"Play the shortest song in the entirety of FNF!",				'short_Beaten',			false],
		["I am not God.",		"Beat Slow.FLP in Villainous Mode.",				'nic_Beaten',			false],
		["ME LIKEY YOU",		"Beat FanFuck Forever in Villainous Mode.",				'fanfuck_Beaten',			false],
		["Come again another day!",		"Beat Rainy Daze in Villainous Mode.",				'rainyDaze_Beaten',			false],
		["Virus Terminated.",		"Beat Marauder in Villainous Mode.",				'marauder_Beaten',			false],
		// Crossover Songs
		["Die in a fire!",		"Beat VGuy in Villainous Mode.",				'vGuy_Beaten',			false],
		["Unconventional Encounter!",		"Beat Fast Food Therapy in Villainous Mode.",				'fastFoodTherapy_Beaten',			false],
		["BOOM BABY!",		"Beat Tactical Mishap in Villainous Mode.",				'tacticalMishap_Beaten',			false],
		["Absolute No-Solver!",		"Beat Breacher in Villainous Mode.",				'breacher_Beaten',			false],
		["World Wide!",		"Beat Concert Chaos in Villainous Mode.",				'concertChaos_Beaten',			false],
		["Dimension Traveller!",		"Finish Beyond Reality.",				'crossover_Beaten',			false],
		//Extra Shit
		["You shouldn't be here.",		"Beat It's Kiana.",				'itsKiana_Beaten',			false],
		["Very Concerning.",		"Find Hermit and The Cellar.",				'hermit_found',			false],
		["Who is she?",		"Find Zeel and her Illegal Shop.",				'zeel_found',			false],
		["Caught on 4K.",		"Touch Merchant Zeel's Boobies.",				'pervert',			false],
		["Certified Pervert.",		"Touch Merchant Zeel's Boobies 25 times in a row.",				'pervertX25',			false],
		["Shopalic!",		"Buy/Obtain all Song/Week Items in the shop.",				'shop_completed',			false],
		["THINK FAST!!",		"Get flashbanged.",				'flashbang',			false],
		["FNV!!",		"Get all of the achievements!",				'FNV_Completed',			false],
		["You found me.",	"Huh?",						'secret',	 true]
	];
	public static var achievementsMapBackUp:Map<String, Bool> = new Map<String, Bool>();


	public static var henchmenDeath:Int = 0;
	public static function unlockAchievement(name:String):Void {
		FlxG.log.add('Completed achievement "' + name +'"');
		achievementsMap.set(name, true);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
	}

	public static function debugUnlock() {
		for (i in 0...45)
		{
			var name:String = achievementsStuff[i][2];
			FlxG.log.add('Completed achievement "' + name +'"');
			achievementsMap.set(name, true);
		}
	}

	public static function isAchievementUnlocked(name:String) {
		if(achievementsMap.exists(name) && achievementsMap.get(name)) {
			return true;
		}
		return false;
	}

	public static function getAchievementIndex(name:String) {
		for (i in 0...achievementsStuff.length) {
			if(achievementsStuff[i][2] == name) {
				return i;
			}
		}
		return -1;
	}

	public static function loadAchievements():Void {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsMap != null) {
				achievementsMap = FlxG.save.data.achievementsMap;
			}
			if(henchmenDeath == 0 && FlxG.save.data.henchmenDeath != null) {
				henchmenDeath = FlxG.save.data.henchmenDeath;
			}
		}
	}
}

class AttachedAchievement extends FlxSprite {
	public var sprTracker:FlxSprite;
	private var tag:String;
	public function new(x:Float = 0, y:Float = 0, name:String) {
		super(x, y);

		changeAchievement(name);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function changeAchievement(tag:String) {
		this.tag = tag;
		reloadAchievementImage();
	}

	public function reloadAchievementImage() {
		if(Achievements.isAchievementUnlocked(tag)) {
			loadGraphic(Paths.image('achievements/' + tag));
		} else {
			loadGraphic(Paths.image('achievements/lockedachievement'));
		}
		scale.set(0.7, 0.7);
		updateHitbox();
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x - 130, sprTracker.y + 25);

		super.update(elapsed);
	}
}

class AchievementObject extends FlxSpriteGroup {
	public var onFinish:Void->Void = null;
	var alphaTween:FlxTween;
	public function new(name:String, ?camera:FlxCamera = null)
	{
		super(x, y);
		ClientPrefs.saveSettings();

		var id:Int = Achievements.getAchievementIndex(name);
		var achievementBG:FlxSprite = new FlxSprite(60, 50).makeGraphic(420, 120, FlxColor.BLACK);
		achievementBG.scrollFactor.set();

		var achievementIcon:FlxSprite = new FlxSprite(achievementBG.x + 10, achievementBG.y + 10).loadGraphic(Paths.image('achievements/' + name));
		achievementIcon.scrollFactor.set();
		achievementIcon.setGraphicSize(Std.int(achievementIcon.width * (2 / 3)));
		achievementIcon.updateHitbox();
		achievementIcon.antialiasing = ClientPrefs.globalAntialiasing;

		var achievementName:FlxText = new FlxText(achievementIcon.x + achievementIcon.width + 20, achievementIcon.y + 16, 280, Achievements.achievementsStuff[id][0], 16);
		achievementName.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementName.scrollFactor.set();

		var achievementText:FlxText = new FlxText(achievementName.x, achievementName.y + 32, 280, Achievements.achievementsStuff[id][1], 16);
		achievementText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT);
		achievementText.scrollFactor.set();

		add(achievementBG);
		add(achievementName);
		add(achievementText);
		add(achievementIcon);

		var cam:Array<FlxCamera> = FlxCamera.defaultCameras;
		if(camera != null) {
			cam = [camera];
		}
		alpha = 0;
		achievementBG.cameras = cam;
		achievementName.cameras = cam;
		achievementText.cameras = cam;
		achievementIcon.cameras = cam;
		alphaTween = FlxTween.tween(this, {alpha: 1}, 0.5, {onComplete: function (twn:FlxTween) {
			alphaTween = FlxTween.tween(this, {alpha: 0}, 0.5, {
				startDelay: 2.5,
				onComplete: function(twn:FlxTween) {
					alphaTween = null;
					remove(this);
					if(onFinish != null) onFinish();
				}
			});
		}});
	}

	override function destroy() {
		if(alphaTween != null) {
			alphaTween.cancel();
		}
		super.destroy();
	}
}