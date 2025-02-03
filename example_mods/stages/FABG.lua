math.randomseed(os.time())

local walkChars = {'liz', 'girl', 'kianas', 'handzyCouple', 'jc', 'zuyu', 'craig'}
local walkCharsSizes = {0.8, 0.8, 1.3, 1.2, 1, 0.7, 1.6}
local walkCharsY = {-130, -120, -440, -300, -300, -200, -240}
local walkCharsYOrigins = {800, 800, 850, 850, 900, 900, 950}

local charLoaded = '';
local curChar = ''

local rightMovement = math.random(0, 1)

local num = 0

function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('BG', 'bgs/kyu/background', -100, -400);
		setScrollFactor('BG', 0.9, 0.9);
		
		makeLuaSprite('MG', 'bgs/kyu/middleground', -100, -450);
		setScrollFactor('MG', 0.9, 0.9);
		
		makeLuaSprite('backgroundCharacters', 'bgs/kyu/batch-'..getRandomInt(1, 5), -100, -170);
		setScrollFactor('backgroundCharacters', 0.9, 0.9);
		setProperty('backgroundCharacters.origin.y', 400)
		
		makeLuaSprite('tables', 'bgs/kyu/tables', -80, -340);
		setScrollFactor('tables', 0.9, 0.9);
		scaleObject('tables', 0.97, 0.9)
		
		num = getRandomInt(1, 7)
		curChar = walkChars[num]
		charLoaded = curChar
		makeLuaSprite('walkingChar', 'bgs/kyu/walkingChars/'..charLoaded, 1800, walkCharsY[num]);
		scaleObject('walkingChar', walkCharsSizes[num], walkCharsSizes[num])
		setScrollFactor('walkingChar', 0.9, 0.9);
		setProperty('walkingChar.origin.y', walkCharsYOrigins[num])
		
		if rightMovement == 1 then
			setProperty('walkingChar.flipX', true)
			setProperty('walkingChar.x', -1100)
		else
			setProperty('walkingChar.flipX', false)
			setProperty('walkingChar.x', 1800)
		end
		
		makeLuaSprite('FG', 'bgs/kyu/foreground', -100, 470);
		setScrollFactor('FG', 0.9, 0.9);
		
		makeLuaSprite('food', 'bgs/kyu/food', -100, 320);
		setScrollFactor('food', 0.9, 0.9);
		scaleObject('food', 0.95, 1)
		
		addLuaSprite('BG', false);
		addLuaSprite('MG', false);
		addLuaSprite('tables', false);
		addLuaSprite('backgroundCharacters', false);
		addLuaSprite('walkingChar', false);
		addLuaSprite('FG', false);
		addLuaSprite('food', true);
	
		runTimer('charAppear', getRandomInt(3, 6) / playbackRate)
	end
end

function onBeatHit()
	if not optimizationMode then
		if curBeat % 2 == 0 then
			setProperty('backgroundCharacters.scale.y', 0.95)
			doTweenY('backCharTween', 'backgroundCharacters.scale', 1, 0.6 / playbackRate, 'circOut')
			
			setProperty('walkingChar.scale.y', walkCharsSizes[num] - 0.03)
			doTweenY('walkCharTween', 'walkingChar.scale', walkCharsSizes[num], 0.6 / playbackRate, 'circOut')
		end
		if walkChars[num] == 'zuyu' then
			if curBeat % 4 == 0 then	
				cancelTween('walkCharTweenDown')
				doTweenY('walkCharTweenUp', 'walkingChar', walkCharsY[num] - 50, 1 / playbackRate, 'cubeInOut')
			end
			if curBeat % 4 == 2 then
				cancelTween('walkCharTweenUp')
				doTweenY('walkCharTweenDown', 'walkingChar', walkCharsY[num] + 50, 1 / playbackRate, 'cubeInOut')
			end
		end
		
		if walkChars[num] ~= 'zuyu' then
			setProperty('walkingChar.y', walkCharsY[num] + 10)
			doTweenY('walkCharTweenY', 'walkingChar', walkCharsY[num], 0.6 / playbackRate, 'circOut')
		end
	end
end

function onTimerCompleted(tag)
	if not optimizationMode then
		if tag == 'charAppear' then
			if rightMovement == 1 then
				doTweenX('charMove', 'walkingChar', 1800, getRandomInt(6, 10) / playbackRate, 'easeIn')
			else
				doTweenX('charMove', 'walkingChar', -1100, getRandomInt(6, 10) / playbackRate, 'easeIn')
			end
		end
		if tag == 'reloadChar' then
			num = getRandomInt(1, 7)
			charLoaded = walkChars[num]
			if charLoaded == curChar then
				runTimer('reloadChar', 0.01)
			else
				loadGraphic('walkingChar', 'bgs/kyu/walkingChars/'..charLoaded)
				scaleObject('walkingChar', walkCharsSizes[num], walkCharsSizes[num])
				setProperty('walkingChar.y', walkCharsY[num])
				setProperty('walkingChar.origin.y', walkCharsYOrigins[num])

				curChar = charLoaded
				
				if rightMovement == 1 then
					setProperty('walkingChar.flipX', true)
					setProperty('walkingChar.x', -1100)
				else
					setProperty('walkingChar.flipX', false)
					setProperty('walkingChar.x', 1800)
				end
			end
		end
		
		if tag == 'wait' then
			if inGameOver then
				doTweenAlpha('BG', 'BG', 0, 1, 'easeIn')
				doTweenAlpha('MG', 'MG', 0, 1, 'easeIn')
				doTweenAlpha('backgroundCharacters', 'backgroundCharacters', 0, 1, 'easeIn')
				doTweenAlpha('tables', 'tables', 0, 1, 'easeIn')
			end
		end
	end
end

local dead = false
function onTweenCompleted(tag)
	if not optimizationMode then
		if tag == 'charMove' then
			math.randomseed(os.time())
			rightMovement = math.random(0, 1)
			runTimer('reloadChar', 0.01)
			runTimer('charAppear', getRandomInt(2, 8) / playbackRate)	
		end
		
		if tag == 'boyfriend' then
			dead = true
		end
	end
end

function onGameOverStart()
	if not dead then
		--setProperty('boyfriend.alpha', 0)
		setObjectOrder('BG', getObjectOrder('boyfriendGroup') + 1)
		setObjectOrder('MG', getObjectOrder('BG') + 1)
		setObjectOrder('backgroundCharacters', getObjectOrder('MG') + 1)
		setObjectOrder('tables', getObjectOrder('backgroundCharacters') + 1)
		
		setProperty('boyfriend.scale.x', 1.02)
		setScrollFactor('boyfriend', 0, 0)
		setScrollFactor('BG', 0, 0)
		setScrollFactor('MG', 0, 0)
		setScrollFactor('backgroundCharacters', 0, 0)
		setScrollFactor('tables', 0, 0)
		setScrollFactor('FG', 0, 0)
		
		screenCenter('boyfriend', 'XY')
		
		setProperty('BG.y', getProperty('BG.y') + 100)
		setProperty('MG.y', getProperty('MG.y') + 100)
		setProperty('backgroundCharacters.y', getProperty('backgroundCharacters.y') + 100)
		setProperty('tables.y', getProperty('tables.y') + 100)
		--setProperty('boyfriend.x', getProperty('boyfriend.x') + 400)
		--setProperty('boyfriend.y', getProperty('boyfriend.y') + 210)
		
		cameraSetTarget('boyfriend')
		runTimer('wait', 0.5)
		dead = true
		return Function_Stop;
	end
	return Function_Continue;
end
