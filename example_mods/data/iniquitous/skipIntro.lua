-- TAKE ME TO THE ACTION
-- script by Kaite#1102
-- This script lets you skip right to gameplay! (Sends you right before the first note)
-- useful when a song has a long wait before the action and you're trying to do something

-- CONFIG:
local checkForBF = false    -- Should the script check if the first note is yours           > (Default: false)
local beatsBefore = 2       -- How many beats before the first note will the time skip to   > (Default: 2)
local keybind = 'space'      -- What keybind will trigger the skip, leave blank for none     > (Default: 'back')
local keyboard = ''         -- What keyboard key will trigger the skip, blank for none      > (Default: '')
-- DONT TOUCH ANYTHING BELOW THIS HHH

local skipTime = 0
local canSkip = false
local crochet1 = 0
function onCreatePost()
    crochet1 = crochet
    skipTime = getPropertyFromGroup('unspawnNotes', 0, 'strumTime') - (crochet1*2)
    if checkForBF then
        for i = 0, getProperty('unspawnNotes.length') do
            if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                skipTime = getPropertyFromGroup('unspawnNotes', i, 'strumTime') - (crochet1*2)
                break
            end
        end
    end
	
	makeLuaText('skipTXT', 'Press SPACE to skip the intro.', 900, 200, 650)
	setTextAlignment('skipTXT', 'CENTER')
	setTextSize('skipTXT', 30)
	setProperty('skipTXT.alpha', 0)
	setObjectCamera('skipTXT', 'other')
	setTextColor('skipTXT', 'FF0000')
	addLuaText('skipTXT')
    -- debugPrint(skipTime)
end

function onSongStart()
	doTweenAlpha('makeSkipIntroAppear', 'skipTXT', 1, 0.7 / playbackRate, 'cubeInOut')
    canSkip = true
end

local skippedIntro = false
function onUpdate()
    if canSkip and getSongPosition() < skipTime then
        if (keybind ~= '' and keyJustPressed(keybind)) or (keyboard ~= '' and keyboardJustPressed(keyboard)) then
            canSkip = false
			skippedIntro = true
            -- debugPrint('hi ', getSongPosition(), ' ', skipTime)
            playSound('confirmMenu')
            cameraFlash('other', '0x55FFFFFF', crochet1*0.001, true)
            runHaxeCode([[game.setSongTime(]]..(skipTime)..[[)]])
			
			cancelTween('makeSkipIntroAppear')
			removeLuaText('skipTXT', true)
        end
    end
end

function onBeatHit()
	if curBeat == 44 then
		canSkip = false
		doTweenAlpha('makeSkipIntroDisappear', 'skipTXT', 0, 0.7 / playbackRate, 'cubeInOut')
	end
end

function onStepHit()
	if skippedIntro then
		removeLuaSprite('intro', true)
		removeLuaSprite('intro2', true)
		
		setProperty('camGame.alpha', 0)
		setProperty('blackBG.alpha', 0)
		setProperty('blackBG.color', getColorFromHex('0xF000000'))
		
		runTimer('change', 0.01)
		
		if curBeat == 128 then
			skippedIntro = false
			setProperty('camGame.alpha', 1)
			cameraFlash('game', 'FFFFFF', 0.7 / playbackRate, false)
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'makeSkipIntroDisappear' then
		removeLuaText('skipTXT', true)
	end
end