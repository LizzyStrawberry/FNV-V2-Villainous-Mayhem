function onCreate()
	-- background shit
	if not optimizationMode then
		if songName == 'Scrouge' or songName == 'Toxic Mishap'  or songName == 'Paycheck' then
			makeLuaSprite('bg', 'bgs/marco/background-new', -240, -100);
			setScrollFactor('bg', 0.9, 0.9);
		
			makeLuaSprite('fg', 'bgs/marco/foreground-new', -240, -40);
			setScrollFactor('fg', 0.95, 0.95);

		elseif songName == 'Villainy' then
			makeLuaSprite('bg', 'bgs/marco/background-villainy', -240, -100);
			setScrollFactor('bg', 0.9, 0.9);
		
			makeLuaSprite('fg', 'bgs/marco/foreground-new', -240, -40);
			setScrollFactor('fg', 0.95, 0.95);

		elseif songName == 'Spendthrift' then
			makeLuaSprite('bg', 'bgs/spendthrift/background', -240, -100);
			setScrollFactor('bg', 0.9, 0.9);
		
			makeLuaSprite('fg', 'bgs/spendthrift/foreground', -240, -40);
			setScrollFactor('fg', 0.95, 0.95);
			
		elseif songName == 'Shucks V2' then
			makeLuaSprite('bg', 'bgs/marco/background-new', -240, -100)
			setScrollFactor('bg', 0.95, 0.95)
		
			makeLuaSprite('fg', 'bgs/marco/foreground-shucks', -240, -100);
			setScrollFactor('fg', 0.9, 0.9);
			
			makeLuaSprite('stabbed', 'bgs/marco/stabbed', 1300, 125);
			setScrollFactor('stabbed', 0.9, 0.9);
			
			makeLuaSprite('hand', 'bgs/marco/hand', 1425, 725);
			setScrollFactor('hand', 0.85, 0.85);
			
			makeLuaSprite('ded', 'bgs/marco/plankthingy', -950, -520);
			setScrollFactor('ded', 1, 1);
			setObjectOrder('ded', getObjectOrder('fg') - 1)
			scaleObject('ded', 1.6, 1.6)
			updateHitbox('ded')
			
		else
			makeLuaSprite('bg', 'bgs/marco/background', -240, -100);
			setScrollFactor('bg', 0.9, 0.9);
		
			makeLuaSprite('fg', 'bgs/marco/foreground', -240, -100);
			setScrollFactor('fg', 0.9, 0.9);
			
		end
		
		setProperty('defaultCamZoom', 1.05)

		addLuaSprite('bg', false)
		addLuaSprite('fg', false)
		
		if songName == 'Shuckle Fuckle' then
			setProperty('defaultCamZoom', 2)
			addLuaSprite('ded', false)
			addLuaSprite('stabbed', false)
			addLuaSprite('hand', false)
		end
	end

	if songName ~= "Shuckle Fuckle" then
		close(true)
	end
end

function onUpdate()
	if songName == "Shucks V2" then
		setProperty("stabbed.alpha", getProperty("fg.alpha"))
		setProperty("hand.alpha", getProperty("fg.alpha"))
	end
end
