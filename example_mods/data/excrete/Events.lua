local fuckingThings = {'healthBar', 'healthBarBG', 'iconP1', 'iconP2'}

function onCreate()
	if mechanics then
		makeLuaSprite('sabotage', '', -800, -600)
		makeGraphic('sabotage', 5000, 5000, 'FF0000')
		setScrollFactor('sabotage', 0, 0)
		setProperty('sabotage.alpha', 0)
		setObjectCamera('sabotage', 'game')
		addLuaSprite('sabotage', true)
	end
	
	runTimer('bfDiesTime', getRandomInt(30, 120))
	
	dadY = getProperty('dad.y')
	setProperty('dad.y', getProperty('dad.y') + 1040)
	setProperty('beef.y', getProperty('beef.y') - 540)
	setProperty('beef.x', getProperty('beef.x') + 540)
	
	doTweenX('bgMove', 'bg', -270, 203, 'linear')
	
	for i = 1, #(fuckingThings) do
		setProperty(fuckingThings[i]..'.alpha', 0)
	end
	
	addBloomEffect('game', 0.15, 1.0)
	addBloomEffect('hud', 0.15, 1.0)
	addChromaticAbberationEffect('game', 0.002)
	addChromaticAbberationEffect('hud', 0.003)
end

function onSongStart()
	for i = 1, #(fuckingThings) do
		doTweenAlpha(fuckingThings[i]..'appear', fuckingThings[i], 1, 0.8, 'cubeInOut')
	end
end

function onUpdate()
	if curBeat == 0 then
		-- In case someone loads the song on optimization mode
		if getPropertyFromClass('ClientPrefs', 'optimizationMode') == true then 
			triggerEvent('Change Icon', 'P2, marcussyExcrete, 393939')
		end
	end
	if curBeat == 79 then
		doTweenY('MarcussyAppears', 'dad', dadY, 0.7, 'circOut')
	end
	
	if curBeat == 416 then
		doTweenAlpha('gameGoByeBye', 'camGame', 0, 0.9, 'circOut')
		for i = 0, 7 do
			noteTweenY('NoteTween'..i, i, getPropertyFromGroup('strumLineNotes', i, 'y') - (i * 2.7), 1.2, 'easeOut')
			noteTweenAlpha('NoteTweenAlpha'..i, i, 0, 1.4, 'cubeInOut')
		end
	end
end

function onBeatHit()
	objectPlayAnimation('speaker', 'idle', true);
	if mechanics and curBeat % 2 == 0 and 
	((curBeat >= 64 and curBeat <= 111) or (curBeat >= 128 and curBeat <= 183) or (curBeat >= 232 and curBeat <= 263)) then
		doTweenAlpha('sabotage', 'sabotage', 0.8, 0.06, 'circOut')
	end
end

function opponentNoteHit() -- health draining mechanic
	health = getProperty('health')
		if not isMayhemMode and mechanics and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
			if ((isStoryMode and difficulty == 1) or (not isStoryMode and difficulty == 0)) and getProperty('health') > 0.2 then
				if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
					setProperty('health', health- 0.0065);
				else
					setProperty('health', health- 0.013);
				end
			end
		end
end

function onTweenCompleted(tag)
	if tag == 'sabotage' then
		doTweenAlpha('sabotageEnd', 'sabotage', 0, 0.7, 'easeOut')
	end
end

function onTimerCompleted(tag)
	if tag == 'bfDiesTime' then
		doTweenX('bfgoesweeeX', 'beef', -1840, 70, 'linear')
		doTweenY('bfgoesweee', 'beef', 1840, 80, 'linear')
		doTweenAngle('bfgoeswooo', 'beef', 360, 76, 'linear')
	end
end