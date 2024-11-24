local xx2 = 1020;
local yy2 = 520;
local ofs = 15;
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
    else
        triggerEvent('Camera Follow Pos','700','300')
    end
end