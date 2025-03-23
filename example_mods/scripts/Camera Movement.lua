--[[
	!!Camera Movement Script by Lizzy Strawberry!!
	------------------------------------------------
	This script allows all songs to have camera movement on note hits
	along with a few enhancements!
	It gives x and y camera values on BF, DAD and GF, for cool movement lmao
	
	It is recommended to add this in any data script of the song you want to use this on:
	callScript("scripts/Camera Movement", "setCameraMovement", {cameraOffsets:String, newOffsetValue:String, noMovementValues:String, camZoomValues:String})
	Use this on "onCreate()". It will adjust the positions properly before the song actually starts.
	
	TO USE IN OTHER SCRIPTS:
	If you want to change any global variables from here in any other script,
	use setGlobalFromScript("scripts/Camera Movement", globalvariable, value)
	based on what the function takes as arguments (mostly strings)
	
	The global variables consist of:
	allowCameraMove: Allows camera movement
	followChars: Checks if you want to follow the character's movements or not 
	allowAngleShift: Allows angle shifting on note press
	allowZoomShifts: Allows dynamic zooming (each character has their own defaultCamZoom value)
]]

allowCameraMove = true
followChars = false
allowAngleShift = true
allowZoomShifts = false

local marcoChars = {
	'marco',
	'marco-old',
	'marcophase2',
	'marcophase2_5',
	'marcophase3',
	'marcophase3_5',
	'marcoElectric',
	'marcoTofu',
	'aizeenPhase2',
	'marcussy',
	'MarcussyExcrete',
	'Spendthrift Marco',
	'marcx',
	'marcoshucks',
	'marcoFFFP1',
	'marcoFFFP2'
}
flipEnemyMovement = false
flipPlayerMovement = false

local camMovementOn = false

-- Character Offsets
local charOffsets = {
	bfX = 0,
	bfY = 0,
	dadX = 0,
	dadY = 0,
	gfX = 0,
	gfY = 0
}
local offset = 0 -- Amount of Movement
local noMovement = {0, 0}
local camZooms = {0, 0, 0}

local isSinging = false
local followGF = false
local gfSide = nil
local shifting = false

local bfIdles = {'idle', 'danceLeft', 'danceRight'}
local dadIdles = {'idle', 'danceLeft', 'danceRight'}
local gfIdles = {'idle', 'danceLeft', 'danceRight'}
local specialAnims = {"tail attack", "jumpscare"}

function onCreate()
	addLuaScript('zCameraFix')
	
	for pee = 1, #(marcoChars) do
		if dadName == marcoChars[pee] then
			flipEnemyMovement = true
		elseif boyfriendName == marcoChars[pee] then
			flipPlayerMovement = true
		end
	end
	if allowCameraMove then
		setCameraMovement() -- Always call this at the start, to set up camera offsets
	end
end

function onCreatePost() -- Set Camera to middle of screen
	if allowCameraMove then
		triggerEvent('Camera Follow Pos', (charOffsets.bfX + charOffsets.dadX) / 2, (charOffsets.bfY + charOffsets.dadY) / 2)
	end
end

function onSongStart()
	followChars = true
	camMovementOn = true
end

-- Idling Mechanic
function onUpdate()
	if allowCameraMove then
		if followChars then
			if not camMovementOn then
				camMovementOn = true
			end
			
			if isSinging then
				-- Check for idle being complete
				if mustHitSection then
					if followGF and gfSide == "player" then
						if not isIdleAnimation('gf') and animationFinished('gf') then
							isSinging = false
						end
					else
						if not isIdleAnimation('bf') and animationFinished('boyfriend') then
							isSinging = false
						end
					end
				else
					if followGF and gfSide == "opponent" then
						if not isIdleAnimation('gf') and animationFinished('gf') then
							isSinging = false
						end
					else
						if not isIdleAnimation('dad') and animationFinished('dad') then
							isSinging = false
						end
					end
				end
			end
			
			-- Return to idle
			if not isSinging then		
				if mustHitSection then
					if followGF and gfSide == "player" then
						lookForIdle('gf', false)
					else 
						lookForIdle('boyfriend', true)
					end
				else
					if followGF and gfSide == "opponent" then
						lookForIdle('gf', false)
					else 
						lookForIdle('dad', true)
					end
				end
			end
		else
			if camMovementOn then
				triggerEvent("Camera Follow Pos", noMovement[1], noMovement[2])
				if allowZoomShifts and songName == "Libidinousness" then
					setProperty('defaultCamZoom', camZooms[1])
				end
				
				if shifting then
					camAngle(-1)
					shifting = false
				end
				
				camMovementOn = false
			end
		end
	end
