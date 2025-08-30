function onCreate()
	-- background shit
	if not optimizationMode then
		makeLuaSprite('stageConfront', 'bgs/lily/stageConfront', 270, -150)
		setScrollFactor('stageConfront', 0.9, 0.9)
		setProperty('stageConfront.alpha', 0)
		
		makeLuaSprite('stageLilyP1', 'bgs/lily/stageLilyP1', 270, 20)
		setScrollFactor('stageLilyP1', 0.9, 0.9)
		scaleObject('stageLilyP1', 0.9, 0.8)
		setProperty('stageLilyP1.alpha', 0)
		
		makeLuaSprite('stageMarcoP1', 'bgs/lily/stageMarcoP1', 270, 20)
		setScrollFactor('stageMarcoP1', 0.9, 0.9)
		scaleObject('stageMarcoP1', 0.9, 0.8)
		setProperty('stageMarcoP1.alpha', 0)
		
		makeLuaSprite('Front', 'bgs/lily/engraveFront', -400, -400)
		scaleObject('Front', 1.6, 1.6)
		setScrollFactor('Front', 0.9, 0.9)
		setProperty('Front.alpha', 0)
		
		makeLuaSprite('kaizokuFront', 'bgs/lily/kaizokuFront', 50, -100)
		setScrollFactor('kaizokuFront', 1, 1)
		scaleObject('kaizokuFront', 1.1, 1.1)
		setProperty('kaizokuFront.alpha', 0)
		
		makeLuaSprite('clones', 'bgs/debug/clones', -70, -60);
		setScrollFactor('clones', 0.7, 0.7);
		scaleObject('clones', 0.9, 0.9)
		setProperty('clones.origin.y', 800)
		setProperty('clones.alpha', 0)
		
		makeLuaSprite('kaizokuBG', 'bgs/lily/kaizokuBG', -300, -365)
		setScrollFactor('kaizokuBG', 0.9, 0.9)
		scaleObject('kaizokuBG', 1.5, 1.3)
		setProperty('kaizokuBG.alpha', 0)
		
		makeLuaSprite('kaizokuSplit', 'bgs/lily/kaizokuSplit', 50, -90)
		setScrollFactor('kaizokuSplit', 0.9, 0.9)
		scaleObject('kaizokuSplit', 0.9, 0.9)
		setObjectOrder('kaizokuSplit', getObjectOrder('dadGroup') + 1)
		setProperty('kaizokuSplit.alpha', 0)
		
		addLuaSprite('stageConfront', false)
		addLuaSprite('stageLilyP1', false)
		addLuaSprite('stageMarcoP1', false)
		
		addLuaSprite('Front', false)
		addLuaSprite('kaizokuFront', false)
		
		addLuaSprite('clones', false)
		addLuaSprite('kaizokuBG', false)
		addLuaSprite('kaizokuSplit', false)
		
		setProperty('defaultCamZoom', 0.4 * zoomMult)
	end

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
