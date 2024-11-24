local xx = 560;
local yy = 330;
local xx2 = 980;
local yy2 = 480;
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;

function onCreate()
	setProperty('gf.visible', false)
end

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
            elseif getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            elseif getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            else
                triggerEvent('Camera Follow Pos',xx,yy)
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
        end
    else
        triggerEvent('Camera Follow Pos','700','350')
    end
	
	if curBeat == 67 then
		yy = 390;
	end
	if curBeat == 76 then
		yy = 330;
	end
	if curBeat == 136 then
		xx = 470
		yy = 300
		xx2 = 980
		yy2 = 440
	end
	if curBeat == 200 then
		xx = 560
		yy = 330
		xx2 = 980
		yy2 = 480
	end
	if curStep == 1776 then
		followchars = false
	end
end