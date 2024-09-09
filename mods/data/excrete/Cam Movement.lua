local xx = 540;
local yy = 330;
local xx2 = 980;
local yy2 = 680;
local xx3 = 360;
local yy3 = 650;
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;
local gfSings = false;

function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
	if followchars == true then
		if mustHitSection == false then
			if gfSection then
				if getProperty('gf.animation.curAnim.name') == 'idle' then
					triggerEvent('Camera Follow Pos',xx3,yy3)
				end
				setProperty('defaultCamZoom', 1.4)
			else
				if gfSings == true then
					if getProperty('gf.animation.curAnim.name') == 'idle' then
						triggerEvent('Camera Follow Pos',xx3,yy3)
					end
				else
					if getProperty('dad.animation.curAnim.name') == 'idle' then
						triggerEvent('Camera Follow Pos',xx,yy)
					end
					setProperty('defaultCamZoom', 0.9)
				end
			end
		else
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' or getProperty('boyfriend.animation.curAnim.name') == 'idleass' then
				triggerEvent('Camera Follow Pos',xx2,yy2)
			end
			setProperty('defaultCamZoom', 1.1)
		end
	end
	if curBeat == 384 then
		gfSings = false;
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if followchars == true then
		if mustHitSection == true then
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFTass' then
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
			setProperty('defaultCamZoom', 1.1)
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if followchars == true then
        if mustHitSection == false then
			if gfSection then
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
				triggerEvent('Change Icon', 'P2, AmogleenExcrete, a3bb89')
			else
				if noteType == '' then
					gfSings = false
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
					setProperty('defaultCamZoom', 0.9)
					triggerEvent('Change Icon', 'P2, marcussyExcrete, 393939')
				else
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
					triggerEvent('Change Icon', 'P2, AmogleenExcrete, a3bb89')
				end
			end
		end
		
		-- Icon Change when the camera is on the player
		if mustHitSection == true then
			if gfSings == true then
				triggerEvent('Change Icon', 'P2, AmogleenExcrete, a3bb89')	
			else
				if noteType == '' then
					triggerEvent('Change Icon', 'P2, marcussyExcrete, 393939')
				else
					triggerEvent('Change Icon', 'P2, AmogleenExcrete, a3bb89')
				end
			end
		end
	end
	
	if noteType == '' and gfSings == false then
		triggerEvent('Screen Shake', '0.4, 0.003', '0.4, 0.003')
	end
end