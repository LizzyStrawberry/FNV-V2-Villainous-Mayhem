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
	
	IMPORTANT: To use any function that sets things after they get created,
	PLEASE use them on "onCreatePost()", as they may not work in "onCreate()".
	
	The global variables consist of:
	allowCameraMove: Allows camera movement
	followChars: Checks if you want to follow the character's movements or not 
	allowAngleShift: Allows angle shifting on note press
	allowZoomShifts: Allows dynamic zooming (each character has their own defaultCamZoom value)
	
	UPDATE(S):
	- Extra Icons support!
	- It now allows you to add a lot of extra cameras in case you have extra characters in-game that need to be focused on!
	Simply use the addExtraCamera Function to add your new Camera in
	(Please use this responsibly!)
	
	What to use for the extra camera:
	- X
	- Y
	- Zoom
	- NoteTypes to follow
	- isPlayer
]]

-- Global Camera checks (modify-able)
allowCameraMove = true
followChars = false
allowAngleShift = true
allowZoomShifts = false
allowGF = false

-- Global Anims to check (so you can modify em on any other data file)
bfIdles = {'idle', 'danceLeft', 'danceRight'}
dadIdles = {'idle', 'danceLeft', 'danceRight'}
gfIdles = {'idle', 'danceLeft', 'danceRight'}
specialAnims = {}

gfNTypes = {"GF Sing"}

-- MAIN Camera Movement Variables
-- Character Offsets
local charOffsets = {
	bfX = 0, bfY = 0,
	dadX = 0, dadY = 0,
	gfX = 0, gfY = 0
}
local offset = 0 -- Amount of Movement
local noMovement = {0, 0} -- No Movement Position
local camZooms = {0, 0, 0} -- Camera Zooms for each character

