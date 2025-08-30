allowIntroCard = true
finishSequence = false
local canScale = false
local scaleNum = 0;
local dur = 0

function onCreatePost()	
	dur = 0.7 / playbackRate;
	
	makeLuaSprite('openingcards', 'openingcards/card', 0, -70);
	setObjectCamera('openingcards', 'hud')
	addLuaSprite('openingcards', true)
		
	if downscroll then
		setProperty('openingcards.flipY', true)
		setProperty('openingcards.y', 70)
	end
		
	makeLuaText('NowPlay', songName, screenWidth, getProperty('openingcards.x'), -70);
	setObjectCamera('NowPlay', 'hud');
	setTextSize('NowPlay', 32);
	setTextFont('NowPlay', 'PhantomMuff.ttf')
	addLuaText('NowPlay');
		
	makeLuaText('NowPlay2', "Composed by: ", screenWidth, getProperty('openingcards.x'), -70);
	setObjectCamera('NowPlay2', 'hud');
	setTextSize('NowPlay2', 32);
	setTextFont('NowPlay2', 'PhantomMuff.ttf')
	setProperty('NowPlay2.alpha', 0)
	addLuaText('NowPlay2');
		
	if downscroll then
		setProperty('NowPlay.y', 720)
	end
	
	-- Check songs
	if songName == 'Couple Clash' then
		setUpCardDetails(true, 1.25, 32, "Composed By: TheRealOscamon")
	end
	
	if songName == 'Scrouge' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'Toxic Mishap' then
		setUpCardDetails(true, 1.75, 28, "Remixed by: Ricey / D3MON1X | OG By: Araz / Zuyu")
	end
	if songName == 'Paycheck' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'Villainy' then
		setUpCardDetails(false, 1, 32, "Composed By: Ricey")
	end
	
	if songName == 'Nunday Monday' then
		setUpCardDetails(false, 1, 32, "Composed By: D3MON1X")
	end
	if songName == 'Nunconventional' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'Point Blank' then
		setUpCardDetails(true, 1.50, 28, "Composed by: D3MON1X (ft. Shiloh)")
	end
	
	if songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'Toybox' then
		setUpCardDetails(false, 1, 32, "Composed By: HQC")
	end
	if songName == 'Lustality Remix' then
		setUpCardDetails(false, 1, 32, "Composed By: Ricey")
		
	end
	if songName == 'Libidinousness' then
		setUpCardDetails(false, 1, 32, "Composed By: HQC")
	end
	
	if songName == 'Spendthrift' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'Instrumentally Deranged' then
		setUpCardDetails(false, 1, 32, "Composed By: Araz")
	end
	if songName == "Get Villain'd" then
		setUpCardDetails(true, 1.25, 32, "Composed By: TheRealOscamon")
	end
	
	if songName == 'Cheap Skate (Legacy)' then
		setUpCardDetails(false, 1, 32, "Composed By: Araz / Zuyu")
	end
	if songName == 'Toxic Mishap (Legacy)' then
		setUpCardDetails(false, 1, 32, "Composed By: Araz")
	end
	if songName == 'Paycheck (Legacy)' then
		setUpCardDetails(false, 1, 32, "Composed By: Araz / Zuyu")
	end
	
	if songName == 'Sussus Marcus' or songName == 'Villain In Board' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'Excrete' then
		setUpCardDetails(false, 1, 32, "Composed By: D3MON1X")
	end
	
	if songName == 'Unpaid Catastrophe' then
		setUpCardDetails(true, 1.25, 32, "Composed By: Shiloh")
	end
	if songName == 'Cheque' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == "Get Gooned" or songName == "Get Pico'd" then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	
	if songName == "Iniquitous" then
		setUpCardDetails(false, 1, 32, "Composed By: Lillie")
	end

	if songName == 'Lustality' or songName == 'Lustality V1' then
		setUpCardDetails(true, 1.75, 30, "Cover By: Lizzy Strawberry | OG By: Saster")
	end
	
	if songName == 'Nunsational' then
		setUpCardDetails(true, 1.75, 30, "Cover By: Lizzy Strawberry | OG By: Tenzalt")
	end
	if songName == 'Tofu' then
		setUpCardDetails(true, 1.75, 28, "Cover By: Lizzy Strawberry | OG By: SuperiorFox")
	end
	if songName == 'Marcochrome' then
		setUpCardDetails(true, 1.75, 28, "Cover By: Lizzy Strawberry | Remix By: Aruichi Rui")
	end
	if songName == 'Slow.FLP' then
		setUpCardDetails(true, 1.05, 28, "Composed By: TheRealOscamon")
	end
	if songName == 'Marauder' then
		setUpCardDetails(true, 1.05, 28, "Composed By: TheRealOscamon")
	end
	if songName == 'Rainy Daze' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'FNV' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'Fanfuck Forever' then
		setUpCardDetails(false, 1, 32, "Composed By: Shiloh")
	end
	if songName == 'VGuy' then
		setUpCardDetails(true, 1.50, 32, "Composed by: Ricey / Shiloh")
	end
	if songName == 'Fast Food Therapy' then
		setUpCardDetails(false, 1, 32, "Composed By: Lillie")
	end
	if songName == 'Tactical Mishap' then
		setUpCardDetails(true, 1.50, 28, "Remixed By: Lillie | OG By: Araz / Zuyu")
	end
	if songName == 'Breacher' then
		setUpCardDetails(false, 1, 32, "Composed By: D3MON1X")
	end
	if songName == 'Negotiation' then
		setUpCardDetails(true, 1.05, 28, "Composed By: TheRealOscamon")
	end
	if songName == 'Concert Chaos' then
		setUpCardDetails(false, 1, 32, "Composed By: Lillie")
	end
	
	if songName == 'Slow.FLP (Old)' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'Marauder (Old)' then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	
	if songName == "It's Kiana" then
		setUpCardDetails(true, 1.75, 28, "Cover by: Lizzy Strawberry | Composed by: Sandi")
	end
	if songName == 'Partner' then
		setUpCardDetails(true, 1.75, 28, "Cover by: Lizzy Strawberry | Composed by: Sturm")
	end
	if songName == "Get Villain'd (Old)" then
		setUpCardDetails(false, 1, 32, "Composed By: Zuyu")
	end
	if songName == 'Shuckle Fuckle' then
		setUpCardDetails(true, 2, 24, "Cover by: Lizzy Strawberry | Voice by: Akira | Composed by: Ezzythecat")
	end
