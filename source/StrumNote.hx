package;

import flixel.graphics.frames.FlxAtlasFrames;

class StrumNote extends FlxSprite
{
	// To set up custom noteskins for shits cuz lua is unbearable sometimes
	public var marcoNoteVars:Array<String> = [
		'marco',
		'marco-old',
		'marcophase2',
		'marcophase2_5',
		'marcophase3',
		'marcophase3_5',
		'marcoElectric',
		'marcoTofu',
		'aizeenPhase1',
		'aizeenPhase2',
		'marcussy',
		'MarcussyExcrete',
		'Spendthrift Marco',
		'marcx',
		'marcoshucks',
		'marcoCCP1',
		'marcoCCP2',
		'marcoCCP3',
		'kaizokuCCP1',
		'kaizokuCCP2',
		'debugGuyScaled'
	];

	public var lilyNoteVars:Array<String> = [
		'lilyIntroP1',
		'lilyIntroP2',
		'lilyP1',
		'lilyP2',
		'lilyP3',
		'lilyDebugP1',
		'lilyDebugP2',
		'managerChanP1'
	];

	private var colorSwap:ColorSwap;
	public var resetAnim:Float = 0;
	private var noteData:Int = 0;
	public var direction:Float = 90;//plan on doing scroll directions soon -bb
	public var downScroll:Bool = false;//plan on doing scroll directions soon -bb
	public var sustainReduce:Bool = true;
	
	private var player:Int;
	
	public var texture(default, set):String = null;
	private function set_texture(value:String):String {
		if(texture != value) {
			texture = value;
			reloadNote();
		}
		return value;
	}

