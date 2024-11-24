local xx = 1820;
local yy = 510;
local xx2 = 1420;
local yy2 = 410;
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
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT'  or getProperty('dad.animation.curAnim.name') == 'singRIGHTass' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singLEFTass' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singUPass' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            elseif getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'singDOWNass' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
			else
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','630','350')
    end
	
	if curBeat == 196 then
		xx = 550
		yy = 510
		xx2 = 1220
		yy2 = 410
	end
	if curBeat == 456 then
		xx = 1820
		yy = 570
		yy2 = 310
	end
end