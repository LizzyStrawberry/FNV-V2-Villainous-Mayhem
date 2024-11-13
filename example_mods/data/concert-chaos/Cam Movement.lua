local xx = 920;
local yy = 400;
local xx2 = 920;
local yy2 = 400;
local ofs = 25;
local followchars = true;
local del = 0;
local del2 = 0;
local managerSings = false;
local aileenSings = false;

function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
			if dadName == 'aileenCCP1' or dadName == 'kaizokuCCP1'
				or dadName == 'kaizokuCCP2' or dadName == 'kaizokuCCP3' or dadName == 'debugGuyScaled' then
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
			else
				managerSings = false
				if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy)
					aileenSings = false
				end
				if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy)
					aileenSings = false
				end
				if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx,yy-ofs)
					aileenSings = false
				end
				if getProperty('dad.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy+ofs)
					aileenSings = false
				end
				
				if getProperty('aileenCCP2.animation.curAnim.name') == 'singLEFT' then
					triggerEvent('Camera Follow Pos',xx-ofs,yy)
					aileenSings = true
				end
				if getProperty('aileenCCP2.animation.curAnim.name') == 'singRIGHT' then
					triggerEvent('Camera Follow Pos',xx+ofs,yy)
					aileenSings = true
				end
				if getProperty('aileenCCP2.animation.curAnim.name') == 'singUP' then
					triggerEvent('Camera Follow Pos',xx,yy-ofs)
					aileenSings = true
				end
				if getProperty('aileenCCP2.animation.curAnim.name') == 'singDOWN' then
					triggerEvent('Camera Follow Pos',xx,yy+ofs)
					aileenSings = true
				end
				
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
				
				if aileenSings == true then
					if getProperty('aileenCCP2.animation.curAnim.name') == 'idle' then
						triggerEvent('Camera Follow Pos',xx,yy)
					end
				else
					if getProperty('dad.animation.curAnim.name') == 'idle' then
						triggerEvent('Camera Follow Pos',xx,yy)
					end
				end
			end
        elseif mustHitSection == true then
			aileenSings = false
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
				managerSings = false
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
				managerSings = false
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
				managerSings = false
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
				managerSings = false
            end
			
			if getProperty('managerChanP2.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
				managerSings = true
            end
            if getProperty('managerChanP2.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
				managerSings = true
            end
            if getProperty('managerChanP2.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
				managerSings = true
            end
            if getProperty('managerChanP2.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
				managerSings = true
            end
			
			if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
				triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
			end
			if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
				triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
			end
			if getProperty('gf.animation.curAnim.name') == 'singUP' then
				triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
			end
			if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
				triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
			end
			
			if managerSings == true then
				if getProperty('managerChanP2.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx2,yy2)
				end
			else
				if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx2,yy2)
				end
			end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
	
	if curBeat == 36 then
		xx = 980
		yy = 450
		xx2 = 980
		yy2 = 450
	end
	if curBeat == 68 then
		xx = 1160
		yy = 430
		xx2 = 1160
		yy2 = 430
	end
	if curBeat == 84 then
		xx = 960
		yy = 380
		xx2 = 960
		yy2 = 380
	end
	
	if curStep == 1360 or curStep == 2896 or curStep == 3408 or curStep == 3728 then
		xx = 1030
		yy = 350
		xx2 = 560
		yy2 = 350
	end
	
	if curStep == 1872 then
		xx = 920
		yy = 400
		xx2 = 920
		yy2 = 400
	end
	
	if curStep == 2408 then
		xx = 800
		yy = 400
		xx2 = 800
		yy2 = 400
	end
	
	if curStep == 2640 then
		xx = 760
		yy = 370
		xx2 = 1060
		yy2 = 370
	end
	
	if curStep == 3152 then
		xx = 850
		yy = 200
		xx2 = 850
		yy2 = 200
	end
	
	if curStep == 3664 or curStep == 3856 then
		xx = 850
		yy = 280
		xx2 = 850
		yy2 = 280
	end
end