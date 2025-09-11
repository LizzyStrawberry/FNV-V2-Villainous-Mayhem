package;

import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.FlxKeyManager;
import haxe.Json;
import haxe.format.JsonParser;
import Alphabet;

typedef DialogueCharacterFile = {
	var image:String;
	var dialogue_pos:String;
	var no_antialiasing:Bool;

	var animations:Array<DialogueAnimArray>;
	var position:Array<Float>;
	var scale:Float;
}

typedef DialogueAnimArray = {
	var anim:String;
	var loop_name:String;
	var loop_offsets:Array<Int>;
	var idle_name:String;
	var idle_offsets:Array<Int>;
}

// Gonna try to kind of make it compatible to Forever Engine,
// love u Shubs no homo :flushedh4:
typedef DialogueFile = {
	var dialogue:Array<DialogueLine>;
}

typedef DialogueLine = {
	var portrait:Null<String>;
	var expression:Null<String>;
	var text:Null<String>;
	var boxState:Null<String>;
	var charVisible:Null<String>;
	var speed:Null<Float>;
	var sound:Null<String>;
	var image:Null<String>;
	var imageAlpha:Null<Float>;
	var imageScale:Null<Float>;
	var boxVisible:Null<String>;
}

class DialogueCharacter extends FlxSprite
{
	private static var IDLE_SUFFIX:String = '-IDLE';
	public static var DEFAULT_CHARACTER:String = 'bf';
	public static var DEFAULT_SCALE:Float = 0.7;

	public var jsonFile:DialogueCharacterFile = null;
	#if (haxe >= "4.0.0")
	public var dialogueAnimations:Map<String, DialogueAnimArray> = new Map();
	#else
	public var dialogueAnimations:Map<String, DialogueAnimArray> = new Map<String, DialogueAnimArray>();
	#end

	public var startingPos:Float = 0; //For center characters, it works as the starting Y, for everything else it works as starting X
	public var isGhost:Bool = false; //For the editor
	public var curCharacter:String = 'bf';
	public var skiptimer = 0;
	public var skipping = 0;
	public function new(x:Float = 0, y:Float = 0, character:String = null)
	{
		super(x, y);

		if(character == null) character = DEFAULT_CHARACTER;
		this.curCharacter = character;

		reloadCharacterJson(character);
		frames = Paths.getSparrowAtlas('dialogue/' + jsonFile.image);
		reloadAnimations();

		antialiasing = ClientPrefs.globalAntialiasing;
		if(jsonFile.no_antialiasing == true) antialiasing = false;
	}

	public function reloadCharacterJson(character:String) {
		var characterPath:String = 'images/dialogue/' + character + '.json';
		var rawJson = null;

		#if MODS_ALLOWED
		var path:String = Paths.modFolders(characterPath);
		if (!FileSystem.exists(path)) {
			path = Paths.getPreloadPath(characterPath);
		}

		if(!FileSystem.exists(path)) {
			path = Paths.getPreloadPath('images/dialogue/' + DEFAULT_CHARACTER + '.json');
		}
		rawJson = File.getContent(path);

		#else
		var path:String = Paths.getPreloadPath(characterPath);
		rawJson = Assets.getText(path);
		#end
		
		jsonFile = cast Json.parse(rawJson);
	}

	public function reloadAnimations() {
		dialogueAnimations.clear();
		if(jsonFile.animations != null && jsonFile.animations.length > 0) {
			for (anim in jsonFile.animations) {
				animation.addByPrefix(anim.anim, anim.loop_name, 24, isGhost);
				animation.addByPrefix(anim.anim + IDLE_SUFFIX, anim.idle_name, 24, true);
				dialogueAnimations.set(anim.anim, anim);
			}
		}
	}

