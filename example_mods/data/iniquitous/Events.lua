local dadX
local bfX

function onCreate()
	addCharacterToList('gfIniquitousP2', 'boyfriend')
	addCharacterToList('iniquitousP2', 'dad')
	addCharacterToList('iniquitousP3', 'dad')
	
	for i = 1, 4 do
		precacheSound('Static Noises/Glitch-'..i)
	end
	
	makeLuaSprite('intro', 'bgs/iniquitous/intro1', mobileFix("X", -350), -200)
	setScrollFactor('intro', 0, 0)
	setObjectCamera('intro', 'game')
	addLuaSprite('intro', true)
	
	makeLuaSprite('intro2', 'bgs/iniquitous/intro2', mobileFix("X", -350), -200)
	setScrollFactor('intro2', 0, 0)
	setObjectCamera('intro2', 'game')
	setProperty('intro2.alpha', 0)
	addLuaSprite('intro2', true)
	
	setProperty('camHUD.alpha', 0)
	setProperty('healthBar.alpha', 0)
	setProperty('healthBarBG.alpha', 0)
	
	makeLuaSprite('blackBG', nil, 0, 0)
	makeGraphic('blackBG', screenWidth * 1.5, screenHeight * 1.5, 'FFFFFF')
	screenCenter("blackBG", "XY")
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	addLuaSprite('blackBG', true)
	
	makeLuaText('dialogue', "", 1000, mobileFix("X", 130), 520)
	setTextSize('dialogue', 35)
	setProperty('dialogue.alpha', 0)
	setObjectCamera('dialogue', 'game')
	setTextColor('dialogue', 'FF0000')
	addLuaText('dialogue')
	
	dadX = getProperty('dad.x')
	bfX = getProperty('boyfriend.x')
	
	setProperty('boyfriend.alpha', 0)
	setProperty('GFPart.alpha', 0)
end

local hudThings = {'iconP1', 'iconP2', 'charmSocket', 'scoreTxt', 'watermark', 'watermark2', 'resCharm', 'aCharm', 'healCharm'}

