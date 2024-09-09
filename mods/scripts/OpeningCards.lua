function onCreate()	
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
	addLuaText('NowPlay', true);
		
	makeLuaText('NowPlay2', "Testing Phase", screenWidth, getProperty('openingcards.x'), -70);
	setProperty('NowPlay2.alpha', 0)
	setObjectCamera('NowPlay2', 'hud');
	setTextSize('NowPlay2', 32);
	setTextFont('NowPlay2', 'PhantomMuff.ttf')
	addLuaText('NowPlay2', true);
		
	if downscroll then
		setProperty('NowPlay.y', 720)
	end
end

local canScale = false
local scaleNum = 0;
function onUpdate()
	if songName == 'Couple Clash' then
		setTextString('NowPlay2', 'Composed by: TheRealOscamon')
	end
	
	if songName == 'Scrouge' then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	if songName == 'Toxic Mishap' then
		canScale = true
		scaleNum = 1.75
		setTextString('NowPlay2', 'Remixed by: Ricey / D3MON1X | OG By: Araz / Zuyu')
		setTextSize('NowPlay2', 28)
	end
	if songName == 'Paycheck' then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	if songName == 'Villainy' then
		setTextString('NowPlay2', 'Composed by: Ricey')
	end
	
	if songName == 'Nunday Monday' then
		setTextString('NowPlay2', 'Composed By: D3MON1X')
	end
	if songName == 'Nunconventional' then
		setTextString('NowPlay2', 'Composed By: Zuyu')
	end
	if songName == 'Nunconventional Simp' then
		setTextString('NowPlay', 'Nunconventional')
		setTextString('NowPlay2', 'Composed By: Zuyu')
	end
	if songName == 'Point Blank' then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 28)
		setTextString('NowPlay2', 'Composed by: D3MON1X (ft. Shiloh)')
	end
	
	if songName == 'Forsaken' or songName == 'Forsaken (Picmixed)' then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	if songName == 'Toybox' then
		setTextString('NowPlay2', 'Composed By: HQC')
	end
	if songName == 'Lustality Remix' then
		setTextString('NowPlay2', 'Composed By: Ricey')
	end
	if songName == 'Libidinousness' then
		setTextString('NowPlay2', 'Composed By: HQC')
	end
	
	if songName == 'Spendthrift' then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	if songName == 'Instrumentally Deranged' then
		setTextString('NowPlay2', 'Composed by: Araz')
	end
	if songName == "Get Villain'd" then
		setTextString('NowPlay2', 'Composed By: Zuyu')
	end
	
	if songName == 'Cheap Skate (Legacy)' then
		setTextString('NowPlay2', 'Composed by: Araz / Zuyu')
	end
	if songName == 'Toxic Mishap (Legacy)' then
		setTextString('NowPlay2', 'Composed by: Araz')
	end
	if songName == 'Paycheck (Legacy)' then
		setTextString('NowPlay2', 'Composed by: Araz / Zuyu')
	end
	
	if songName == 'Sussus Marcus' or songName == 'Villain In Board' then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	if songName == 'Excrete' then
		setTextString('NowPlay2', 'Composed by: D3MON1X')
	end
	
	if songName == 'Unpaid Catastrophe' then
		canScale = true
		scaleNum = 1.25
		setTextString('NowPlay2', 'Composed by: Shiloh')
	end
	if songName == 'Cheque' then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	if songName == "Get Gooned" or songName == "Get Pico'd" then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	
	if songName == "Iniquitous" then
		setTextString('NowPlay2', 'Composed By: Lillie')
	end
	
	if songName == 'Lustality' then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 30)
		setTextString('NowPlay2', 'Cover By: Strawberry | OG By: Saster')
	end
	
	if songName == 'Lustality V1' then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 30)
		setTextString('NowPlay2', 'Cover By: Strawberry  | OG By: Saster')
	end
	
	if songName == 'Nunsational' then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 30)
		setTextString('NowPlay2', 'Cover By: Strawberry | OG By: Tenzalt')
	end
	if songName == 'Nunsational Simp' then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 30)
		setTextString('NowPlay', 'Nunsational')
		setTextString('NowPlay2', 'Cover By: Strawberry | OG By: Tenzalt')
	end
	if songName == 'Tofu' then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 28)
		setTextString('NowPlay2', 'Cover By: Strawberry | OG By: SuperiorFox')
	end
	if songName == 'Marcochrome' then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 28)
		setTextString('NowPlay2', 'Cover By: Strawberry | Remix By: Aruichi Rui')
	end
	if songName == 'Slow.FLP' then
		canScale = true
		scaleNum = 1.05
		setTextSize('NowPlay2', 28)
		setTextString('NowPlay2', 'Composed by: TheRealOscamon')
	end
	if songName == 'Marauder' then
		canScale = true
		scaleNum = 1.05
		setTextSize('NowPlay2', 28)
		setTextString('NowPlay2', 'Composed by: TheRealOscamon')
	end
	if songName == 'Rainy Daze' then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	if songName == 'FNV' then
		setTextString('NowPlay2', 'Composed By: Zuyu')
	end
	if songName == 'Tactical Mishap' then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 28)
		setTextString('NowPlay2', 'Remixed By: Lillie | OG By: Araz / Zuyu')
	end
	if songName == 'VGuy' then
		canScale = true
		scaleNum = 1.50
		setTextString('NowPlay2', 'Composed by: Ricey / Shiloh')
	end
	if songName == 'Fast Food Therapy' then
		setTextString('NowPlay2', 'Composed By: Lillie')
	end
	if songName == 'Fanfuck Forever' then
		setTextString('NowPlay2', 'Composed by: Shiloh')
	end
	if songName == 'Concert Chaos' then
		setTextString('NowPlay2', 'Composed by: Lillie')
	end
	if songName == 'Breacher' then
		setTextString('NowPlay2', 'Composed by: D3MON1X')
	end
	
	if songName == 'Slow.FLP (Old)' then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	if songName == 'Marauder (Old)' then
		setTextString('NowPlay2', 'Composed by: Zuyu')
	end
	if songName == "It's Kiana" then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 28)
		setTextString('NowPlay2', 'Cover by: Strawberry | Composed by: Sandi')
	end
	
	if songName == 'Partner' then
		canScale = true
		scaleNum = 1.50
		setTextSize('NowPlay2', 28)
		setTextString('NowPlay2', 'Cover by: Strawberry | Composed by: Sturm')
	end
	if songName == 'Shucks V2' then
		canScale = true
		scaleNum = 1.75
		setTextSize('NowPlay2', 24)
		setTextString('NowPlay2', 'Done by: Strawberry | Voice by: Akira | Composed by: Ezzythecat')
	end
	
	if curStep == 0 then
		doTweenY('openingcards', 'openingcards', 0, 1 / playbackRate, 'cubeInOut')
		doTweenAlpha('timerTxt', 'timeTxt', 0, 1 / playbackRate, 'cubeInOut')
		doTweenAlpha('timerBar', 'timeBar', 0, 1 / playbackRate, 'cubeInOut')
		doTweenAlpha('timerBarBG', 'timeBarBG', 0, 1 / playbackRate, 'cubeInOut')
		if not downscroll then
			doTweenY('NowPlay', 'NowPlay', 10, 1 / playbackRate, 'cubeInOut')
			doTweenY('NowPlay2', 'NowPlay2', 10, 1 / playbackRate, 'cubeInOut')
		end
		if downscroll then
			doTweenY('NowPlay', 'NowPlay', 670, 1 / playbackRate, 'cubeInOut')
			doTweenY('NowPlay2', 'NowPlay2', 670, 1 / playbackRate, 'cubeInOut')
		end
	end 
	if curStep == 64 then
		doTweenAlpha('NowPlay1Bye', 'NowPlay', 0, 0.3 / playbackRate, 'cubeInOut')
		doTweenAlpha('NowPlay2Hi', 'NowPlay2', 1, 0.3 / playbackRate, 'cubeInOut')
		if canScale == true then
			doTweenX('openingcardsScaleX', 'openingcards.scale', scaleNum, 0.3 / playbackRate, 'circInOut')
		end
	end
	if curStep == 128 then
		if not downscroll then
			doTweenY('NowPlay', 'NowPlay', -70, 1 / playbackRate, 'cubeInOut')
			doTweenY('NowPlay2', 'NowPlay2', -70, 1 / playbackRate, 'cubeInOut')
			doTweenY('openingcards', 'openingcards', -70, 1 / playbackRate, 'cubeInOut')
		end
		if downscroll then
			doTweenY('NowPlay', 'NowPlay', 720, 1 / playbackRate, 'cubeInOut')
			doTweenY('NowPlay2', 'NowPlay2', 720, 1 / playbackRate, 'cubeInOut')
			doTweenY('openingcards', 'openingcards', 70, 1 / playbackRate, 'cubeInOut')
		end
		doTweenAlpha('timerTxt', 'timeTxt', 1, 1 / playbackRate, 'cubeInOut')
		doTweenAlpha('timerBar', 'timeBar', 1, 1 / playbackRate, 'cubeInOut')
		doTweenAlpha('timerBarBG', 'timeBarBG', 1, 1 / playbackRate, 'cubeInOut')
		end
	if curStep == 192 then
		removeLuaSprite('openingcards', true)
		removeLuaText('NowPlay', true)
		removeLuaText('NowPlay2', true)
	end 
end