	public function playAnim(animName:String = null, playIdle:Bool = false) {
		var leAnim:String = animName;
		if(animName == null || !dialogueAnimations.exists(animName)) { //Anim is null, get a random animation
			var arrayAnims:Array<String> = [];
			for (anim in dialogueAnimations) {
				arrayAnims.push(anim.anim);
			}
			if(arrayAnims.length > 0) {
				leAnim = arrayAnims[FlxG.random.int(0, arrayAnims.length-1)];
			}
		}

		if(dialogueAnimations.exists(leAnim) &&
		(dialogueAnimations.get(leAnim).loop_name == null ||
		dialogueAnimations.get(leAnim).loop_name.length < 1 ||
		dialogueAnimations.get(leAnim).loop_name == dialogueAnimations.get(leAnim).idle_name)) {
			playIdle = true;
		}
		animation.play(playIdle ? leAnim + IDLE_SUFFIX : leAnim, false);

		if(dialogueAnimations.exists(leAnim)) {
			var anim:DialogueAnimArray = dialogueAnimations.get(leAnim);
			if(playIdle) {
				offset.set(anim.idle_offsets[0], anim.idle_offsets[1]);
				//trace('Setting idle offsets: ' + anim.idle_offsets);
			} else {
				offset.set(anim.loop_offsets[0], anim.loop_offsets[1]);
				//trace('Setting loop offsets: ' + anim.loop_offsets);
			}
		} else {
			offset.set(0, 0);
			trace('Offsets not found! Dialogue character is badly formatted, anim: ' + leAnim + ', ' + (playIdle ? 'idle anim' : 'loop anim'));
		}
	}

	public function animationIsLoop():Bool {
		if(animation.curAnim == null) return false;
		return !animation.curAnim.name.endsWith(IDLE_SUFFIX);
	}
}

// TO DO: Clean code? Maybe? idk
class DialogueBoxPsych extends FlxSpriteGroup
{
	var dialogue:TypedAlphabet;
	var dialogueList:DialogueFile = null;

	public var finishThing:Void->Void;
	public var nextDialogueThing:Void->Void = null;
	public var skipDialogueThing:Void->Void = null;
	public var endDialogueThing:Void->Void = null;
	var bgFade:FlxSprite = null;
	var box:FlxSprite;
	var textToType:String = '';

	var arrayCharacters:Array<DialogueCharacter> = [];

	var currentText:Int = 0;
	var offsetPos:Float = -600;

	var textBoxTypes:Array<String> = ['normal', 'angry'];
	
	var curCharacter:String = "";
	var alphaTween:FlxTween = null;
	//var charPositionList:Array<String> = ['left', 'center', 'right'];
	var curDialogue:DialogueLine = null;

	var skipText:FlxText;
	var bottomBar:FlxSprite;
	var topBar:FlxSprite;
	var arrowThingy:FlxSprite;

	public function new(dialogueList:DialogueFile, ?song:String = null)
	{
		super();

		if(song != null && song != '') {
			FlxG.sound.playMusic(Paths.music(song), 0);
			FlxG.sound.music.fadeIn(2, 0, 1);
		}
		
		bgFade = new FlxSprite(-500, -500).makeGraphic(1280, 720, FlxColor.WHITE);
		bgFade.scrollFactor.set();
		bgFade.visible = true;
		bgFade.alpha = 0;
		add(bgFade);

		this.dialogueList = dialogueList;

		topBar = new FlxSprite(0, FlxG.height - 726).makeGraphic(FlxG.width, 106, 0xFF000000);
		topBar.alpha = 0;
		add(topBar);

		spawnCharacters();

  box = new FlxSprite(70, 370);
		box.frames = Paths.getSparrowAtlas('newDialogueBubbles');
		box.animation.addByPrefix('normal', 'dialogueNormal', 24);
		box.animation.addByPrefix('angry', 'dialogueAngry', 24);
		box.screenCenter(XY);
		box.scrollFactor.set();
		box.antialiasing = ClientPrefs.globalAntialiasing;
		box.visible = false;
		updateBoxOffsets(box);
		add(box);
		
		daText = new TypedAlphabet(DEFAULT_TEXT_X, DEFAULT_TEXT_Y, '');
		daText.scaleX = 0.67;
		daText.scaleY = 0.67;
		add(daText);

		arrowThingy = new FlxSprite(0, 0).loadGraphic(Paths.image('dialogueBackground/dialogueArrow'));
		arrowThingy.screenCenter(XY);
		arrowThingy.x += 500;
		arrowThingy.y += 305;
		arrowThingy.alpha = 0;
		add(arrowThingy);

		FlxTween.tween(arrowThingy, {x: arrowThingy.x - 10}, 0.7, {ease: FlxEase.cubeOut, type: LOOPING});

		skipText = new FlxText(12, FlxG.height - 44, 0, "Press ESC to Skip.", 12);
		skipText.scrollFactor.set();
		skipText.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(skipText);

		startNextDialog();
	}

	var dialogueStarted:Bool = false;
	var dialogueEnded:Bool = false;

	public static var LEFT_CHAR_X:Float = -60;
	public static var RIGHT_CHAR_X:Float = -100;
	public static var DEFAULT_CHAR_Y:Float = 60;

