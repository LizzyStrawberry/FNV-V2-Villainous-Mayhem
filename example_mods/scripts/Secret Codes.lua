function onCreatePost()
	addHaxeLibrary('PlayState')
	
	if songName == 'Tofu' then
		addCharacterToList('aileenTofuAlt', 'boyfriend')
		
		makeLuaSprite('lizGoingThroughHell', 'effects/help', mobileFix("X", 320), 200)
		setObjectCamera('lizGoingThroughHell', 'hud')
		scaleObject('lizGoingThroughHell', 0.4, 0.4)
		setProperty('lizGoingThroughHell.alpha', 0)
		addLuaSprite('lizGoingThroughHell', true)
	end
end

function onUpdate(elapsed)
	-- Omg not these again
	if (not isStoryMode and not isMayhemMode and not isIniquitousMode and not isInjectionMode)
	and songName == "Lustality Remix" and not getPropertyFromClass('ClientPrefs', 'itsameDsidesUnlocked') then
		if pressAction("iconP1") then
			playSound('secretSound')
			loadSong("It's Kiana", 1)

			setPropertyFromClass('ClientPrefs', 'itsameDsidesUnlocked', true);
			setPropertyFromClass('ClientPrefs', 'xtraBonusUnlocked', true);
			setPropertyFromClass('FreeplayCategoryState', 'freeplayName', 'XTRABONUS');
			saveSettings();

			runHaxeCode([[
				PlayState.SONG.player1 = 'd-side gf';
			]])
		end
	end
	
	if (not isStoryMode and not isMayhemMode and not isIniquitousMode and not isInjectionMode)
	and songName == "Tofu" and not mustHitSection then
		if pressAction("iconP2") then
			playSound('poof')
			
			if boyfriendName == 'aileenTofu' then
				triggerEvent('Change Character', 'bf', 'aileenTofuAlt')
			else
				triggerEvent('Change Character', 'bf', 'aileenTofu')
			end
			scaleObject('lizGoingThroughHell', 0.4, 0.4)
			setProperty('lizGoingThroughHell.alpha', 1)
			doTweenAlpha('poof', 'lizGoingThroughHell', 0, 0.7 / playbackRate, 'cubeOut')
			doTweenX('poofX', 'lizGoingThroughHell.scale', 2, 0.7 / playbackRate, 'cubeOut')
			doTweenY('poofY', 'lizGoingThroughHell.scale', 0.8, 0.7 / playbackRate, 'cubeOut')
		end
	end
end
