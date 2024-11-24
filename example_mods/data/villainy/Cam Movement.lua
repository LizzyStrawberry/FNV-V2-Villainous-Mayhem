local xx = 760;
local yy = 430;
local xx2 = 980;
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
        triggerEvent('Camera Follow Pos','700','350')
    end
	
	if curStep == 48 then
		xx = 560
		yy = 330
	end
	
	if curStep == 927 then
		yy = 530
		xx2 = 660
		yy2 = 500
	end
	
	
	if curStep == 944 then
		yy = 330
		xx2 = 980
		yy2 = 510
	end
end