	function spawnCharacters() {
		#if (haxe >= "4.0.0")
		var charsMap:Map<String, Bool> = new Map();
		#else
		var charsMap:Map<String, Bool> = new Map<String, Bool>();
		#end
		for (i in 0...dialogueList.dialogue.length) {
			if(dialogueList.dialogue[i] != null) {
				var charToAdd:String = dialogueList.dialogue[i].portrait;
				if(!charsMap.exists(charToAdd) || !charsMap.get(charToAdd)) {
					charsMap.set(charToAdd, true);
				}
			}
		}

		for (individualChar in charsMap.keys()) {
			var x:Float = LEFT_CHAR_X;
			var y:Float = DEFAULT_CHAR_Y;
			var char:DialogueCharacter = new DialogueCharacter(x + offsetPos, y, individualChar);
			char.setGraphicSize(Std.int(char.width * DialogueCharacter.DEFAULT_SCALE * char.jsonFile.scale));
			char.updateHitbox();
			char.scrollFactor.set();
			char.alpha = 0.00001;
			add(char);

			var saveY:Bool = false;
			switch(char.jsonFile.dialogue_pos) {
				case 'center':
					char.x = FlxG.width / 2;
					char.x -= char.width / 2;
					y = char.y;
					char.y = FlxG.height + 50;
					saveY = true;
				case 'right':
					x = FlxG.width - char.width + RIGHT_CHAR_X;
					char.x = x - offsetPos;
			}
			x += char.jsonFile.position[0];
			y += char.jsonFile.position[1];
			char.x += char.jsonFile.position[0];
			char.y += char.jsonFile.position[1];
			char.startingPos = (saveY ? y : x);
			arrayCharacters.push(char);
		}
	}

	public static var DEFAULT_TEXT_X = 175;
	public static var DEFAULT_TEXT_Y = 210;
	public static var LONG_TEXT_ADD = 20;
	var scrollSpeed = 4000;
	var daText:TypedAlphabet = null;
	var ignoreThisFrame:Bool = true; //First frame is reserved for loading dialogue images

