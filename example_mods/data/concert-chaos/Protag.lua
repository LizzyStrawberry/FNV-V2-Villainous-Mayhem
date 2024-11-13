-- script by ItsCapp don't steal, it's dumb

-- simply, offsets. they're the numbers in the top left of the character editor
idleoffsets = {'0', '0'} -- I recommend you have your idle offset at 0
leftoffsets = {'22', '9'}
downoffsets = {'-19', '-33'}
upoffsets = {'11', '16'}
rightoffsets = {'28', '-3'}
leftmissoffsets = {'53', '18'}
downmissoffsets = {'-19', '-60'}
upmissoffsets = {'-19', '66'}
rightmissoffsets = {'-36', '18'}

-- change all of these to the name of the animation in your character's xml file
idle_xml_name = 'manager chan idle0'
left_xml_name = 'manager chan left0'
down_xml_name = 'manager chan down0'
up_xml_name = 'manager chan up0'
right_xml_name = 'manager chan right0'
leftmiss_xml_name = 'manager chan left miss0'
downmiss_xml_name = 'manager chan down miss0'
upmiss_xml_name = 'manager chan up miss0'
rightmiss_xml_name = 'manager chan right miss0'

-- basically horizontal and vertical positions
x_position = 380
y_position = 100

-- scales your character (set to 1 by default)
xScale = 1
yScale = 1

-- invisible character (so basically if you wanna use the change character event, you need to make the second character invisible first)
invisible = true

-- pretty self-explanitory
name_of_character_xml = 'concertChaos/Manager Chan Phase 1'
name_of_character = 'managerChanP2'
name_of_notetype = 'protag'
name_of_notetype2 = 'protag bg' -- you don't need this, but if you want a notetype that has multiple characters to sing you can use this.


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
	addAnimationByPrefix(name_of_character, 'singLEFTmiss', leftmiss_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singDOWNmiss', downmiss_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singUPmiss', upmiss_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singRIGHTmiss', rightmiss_xml_name, 24, false);

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
		objectPlayAnimation(name_of_character, singAnims[direction - 11], true);
		
		runTimer('returnidleh', 0.45)

			if noteType == name_of_notetype2 then
			end

		if direction == 12 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction - 11], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only') then
				setTimeBarColors('9700FF', ' ')
			end
		elseif direction == 13 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction - 11], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only') then
				setTimeBarColors('00FFFF', ' ')
			end
		elseif direction == 14 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction - 11], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only') then
				setTimeBarColors('00FF00', ' ')
			end
		elseif direction == 15 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);

			if isSustainNote then
				objectPlayAnimation(name_of_character, singAnims[direction - 11], true);
			end
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only') then
				setTimeBarColors('FF0000', ' ')
			end
		end
	end
end

-- I know this is messy, but it's the only way I know to make it work on both sides.
local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype or noteType == name_of_notetype2 then
		doIdle = false
		objectPlayAnimation(name_of_character, singAnims[direction + 1], true);

		if direction == 0 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only') then
				setTimeBarColors('9700FF', ' ')
			end
		elseif direction == 1 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only') then
				setTimeBarColors('00FFFF', ' ')
			end
		elseif direction == 2 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only') then
				setTimeBarColors('00FF00', ' ')
			end
		elseif direction == 3 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false or (getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'All Enabled'
			or getPropertyFromClass('ClientPrefs', 'timeBarFlash') == 'Player Only') then
				setTimeBarColors('FF0000', ' ')
			end
		end
	end
end

local singAnims = {"singLEFTmiss", "singDOWNmiss", "singUPmiss", "singRIGHTmiss"}
function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype or noteType == name_of_notetype2 then
		doIdle = false
		objectPlayAnimation(name_of_character, singAnims[direction + 1], true);

		if direction == 0 then
			setProperty(name_of_character .. '.offset.x', leftmissoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftmissoffsets[2]);
		elseif direction == 1 then
			setProperty(name_of_character .. '.offset.x', downmissoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downmissoffsets[2]);
		elseif direction == 2 then
			setProperty(name_of_character .. '.offset.x', upmissoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upmissoffsets[2]);
		elseif direction == 3 then
			setProperty(name_of_character .. '.offset.x', rightmissoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightmissoffsets[2]);
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