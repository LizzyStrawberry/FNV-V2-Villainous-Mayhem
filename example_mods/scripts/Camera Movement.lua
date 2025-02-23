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
	'marcoshucks'
}
flipEnemyMovement = false

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
local shifting = false

local dadIdles = {
	'idle',
	'danceLeft',
	'danceRight'
}
local gfIdles = {
	'idle',
	'danceLeft',
	'danceRight'
}
local specialAnims = {
	"tail attack",
	'jumpscare'
}

local nonZCameraFixSongs = {"Slow.FLP", "Slow.FLP (Old)"}
local allowZcam = true
function onCreate()
	for song = 1, #(nonZCameraFixSongs) do
		if songName == nonZCameraFixSongs[song] then
			allowZcam = false
		end
	end
	
	if allowZcam then
		addLuaScript('zCameraFix')
	else
		removeLuaScript('zCameraFix')
	end
	
	for pee = 1, #(marcoChars) do
		if dadName == marcoChars[pee] then
			flipEnemyMovement = true
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
	moveCameraSection()
	onSectionHit()
end

-- Mechanism
function onUpdate()
	if allowCameraMove then
		if followChars then
			camMovementOn = true
			if isSinging then
				if mustHitSection then
					if followGF then
						for anim = 1, #(gfIdles) do
							if getProperty('gf.animation.curAnim.name') ~= gfIdles[anim] and getProperty('gfGroup.animation.curAnim.finished') then
								followGF = false
								isSinging = false
							end
						end
					else
						if getProperty('boyfriend.animation.curAnim.name') ~= 'idle' and getProperty('boyfriendGroup.animation.curAnim.finished') then
							isSinging = false
						end
					end
				else
					if followGF then
						for anim = 1, #(gfIdles) do
							if getProperty('gf.animation.curAnim.name') ~= gfIdles[anim] and getProperty('gfGroup.animation.curAnim.finished') then
								followGF = false
								isSinging = false
							end
						end
					else
						for anim = 1, #(dadIdles) do
							if getProperty('dad.animation.curAnim.name') ~= dadIdles[anim] and getProperty('dadGroup.animation.curAnim.finished') then
								isSinging = false
							end
						end
					end
				end
			end
			
			if not isSinging then		
				if mustHitSection then
					if followGF or gfSection then
						for anim = 1, #(gfIdles) do
							if getProperty('gf.animation.curAnim.name') == gfIdles[anim] then
								triggerEvent("Camera Follow Pos", charOffsets.gfX, charOffsets.gfY)
								if allowAngleShift and shifting then
									camAngle(-1)
									shifting = false
								end
							end
						end
					elseif not followGF then
						if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
							triggerEvent("Camera Follow Pos", charOffsets.bfX, charOffsets.bfY)
							if allowAngleShift and shifting then
								camAngle(-1)
								shifting = false
							end
						end
						for anim = 1, #(specialAnims) do
							if getProperty('boyfriend.animation.curAnim.name') == specialAnims[anim] then
								if specialAnims[anim] == 'tail attack' then
									triggerEvent("Camera Follow Pos", charOffsets.bfX, charOffsets.bfY + (offset*3))
								else
									triggerEvent("Camera Follow Pos", charOffsets.bfX, charOffsets.bfY)
								end
								if allowAngleShift and shifting then
									camAngle(-1)
								end
							end
						end
					end
				else
					if followGF or gfSection then
						for anim = 1, #(gfIdles) do
							if getProperty('gf.animation.curAnim.name') == gfIdles[anim] then
								triggerEvent("Camera Follow Pos", charOffsets.gfX, charOffsets.gfY)
								if allowAngleShift and shifting then
									camAngle(-1)
									shifting = false
								end
							end
						end
					elseif not followGF then
						for anim = 1, #(dadIdles) do
							if getProperty('dad.animation.curAnim.name') == dadIdles[anim] then
								triggerEvent("Camera Follow Pos", charOffsets.dadX, charOffsets.dadY)
								if allowAngleShift and shifting then
									camAngle(-1)
								end
							end
						end
						for anim = 1, #(specialAnims) do
							if getProperty('dad.animation.curAnim.name') == specialAnims[anim] then
								if specialAnims[anim] == 'tail attack' then
									triggerEvent("Camera Follow Pos", charOffsets.dadX, charOffsets.dadY + (offset*3))
								else
									triggerEvent("Camera Follow Pos", charOffsets.dadX, charOffsets.dadY)
								end
								if allowAngleShift and shifting then
									camAngle(-1)
								end
							end
						end
					end
				end
			end
		else
			if camMovementOn then
				triggerEvent("Camera Follow Pos", noMovement[1], noMovement[2])
				if shifting then
					camAngle(-1)
					shifting = false
				end
				camMovementOn = false
			end
		end
	end
