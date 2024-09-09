package;

import flixel.FlxG;

using StringTools;

class Highscore
{
	#if (haxe >= "4.0.0")
	public static var weekScores:Map<String, Int> = new Map();
	public static var songScores:Map<String, Int> = new Map();
	public static var songRating:Map<String, Float> = new Map();
	#else
	public static var weekScores:Map<String, Int> = new Map();
	public static var songScores:Map<String, Int> = new Map<String, Int>();
	public static var songRating:Map<String, Float> = new Map<String, Float>();
	#end

	public static var songNames:Array<String> = [
		"scrouge",
		"toxic-mishap",
		"paycheck",
		'villainy',

		"nunday-monday",
		"nunconventional",
		"point-blank",

		"forsaken",
		"toybox",
		"lustality-remix",
		'libidinousness',

		"sussus-marcus",
		"villain-in-board",
		"excrete",

		"unpaid-catastrophe",
		"cheque",
		"get-gooned",

		"spendthrift",
		"get-villaind",
		
		"cheap-skate-(legacy)",
		"toxic-mishap-(legacy)",
		"paycheck-(legacy)",

		'iniquitous',

		'tofu',
		'marcochrome',
		'marauder',
		'slowflp',
		'lustality',
		'fnv',
		'fanfuck-forever',
		'rainy-daze',
		'vguy',
		'tactical-mishap',
		'fast-food-therapy',
		'breacher',
		'concert-chaos',
		'nunsational',
		"its-kiana",
		"forsaken-(picmixed)",
		"get-picod",
		"marauder-(old)",
		"slowflp-(old)"
	];

	public static var weekNames:Array<String> = [
		"mainTutWeek",
		"mainweek",
		"weekbeatrice",
		"weekkiana",
		'weekmorky',
		'week_d-side',
		'weeksussus',
		'weeklegacy',
		'week_iniquitous',
		'week_xtraCrossovers'
	];
	
	public static function resetAllSongs():Void
	{
		for (i in 0...songNames.length - 1)
		{
			for (diff in 0...3)
			{
				var daSong:String = formatSong(songNames[i], diff);
				setScore(daSong, 0);
				setRating(daSong, 0);
			}
		}
	}

	public static function resetAllWeeks():Void
	{
		for (i in 0...weekNames.length - 1)
		{
			for (diff in 0...3)
			{
				var daWeek:String = formatSong(weekNames[i], diff);
				setWeekScore(daWeek, 0);
			}
		}
	}

	public static function resetSong(song:String, diff:Int = 0):Void
	{
		var daSong:String = formatSong(song, diff);
		setScore(daSong, 0);
		setRating(daSong, 0);
	}

	public static function resetWeek(week:String, diff:Int = 0):Void
	{
		var daWeek:String = formatSong(week, diff);
		setWeekScore(daWeek, 0);
	}

	public static function floorDecimal(value:Float, decimals:Int):Float
	{
		if(decimals < 1)
		{
			return Math.floor(value);
		}

		var tempMult:Float = 1;
		for (i in 0...decimals)
		{
			tempMult *= 10;
		}
		var newValue:Float = Math.floor(value * tempMult);
		return newValue / tempMult;
	}

	public static function saveScore(song:String, score:Int = 0, ?diff:Int = 0, ?rating:Float = -1):Void
	{
		var daSong:String = formatSong(song, diff);

		if (songScores.exists(daSong)) {
			if (songScores.get(daSong) < score) {
				setScore(daSong, score);
				if(rating >= 0) setRating(daSong, rating);
			}
		}
		else {
			setScore(daSong, score);
			if(rating >= 0) setRating(daSong, rating);
		}
	}

	public static function saveWeekScore(week:String, score:Int = 0, ?diff:Int = 0):Void
	{
		var daWeek:String = formatSong(week, diff);

		if (weekScores.exists(daWeek))
		{
			if (weekScores.get(daWeek) < score)
				setWeekScore(daWeek, score);
		}
		else
			setWeekScore(daWeek, score);
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function setScore(song:String, score:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songScores.set(song, score);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}
	static function setWeekScore(week:String, score:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		weekScores.set(week, score);
		FlxG.save.data.weekScores = weekScores;
		FlxG.save.flush();
	}

	static function setRating(song:String, rating:Float):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songRating.set(song, rating);
		FlxG.save.data.songRating = songRating;
		FlxG.save.flush();
	}

	public static function formatSong(song:String, diff:Int):String
	{
		return Paths.formatToSongPath(song) + CoolUtil.getDifficultyFilePath(diff);
	}

	public static function getScore(song:String, diff:Int):Int
	{
		var daSong:String = formatSong(song, diff);
		if (!songScores.exists(daSong))
			setScore(daSong, 0);

		return songScores.get(daSong);
	}

	public static function getRating(song:String, diff:Int):Float
	{
		var daSong:String = formatSong(song, diff);
		if (!songRating.exists(daSong))
			setRating(daSong, 0);

		return songRating.get(daSong);
	}

	public static function getWeekScore(week:String, diff:Int):Int
	{
		var daWeek:String = formatSong(week, diff);
		if (!weekScores.exists(daWeek))
			setWeekScore(daWeek, 0);

		return weekScores.get(daWeek);
	}

	public static function load():Void
	{
		if (FlxG.save.data.weekScores != null)
		{
			weekScores = FlxG.save.data.weekScores;
		}
		if (FlxG.save.data.songScores != null)
		{
			songScores = FlxG.save.data.songScores;
		}
		if (FlxG.save.data.songRating != null)
		{
			songRating = FlxG.save.data.songRating;
		}
	}
}