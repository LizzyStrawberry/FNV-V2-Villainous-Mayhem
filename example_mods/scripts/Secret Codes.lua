local pressedT = false;
local pressedA = false;
local pressedI = false;
local pressedL = false;
local pressedS = false;

local pressedP = false;
local pressedO1 = false;
local pressedO2 = false;
local pressedF = false;
local allowInput = false;

function onCreatePost()
	addHaxeLibrary('PlayState')
	
	if songName == 'Tofu' then
		addCharacterToList('aileenTofuAlt', 'boyfriend')
		
		makeLuaSprite('lizGoingThroughHell', 'effects/help', 320, 200)
		setObjectCamera('lizGoingThroughHell', 'hud')
		scaleObject('lizGoingThroughHell', 0.4, 0.4)
		setProperty('lizGoingThroughHell.alpha', 0)
		addLuaSprite('lizGoingThroughHell', true)
	end
end

function onUpdate(elapsed)
	-- Omg not these again
	if (not isStoryMode and not isMayhemMode and not isIniquitousMode and not isInjectionMode)
	and songName == "Lustality Remix" and getPropertyFromClass('ClientPrefs', 'itsameDsidesUnlocked') == false then
		if not pressedT and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.T') then
			playSound('clickText')
			pressedT = true;
			debugPrint('T Key was just pressed.')
		end
		if pressedT and not pressedA and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.A') then
			playSound('clickText')
			pressedA = true;
			debugPrint('A Key was just pressed.')
		end
		if pressedA and not pressedI and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.I') then
			playSound('clickText')
			pressedI = true;
			debugPrint('I Key was just pressed.')
		end
		if pressedI and not pressedL and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.L') then
			playSound('clickText')
			pressedL = true;
			debugPrint('L Key was just pressed.')
		end
		if pressedL and not pressedS and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.S') then
			playSound('secretSound')
			loadSong("It's Kiana", 1)
			debugPrint('S Key was just pressed. Unlocking Secret...')
			
			setPropertyFromClass('ClientPrefs', 'itsameDsidesUnlocked', true);
			setPropertyFromClass('ClientPrefs', 'xtraBonusUnlocked', true);
			setPropertyFromClass('FreeplayXtraCategoryState', 'freeplayName', 'XTRABONUS');
			saveSettings();

			runHaxeCode([[
				PlayState.SONG.player1 = 'd-side gf';
			]])
			
			pressedK = true;
		end
	end
	
	if (not isStoryMode and not isMayhemMode and not isIniquitousMode and not isInjectionMode)
	and songName == "Tofu" then
		if not pressedP and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.P') then
			playSound('clickText')
			pressedP = true;
		end
		if pressedP and not pressedO1 and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.O') then
			playSound('clickText')
			runTimer('delayInput', 0.1)
			pressedO1 = true;
		end
		if allowInput and pressedO1 and not pressedO2 and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.O') then
			playSound('clickText')
			pressedO2 = true;
		end
		if pressedO2 and not pressedF and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.F') then
			playSound('poof')
			
			if boyfriendName == 'aileenTofu' then
				triggerEvent('Change Character', 'bf', 'aileenTofuAlt')
			else
				triggerEvent('Change Character', 'bf', 'aileenTofu')
			end
			scaleObject('lizGoingThroughHell', 0.4, 0.4)
			setProperty('lizGoingThroughHell.alpha', 1)
			doTweenAlpha('poof', 'lizGoingThroughHell', 0, 0.7 / playbackRate, 'cubeOut')
			doTweenX('poofX', 'lizGoingThroughHell.scale', 2, 0.7 / playbackRate, 'cubeOut')
			doTweenY('poofY', 'lizGoingThroughHell.scale', 0.8, 0.7 / playbackRate, 'cubeOut')
			pressedF = true;
			pressedF = true;
			
			--Reset so people can retype the code
			runTimer('resetInput', 0.75)
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'delayInput' then
		allowInput = true;
	end
	if tag == 'resetInput' then
		scaleObject('lizGoingThroughHell', 0.4, 0.4)
		pressedP = false;
		pressedO1 = false;
		pressedO2 = false;
		pressedF = false;
		allowInput = false;
	end
end
