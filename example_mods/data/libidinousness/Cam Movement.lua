local xx = 385;
local yy = 410;
local xx2 = 800;
local yy2 = 960;
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;

function onCreate()
	setProperty('gf.visible', false)
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
				setProperty('defaultCamZoom', 0.4)
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