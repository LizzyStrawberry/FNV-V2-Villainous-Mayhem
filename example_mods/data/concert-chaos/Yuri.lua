-- script by ItsCapp don't steal, it's dumb

-- simply, offsets. they're the numbers in the top left of the character editor
idleoffsets = {'0', '0'} -- I recommend you have your idle offset at 0
leftoffsets = {'40', '-3'}
downoffsets = {'2', '-45'}
upoffsets = {'-15', '13'}
rightoffsets = {'8', '-3'}

-- change all of these to the name of the animation in your character's xml file
idle_xml_name = 'aileen idle0'
left_xml_name = 'aileen left0'
down_xml_name = 'aileen down0'
up_xml_name = 'aileen up0'
right_xml_name = 'aileen right0'

-- basically horizontal and vertical positions
x_position = 1100
y_position = 250

-- scales your character (set to 1 by default)
xScale = 1
yScale = 1

-- invisible character (so basically if you wanna use the change character event, you need to make the second character invisible first)
invisible = true

-- pretty self-explanitory
name_of_character_xml = 'concertChaos/Aileen Phase 1'
name_of_character = 'aileenCCP2'
name_of_notetype = 'yuri'
name_of_notetype2 = 'Opposition' -- you don't need this, but if you want a notetype that has multiple characters to sing you can use this.


-- if it's set to true the character appears behind the default characters, including gf, watch out for that
foreground = false
playablecharacter = false -- change to 'true' if you want to flipX

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

doIdle = true

function onCreate()
	makeAnimatedLuaSprite(name_of_character, 'characters/' .. name_of_character_xml, x_position, y_position);

	addAnimationByPrefix(name_of_character, 'idle', idle_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singLEFT', left_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singDOWN', down_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singUP', up_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singRIGHT', right_xml_name, 24, false);

	if playablecharacter == true then
		setPropertyLuaSprite(name_of_character, 'flipX', true);
	else
		setPropertyLuaSprite(name_of_character, 'flipX', false);
	end

	scaleObject(name_of_character, xScale, yScale);


	objectPlayAnimation(name_of_character, 'idle');
	addLuaSprite(name_of_character, foreground);

	if invisible == true then
		setPropertyLuaSprite(name_of_character, 'alpha', 0)
	end
	
	setProperty(name_of_character .. '.offset.x', idleoffsets[1]);
	setProperty(name_of_character .. '.offset.y', idleoffsets[2]);
end

local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype or noteType == name_of_notetype2 then
		doIdle = false
		if direction>=4 then
			objectPlayAnimation(name_of_character, singAnims[direction - 3], true);
		else
			objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
		end
		
		runTimer('returnidleh', 0.45)

			if noteType == name_of_notetype2 then
			end
		if direction == 0 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);
	
			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('dcdcdc', ' ')
			end
		elseif direction == 1 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);
	
			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('729576', ' ')
			end
		elseif direction == 2 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);
	
			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('729576', ' ')
			end
		elseif direction == 3 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);
	
			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('565656', ' ')
			end
		elseif direction == 4 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction - 3], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('dcdcdc', ' ')
			end
		elseif direction == 5 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction - 3], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('729576', ' ')
			end
		elseif direction == 6 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction - 3], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('729576', ' ')
			end
		elseif direction == 7 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction - 3], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('565656', ' ')
			end
		end
	end
end

-- I know this is messy, but it's the only way I know to make it work on both sides.
local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype or noteType == name_of_notetype2 then
		doIdle = false
		objectPlayAnimation(name_of_character, singAnims[direction - 3], true);

		if direction == 4 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('dcdcdc', ' ')
			end
		elseif direction == 5 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('729576', ' ')
			end
		elseif direction == 6 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('729576', ' ')
			end
		elseif direction == 7 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Opponent Only') then
				setTimeBarColors('565656', ' ')
			end
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'returnidleh' then
		objectPlayAnimation(name_of_character, 'idle')
		setProperty(name_of_character .. '.offset.x', idleoffsets[1]);
		setProperty(name_of_character .. '.offset.y', idleoffsets[2]);
	end
end

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0  and doIdle then
		objectPlayAnimation(name_of_character, 'idle');
		setProperty(name_of_character .. '.offset.x', idleoffsets[1]);
		setProperty(name_of_character .. '.offset.y', idleoffsets[2]);
	end
	doIdle = true
end

function onCountdownTick(counter)
	-- counter = 0 -> "Three"
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
	if counter % 2 == 0 then
		if doIdle == true then
			objectPlayAnimation(name_of_character, 'idle');
			setProperty(name_of_character .. '.offset.x', idleoffsets[1]);
			setProperty(name_of_character .. '.offset.y', idleoffsets[2]);
		end
	end
end