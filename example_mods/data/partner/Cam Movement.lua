local xx = 80;
local yy = 300;
local xx2 = 1060;
local yy2 = 510;
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;

function onUpdate()
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
            end
			if (curBeat >= 176 and curBeat <= 384) or curBeat >= 512 then
				setProperty('defaultCamZoom', 0.6)
			end
        else
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
			else
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
			if curBeat <= 384 or curBeat >= 512 then
				setProperty('defaultCamZoom', 1.1)
			end
        end
    else
        triggerEvent('Camera Follow Pos','700','350')
    end
	
	if curBeat == 176 then
		xx = 260
		yy = 180
	end
	if curBeat == 384 then
		ofs = 55
		xx = 80
		xx2 = 80
		yy = 330
		yy2 = 330
	end
	
	if curBeat == 512 then
		ofs = 35
		xx = 260
		xx2 = 1060
		yy = 180
		yy2 = 510
	end
end