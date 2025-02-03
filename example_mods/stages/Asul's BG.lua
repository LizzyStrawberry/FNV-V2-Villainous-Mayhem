function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('BGP1', 'bgs/asul/BGP1', -1690, -570);
		setScrollFactor('BGP1', 0.95, 0.95);
		scaleObject('BGP1', 2.5, 2)
	
		makeLuaSprite('fuckyouhaveanotherbridge', 'bgs/asul/fuckinBridge', -1320, -450);
		setScrollFactor('fuckyouhaveanotherbridge', 0.4, 0.4);
		scaleObject('fuckyouhaveanotherbridge', 2.1, 1.2)
		setProperty('fuckyouhaveanotherbridge.alpha', 0)
		
		makeLuaSprite('BGP2Back', 'bgs/asul/BGP2Back', -990, -850);
		setScrollFactor('BGP2Back', 0.2, 0.2);
		scaleObject('BGP2Back', 1.7, 1.7)
		setProperty('BGP2Back.alpha', 0)
	
		makeLuaSprite('BGP2', 'bgs/asul/BGP2', -1520, -580);
		setScrollFactor('BGP2', 1, 1);
		scaleObject('BGP2', 2.3, 1.6)
		setProperty('BGP2.origin.y', 300)
		setProperty('BGP2.scale.y', 2)
		setProperty('BGP2.alpha', 0)
		
		makeLuaSprite('BGP3', 'bgs/asul/BGP3', -660, -100);
		setScrollFactor('BGP3', 0.95, 0.95);
		scaleObject('BGP3', 1.3, 1.3)
		setProperty('BGP3.alpha', 0)
		
		makeLuaSprite('fuckinPillars', 'bgs/asul/fuckinPillars', 2000, -300);
		setScrollFactor('fuckinPillars', 0.95, 0.95);
		scaleObject('fuckinPillars', 1.5, 1.5)
		setProperty('fuckinPillars.alpha', 0)
		
		makeLuaSprite('fuckinPillarsInFrontOfYouBitch', 'bgs/asul/fuckinPillars', 3000, -300);
		setScrollFactor('fuckinPillarsInFrontOfYouBitch', 0.95, 0.95);
		scaleObject('fuckinPillarsInFrontOfYouBitch', 3, 3)
		setProperty('fuckinPillarsInFrontOfYouBitch.alpha', 1)

		addLuaSprite('BGP1', false);
		addLuaSprite('BGP2Back', false);
		addLuaSprite('BGP3', false);
		addLuaSprite('fuckyouhaveanotherbridge', false);
		addLuaSprite('fuckinPillars', false);
		addLuaSprite('BGP2', false);
		addLuaSprite('fuckinPillarsInFrontOfYouBitch', true);
	end
	
	setProperty('defaultCamZoom', 0.7)
	
	runTimer('pillarMOVEEEEE', 0.01)
end

function onUpdate()
	if curBeat == 200 then
		runTimer('pillarMOVEEEEEinfrontofyoubitch', 0.01)
	end
end

function onTimerCompleted(tag)
	if tag == 'pillarMOVEEEEE' then
		pos = getRandomInt(1,2)
		if curBeat < 308 then
			depth = getRandomInt(1, 3)
		else
			depth = getRandomInt(1, 2)
		end
		if pos == 1 then
			setProperty('fuckinPillars.x', 2500)
			setProperty('fuckinPillars.flipX', false)
			
			if depth == 1 then
				scaleObject('fuckinPillars', 1.5, 1.5)
				setProperty('fuckinPillars.y', -300)
				setObjectOrder('fuckinPillars', 5)
			elseif depth == 2 then
				scaleObject('fuckinPillars', 1.2, 1.2)
				setProperty('fuckinPillars.y', -300)
				setObjectOrder('fuckinPillars', 5)
			elseif depth == 3 then
				scaleObject('fuckinPillars', 0.8, 0.8)
				setProperty('fuckinPillars.y', -100)
				setObjectOrder('fuckinPillars', 4)
			end
			
			if (curBeat >= 0 and curBeat < 138) or (curBeat >= 200 and curBeat < 264) or curBeat >= 436 then
				doTweenX('pillarFuckingMove', 'fuckinPillars', -2500, 1.7 / playbackRate, 'linear')
			elseif (curBeat >= 138 and curBeat < 200) or (curBeat >= 264 and curBeat < 308) then
				doTweenX('pillarFuckingMove', 'fuckinPillars', -2500, 1 / playbackRate, 'linear')
			elseif curBeat >= 308 and curBeat < 436 then
				doTweenX('pillarFuckingMove', 'fuckinPillars', -2500, 0.4 / playbackRate, 'linear')
			end
		else
			setProperty('fuckinPillars.x', -2500)
			setProperty('fuckinPillars.flipX', true)
			
			if depth == 1 then
				scaleObject('fuckinPillars', 1.5, 1.5)
				setProperty('fuckinPillars.y', -300)
				setObjectOrder('fuckinPillars', 5)
			elseif depth == 2 then
				scaleObject('fuckinPillars', 1.2, 1.2)
				setProperty('fuckinPillars.y', -300)
				setObjectOrder('fuckinPillars', 5)
			elseif depth == 3 then
				scaleObject('fuckinPillars', 0.8, 0.8)
				setProperty('fuckinPillars.y', -100)
				setObjectOrder('fuckinPillars', 4)
			end
			
			if (curBeat >= 0 and curBeat < 138) or (curBeat >= 200 and curBeat < 264) or curBeat >= 436 then
				doTweenX('pillarFuckingMove', 'fuckinPillars', 2500, 1.7 / playbackRate, 'linear')
			elseif (curBeat >= 138 and curBeat < 200) or (curBeat >= 264 and curBeat < 308) then
				doTweenX('pillarFuckingMove', 'fuckinPillars', 2500, 1 / playbackRate, 'linear')
			elseif curBeat >= 308 and curBeat < 436 then
				doTweenX('pillarFuckingMove', 'fuckinPillars', 2500, 0.4 / playbackRate, 'linear')
			end
		end
	end
	
	if tag == 'pillarMOVEEEEEinfrontofyoubitch' then
		pos = getRandomInt(1,2)
		if pos == 1 then
			setProperty('fuckinPillarsInFrontOfYouBitch.x', 3500)
			setProperty('fuckinPillarsInFrontOfYouBitch.flipX', false)
			
			doTweenX('pillarFuckingMoveBITCH', 'fuckinPillarsInFrontOfYouBitch', -3500, 15 / playbackRate, 'linear')
		else
			setProperty('fuckinPillarsInFrontOfYouBitch.x', -3500)
			setProperty('fuckinPillarsInFrontOfYouBitch.flipX', true)

			doTweenX('pillarFuckingMoveBITCH', 'fuckinPillarsInFrontOfYouBitch', 3500, 15 / playbackRate, 'linear')
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'pillarFuckingMove' then
		runTimer('pillarMOVEEEEE', 0.01)
	end
end