end

function onSectionHit()
	if allowCameraMove then
		if allowZoomShifts then
			if not mustHitSection then
				if gfSection then
					setProperty('defaultCamZoom', camZooms[3])
				else
					setProperty('defaultCamZoom', camZooms[1])
				end
			else
				if gfSection then
					setProperty('defaultCamZoom', camZooms[3])
				else
					setProperty('defaultCamZoom', camZooms[2])
				end
			end
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if allowCameraMove then
		if followChars and not mustHitSection then
			isSinging = true
			if gfSection then
				followGF = true
				if direction == 0 then
					triggerEvent("Camera Follow Pos", charOffsets.gfX - offset, charOffsets.gfY)
				elseif direction == 1 then
					triggerEvent("Camera Follow Pos", charOffsets.gfX, charOffsets.gfY + offset)
				elseif direction == 2 then
					triggerEvent("Camera Follow Pos", charOffsets.gfX, charOffsets.gfY - offset)
				elseif direction == 3 then
					triggerEvent("Camera Follow Pos", charOffsets.gfX + offset, charOffsets.gfY)
				end
			else
				followGF = false
				if flipEnemyMovement then
					if direction == 0 then
						triggerEvent("Camera Follow Pos", charOffsets.dadX + offset, charOffsets.dadY)
					elseif direction == 1 then
						triggerEvent("Camera Follow Pos", charOffsets.dadX, charOffsets.dadY - offset)
					elseif direction == 2 then
						triggerEvent("Camera Follow Pos", charOffsets.dadX, charOffsets.dadY + offset)
					elseif direction == 3 then
						triggerEvent("Camera Follow Pos", charOffsets.dadX - offset, charOffsets.dadY)
					end
				else
					if direction == 0 then
						triggerEvent("Camera Follow Pos", charOffsets.dadX - offset, charOffsets.dadY)
					elseif direction == 1 then
						triggerEvent("Camera Follow Pos", charOffsets.dadX, charOffsets.dadY + offset)
					elseif direction == 2 then
						triggerEvent("Camera Follow Pos", charOffsets.dadX, charOffsets.dadY - offset)
					elseif direction == 3 then
						triggerEvent("Camera Follow Pos", charOffsets.dadX + offset, charOffsets.dadY)
					end
				end
			end
				
			if not isSustainNote and allowAngleShift then
				camAngle(direction)
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if allowCameraMove then
		if followChars and mustHitSection then
			isSinging = true
			if gfSection then
				followGF = true
				if direction == 0 then
					triggerEvent("Camera Follow Pos", charOffsets.gfX - offset, charOffsets.gfY)
				elseif direction == 1 then
					triggerEvent("Camera Follow Pos", charOffsets.gfX, charOffsets.gfY + offset)
				elseif direction == 2 then
					triggerEvent("Camera Follow Pos", charOffsets.gfX, charOffsets.gfY - offset)
				elseif direction == 3 then
					triggerEvent("Camera Follow Pos", charOffsets.gfX + offset, charOffsets.gfY)
				end
			else		
				followGF = false
				if direction == 0 then
					triggerEvent("Camera Follow Pos", charOffsets.bfX - offset, charOffsets.bfY)
				elseif direction == 1 then
					triggerEvent("Camera Follow Pos", charOffsets.bfX, charOffsets.bfY + offset)
				elseif direction == 2 then
					triggerEvent("Camera Follow Pos", charOffsets.bfX, charOffsets.bfY - offset)
				elseif direction == 3 then
					triggerEvent("Camera Follow Pos", charOffsets.bfX + offset, charOffsets.bfY)
				end
			end
				
			if not isSustainNote and allowAngleShift then
				camAngle(direction)
			end
		end
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if allowCameraMove then
		if not isSustainNote then
			if followChars and mustHitSection then
				if gfSection then
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
		onSectionHit()
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
			table.insert(cs,str)
		end
    return cs
end