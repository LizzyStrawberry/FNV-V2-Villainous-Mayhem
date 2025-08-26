--Original Events by Lillie, modified by Strawberry
local clonesOriginScaleY
local addShaders = false

function onCreate()
	if not getPropertyFromClass('ClientPrefs', 'optimizationMode') then
		addCharacterToList('lilyIntroP2', 'boyfriend')
		addCharacterToList('lilyP1', 'boyfriend')
		addCharacterToList('lilyP2', 'boyfriend')
		addCharacterToList('lilyP3', 'boyfriend')
		addCharacterToList('lilyDebugP1', 'boyfriend')
		addCharacterToList('lilyDebugP2', 'boyfriend')
		addCharacterToList('managerChanP1', 'boyfriend')
		
		addCharacterToList('marcoCCP1', 'dad')
		addCharacterToList('marcoCCP3', 'dad')
		addCharacterToList('kaizokuCCP1', 'dad')
		addCharacterToList('kaizokuCCP2', 'dad')
		addCharacterToList('kaizokuCCP3', 'dad')
		addCharacterToList('debugGuyScaled', 'dad')
		addCharacterToList('aileenCCP1', 'dad')
		
		precacheImage('notes/AileenNOTE_assets')
		precacheImage('notes/MarcoNOTE_assets')
	end
	
	setProperty('dad.alpha', 0);
	setProperty('healthBar.alpha', 0);
	setProperty('healthBarBG.alpha', 0);
	setProperty('iconP1.alpha', 0);
	setProperty('iconP2.alpha', 0);
	
	makeLuaSprite('floorLight', 'effects/floorLight', getProperty('boyfriend.x') - 135, getProperty('boyfriend.y') + 430)
	scaleObject('floorLight', 0.65, 0.6)
	setProperty('floorLight.alpha', 0)
	addLuaSprite('floorLight', false)
	
	makeLuaSprite('light1', 'effects/light1', getProperty('boyfriend.x') - 530, getProperty('boyfriend.y') - 480)
	setProperty('light1.alpha', 0)
	addLuaSprite('light1', true)
	
	makeLuaSprite('light2', 'effects/light2', getProperty('boyfriend.x') - 130, getProperty('boyfriend.y') - 120)
	scaleObject('light2', 0.8, 0.8)
	setProperty('light2.alpha', 0)
	addLuaSprite('light2', true)
	
	makeLuaSprite('playerCover', 'effects/playerCover', getProperty('boyfriend.x'), getProperty('boyfriend.y'))
	setProperty('playerCover.alpha', 0)
	scaleObject('playerCover', 1.2, 1.2)
	setObjectOrder('playerCover', getObjectOrder('dadGroup') + 1)
	addLuaSprite('playerCover', false)
	
	makeAnimatedLuaSprite('Audience', 'bgs/lily/audience', -570, 480);
	addAnimationByPrefix('Audience', 'clap', 'hands clap', 24 / playbackRate, false);
	setScrollFactor('Audience', 0.9, 0.9)
	scaleObject('Audience', 2.2, 1.8)
	setProperty('Audience.alpha', 0)
	addLuaSprite('Audience', true)
	
	makeLuaSprite('gfCover', 'effects/playerCover', getProperty('boyfriend.x'), getProperty('boyfriend.y'))
	setProperty('gfCover.alpha', 0)
	setProperty('gfCover.flipX', true)
	scaleObject('gfCover', 1.2, 1.2)
	setObjectOrder('gfCover', getObjectOrder('dadGroup') + 1)
	addLuaSprite('gfCover', false)
	
	makeLuaSprite('fade', 'effects/fade', 0, 2000)
	setProperty('fade.alpha', 1)
	scaleObject('fade', 3, 3)
	addLuaSprite('fade', true)
	
	makeLuaSprite('whiteBG', '', 0, 0)
	makeGraphic('whiteBG', 1280, 720, 'FFFFFF')
	setScrollFactor('whiteBG', 0, 0)
	setProperty('whiteBG.alpha', 0)
	setObjectCamera('whiteBG', 'hud')
	addLuaSprite('whiteBG', false)

	setProperty('dad.x', 1290)
	setProperty('dad.y', 70)
	scaleObject('dad', 0.7, 0.7)
	
	setProperty('gf.alpha', 0)
	setProperty('boyfriend.alpha', 0)
	
	clonesOriginScaleY = getProperty('clones.scale.y')
