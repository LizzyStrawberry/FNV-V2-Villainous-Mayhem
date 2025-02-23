local xx = 400;
local yy = 400;
local xx2 = 860;
local yy2 = 360;
local xx3 = 660;
local yy3 = 350;
local ofs = 35;
local followchars = false;
local del = 0;
local del2 = 0;
local gfSings = false;
local shifting = false

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'allowCameraMove', false)
end

function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
	if followchars == true then
		if mustHitSection == true then
			if gfSings == true then
				if getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx3,yy3)
					if shifting then
						camAngle(-1)
						shifting = false
					end
				end
				setProperty('defaultCamZoom', 1.4)
			end
			if (curBeat >= 0 and curBeat < 132) or (curBeat >= 135 and curBeat < 148) then
				gfSings = false
				if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx2,yy2)
					if shifting then
						camAngle(-1)
						shifting = false
					end
				end
				setProperty('defaultCamZoom', 0.9)	
			end
		end
		if mustHitSection == false then
			if (curBeat >= 0 and curBeat < 132) or (curBeat >= 135 and curBeat < 148) then
				gfSings = false
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx,yy+ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy-ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx,yy)
					if shifting then
						camAngle(-1)
						shifting = false
					end
				end
				setProperty('defaultCamZoom', 1.0)
			end
		end
	else
		triggerEvent('Camera Follow Pos','600','350')
	end
	
	if curBeat == 36 then
		followchars = true
	end
	if curBeat == 132 then
		followchars = false
	end
	if curBeat == 135 then
		followchars = true
	end
	if curBeat == 262 then
		followchars = false
		setProperty('defaultCamZoom', 0.9)
		cameraFlash('game', 'FFFFFF', 0.5, false)
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if followchars == true then
		if mustHitSection == true then
			if noteType == 'GF Sing' then
				gfSings = true
				if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx3-ofs,yy3)
				end
				if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx3+ofs,yy3)
				end
				if getProperty('gf.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx3,yy3-ofs)
				end
				if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx3,yy3+ofs)
				end
				if getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx3,yy3)
				end
				setProperty('defaultCamZoom', 1.4)
			elseif noteType == '' then
				gfSings = false
				if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx2,yy2)
				end
				setProperty('defaultCamZoom', 0.9)		
			elseif gfSings == false then
				if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
				end
				if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx2,yy2)
				end
				setProperty('defaultCamZoom', 0.9)		
			end
			if not isSustainNote then
				camAngle(direction)
			end
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if followchars == true then
        if mustHitSection == false then
			if noteType == '' then
				gfSings = false
				if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy)
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy-ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx,yy+ofs)
				end
				if getProperty('dad.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx,yy)
				end
				setProperty('defaultCamZoom', 1.0)
			end
			if not isSustainNote then
				camAngle(direction)
			end
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