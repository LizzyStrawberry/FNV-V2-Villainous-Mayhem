local xx = 360;
local yy = -70;
local xx2 = 1020;
local yy2 = 220;
local ofs = 35;
local followchars = false;
local del = 0;
local del2 = 0;

local beatsAllowed = {3, 7, 15, 23, 31, 63}
local beatSelected
local allow = false
local attack = false
local allowDodge = false
local dodged = false
local flash = false
local botPlayOn = false

function onCreate()
	if boyfriendName == 'amongGF' then
		yy2 = yy2 + 100
	end
	setProperty('gf.visible', false)
	
	if mechanics then
		beatSelected = getRandomInt(1, #(beatsAllowed))
		
		makeLuaSprite('qteGoal', 'effects/qteGoal', -165, -100)
		setScrollFactor('qteGoal', 0, 0)
		setObjectCamera('qteGoal', 'hud')
		setProperty('qteGoal.color', getColorFromHex('FF0000'))
		setProperty('qteGoal.alpha', 0)
		addLuaSprite('qteGoal', true)

		
		makeLuaSprite('qte', 'effects/qte', -165, -100)
		setScrollFactor('qte', 0, 0)
		setObjectCamera('qte', 'hud')
		setProperty('qte.color', getColorFromHex('00FF00'))
		setProperty('qte.alpha', 0)
		addLuaSprite('qte', true)
	end
end

function onUpdate()
	-- Camera Movement
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
			setProperty('defaultCamZoom', 0.6)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            elseif getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
			else
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else
			setProperty('defaultCamZoom', 0.8)
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT'  or getProperty('boyfriend.animation.curAnim.name') == 'singLEFTass' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTass' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singUPass' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWNass' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
			else
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','650','40')
    end
	
	-- Dodge Mechanic
	if mechanics then
		if botPlay or getPropertyFromClass('ClientPrefs', 'autoCharm') == 1 then
			botPlayOn = true
		end
		if botPlayOn then
			if attack and allowDodge then
				allowDodge = false
				dodged = true
			end
		else
			if attack and allowDodge and keyJustPressed('dodge') then
				allowDodge = false
				dodged = true
			elseif attack and (not allowDodge) and keyJustPressed('dodge') then
				cancelAttack()
			end
		end
	end
	
	-- Events to Camera
	if curBeat == 16 or curBeat == 64 then
		followchars = true
	end
	if curStep == 240 then
		followchars = false
	end
end

local sing = {'LEFT', 'RIGHT', 'UP', 'DOWN'}
function onBeatHit()
	if mechanics then
		if attack == true then
			if curBeat % 8 == 0 or curBeat % 8 == 4 then
				setProperty('defaultCamZoom', 0.9)
				
				followchars = false
				
				playSound('tick')
				
				setProperty('qteGoal.color', getColorFromHex('FF0000'))
				doTweenAlpha('qte', 'qte', 1, 0.3 / playbackRate, 'circOut')
				doTweenAlpha('qteGoal', 'qteGoal', 1, 0.3 / playbackRate, 'circOut')
				doTweenX('qteScaleX', 'qte.scale', 0.35, 0.3 / playbackRate, 'bounceOut')
				doTweenY('qteScaleY', 'qte.scale', 0.35, 0.3 / playbackRate, 'bounceOut')
			end
			if curBeat % 8 == 1 or curBeat % 8 == 5 then
				setProperty('defaultCamZoom', 1.0)
				
				playSound('tick')
				
				doTweenX('qteScaleX', 'qte.scale', 0.70, 0.3 / playbackRate, 'bounceOut')
				doTweenY('qteScaleY', 'qte.scale', 0.70, 0.3 / playbackRate, 'bounceOut')
			end
			if curBeat % 8 == 2 or curBeat % 8 == 6 then
				setProperty('defaultCamZoom', 1.1)
				
				followchars = false
				
				playSound('tick')
				
				doTweenX('qteScaleX', 'qte.scale', 1, 0.3 / playbackRate, 'bounceOut')
				doTweenY('qteScaleY', 'qte.scale', 1, 0.3 / playbackRate, 'bounceOut')
				doTweenColor('qteGoalColorChange', 'qteGoal', '9cff9c', 0.2 / playbackRate, 'bounceOut')
				allowDodge = true
			end
			if curBeat % 8 == 3 or curBeat % 8 == 7 then
				doTweenAlpha('qte', 'qte', 0, 0.3 / playbackRate, 'circOut')
				doTweenAlpha('qteGoal', 'qteGoal', 0, 0.3 / playbackRate, 'circOut')
				setProperty('defaultCamZoom', 0.6)
				if dodged then
					playSound('gfDodge')
					playSound('ding')
					triggerEvent('Play Animation', 'dodge', 'bf')
					triggerEvent('Play Animation', 'attack', 'dad')
				else
					playSound('DirectHit')
					cameraFlash('game', 'FF0000', 0.3 / playbackRate, false)
					triggerEvent('Play Animation', 'sing'..sing[getRandomInt(1, 4)]..'miss', 'bf')
					triggerEvent('Play Animation', 'attack', 'dad')
					
					if isMayhemMode then
						if getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
								setProperty('health', getHealth() - 5)
							else
								setProperty('health', getHealth() - 10)
							end
						end
					else
						if getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
							if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
								if (isStoryMode and difficulty == 1) or (not isStoryMode and difficulty == 0) then
									setProperty('health', getHealth() - 0.249)
								elseif (isStoryMode and difficulty == 2) or (not isStoryMode and difficulty == 1) then
									setProperty('health', getHealth() - 0.499)
								end
							else
								if (isStoryMode and difficulty == 1) or (not isStoryMode and difficulty == 0) then
									setProperty('health', getHealth() - 0.499)
								elseif (isStoryMode and difficulty == 2) or (not isStoryMode and difficulty == 1) then
									setProperty('health', getHealth() - 0.99)
								end
							end
						end
					end
					
					flash = true
					runTimer('flashing', 2)
				end
				
				if curBeat % 8 == 3 then
					if not botPlayOn then
						allowDodge = false
						dodged = false
					end
				end
	
				if curBeat % 8 == 7 then
					allow = false
					attack = false
					allowDodge = false
					dodged = false
					
					followchars = true
					beatSelected = getRandomInt(1, #(beatsAllowed))
				end
			end
		end
		if curBeat >= 64 and curBeat < 608 and curBeat % 64 == beatsAllowed[beatSelected] and attack == false and allow == false then
			allow = true
		end
	end
end

function onStepHit()
	if mechanics then
		if not attack and allow and (not mustHitSection) and curStep % 32 == 31 then
			attack = true
		end
		if flash then
			if curStep % 2 == 0 then
				setProperty('boyfriend.alpha', 0)
			end
			if curStep % 2 == 1 then
				setProperty('boyfriend.alpha', 1)
			end
		end
	end
end

function cancelAttack()
	doTweenAlpha('qte', 'qte', 0, 0.3 / playbackRate, 'circOut')
	doTweenAlpha('qteGoal', 'qteGoal', 0, 0.3 / playbackRate, 'circOut')
	setProperty('defaultCamZoom', 0.6)
	
	playSound('DirectHit')
	cameraFlash('game', 'FF0000', 0.3 / playbackRate, false)
	triggerEvent('Play Animation', 'sing'..sing[getRandomInt(1, 4)]..'miss', 'bf')
	triggerEvent('Play Animation', 'attack', 'dad')
					
	if isMayhemMode then
		if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
			setProperty('health', getHealth() - 5)
		else
			setProperty('health', getHealth() - 10)
		end
	else
		if getPropertyFromClass('ClientPrefs', 'resistanceCharm') == 1 then
			if (isStoryMode and difficulty == 1) or (not isStoryMode and difficulty == 0) then
				setProperty('health', getHealth() - 0.249)
			elseif (isStoryMode and difficulty == 2) or (not isStoryMode and difficulty == 1) then
				setProperty('health', getHealth() - 0.499)
			end
		else
			if (isStoryMode and difficulty == 1) or (not isStoryMode and difficulty == 0) then
				setProperty('health', getHealth() - 0.499)
			elseif (isStoryMode and difficulty == 2) or (not isStoryMode and difficulty == 1) then
				setProperty('health', getHealth() - 0.99)
			end
		end
	end
					
	flash = true
	runTimer('flashing', 2)
	
	allow = false
	attack = false
	allowDodge = false
	dodged = false
					
	followchars = true
	beatSelected = getRandomInt(1, #(beatsAllowed))
end

function onTimerCompleted(tag)
	if tag == 'flashing' then
		setProperty('boyfriend.alpha', 1)
		flash = false
	end
end