end

function onUpdate()
	-- Beginning sequence
	if curBeat == 4 then
		setProperty('floorLight.alpha', 1)
		setProperty('light1.alpha', 1)
	end
	if curBeat == 6 then
 		doTweenAlpha('boyfriendAppear','boyfriend', 1, 1, 'cubeInOut')
		doTweenZoom('camZoom', 'camGame', 1.3, 10.5, 'cubeInOut')
	end
	if curBeat == 32 then
		doTweenAlpha('camGame', 'camGame', 0, 1, 'cubeInOut')
	end
	if curBeat == 36 then
		removeLuaSprite('floorLight', true)
		removeLuaSprite('light1', true)
		setProperty('light2.alpha', 1)
		setProperty('defaultCamZoom', 1.3)
		triggerEvent('Change Character', 'bf', 'lilyIntroP2')
		doTweenAlpha('camGame', 'camGame', 1, 0.65, 'cubeInOut')
		doTweenAlpha('light2', 'light2', 1, 0.65, 'cubeInOut')
	end
	if curBeat == 68 then
		doTweenAlpha('camHudBye', 'camHUD', 0, 1.2, 'circOut')
	end
	if curStep == 300 then
		triggerEvent('Play Animation', 'turn', 'bf')
		removeLuaSprite('light2', true)
	end
	if curStep == 332 then
		setProperty('dad.alpha', 1)
		setProperty('stageConfront.alpha', 1)
	end
	
	-- Phase 2: Stage Confrontation (Lily / Marco)
	if curStep == 336 then
		removeLuaSprite('stageConfront', true)
		setProperty('healthBar.alpha', 1);
		setProperty('healthBarBG.alpha', 1);
		setProperty('iconP1.alpha', 1);
		setProperty('iconP2.alpha', 1);
	
		doTweenAlpha('camHudBye', 'camHUD', 1, 1.2, 'circOut')
		
		triggerEvent('Change Character', 'dad', 'marcoCCP1')
		triggerEvent('Change Character', 'bf', 'lilyP1')
		
		setProperty('boyfriend.x', 600)
		setProperty('boyfriend.y', 210)
		
		setProperty('dad.x', 890)
		setProperty('dad.y', 230)
		scaleObject('dad', 1, 1)
		
		setProperty('defaultCamZoom', 1.2)
		cameraFlash('game', 'FFFFFF', 0.5, false)
	end
	
	if curStep >= 336 and curStep < 1359 then
		if curBeat % 16 == 4 then
			if mustHitSection then
				setProperty('boyfriend.alpha', 1)
				setProperty('dad.alpha', 0)
				setProperty('stageMarcoP1.alpha', 0)
				setProperty('stageLilyP1.alpha', 1)
				
				if curStep >= 848 and curStep < 1359 then
					triggerEvent('Change Character', 'gf', 'lilyP1GF')
					scaleObject('gf', 1, 1)
					updateHitbox('gf')
					setProperty('gf.alpha', 0.6)
					setProperty('gf.x', getProperty('boyfriend.x') - 180)
					setProperty('gf.y', getProperty('boyfriend.y') + 20)
				end
			else
				setProperty('boyfriend.alpha', 0)
				setProperty('dad.alpha', 1)
				setProperty('stageMarcoP1.alpha', 1)
				setProperty('stageLilyP1.alpha', 0)
				
				if curStep >= 848 and curStep < 1359 then
					triggerEvent('Change Character', 'gf', 'marcoCCP1')
					scaleObject('gf', 1.1, 1.1)
					updateHitbox('gf')
					setProperty('gf.alpha', 0.6)
					setProperty('gf.x', getProperty('dad.x') + 80)
					setProperty('gf.y', getProperty('dad.y') - 50)
				end
			end
		end
	end
	
	-- Phase 2.5: Stage Confrontation (Manager / Aileen)
	if curStep == 848 then
		setProperty('camGame.alpha', 0)
		triggerEvent('Change Character', 'bf', 'managerChanP1')
		triggerEvent('Change Character', 'dad', 'aileenCCP1')
		
		setProperty('boyfriend.x', getProperty('boyfriend.x') - 30)
		setProperty('boyfriend.y', getProperty('boyfriend.y') - 5)
		
		setProperty('dad.x', 1000)
		setProperty('dad.y', 280)
		
		triggerEvent('Change Character', 'gf', 'marcoCCP1')
		setProperty('gf.x', getProperty('dad.x') + 20)
		
		setObjectOrder('gfGroup', getObjectOrder('gfGroup') + 1)
	end
	
	if curStep == 856 then
		doTweenAlpha('camGame','camGame', 1, 0.3, 'cubeInOut')
	end

	-- Phase 3: Full Stage Confrontation
	if curStep == 1360 then
		cameraFlash('game', 'FFFFFF', 0.5, false)
		removeLuaSprite('stageLilyP1', true)
		removeLuaSprite('stageMarcoP1', true)
		setProperty('Front.alpha', 1)
		
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 1)
		
		triggerEvent('Change Character', 'dad', 'marcoCCP2')
		triggerEvent('Change Character', 'bf', 'lilyP2')
		
		setProperty('boyfriend.x', 208)
		setProperty('boyfriend.y', 220)
		
		setProperty('dad.x', 1210)
		setProperty('dad.y', 250)
		
		setProperty('gf.alpha', 0)
		
		setProperty('defaultCamZoom', 0.9)

		doTweenAlpha('managerChan', 'managerChanP2', 1, 0.001, 'linear');
		doTweenAlpha('Aileen', 'aileenCCP2', 1, 0.001, 'linear');
	end

	-- Phase 4: Debug Intervention
	if curStep == 1872 then
		cameraFlash('game', '8BD46D', 0.5, false)
		setProperty('camGame.alpha', 0)
	
		setProperty('Front.alpha', 0)
		setProperty('kaizokuFront.alpha', 1)
		cameraFlash('game', 'FD96D1', 0.5, false)
		
		setProperty('boyfriend.alpha', 1)
		setProperty('dad.alpha', 1)
		setProperty('gf.alpha', 1)
		
		triggerEvent('Change Character', 'dad', 'kaizokuCCP1')
		triggerEvent('Change Character', 'bf', 'lilyP1Scaled')
		triggerEvent('Change Character', 'gf', 'managerChanP1Flipped')
		
		setProperty('boyfriend.x', -508)
		setProperty('boyfriend.y', 320)
		
		setProperty('playerCover.x', -508)
		setProperty('playerCover.y', 450)
		setProperty('playerCover.alpha', 1)
		
		setProperty('gfCover.x', 1908)
		setProperty('gfCover.y', 450)
		setProperty('gfCover.alpha', 1)
		
		setProperty('gf.x', 2058)
		setProperty('gf.y', 260)
		setObjectOrder('gfGroup', getObjectOrder('gfCover') + 1)
		
		setProperty('dad.x', 485)
		setProperty('dad.y', 140)
		
		setProperty('defaultCamZoom', 0.8)
	end
	
	if curStep == 1880 then
		doTweenAlpha('camGame', 'camGame', 1, 10 / playbackRate, 'cubeInOut')
	end
	
	if curStep == 1940 then
		doTweenX('boyfriendMove', 'boyfriend', 148, 1, 'cubeInOut')
		doTweenX('PlayerBaseMove', 'playerCover', 98, 1, 'cubeInOut')
	end
	
	if curStep == 2048 then
		doTweenX('gfMove', 'gf', 1428, 1, 'cubeInOut')
		doTweenX('GFBaseMove', 'gfCover', 1158, 1, 'cubeInOut')
	end
	
	-- Phase 5: Debug Confrontation
	if curStep == 2384 then
		setProperty('camGame.alpha', 0)
	
		removeLuaSprite('kaizokuFront', true)
		setProperty('kaizokuSplit.alpha', 1)
		
		setProperty('gf.alpha', 0)
		
		triggerEvent('Change Character', 'dad', 'kaizokuCCP2')
		triggerEvent('Change Character', 'bf', 'lilyDebugP1')
		
		setProperty('boyfriend.x', 860)
		setProperty('boyfriend.y', 250)
		
		removeLuaSprite('playerCover', true)
		removeLuaSprite('gfCover', true)
		
		setProperty('dad.x', 240)
		setProperty('dad.y', 240)
		
		setProperty('defaultCamZoom', 1.2)
		
		if not addShaders and shadersEnabled then
			addBloomEffect('game', 0.15, 1.0)
			addBloomEffect('hud', 0.15, 1.0)
			addScanlineEffect('game', false)
			addScanlineEffect('hud', true)
			addShaders = true
		end
	end
	
	if curStep == 2408 then
		doTweenAlpha('camGame', 'camGame', 1, 7 / playbackRate, 'cubeInOut')
	end
	
	if curStep == 2632 then
		doTweenY('fadeOut', 'fade', -2000, 1.3 / playbackRate, 'cubeInOut')
	end
	
	-- Phase 6: Marauder
	if curStep == 2640 then
		removeLuaSprite('kaizokuSplit', true)
		setProperty('kaizokuBG.alpha', 1)
		
		triggerEvent('Change Character', 'dad', 'debugGuyScaled')
		triggerEvent('Change Character', 'bf', 'lilyDebugP2')
		
		setProperty('boyfriend.x', 990)
		setProperty('boyfriend.y', 230)
		
		setProperty('dad.x', 400)
		setProperty('dad.y', 130)
		
		doTweenAlpha('clones', 'clones', 1, 5 / playbackRate, 'cubeInOut')
		
		setProperty('defaultCamZoom', 1)
	end
	
	if curStep == 2836 then
		setProperty('defaultCamZoom', 1.3)
	end
	
	if curStep == 2880 then
		doTweenAlpha('whiteBGFade', 'whiteBG', 1, 0.6, 'easeIn')
		setProperty('defaultCamZoom', 0.4)
	end

	-- Phase 7: Back to Stage with everyone
	if curStep == 2896 then	
		doTweenAlpha('whiteBGFadeOut', 'whiteBG', 0, 1, 'easeIn')
		removeLuaSprite('kaizokuBG', true)
		removeLuaSprite('clones', true)
		setProperty('Front.alpha', 1)
		
		triggerEvent('Change Character', 'dad', 'marcoCCP3')
		triggerEvent('Change Character', 'bf', 'lilyP3')
		triggerEvent('Change Character', 'gf', 'kaizokuCCP3')
		
		setProperty('boyfriend.x', 288)
		setProperty('boyfriend.y', 220)
		
		setProperty('dad.x', 1190)
		setProperty('dad.y', 250)
		
		setProperty('gf.alpha', 1)
		setProperty('gf.x', 660)
		setProperty('gf.y', -140)
		
		setScrollFactor('gfGroup', 0.9, 0.9)
		setScrollFactor('boyfriendGroup', 0.9, 0.9)
		setScrollFactor('dadGroup', 0.9, 0.9)
		setScrollFactor('managerChanP2', 0.9, 0.9)
		setScrollFactor('aileenCCP2', 0.9, 0.9)
		
		setProperty('defaultCamZoom', 1.4)
			
		if shadersEnabled then
			clearEffects('game')
			clearEffects('hud')
		end
	end
	
	if curStep == 3152 then
		setProperty('defaultCamZoom', 0.6)
	end
	if curStep == 3408 or curStep == 3728 then
		setProperty('defaultCamZoom', 0.8)
	end
	if curStep == 3664 then
		setProperty('defaultCamZoom', 0.55)
		doTweenAlpha('Audience', 'Audience', 1, 0.6, 'cubeInOut')
	end
	if curStep == 3856 then
		setProperty('defaultCamZoom', 0.55)
	end
	if curStep == 3952 then
		setProperty('camGame.visible', false)
	end
end

function onStepHit()
	if curStep == 848 then
		changeNoteskin('AileenNOTE_assets')
	end
	if curStep == 1360 then
		changeNoteskin('MarcoNOTE_assets')
	end
	
	
	if curStep >= 2640 and curStep <= 2895 then
		if curStep % 4 == 0 then
			setProperty('clones.scale.y', clonesOriginScaleY - 0.08)
			doTweenY('clonesBop', 'clones.scale', clonesOriginScaleY, 0.26, 'sineOut')
		end
	end
	if curStep >= 2896 then
		if curStep % 8 == 0 then
			objectPlayAnimation('Audience', 'clap', true)
		end
	end
end

function changeNoteskin(noteSkin)
	for i = 0, 3 do
		setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/'..noteSkin);
	end
end

function onTweenCompleted(tag)
	if tag == 'whiteBGFadeOut' then
		removeLuaSprite('whiteBG', true)
	end
	if tag == 'fadeOut' then
		removeLuaSprite('fade', true)
	end
end