end

function lookForIdle(character, hasSpecial)
	if isIdleAnimation(character) then
		if character == 'boyfriend' then
			triggerEvent("Camera Follow Pos", charOffsets.bfX, charOffsets.bfY)
		else
			triggerEvent("Camera Follow Pos", charOffsets[character..'X'], charOffsets[character..'Y'])
		end
		
		if allowAngleShift and shifting then
			camAngle(-1)
			shifting = false
		end	
	end
	if hasSpecial and isSpecialAnimation(character) then
		playSpecialAnimation(character)
		
		if allowAngleShift and shifting then
			camAngle(-1)
			shifting = false
		end	
	end
end

function isIdleAnimation(character)
	local foundAnim = false
	if character == "gf" then
		for i = 1, #(gfIdles) do
			if getProperty('gf.animation.curAnim.name') == gfIdles[i] then
				foundAnim = true
			end
		end
	elseif character == "dad" then
		for i = 1, #(dadIdles) do
			if getProperty('dad.animation.curAnim.name') == dadIdles[i] then
				foundAnim = true
			end
		end
	elseif character == "boyfriend" then
		for i = 1, #(bfIdles) do
			if getProperty('boyfriend.animation.curAnim.name') == bfIdles[i] then
				foundAnim = true
			end
		end
	end
	
	return foundAnim
end

function isSpecialAnimation(character)
	for i = 1, #(specialAnims) do
		if getProperty(character..'.animation.curAnim.name') == specialAnims[i] then return true end
	end
	
	return false
end

function playSpecialAnimation(character)
	for anim = 1, #(specialAnims) do
		if getProperty(character..'.animation.curAnim.name') == specialAnims[anim] then
			if specialAnims[anim] == 'tail attack' then
				triggerEvent("Camera Follow Pos", charOffsets[character.."X"], charOffsets[character.."Y"] + (offset*3))
			else
				triggerEvent("Camera Follow Pos", charOffsets[character.."X"], charOffsets[character.."Y"])
			end	

			break
		end
	end
end

function animationFinished(character)
	return getProperty(character..'.animation.finished')
end

-- Note Hit functions
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if allowCameraMove then
		if followChars and not mustHitSection then
			isSinging = true
			
			if allowAngleShift and not isSustainNote then
				camAngle(direction)
			end
			
			if noteType == 'GF Sing' or gfSection then
				followGF = true
				gfSide = "opponent"
			else
				followGF = false
			end
		
			if followGF and gfSide == "opponent" then
				camMove("gf", direction, false)

				if allowZoomShifts then
					setProperty('defaultCamZoom', camZooms[3])
				end
			else
				camMove("dad", direction, false)
				
				if allowZoomShifts then
					setProperty('defaultCamZoom', camZooms[1])
				end
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if allowCameraMove then
		if followChars and mustHitSection then
			isSinging = true
			
			if allowAngleShift and not isSustainNote then
				camAngle(direction)
			end
			
			if noteType == 'GF Sing' or gfSection then
				followGF = true
				gfSide = "player"
			else
				followGF = false
			end
			
			if followGF and gfSide == "player" then
				camMove("gf", direction, true)
				
				if allowZoomShifts then
					setProperty('defaultCamZoom', camZooms[3])
				end
			else		
				camMove("bf", direction, true)
				
				if allowZoomShifts then
					setProperty('defaultCamZoom', camZooms[2])
				end
			end
		end
	end
end

function camMove(character, direction, isPlayer)
	local x, y = charOffsets[character.."X"], charOffsets[character.."Y"]
	
	if isPlayer then
		if flipPlayerMovement and not followGF then
			if direction == 0 then x = x + offset
			elseif direction == 1 then y = y - offset
			elseif direction == 2 then y = y + offset
			elseif direction == 3 then x = x - offset end
		else
			if direction == 0 then x = x - offset
			elseif direction == 1 then y = y + offset
			elseif direction == 2 then y = y - offset
			elseif direction == 3 then x = x + offset end
		end
	else
		if flipEnemyMovement and not followGF then
			if direction == 0 then x = x + offset
			elseif direction == 1 then y = y - offset
			elseif direction == 2 then y = y + offset
			elseif direction == 3 then x = x - offset end
		else
			if direction == 0 then x = x - offset
			elseif direction == 1 then y = y + offset
			elseif direction == 2 then y = y - offset
			elseif direction == 3 then x = x + offset end
		end
	end
	
	triggerEvent("Camera Follow Pos", x, y)
