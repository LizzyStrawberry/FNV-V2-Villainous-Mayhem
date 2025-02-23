local xx = 385;
local yy = 410;
local xx2 = 800;
local yy2 = 960;
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;
local shifting = false

function onCreate()
	setProperty('gf.visible', false)
	setGlobalFromScript("scripts/Camera Movement", 'allowCameraMove', false)
end

function onUpdate()
	if not lowQuality then
		if del > 0 then
			del = del - 1
		end
		if del2 > 0 then
			del2 = del2 - 1
		end
		if followchars == true then
			if mustHitSection == false then
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
					if shifting then
						camAngle(-1)
						shifting = false
					end
				end
				setProperty('defaultCamZoom', 0.4)
			else
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
					if shifting then
						camAngle(-1)
						shifting = false
					end
				end
				setProperty('defaultCamZoom', 0.7)
			end
		else
			triggerEvent('Camera Follow Pos', '430', '550')
			setProperty('defaultCamZoom', 0.4)
		end
		
		if curBeat == 96 then
			xx2 = 620
			yy2 = 900
			followchars = true
		end
		if curBeat == 92 or curBeat == 272 or curBeat == 448 or curStep == 3016 then
			followchars = false
		end
		if curBeat == 287 or curBeat == 465 then
			followchars = true
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if followchars and mustHitSection then	
		if not isSustainNote then
			camAngle(direction)
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if followchars and not mustHitSection then	
		if not isSustainNote then
			camAngle(direction)
		end
	end
end

function camAngle(direction)
	shifting = true
	cancelTween('camAngleTween')
	if direction == 0 then
		doTweenAngle('camAngleTween', 'camGame', -0.45 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	elseif direction == 1 then
		doTweenAngle('camAngleTween', 'camGame', -0.175 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	elseif direction == 2 then
		doTweenAngle('camAngleTween', 'camGame', 0.175 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	elseif direction == 3 then
		doTweenAngle('camAngleTween', 'camGame', 0.45 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	else
		doTweenAngle('camAngleTween', 'camGame', 0, 0.7 / playbackRate, 'sineOut')
		shifting = false
	end
end