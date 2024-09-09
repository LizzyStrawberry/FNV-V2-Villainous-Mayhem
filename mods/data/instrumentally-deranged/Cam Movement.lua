local xx = 680;
local yy = 750;
local xx2 = 680;
local yy2 = 750;
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;

function onSongStart()
	xx = 380
	yy = 750
	xx2 = 880
	yy2 = 750
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
            if getProperty('dad.animation.curAnim.name') == 'tail attack' then
                triggerEvent('Camera Follow Pos',xx,yy+(ofs*3))
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
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
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
	
	if curBeat == 70 then
		xx = 680
		yy = 750
		xx2 = 680
		yy2 = 750
		doTweenZoom('camZoomOut', 'camGame', 0.22, 120 / playbackRate, 'cubeInOut')
	end
	
	if curStep >= 409 and curStep < 473 then
		setTextString('scoreTxt', 'Are you still sure there are notes up ahead?')
	end
	if curStep >= 473 and curStep < 537 then
		setTextString('scoreTxt', 'Man, I feel bad for you lmao')
	end
	if curStep >= 537 and curStep < 665 then
		setTextString('scoreTxt', 'You know, this is a joke song, there are no notes in this chart :/')
	end
	if curStep >= 665 and curStep < 729 then
		setTextString('scoreTxt', 'So uh........ idk what else to say lmao')
	end
	if curStep >= 729 and curStep < 792 then
		setTextString('scoreTxt', 'How has your day been?')
	end
	if curStep >= 792 and curStep < 856 then
		setTextString('scoreTxt', 'Also, is that you TC, or am I tripping lmao')
	end
	if curStep >= 856 and curStep < 920 then
		setTextString('scoreTxt', 'I love Fnf, fnf best game')
	end
	if curStep >= 920 and curStep < 984 then
		setTextString('scoreTxt', 'k')
	end
	if curStep >= 984 then
		setTextString('scoreTxt', 'Just chillax and enjoy the song! No stress at all fam.')
	end
end