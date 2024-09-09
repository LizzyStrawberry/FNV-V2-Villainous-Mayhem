local xx = 1130;
local yy = 510;
local xx2 = 1130;
local yy2 = 510;
local ofs = 13;
local followchars = true;
local del = 0;
local del2 = 0;
local gfSings = false

function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
			if gfSings then
				if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy)
				end
				if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy)
				end
				if getProperty('gf.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy-ofs)
				end
				if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx,yy+ofs)
				end
				if getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx,yy)
				end
			end
			if (curBeat >= 144 and curBeat < 432) or curBeat >= 504 then
				setProperty('defaultCamZoom', 1)
			end
			if curBeat >= 432 and curBeat < 504 then
				setProperty('defaultCamZoom', 1.5)
			end
        else
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT'  or getProperty('boyfriend.animation.curAnim.name') == 'singLEFTass' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTass' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singUPass' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWNass' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' or getProperty('boyfriend.animation.curAnim.name') == 'idleass' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
			if curBeat >= 144 and curBeat < 176 then
				setProperty('defaultCamZoom', 1.5)
			end
			if curBeat >= 432 and curBeat < 504 then
				setProperty('defaultCamZoom', 2)
			end
			if (curBeat >= 176 and curBeat < 432) or curBeat >= 504 then
				setProperty('defaultCamZoom', 1.3)
			end
        end
    else
        triggerEvent('Camera Follow Pos','700','350')
    end
	
	if curBeat == 144 or curBeat == 504 then
		gfSings = false
		xx = 600
		yy = 300
		xx2 = 1130
		yy2 = 510
		ofs = 35
	end
	if curBeat == 440 then
		gfSings = true
		xx = 1000
		yy = 490
		xx2 = 1130
		yy2 = 510
		ofs = 35
	end
	if curBeat == 984 then
		followchars = false
		setProperty('defaultCamZoom', 0.8)
	end
end