-- Local variables`
local camMovementOn = false -- Enable movement
local isSinging = false -- Check for singing
local shifting = false -- For angle shifting

-- Checks for note presses
local followBoth = false
local followGF = false
local followExtraChar = false
gfSide = nil -- Check GF Side
focusOnGF = false -- Use ONLY if you want to focus on GF!!!!

-- Extra Character variables
local exCharsOn = false
local extraCameraProperties = {}
local extraCharNames = {}
local curEXSinging

-- Extra Icon Variables
local hasExtraIcons = false
local addingIcons = false
local addGFIcon = false
local exIcons = {}
local exIconsSides = {}
local ICON_HSP = 60 -- horizontal step per layer (px)
local ICON_VSP = 75 -- vertical step per layer (px)
local iconSizeDecrease = 0.1

function onCreate()
	addLuaScript('zCameraFix')
	setVar("exIcons", exIcons)
	
	if allowCameraMove then
		setCameraMovement() -- Always call this at the start, to set up camera offsets, won't work onCreatePost()
	end
end

function onCreatePost() -- Set Camera to middle of screen
	setVar("gfSide", gfSide)
	
	if allowCameraMove then
		triggerEvent('Camera Follow Pos', (charOffsets.bfX + charOffsets.dadX) / 2, (charOffsets.bfY + charOffsets.dadY) / 2)
	end
	
	if addGFIcon then 
		local side = ((gfSide == "player" and not getVar("flippedIcons")) and "1" or "2")
		setObjectOrder("iconGF", getObjectOrder("iconP"..side) + 1)
		addNewIcon("GF", "gf", gfSide, true) 
	end
end

function onSongStart()
	followChars = true
	camMovementOn = true
	onSectionHit()
end

function onSectionHit()
	if allowZoomShifts then
		if mustHitSection then
			if followExtraChar then setZoom(extraCameraProperties[curEXSinging.."zoomPos"]) elseif followGF then setZoom(3) else setZoom(2) end
		else
			if followExtraChar then setZoom(extraCameraProperties[curEXSinging.."zoomPos"]) elseif followGF then setZoom(3) else setZoom(1) end
		end
	end
end

function onUpdate()
	-- Extra Character checking
	exCharsOn = getVar("exCharsOn") -- From ExtraCharModule!
	if exCharsOn then
		curEXSinging = getVar("charSinging") -- From ExtraCharModule!
	end
	
	-- Camera Movement Mechanism
	if allowCameraMove then
		if followChars then
			if not camMovementOn then
				camMovementOn = true
			end
			
			if mustHitSection then
				if followExtraChar and curEXSinging ~= "" then
					lookForIdle(curEXSinging, true)
				elseif followBoth then
					lookForIdle('boyfriend', true)
				elseif followGF and gfSide == "player" then
					lookForIdle('gf', false)
				else 
					lookForIdle('boyfriend', true)
				end
			else
				if followExtraChar and curEXSinging ~= "" then
					lookForIdle(curEXSinging, true)
				elseif followBoth then
					lookForIdle('dad', true)
				elseif followGF and gfSide == "opponent" then
					lookForIdle('gf', false)
				else 
					lookForIdle('dad', true)
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

	-- Extra Icon bopping
	if hasExtraIcons then
		-- keep extras following main icon positions each frame
		setIconLayout("player")
		setIconLayout("opponent")

		-- match scales & frames to their respective main icon
		if getVar("exCharsOn") or getVar("gfSide") ~= nil then
			for i = 1, #exIcons do
				if exIconsSides[i] == "player" then
					scaleObject(exIcons[i], getProperty("iconP1.scale.x") - iconSizeDecrease, getProperty("iconP1.scale.y") - iconSizeDecrease)
					setProperty(exIcons[i]..".animation.curAnim.curFrame", getProperty("iconP1.animation.curAnim.curFrame"))
				else
					scaleObject(exIcons[i], getProperty("iconP2.scale.x") - iconSizeDecrease, getProperty("iconP2.scale.y") - iconSizeDecrease)
					setProperty(exIcons[i]..".animation.curAnim.curFrame", getProperty("iconP2.animation.curAnim.curFrame"))
				end
			end
		end
	end
end

-- Update Function checks (Idling / Special Animations)
function lookForIdle(character, hasSpecial)
	if hasSpecial and isSpecialAnimation(character) then
		isSinging = false
		playSpecialAnimation(character)
		
		if allowAngleShift and shifting then
			camAngle(-1)
			shifting = false
		end	
	elseif isIdleAnimation(character) then
		isSinging = false
		if character == 'boyfriend' then
			triggerEvent("Camera Follow Pos", charOffsets.bfX, charOffsets.bfY)
		elseif followExtraChar and curEXSinging ~= "" then
			triggerEvent("Camera Follow Pos", charOffsets[curEXSinging.."X"], charOffsets[curEXSinging.."Y"])
		elseif (character == "gf" and followGF) or character == "dad" then
			triggerEvent("Camera Follow Pos", charOffsets[character..'X'], charOffsets[character..'Y'])
		end
		
		if allowAngleShift and shifting then
			camAngle(-1)
			shifting = false
		end	
	end
end

function isIdleAnimation(character)
	local foundAnim = false
	if character == curEXSinging then
		if getProperty(curEXSinging..'.animation.curAnim.name') == 'idle' then
			foundAnim = true
		end
	elseif character == "gf" then
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
		if character == "bf" then
			if getProperty('boyfriend.animation.curAnim.name') == specialAnims[i] then return true end
		else
			if getProperty(character..'.animation.curAnim.name') == specialAnims[i] then return true end
		end
	end
	
	return false
end

function playSpecialAnimation(character)
	for anim = 1, #(specialAnims) do
		if getProperty(character..'.animation.curAnim.name') == specialAnims[anim] then
			triggerEvent("Camera Follow Pos", charOffsets[character.."X"], charOffsets[character.."Y"])

			break
		end
	end
end

-- Zooming
function setZoom(charNum)
	setProperty('defaultCamZoom', camZooms[charNum])
end

function checkGFNoteTypes(noteType)
	for nt = 1, #gfNTypes do
		if gfNTypes[nt] == noteType then return true end
	end
	
	return false
end

-- Note Press Functions
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if allowCameraMove then
		if followChars and not mustHitSection then
			isSinging = true
			
			-- Camera Angle
			if allowAngleShift and not isSustainNote then
				camAngle(direction % 4)
			end
			
			checkNotePress("dad", noteType)
			
			if not focusOnGF and followExtraChar and not extraCameraProperties[curEXSinging.."isPlayer"] and curEXSinging ~= "" then
				camMove("extraChar", direction % 4)
						
				if allowZoomShifts then setZoom(extraCameraProperties[curEXSinging.."zoomPos"]) end
			elseif followBoth and gfSide == 'opponent' then
				camMove("bothEnemies", direction % 4)
				
				if allowZoomShifts then	setZoom(1) end
			elseif followGF and gfSide == "opponent" then
				camMove("gf", direction % 4)

				if allowZoomShifts then	setZoom(3) end
			else
				camMove("dad", direction % 4)
				
				if allowZoomShifts then	setZoom(1) end
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if allowCameraMove then
		if followChars and mustHitSection then
			isSinging = true
			
			-- Camera Angle
			if allowAngleShift and not isSustainNote then
				camAngle(direction % 4)
			end
			
			checkNotePress("boyfriend", noteType)
			
			if not focusOnGF and followExtraChar and extraCameraProperties[curEXSinging.."isPlayer"] and curEXSinging ~= "" then
				camMove("extraChar", direction % 4)
						
				if allowZoomShifts then setZoom(extraCameraProperties[curEXSinging.."zoomPos"]) end
			elseif followBoth and gfSide == 'player' then
				camMove("bothPlayers", direction % 4)
				
				if allowZoomShifts then setZoom(2) end
			elseif followGF and gfSide == "player" then
				camMove("gf", direction % 4)
				
				if allowZoomShifts then setZoom(3) end
			else		
				camMove("bf", direction % 4)
				
				if allowZoomShifts then setZoom(2) end
			end
		end
	end
end

function checkNotePress(char, noteType)
	-- GF Check
	if not followExtraChar and not followBoth and allowGF and (checkGFNoteTypes(noteType) or gfSection or focusOnGF) then
		followGF = true
		followBoth = false
		followExtraChar = false
		if char == "dad" then gfSide = "opponent" else gfSide = "player" end
	else
		-- Check for Extra Char First
		if exCharsOn and not isIdleAnimation(curEXSinging) and curEXSinging ~= "" then
			for note = 1, #(extraCameraProperties[curEXSinging.."NoteTypes"]) do
				if noteType == extraCameraProperties[curEXSinging.."NoteTypes"][note] then
					if (char == "dad" and not extraCameraProperties[curEXSinging.."isPlayer"]) or (char == "boyfriend" and extraCameraProperties[curEXSinging.."isPlayer"]) then
						followExtraChar = true
						followBoth = false
						followGF = false
					end
				end
			end
		end
		-- Then check here
		if not followExtraChar then
			if not isIdleAnimation('gf') and not isIdleAnimation(char) then
				if (char == "boyfriend" and gfSide == "player") or (char == "dad" and gfSide == "opponent") then
					followBoth = true
					followExtraChar = false
					followGF = false
				end
			else
				followBoth = false
				followExtraChar = false
				followGF = false
			end
		end
	end
end

function camMove(character, direction)
	local x, y = 0, 0
	if character == "extraChar" and curEXSinging ~= "" then
		x, y = charOffsets[curEXSinging.."X"], charOffsets[curEXSinging.."Y"]
	elseif character == 'bothExtra' and curEXSinging ~= "" then
		x, y = (charOffsets[curEXSinging.."X"] + charOffsets.gfX) / 2, (charOffsets[curEXSinging.."Y"] + charOffsets.gfY) / 2
	elseif character == 'bothEnemies' then
		x, y = (charOffsets.dadX + charOffsets.gfX) / 2, (charOffsets.dadY + charOffsets.gfY) / 2
	elseif character == 'bothPlayers' then
		x, y = (charOffsets.bfX + charOffsets.gfX) / 2, (charOffsets.bfY + charOffsets.gfY) / 2
	else
		x, y = charOffsets[character.."X"], charOffsets[character.."Y"]
	end

	if direction == 0 then x = x - offset
	elseif direction == 1 then y = y + offset
	elseif direction == 2 then y = y - offset
	elseif direction == 3 then x = x + offset end
	
	triggerEvent("Camera Follow Pos", x, y)
end

function noteMiss(id, direction, noteType, isSustainNote)
	if allowCameraMove then
		if not isSustainNote then
			if followChars and mustHitSection then
				if gfSection then
					triggerEvent("Camera Follow Pos", charOffsets.gfX, charOffsets.gfY)
				elseif followExtraChar then
					triggerEvent("Camera Follow Pos", charOffsets[curEXSinging.."X"], charOffsets[curEXSinging.."Y"])
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
		newCamOffsets = "1080, 720, 550, 720" -- Default ok values, NO GF!!!
	end
	if newOffset == nil then
		newOffset = 35
	end
	if newCamZooms == nil then
		newCamZooms = "0.9, 0.9"
	end
	
	-- Camera Values
	local camOffsets = tableSplit(newCamOffsets, ',')
	charOffsets.bfX = tonumber(camOffsets[1])
	charOffsets.bfY = tonumber(camOffsets[2])
	charOffsets.dadX = tonumber(camOffsets[3])
	charOffsets.dadY = tonumber(camOffsets[4])
	if #camOffsets == 6 then -- Has GF Offsets, make her work
		allowGF = true
		charOffsets.gfX = tonumber(camOffsets[5])
		charOffsets.gfY = tonumber(camOffsets[6])
		addGFIcon = true
	end
	
	-- No Movement Values
	if noMovementOffsets == nil then
		noMovement[1] = (charOffsets.bfX + charOffsets.dadX) / 2
		noMovement[2] = (charOffsets.bfY + charOffsets.dadY) / 2
 	else
		local noMovementContents = tableSplit(noMovementOffsets, ',')
		noMovement[1] = tonumber(noMovementContents[1])
		noMovement[2] = tonumber(noMovementContents[2])
	end
	
	setValues()
	
	-- Offset
	offset = newOffset
	
	-- Zooms
	local zoomContents = tableSplit(newCamZooms, ',')
	for count = 1, #(zoomContents) do
		camZooms[count] = tonumber(zoomContents[count])
	end
end

function setCameraProperty(property, value, isExtra, extraName)
	local contents = tableSplit(value, ',')
	
	if not isExtra or isExtra == nil then
		if string.lower(property) == 'bfcamera' then
			charOffsets.bfX = tonumber(contents[1])
			charOffsets.bfY = tonumber(contents[2])
			setValues()
		elseif string.lower(property) == 'dadcamera' then
			charOffsets.dadX = tonumber(contents[1])
			charOffsets.dadY = tonumber(contents[2])
			setValues()
		elseif string.lower(property) == 'gfcamera' then
			charOffsets.gfX = tonumber(contents[1])
			charOffsets.gfY = tonumber(contents[2])
			setValues()
		elseif string.lower(property) == 'camoffsets' then
			offset = tonumber(contents[1])
		elseif string.lower(property) == 'camzooms' then
			for count = 1, #(contents) do
				camZooms[count] = tonumber(contents[count])
			end
			onSectionHit()
		end
	else -- For Extra Cameras
		if string.lower(property) == 'camera' then
			charOffsets[extraName.."X"] = tonumber(contents[1])
			charOffsets[extraName.."Y"] = tonumber(contents[2])
			setValues()
			--debugPrint("New Offsets for "..extraName..": X = "..charOffsets[extraName.."X"].." | Y = "..charOffsets[extraName.."Y"])
		elseif string.lower(property) == 'notetypes' then
			for i = 1, #contents do
				table.insert(extraCameraProperties[extraName.."NoteTypes"], contents[i])
			end
		elseif string.lower(property) == 'isplayer' then
			if string.lower(contents[1]) == "true" then extraCameraProperties[extraName.."isPlayer"] = true
			elseif string.lower(contents[1]) == "false" then extraCameraProperties[extraName.."isPlayer"] = false
			end
			--debugPrint("New isPlayer for "..extraName..": "..tostring(extraCameraProperties[extraName.."isPlayer"]))
		end
	end
end

-- Extra Camera Functions
function addExtraCamera(name, x, y, nTypes, zoom, isPlayer)
	if zoom == nil then
		zoom = 0.9
	end
	if nTypes == nil then
		nTypes = "null"
	end

	table.insert(extraCharNames, name)
	charOffsets[name.."X"] = x
	charOffsets[name.."Y"] = y
	
	table.insert(camZooms, zoom)
	extraCameraProperties[name.."zoomPos"] = #camZooms
	extraCameraProperties[name.."NoteTypes"] = tableSplit(nTypes, ",")

	extraCameraProperties[name.."isPlayer"] = isPlayer
	
	setValues()
end

-- Extra Icon layout config (dynamic)
-- return x,y for k-th extra icon on a side relative to the main icon
function setExtraIconsPositions(baseX, baseY, dir, k)
	local layer = math.ceil((k - 1) / 2) -- Layers: 1, 1, 2, 2, 3, 3...
	local isTop = (k % 2 == 1) -- Odd Value should be on top
	local yOff  = (isTop and -1 or 1) * (ICON_VSP * layer) - 40 -- Add a small offset at the end
	local xOff = (k == 1 and (dir * ICON_HSP) or (dir * (ICON_HSP * layer))) -- Check if k = 1, so it shouldn't get to 0, meaning the first icons will be on top of the main ones
	return baseX + xOff, baseY + yOff
end

-- lay out all extras on a given side to follow the main icon
function setIconLayout(side)
	local baseX = getProperty((side == "player" and not getVar("flippedIcons")) and "iconP1.x" or "iconP2.x")
	local baseY = getProperty((side == "player" and not getVar("flippedIcons")) and "iconP1.y" or "iconP2.y")
	local dir = (side == "player") and 1 or -1
	local k = 0

	for i = 1, #exIcons do
		if exIconsSides[i] == side then
			k = k + 1 
			local x, y = setExtraIconsPositions(baseX, baseY, dir, k)
			setProperty(exIcons[i]..".x", x)
			setProperty(exIcons[i]..".y", y)
		end
	end
end

function addNewIcon(tag, char, isPlayer, visible)
	hasExtraIcons = true

	local side = isPlayer and "player" or "opponent"
	local order
	local iconNum = isPlayer and "1" or "2"
	if isPlayer then
		order = getObjectOrder("iconP1") + 2
	else
		order = getObjectOrder("iconP2") + 1
	end

	-- Create New Icon
	local iconName = "icon"..tag
	createInstance(iconName, "HealthIcon", { (char == "gf") and getProperty("gf.healthIcon") or char, isPlayer })
	setObjectCamera(iconName, "hud")
	setObjectOrder(iconName, order)
	addInstance(iconName)
	table.insert(exIcons, iconName)
	table.insert(exIconsSides, side)
	
	if char == "gf" then setProperty("iconGF.flipX", isPlayer and true or false) end

	-- Set Icon Properties Immediately
	scaleObject(iconName, getProperty("iconP"..iconNum..".scale.x") - iconSizeDecrease, getProperty("iconP"..iconNum..".scale.y") - iconSizeDecrease)

	-- Position everything and start
	setIconLayout(side)

	setProperty(iconName..".alpha", visible and 1 or 0)
end

function removeIcon(pos)
	if pos < 1 or pos > #exIcons then return end
	local side = exIconsSides[pos]

	callMethod("remove", {instanceArg(exIcons[pos])})
	table.remove(exIcons, pos)
	table.remove(exIconsSides, pos)

	setIconLayout(side)
	setValues()
end

-- To use globally on other scripts!!
function setValues()
	setVar("allowGF", allowGF)
	
	setVar("bfCamX", charOffsets.bfX)
	setVar("bfCamY", charOffsets.bfY)
	setVar("dadCamX", charOffsets.dadX)
	setVar("dadCamY", charOffsets.dadY)
	-- GF Values
	if allowGF then
		setVar("gfSide", gfSide)
		setVar("gfCamX", charOffsets.gfX)
		setVar("gfCamY", charOffsets.gfY)
	end
	
	-- Extra Character Values + icons
	if exCharsOn then
		setVar("exIcons", exIcons)
		setVar("exIconsSides", exIconsSides)

		setVar("exCharNamesOnCamera", extraCharNames)
		for i = 1, #extraCharNames do
			local name = extraCharNames[i]
			setVar(name.."CamX", charOffsets[name.."X"])
			setVar(name.."CamY", charOffsets[name.."Y"])
		end
	end
end

function camAngle(direction)
	shifting = true
	cancelTween('camAngleTween')
	if direction == 0 then
		doTweenAngle('camAngleTween', 'camGame', -0.55 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	elseif direction == 1 then
		doTweenAngle('camAngleTween', 'camGame', -0.275 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	elseif direction == 2 then
		doTweenAngle('camAngleTween', 'camGame', 0.275 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	elseif direction == 3 then
		doTweenAngle('camAngleTween', 'camGame', 0.55 / getProperty("defaultCamZoom"), 0.7 / playbackRate, 'sineOut')
	else
		doTweenAngle('camAngleTween', 'camGame', 0, 0.7 / playbackRate, 'sineOut')
		shifting = false
	end
end

function onEvent(name, v1, v2)
	if name == 'Play Animation' then -- Used for Special Animations
		lookForIdle(v2, true)
	end
end

-- Table splitting
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