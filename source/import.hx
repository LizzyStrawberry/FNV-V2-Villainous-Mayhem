#if !macro
import Paths;

#if DISCORD_ALLOWED
import Discord.DiscordClient;
#end

#if VIDEOS_ALLOWED
import hxcodec.VideoHandler;
import hxcodec.VideoSprite;
#end

// Shaders
import Shaders;
import openfl.filters.ShaderFilter;
import openfl.display.Shader;
import openfl.filters.BitmapFilter;
import WiggleEffect;
import flixel.system.FlxAssets.FlxShader;
import flixel.addons.display.FlxRuntimeShader;

// Sys
#if sys
import sys.FileSystem;
import sys.io.File;
#end

import openfl.Lib;
import openfl.utils.Assets;

import Achievements;

//Flixel stuff, so we don't have to import things every fricking time
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.FlxBasic;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.FlxAxes;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;


using StringTools;
#end