end

function onSongStart()
	if allowIntroCard then
		setUpCard(false)
	end
end

function onStepHit()
	if allowIntroCard and not finishSequence then
		if curStep % 128 == 64 then
			doTweenAlpha('NowPlay1Bye', 'NowPlay', 0, 0.3 / playbackRate, 'cubeInOut')
			doTweenAlpha('NowPlay2Hi', 'NowPlay2', 1, 0.3 / playbackRate, 'cubeInOut')
			if canScale == true then
				doTweenX('openingcardsScaleX', 'openingcards.scale', scaleNum, 0.3 / playbackRate, 'cubeInOut')
			end
		end
		if curStep % 128 == 127 then
			setUpCard(true)
		end
	end
end

function setUpCardDetails(allowScale, scale, textSize, textString)
	if allowScale then
		canScale = true
	end
	scaleNum = scale
	setTextSize('NowPlay2', textSize)
	setTextString('NowPlay2', textString)
end

local vars = {"openingcards", 'timerTxt', 'timerBar', 'timerBarBG', 'NowPlay', 'NowPlay2'}
function setUpCard(ending)
	if not ending then
		doTweenY('openingcards', 'openingcards', 0, dur, 'circOut')
		doTweenAlpha('timerTxt', 'timeTxt', 0, dur, 'cubeInOut')
		doTweenAlpha('timerBar', 'timeBar', 0, dur, 'cubeInOut')
		doTweenAlpha('timerBarBG', 'timeBarBG', 0, dur, 'cubeInOut')
		if downscroll then
			doTweenY('NowPlay', 'NowPlay', 670, dur, 'circOut')
			doTweenY('NowPlay2', 'NowPlay2', 670, dur, 'circOut')
		else
			doTweenY('NowPlay', 'NowPlay', 10, dur, 'circOut')
			doTweenY('NowPlay2', 'NowPlay2', 10, dur, 'circOut')
		end
	elseif ending then
		finishSequence = true

		for i = 1, #(vars) do
			cancelTween(vars[i])
		end
		
		if downscroll then
			doTweenY('NowPlay', 'NowPlay', 720, dur, 'cubeInOut')
			doTweenY('NowPlay2', 'NowPlay2', 720, dur, 'cubeInOut')
			doTweenY('openingcards', 'openingcards', 70, dur, 'cubeInOut')
		else
			doTweenY('NowPlay', 'NowPlay', -70, dur, 'cubeInOut')
			doTweenY('NowPlay2', 'NowPlay2', -70, dur, 'cubeInOut')
			doTweenY('openingcards', 'openingcards', -70, dur, 'cubeInOut')
		end
		doTweenAlpha('timerTxt', 'timeTxt', 1, dur, 'cubeInOut')
		doTweenAlpha('timerBar', 'timeBar', 1, dur, 'cubeInOut')
		doTweenAlpha('timerBarBG', 'timeBarBG', 1, dur, 'cubeInOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'timerTxt' and finishSequence then
		removeLuaSprite('openingcards', true)
		removeLuaText('NowPlay', true)
		removeLuaText('NowPlay2', true)
	end
end