	public function new(x:Float, y:Float, leData:Int, player:Int) {
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;
		noteData = leData;
		this.player = player;
		this.noteData = leData;
		super(x, y);

		var skin:String = 'NOTE_assets';

		if (!ClientPrefs.optimizationMode)
		{
			if (player == 0) // For Opponents
			{
				for (i in 0...marcoNoteVars.length-1)
				{
					if(PlayState.SONG.player2 == marcoNoteVars[i])
						skin = 'notes/MarcoNOTE_assets';
				}
				switch(PlayState.SONG.player2)
				{
					case 'marcoOurple':
						skin = 'notes/ourpleNOTE_assets';
					case 'beatricephase1' | 'beatricephase2' | 'BeatriceLegacyP1' | 'BeatriceLegacyP2':
						skin = 'notes/BeatriceNOTE_assets';
					case 'aileen' | 'aileen-old':
						skin = 'notes/AileenNOTE_assets';
					case 'kiana' | 'kianaPhase2' | 'kianaPhase3' | 'KianaFinalPhase':
						skin = 'notes/KianaNOTE_assets';
					case 'Morky' | 'MorkyMoist' | 'MorkyHypno' | 'MorkyHypnoAgain'
						| 'MorkyEgg' | 'MorkyHank' | 'Justky':
						skin = 'notes/MorkyNOTE_assets';
					case 'NicFLP':
						skin = 'notes/NicNOTE_assets';
					case 'DV Phase 0' | 'DV' | 'DVTurn' | 'DV Phase 2':
						skin = 'notes/dvNOTE_assets';
					case 'fnv':
						skin = 'notes/FNVNOTE_assets';
					case 'iniquitousP1' | 'iniquitousP2' | 'iniquitousP3':
						skin = 'notes/IniquitousNOTE_assets';
					case 'AsulP1' | 'AsulP2' | 'AsulP3':
						skin = 'notes/AsulNOTE_assets';
					case 'narrin' | 'Narrin Side':
						skin = 'notes/NarrinNOTE_assets';
					case 'Negotiation Cross' | 'FangirlIntro' | 'FangirlP1' | 'FangirlP2':
						skin = 'notes/CrossNOTE_assets';
					case 'Yaku':
						skin = 'notes/YakuNOTE_assets';
				}
			}
			else // For Player
			{
				for (i in 0...lilyNoteVars.length-1)
				{
					if(PlayState.SONG.player1 == lilyNoteVars[i])
						skin = 'notes/LilyNOTE_assets';
				}
				switch(PlayState.SONG.player1)
				{
					case 'aileenTofu' | "aileenTofuAlt":
						skin = 'notes/AileenNOTE_assets';
					case 'TC' | 'TCAlt':
						skin = 'notes/TCNOTE_assets';
					case 'GFwav':
						skin = 'notes/NicNOTE_assets';
					case 'ourple':
						skin = 'notes/ourpleNOTE_assets';
					case 'Kyu' | 'KyuAlt':
						skin = 'notes/KyuNOTE_assets';
					case 'marcoFFFP1' | 'marcoFFFP2' | "Negotiation Marco":
						skin = 'notes/MarcoNOTE_assets';
					case 'gfIniquitousP1' | 'gfIniquitousP2':
						skin = 'notes/IniquitousMechanicNOTE_assets';
				}
			}
		}

		if(PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;
		texture = skin; //Load texture and anims

		scrollFactor.set();
	}

	public function reloadNote()
	{
		var lastAnim:String = null;
		if(animation.curAnim != null) lastAnim = animation.curAnim.name;

		if(PlayState.isPixelStage)
		{
			loadGraphic(Paths.image('pixelUI/' + texture));
			width = width / 4;
			height = height / 5;
			loadGraphic(Paths.image('pixelUI/' + texture), true, Math.floor(width), Math.floor(height));

			antialiasing = false;
			setGraphicSize(Std.int(width * PlayState.daPixelZoom));

			animation.add('green', [6]);
			animation.add('red', [7]);
			animation.add('blue', [5]);
			animation.add('purple', [4]);
			switch (Math.abs(noteData) % 4)
			{
				case 0:
					animation.add('static', [0]);
					animation.add('pressed', [4, 8], 12, false);
					animation.add('confirm', [12, 16], 24, false);
				case 1:
					animation.add('static', [1]);
					animation.add('pressed', [5, 9], 12, false);
					animation.add('confirm', [13, 17], 24, false);
				case 2:
					animation.add('static', [2]);
					animation.add('pressed', [6, 10], 12, false);
					animation.add('confirm', [14, 18], 12, false);
				case 3:
					animation.add('static', [3]);
					animation.add('pressed', [7, 11], 12, false);
					animation.add('confirm', [15, 19], 24, false);
			}
		}
		else
		{
			frames = Paths.getSparrowAtlas(texture);
			animation.addByPrefix('green', 'arrowUP');
			animation.addByPrefix('blue', 'arrowDOWN');
			animation.addByPrefix('purple', 'arrowLEFT');
			animation.addByPrefix('red', 'arrowRIGHT');

			antialiasing = ClientPrefs.globalAntialiasing;
			setGraphicSize(Std.int(width * 0.7));

			switch (Math.abs(noteData) % 4)
			{
				case 0:
					animation.addByPrefix('static', 'arrowLEFT');
					animation.addByPrefix('pressed', 'left press', 24, false);
					animation.addByPrefix('confirm', 'left confirm', 24, false);
				case 1:
					animation.addByPrefix('static', 'arrowDOWN');
					animation.addByPrefix('pressed', 'down press', 24, false);
					animation.addByPrefix('confirm', 'down confirm', 24, false);
				case 2:
					animation.addByPrefix('static', 'arrowUP');
					animation.addByPrefix('pressed', 'up press', 24, false);
					animation.addByPrefix('confirm', 'up confirm', 24, false);
				case 3:
					animation.addByPrefix('static', 'arrowRIGHT');
					animation.addByPrefix('pressed', 'right press', 24, false);
					animation.addByPrefix('confirm', 'right confirm', 24, false);
			}
		}
		updateHitbox();

		if(lastAnim != null)
		{
			playAnim(lastAnim, true);
		}
	}

	public function postAddedToGroup() {
		playAnim('static');
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player);
		ID = noteData;
	}

	override function update(elapsed:Float) {
		if(resetAnim > 0) {
			resetAnim -= elapsed;
			if(resetAnim <= 0) {
				playAnim('static');
				resetAnim = 0;
			}
		}
		//if(animation.curAnim != null){ //my bad i was upset
		if(animation.curAnim.name == 'confirm' && !PlayState.isPixelStage) {
			centerOrigin();
		//}
		}

		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false) {
		animation.play(anim, force);
		centerOffsets();
		centerOrigin();
		if(animation.curAnim == null || animation.curAnim.name == 'static') {
			colorSwap.hue = 0;
			colorSwap.saturation = 0;
			colorSwap.brightness = 0;
		} else {
			if (noteData > -1 && noteData < ClientPrefs.arrowHSV.length)
			{
				colorSwap.hue = ClientPrefs.arrowHSV[noteData][0] / 360;
				colorSwap.saturation = ClientPrefs.arrowHSV[noteData][1] / 100;
				colorSwap.brightness = ClientPrefs.arrowHSV[noteData][2] / 100;
			}

			if(animation.curAnim.name == 'confirm' && !PlayState.isPixelStage) {
				centerOrigin();
			}
		}
	}
}