	public var closeSound:String = 'dialogueClose';
	public var closeVolume:Float = 1;
	var beatriceShit:FlxTween;
	override function update(elapsed:Float)
	{
		if(ignoreThisFrame) {
			ignoreThisFrame = false;
			super.update(elapsed);
			return;
		}

		if(!dialogueEnded) {
			FlxTween.tween(bgFade, {alpha: curDialogue.imageAlpha}, 0.7, {ease: FlxEase.cubeOut, type: PERSIST});
			FlxTween.tween(topBar, {alpha: 1}, 0.7, {ease: FlxEase.cubeOut, type: PERSIST});
			FlxTween.tween(bottomBar, {alpha: 1}, 0.7, {ease: FlxEase.cubeOut, type: PERSIST});
			FlxTween.tween(skipText, {alpha: 1}, 0.7, {ease: FlxEase.cubeOut, type: PERSIST});

			if (beatriceShit != null && curDialogue.expression != 'fadeaway')
				beatriceShit.percent = 100;

			if (curDialogue.boxVisible == "Yes")
				box.visible = true;
			else if (curDialogue.boxVisible == "No")
				box.visible = false;

			if (FlxG.keys.justPressed.ESCAPE)
			{
				dialogueEnded = true;
				if(endDialogueThing != null) {
					endDialogueThing();
				}
				FlxTween.tween(box, {alpha: 0}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
				FlxTween.tween(arrowThingy, {alpha: 0}, 0.5, {ease: FlxEase.circOut, type: PERSIST});

				if(daText != null)
				{
					daText.kill();
					remove(daText);
					daText.destroy();
				}
				FlxG.sound.music.fadeOut(1, 0);
				FlxG.sound.play(Paths.sound(closeSound), closeVolume);
			}

			var videoPlaying:Bool = PlayState.instance.videoCutscene != null && PlayState.instance.videoCutscene.videoSprite.bitmap.isPlaying;
			if(PlayerSettings.player1.controls.ACCEPT && !videoPlaying) {
				if(!daText.finishedText) {
					arrowThingy.alpha = 1;
					daText.finishText();
					if(skipDialogueThing != null) {
						skipDialogueThing();
					}
				} else if(currentText >= dialogueList.dialogue.length) {
					dialogueEnded = true;
					if(endDialogueThing != null) {
						endDialogueThing();
					}
					FlxTween.tween(box, {alpha: 0}, 0.5, {ease: FlxEase.circOut, type: PERSIST});
					FlxTween.tween(arrowThingy, {alpha: 0}, 0.5, {ease: FlxEase.circOut, type: PERSIST});

					if(daText != null)
					{
						daText.kill();
						remove(daText);
						daText.destroy();
					}
					FlxG.sound.music.fadeOut(1, 0);
				} else {
					startNextDialog();
				}
				FlxG.sound.play(Paths.sound(closeSound), closeVolume);
			} else if(daText.finishedText) {
				arrowThingy.alpha = 1;
				var char:DialogueCharacter = arrayCharacters[lastCharacter];
				if(char != null && char.animation.curAnim != null && char.animationIsLoop() && char.animation.finished) {
					char.playAnim(char.animation.curAnim.name, true);
				}
			} else {
				arrowThingy.alpha = 0;
				var char:DialogueCharacter = arrayCharacters[lastCharacter];
				if(char != null && char.animation.curAnim != null && char.animation.finished) {
					char.animation.curAnim.restart();
				}
			}
			

			if(lastCharacter != -1 && arrayCharacters.length > 0) {
				for (i in 0...arrayCharacters.length) {
					var char = arrayCharacters[i];
					if(char != null) {
						if(i != lastCharacter) {
							switch(char.jsonFile.dialogue_pos) {
								case 'left':
									char.x -= scrollSpeed * elapsed;
									if(char.x < char.startingPos + offsetPos) char.x = char.startingPos + offsetPos;
								case 'center':
									char.y += scrollSpeed * elapsed;
									if(char.y > char.startingPos + FlxG.height) char.y = char.startingPos + FlxG.height;
								case 'right':
									char.x += scrollSpeed * elapsed;
									if(char.x > char.startingPos - offsetPos) char.x = char.startingPos - offsetPos;
							}
							if (curDialogue.expression != 'fadeaway')
							{
								char.alpha -= 3 * elapsed;
								if(char.alpha < 0.00001) char.alpha = 0.00001;
							}
						} else {
							switch(char.jsonFile.dialogue_pos) {
								case 'left':
									char.x += scrollSpeed * elapsed;
									if(char.x > char.startingPos) char.x = char.startingPos;
								case 'center':
									char.y -= scrollSpeed * elapsed;
									if(char.y < char.startingPos) char.y = char.startingPos;
								case 'right':
									char.x -= scrollSpeed * elapsed;
									if(char.x < char.startingPos) char.x = char.startingPos;
							}
							if (curDialogue.expression != 'fadeaway')
							{
								char.alpha += 3 * elapsed;
								if(char.alpha > 1) char.alpha = 1;
							}
						}
					}
				}
			}
		} else { //Dialogue ending
			if(box != null && box.alpha <= 0) {
				box.kill();
				remove(box);
				box.destroy();
				box = null;
				
				arrowThingy.kill();
				remove(arrowThingy);
				arrowThingy.destroy();
				arrowThingy = null;
			}

			if(bgFade != null) {
				bgFade.alpha -= 0.5 * elapsed;
				skipText.alpha -= 0.5 * elapsed;
				bottomBar.alpha -= 0.5 * elapsed;
				topBar.alpha -= 0.5 * elapsed;
				if(bgFade.alpha <= 0) {
					bgFade.kill();
					remove(bgFade);
					bgFade.destroy();
					bgFade = null;
				}
				if(skipText.alpha <= 0) {
					skipText.kill();
					remove(skipText);
					skipText.destroy();
					skipText = null;
				}
				if(bottomBar.alpha <= 0) {
					bottomBar.kill();
					remove(bottomBar);
					bottomBar.destroy();
					bottomBar = null;
				}
				if(topBar.alpha <= 0) {
					topBar.kill();
					remove(topBar);
					topBar.destroy();
					topBar = null;
				}
			}

			for (i in 0...arrayCharacters.length) {
				var leChar:DialogueCharacter = arrayCharacters[i];
				if(leChar != null) {
					switch(arrayCharacters[i].jsonFile.dialogue_pos) {
						case 'left':
							leChar.x -= scrollSpeed * elapsed;
						case 'center':
							leChar.y += scrollSpeed * elapsed;
						case 'right':
							leChar.x += scrollSpeed * elapsed;
					}
					leChar.alpha -= elapsed * 10;
				}
			}

			if(box == null && bgFade == null) {
				for (i in 0...arrayCharacters.length) {
					var leChar:DialogueCharacter = arrayCharacters[0];
					if(leChar != null) {
						arrayCharacters.remove(leChar);
						leChar.kill();
						remove(leChar);
						leChar.destroy();
					}
				}
				finishThing();
				kill();
			}
		}
		super.update(elapsed);
	}

	var lastCharacter:Int = -1;
	var lastBoxType:String = '';
	function startNextDialog():Void
	{
		do {
			curDialogue = dialogueList.dialogue[currentText];
		} while(curDialogue == null);

		if(curDialogue.text == null || curDialogue.text.length < 1) curDialogue.text = ' ';
		if(curDialogue.boxState == null) curDialogue.boxState = 'normal';
		if(curDialogue.charVisible == 'Yes') arrayCharacters[0].visible = true;
		if(curDialogue.charVisible == 'No') arrayCharacters[0].visible = false;
		if(curDialogue.speed == null || Math.isNaN(curDialogue.speed)) curDialogue.speed = 0.05;
		if (curDialogue.image == null || curDialogue.image == ' ' || curDialogue.image == '')
		{
			bgFade.makeGraphic(1280, 720, FlxColor.WHITE);
			bgFade.screenCenter(XY);
			bgFade.scale.set(curDialogue.imageScale, curDialogue.imageScale);
			bgFade.alpha = curDialogue.imageAlpha;
		}
		else
		{
			bgFade.loadGraphic(Paths.image('dialogueBackground/' + curDialogue.image));
			bgFade.screenCenter(XY);
			bgFade.scale.set(curDialogue.imageScale, curDialogue.imageScale);
			bgFade.alpha = curDialogue.imageAlpha;
		}

		var animName:String = curDialogue.boxState;
		var boxType:String = textBoxTypes[0];
		for (i in 0...textBoxTypes.length) {
			if(textBoxTypes[i] == animName) {
				boxType = animName;
			}
		}

		var character:Int = 0;
		for (i in 0...arrayCharacters.length) {
			if(arrayCharacters[i].curCharacter == curDialogue.portrait) {
				character = i;
				break;
			}
		}
		var centerPrefix:String = '';
		var lePosition:String = arrayCharacters[character].jsonFile.dialogue_pos;
		if(lePosition == 'center') centerPrefix = 'center-';

		updateBoxOffsets(box, boxType, lePosition);

		lastCharacter = character;
		lastBoxType = boxType;

		daText.text = curDialogue.text;
		daText.sound = curDialogue.sound;
		daText.delay = curDialogue.speed;
		if(daText.sound == null || daText.sound.trim() == '') daText.sound = 'dialogue';
		
		daText.x = DEFAULT_TEXT_X;
		daText.y = DEFAULT_TEXT_Y;
		if(daText.rows > 2) daText.y -= LONG_TEXT_ADD;

		var char:DialogueCharacter = arrayCharacters[character];
		if (curDialogue.expression == 'fadeaway')
		{
			beatriceShit = FlxTween.tween(char, {alpha: 0}, 2, {ease: FlxEase.cubeInOut, type: PERSIST});
			new FlxTimer().start(0.6, function (tmr:FlxTimer) {
				FlxG.sound.play(Paths.sound('goodbyeLmao'), 0.7);
			});
		}
		if(char != null) {
			char.playAnim(curDialogue.expression, daText.finishedText);
			if(char.animation.curAnim != null) {
				var rate:Float = 24 - (((curDialogue.speed - 0.05) / 5) * 480);
				if(rate < 12) rate = 12;
				else if(rate > 48) rate = 48;
				char.animation.curAnim.frameRate = rate;
			}
		}
		currentText++;

		if(nextDialogueThing != null) {
			nextDialogueThing();
		}
	}

	public static function parseDialogue(path:String):DialogueFile {
		#if MODS_ALLOWED
		if(FileSystem.exists(path))
		{
			return cast Json.parse(File.getContent(path));
		}
		#end
		return cast Json.parse(Assets.getText(path));
	}

	public static function updateBoxOffsets(box:FlxSprite, boxType:String = 'normal', lePosition:String = 'right') { //Had to make it static because of the editors
		box.scale.set(1.03, 1.03);
		box.screenCenter(XY);
		box.y += 30;
		box.animation.play(boxType, true);
		box.flipX = !(lePosition == 'left');
		switch(lePosition)
		{
			case 'left':
				box.x += 150;
				DEFAULT_TEXT_X = 465;
			default:
				box.x -= 150;
				DEFAULT_TEXT_X = 145;
		}
		box.updateHitbox();
	}
}