end

function noteMiss(id, direction, noteType, isSustainNote)
	if allowCameraMove then
		if not isSustainNote then
			if followChars and mustHitSection then
				if followGF and gfSide == "player" then
					triggerEvent("Camera Follow Pos", charOffsets.gfX, charOffsets.gfY)
				else
					triggerEvent("Camera Follow Pos", charOffsets.bfX, charOffsets.bfY)
				end
				
				if allowAngleShift and shifting then
					camAngle(-1)
					shifting = false
				end
			end
		end
	end
end

-- Custom global functions
function setCameraMovement(newCamOffsets, newOffset, noMovementOffsets, newCamZooms)
	-- Check if values are null. If so, give default values
	if newCamOffsets == nil then
		newCamOffsets = "980, 510, 460, 400, 0, 0"
	end
	if newOffset == nil then
		newOffset = 28
	end
	if noMovementOffsets == nil then
		noMovement[1] = ''
		noMovement[2] = ''
 	else
		local noMovementContents = tableSplit(noMovementOffsets, ',')
		noMovement[1] = tonumber(noMovementContents[1])
		noMovement[2] = tonumber(noMovementContents[2])
	end
	if newCamZooms == nil then
		newCamZooms = "0.9, 0.9, 0.9"
	end
	
	local camOffsets = tableSplit(newCamOffsets, ',')
	charOffsets.bfX = tonumber(camOffsets[1])
	charOffsets.bfY = tonumber(camOffsets[2])
	charOffsets.dadX = tonumber(camOffsets[3])
	charOffsets.dadY = tonumber(camOffsets[4])
	charOffsets.gfX = tonumber(camOffsets[5])
	charOffsets.gfY = tonumber(camOffsets[6])
	
	offset = newOffset
	
	local zoomContents = tableSplit(newCamZooms, ',')
	camZooms[1] = tonumber(zoomContents[1])
	camZooms[2] = tonumber(zoomContents[2])
	camZooms[3] = tonumber(zoomContents[3])
end

function setCameraProperty(property, value)
	local contents = tableSplit(value, ',')
	
	if string.lower(property) == 'bfcamera' then
		charOffsets.bfX = tonumber(contents[1])
		charOffsets.bfY = tonumber(contents[2])
	elseif string.lower(property) == 'dadcamera' then
		charOffsets.dadX = tonumber(contents[1])
		charOffsets.dadY = tonumber(contents[2])
	elseif string.lower(property) == 'gfcamera' then
		charOffsets.gfX = tonumber(contents[1])
		charOffsets.gfY = tonumber(contents[2])
	elseif string.lower(property) == 'camoffsets' then
		offset = tonumber(contents[1])
	elseif string.lower(property) == 'nomovementoffsets' then
		noMovement[1] = tonumber(contents[1])
		noMovement[2] = tonumber(contents[2])
	elseif string.lower(property) == 'camzooms' then
		camZooms[1] = tonumber(contents[1])
		camZooms[2] = tonumber(contents[2])
		camZooms[3] = tonumber(contents[3])
	end
end

function camAngle(direction)
	shifting = true
	cancelTween('camAngleTween')
	if direction == 0 then
		doTweenAngle('camAngleTween', 'camGame', -0.45 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	elseif direction == 1 then
		doTweenAngle('camAngleTween', 'camGame', -0.175 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	elseif direction == 2 then
		doTweenAngle('camAngleTween', 'camGame', 0.175 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	elseif direction == 3 then
		doTweenAngle('camAngleTween', 'camGame', 0.45 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	else
		doTweenAngle('camAngleTween', 'camGame', 0, 0.7 / playbackRate, 'sineOut')
		shifting = false
	end
end

function tableSplit(input, Contrix)
    if Contrix == nil then
		Contrix = '%s'
    end
    local cs={}
		for str in string.gmatch(input,"([^"..Contrix.."]+)") do
			table.insert(cs,str:match("^%s*(.-)%s*$"))
		end
    return cs
end