function onUpdate()
	if curBeat == 0 then
		doTweenAlpha('blackBG', 'blackBG', 0, 7 / playbackRate, 'cubeInOut')
	end
	if curBeat == 32 then
		doTweenAlpha('intro2', 'intro2', 1, 4 / playbackRate, 'cubeInOut')
	end
	if curBeat == 44 then
		setObjectOrder('intro', getObjectOrder('intro') + 2)
		setProperty('intro.alpha', 0)
		setProperty('blackBG.color', getColorFromHex('0xF000000'))
		doTweenAlpha('blackBG', 'blackBG', 1, 6 / playbackRate, 'cubeInOut')
	end
	if curBeat == 62 then
		setProperty('intro.alpha', 1)
		loadGraphic('intro', 'bgs/iniquitous/intro3')
		cameraFlash('game', 'FF0000', 0.4 / playbackRate, false)
	end
	if curBeat == 63 then
		loadGraphic('intro', 'bgs/iniquitous/intro4')
		cameraFlash('game', 'FF0000', 0.4 / playbackRate, false)
	end
	if curBeat == 64 then
		removeLuaSprite('intro', true)
		removeLuaSprite('intro2', true)
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		doTweenAlpha('blackBG', 'blackBG', 0, 21 / playbackRate, 'cubeInOut')
	end
	if curBeat == 96 then
		runTimer('change', 0.01)
	end
	if curBeat == 128 then
		callScript("scripts/OpeningCards", "setUpCard", false)
		setGlobalFromScript('scripts/OpeningCards', 'allowIntroCard', true)

		doTweenAlpha('hud', 'camHUD', 1, 0.8 / playbackRate, 'circOut')
		runTimer('change', 0.01)
	end
	if curBeat >= 129 and curBeat < 240 then
		if curBeat % 16 == 0 then
			runTimer('change', 0.01)
		end
	end
	if curBeat == 240 then
		doTweenAlpha('gfAppear', 'boyfriend', 1, 0.7 / playbackRate, 'circOut')
		doTweenAlpha('gfBGAppear', 'GFPart', 1, 0.7 / playbackRate, 'circOut')
	end
	if curBeat == 336 then
		cameraFlash('game', 'FFFFFF', 0.6 / playbackRate, false)
		
		removeLuaSprite('BGP0', true)
		removeLuaSprite('BGP1', true)
		removeLuaSprite('GFPart', true)
		setProperty('Base.alpha', 1)
		setProperty('BGP2.alpha', 1)
		
		setProperty('dad.x', bfX + 100)
		setProperty('dad.y', getProperty('boyfriend.y') - 550)
		
		setProperty('boyfriend.x', dadX - 130)

		triggerEvent('Change Character', 'dad', 'iniquitousP2')
		triggerEvent('Change Character', 'bf', 'gfIniquitousP2')
	end
	
	if curBeat == 464 then	
		setProperty('blackBG.alpha', 1)
		setProperty('dialogue.alpha', 1)
		setProperty('camZooming', false)
		setProperty('camHUD.alpha', 0)
	end
	
	-- Dialogue go brRRRRRRRRRRRRRRRR
	if curStep == 1924 then
		setTextString('dialogue', "Not")
	end
	if curStep == 1928 then
		setTextString('dialogue', "Not everyone")
	end
	if curStep == 1936 then
		setTextString('dialogue', "Not everyone who")
	end
	if curStep == 1938 then
		setTextString('dialogue', "Not everyone who calls him")
	end
	if curStep == 1943 then
		setTextString('dialogue', "Not everyone who calls him lord")
	end
	if curStep == 1948 then
		setTextString('dialogue', "Not everyone who calls him lord will")
	end
	if curStep == 1950 then
		setTextString('dialogue', "Not everyone who calls him lord will enter")
	end
	if curStep == 1953 then
		setTextString('dialogue', "Not everyone who calls him lord will enter the Paradise,")
	end
	if curStep == 1989 then
		setTextString('dialogue', "But only the one who does the will of Father")
	end
	if curStep == 1989 then
		setTextString('dialogue', "But")
	end
	if curStep == 1991 then
		setTextString('dialogue', "But only")
	end
	if curStep == 1995 then
		setTextString('dialogue', "But only the")
	end
	if curStep == 1996 then
		setTextString('dialogue', "But only the one")
	end
	if curStep == 1999 then
		setTextString('dialogue', "But only the one who does")
	end
	if curStep == 2004 then
		setTextString('dialogue', "But only the one who does the will")
	end
	if curStep == 2009 then
		setTextString('dialogue', "But only the one who does the will of Father,")
	end
	if curStep == 2050 then
		setTextString('dialogue', "When")
	end
	if curStep == 2052 then
		setTextString('dialogue', "When we'll")
	end
	if curStep == 2055 then
		setTextString('dialogue', "When we'll say")
	end
	if curStep == 2057 then
		setTextString('dialogue', "When we'll say to him")
	end
	if curStep == 2061 then
		setTextString('dialogue', "When we'll say to him that")
	end
	if curStep == 2065 then
		setTextString('dialogue', "When we'll say to him that day:")
	end
	if curStep == 2068 then
		setTextString('dialogue', "'Oh")
	end
	if curStep == 2071 then
		setTextString('dialogue', "'Oh lord")
	end
	if curStep == 2074 then
		setTextString('dialogue', "'Oh lord we did this,")
	end
	if curStep == 2081 then
		setTextString('dialogue', "'Oh lord we did this, we did that,")
	end
	if curStep == 2087 then
		setTextString('dialogue', "'Oh lord we did this, we did that, on your name.'")
	end
	if curStep == 2100 then
		setTextString('dialogue', "And")
	end
	if curStep == 2101 then
		setTextString('dialogue', "And he")
	end
	if curStep == 2102 then
		setTextString('dialogue', "And he will")
	end
	if curStep == 2105 then
		setTextString('dialogue', "And he will tell")
	end
	if curStep == 2107 then
		setTextString('dialogue', "And he will tell them:")
	end
	if curStep == 2116 then
		setTextString('dialogue', "'I")
	end
	if curStep == 2118 then
		setTextString('dialogue', "'I never")
	end
	if curStep == 2122 then
		setTextString('dialogue', "'I never knew")
	end
	if curStep == 2124 then
		setTextString('dialogue', "'I never knew you.'")
	end
	if curStep == 2135 then
		setTextString('dialogue', "'Depart")
	end
	if curStep == 2140 then
		setTextString('dialogue', "'Depart from")
	end
	if curStep == 2143 then
		setTextString('dialogue', "'Depart from me,'")
	end
	if curStep == 2153 then
		setTextString('dialogue', "'Practicers")
	end
	if curStep == 2161 then
		setTextString('dialogue', "'Practicers of")
	end
	if curStep == 2164 then
		setTextColor('dialogue', '780000')
		setProperty('camZooming', true)
		setTextString('dialogue', "'Practicers of Iniquity.'")
	end
	
	if curBeat == 544 then
		doTweenAlpha('dialogue', 'dialogue', 0, 0.8 / playbackRate, 'cubeInOut')
		doTweenAlpha('camHUD', 'camHUD', 1, 0.8 / playbackRate, 'cubeInOut')
		doTweenAlpha('blackBG', 'blackBG', 0, 8 / playbackRate, 'cubeInOut')
	end
	
	if curBeat == 608 then
		cameraFlash('hud', 'ff0000', 0.6 / playbackRate, false)
		triggerEvent('Change Character', 'dad', 'iniquitousP3')
		setProperty('dad.x', bfX + 100)
		setProperty('dad.y', getProperty('boyfriend.y') - 550)
	end
	if curBeat == 744 then
		setProperty('blackBG.alpha', 1)
		for i = 1, #(hudThings) do
			setProperty(hudThings[i]..'.alpha', 0)
		end
		doTweenAlpha('timeTxt', 'timeTxt', 0, 4 / playbackRate)
	end
	if curBeat >= 744 then
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums', i, 'alpha', 0);
			setPropertyFromGroup('playerStrums', i, 'alpha', 0);
		end
	end
end

function onTimerCompleted(tag)
	if tag == 'change' then
		if getProperty('boyfriend.alpha') == 1 then
			doTweenAlpha('gfGoAway', 'boyfriend', 0, 0.7 / playbackRate, 'circOut')
			doTweenAlpha('gfBGGoAway', 'BGP0', 0, 0.7 / playbackRate, 'circOut')
			doTweenAlpha('dadAppear', 'dad', 1, 0.7 / playbackRate, 'circOut')
			doTweenAlpha('dadBGAppear', 'BGP1', 1, 0.7 / playbackRate, 'circOut')
		end
		if getProperty('dad.alpha') == 1 then
			doTweenAlpha('dadGoAway', 'dad', 0, 0.7 / playbackRate, 'circOut')
			doTweenAlpha('dadBGGoAway', 'BGP1', 0, 0.7 / playbackRate, 'circOut')
			doTweenAlpha('gfAppear', 'boyfriend', 1, 0.7 / playbackRate, 'circOut')
			doTweenAlpha('gfBGAppear', 'BGP0', 1, 0.7 / playbackRate, 'circOut')
		end
	end
end