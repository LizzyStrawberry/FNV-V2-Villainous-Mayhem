local defaultNotePos = {};
local shake = 2.5;
local missedNotes = 0;
local windowX = 0;
local windowY = 0;

function onCreate()
	setProperty('gf.alpha', 0)
	windowX = getPropertyFromClass('openfl.Lib', 'application.window.x')
	windowY = getPropertyFromClass('openfl.Lib', 'application.window.y')
end
 
function onSongStart()
	for i = 0,7 do 
        x = getPropertyFromGroup('strumLineNotes', i, 'x')
 
        y = getPropertyFromGroup('strumLineNotes', i, 'y')
 
        table.insert(defaultNotePos, {x,y})
    end
end

function onUpdate(elapsed)
	missedNotes = getProperty('songMisses')
	
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 160)

    if curStep >= 0 then
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + getRandomFloat(-shake, shake) + math.sin((currentBeat + i*0.75) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + getRandomFloat(-shake, shake) + math.sin((currentBeat + i*0.75) * math.pi))
        end    	
	end 	
	if curStep == 128 then
		shake = 3.0
	end
	if curStep == 304 then
		shake = 0.5
	end
	if curStep == 308 then
		shake = 3.5
	end
	if curBeat >= 308 and curBeat <= 403 then
		setPropertyFromClass('openfl.Lib','application.window.x',windowX + math.random(-shake, shake))
		setPropertyFromClass('openfl.Lib','application.window.y',windowY + math.random(-shake, shake))	
	end
	if curBeat == 404 then
		setPropertyFromClass('openfl.Lib','application.window.x', windowX)
		setPropertyFromClass('openfl.Lib','application.window.y', windowY)
	end
    --if curStep == 80 then
      --  for i = 0,7 do 
        --    setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1])
         --   setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2])
        --end
    --end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if mechanics then
		if noteType == '' and isSustainNote then
			setProperty('songMisses', missedNotes + 0)
		end
	end
end

function onPause()
	setPropertyFromClass('openfl.Lib','application.window.x', windowX)
	setPropertyFromClass('openfl.Lib','application.window.y', windowY)
end

function onDestroy()
	setPropertyFromClass('openfl.Lib','application.window.x', windowX)
	setPropertyFromClass('openfl.Lib','application.window.y', windowY)
end