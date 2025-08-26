local chars = {}
local extraChars = {}
local json

local anims = {
    'singLEFT',
    'singDOWN',
    'singUP',
    'singRIGHT'
}

--[[
    Instructions:

        //Use via adding at the top of your script:
            local extraChars = require("mods/scripts/ExtraCharModule")
        //Functions:
            --makeCharacter(tag,img,nType,x,y)
            <tag> the tag for the sprite of the character, mostly for easy access to it outside of this!
            <img> is the name of your character's json, it should be inside the characters folder.
            <nType> is the name of the noteType you want to use for your character.
            <isPlayer> is wheter your character is the player or not, should just be true or false.
            <sOffs> is a table which has 2 values: x and y. It should look like: {-100,0} for example. 1st num being x and the 2nd being y.
            <aSuffix> is the suffix for your altNote type, so if your noteType is called "Rizz" then call the alt one "Rizz-alt" and put "-alt" in aSuffix.
            --removeCharacter(tag,destory)
            <tag> the tag of the character you want to remove.
            <destory> wheter you want to permanently remove it or not.
            --changeCharacter(value1, value2)
            <value1> is the tag of the character you want to change.
            <value2> name of the character json your changing to.

]]--

function onCreate()
    if currentModDirectory ~= nil and currentModDirectory ~= '' then
        json = require("mods/"..currentModDirectory.."/scripts/jsonlua")
    else
        json = require("mods/scripts/jsonlua")
    end
end

function onCreatePost()
	setVar("charSinging", "") -- Leave Blank
	setVar("exCharsOn", false) -- Should be false at first
end

function extraChars.makeCharacter(tag, charName, nType, isPlayer, allowBothSides, sOffs, aSuffix, visibleIcon)
    local charJson = json.parse(getTextFromFile('characters/'..charName..'.json'))
    local newChar = {
        name = tag,
        positions = charJson.position,
        stageOffset = {
            sOffs[1],sOffs[2]
        },
		healthIcon = charJson.healthicon,
        animations = charJson.animations,
        antiAlias = charJson.no_antialiasing,
        idleSuffix = "",
        noteTypes = tableSplit(nType, ","),
        altSuffix = aSuffix,
        playable = isPlayer,
		bothSided = allowBothSides,
        doIdle = true,
        specialAnim = false,
        idleLoop
    }
    makeAnimatedLuaSprite(tag, charJson.image, charJson.position[1] + sOffs[1], charJson.position[2] + sOffs[2])
    scaleObject(tag, charJson.scale, charJson.scale)
	if isPlayer then
		setObjectOrder(tag, getObjectOrder('boyfriendGroup') + 1)
	else
		setObjectOrder(tag, getObjectOrder('boyfriendGroup') - 1)
	end

    -- Set up animations
    for i,animation in ipairs(charJson.animations) do
		if table.concat(animation.indices, ',') ~= "" then
			if animation.loop then
				addAnimationByIndicesLoop(tag, animation.anim, animation.name, table.concat(animation.indices, ','), animation.fps / playbackRate)
			else
				addAnimationByIndices(tag, animation.anim, animation.name, table.concat(animation.indices, ','), animation.fps / playbackRate)
			end
		else
			addAnimationByPrefix(tag, animation.anim, animation.name, animation.fps / playbackRate, animation.loop)
		end
        addOffset(tag, animation.anim, animation.offsets[1], animation.offsets[2])
        if animation.anim == 'idle' then
            newChar.idleLoop = animation.loop
        end
    end

    -- Set Properties
    setProperty(tag..'.flipX', charJson.flip_x)
    setProperty(tag..'.antialiasing', charJson.antiAlias)
    if newChar.playable then
        setProperty(tag..'.flipX', not getProperty(tag..'.flipX'))
    end    
    
    addLuaSprite(tag)
    playAnim(tag, 'idle'..newChar.idleSuffix)
    table.insert(chars,newChar)

	-- Icon Check
	callScript("scripts/Camera Movement", "addNewIcon", {tag, charJson.healthicon, newChar.playable, visibleIcon})

    -- Set Variables
    setVar("exCharsOn", true)
end

-- This shit broken, I'm too lazy to fix this LMAO
function extraChars.removeCharacter(tag, destroy)
	local counter = 1
    for i,char in pairs(chars) do
        if char.name == tag then
			debugPrint("Checking char "..char.name.."in number "..counter)
			removeLuaSprite(tag, destroy)
			if destroy then
				callScript("scripts/Camera Movement", "removeIcon", {counter})
				
                -- Remove Character
                table.remove(chars, counter) 
           end
           break
        end
		counter = counter + 1;
    end
end

function extraChars.changeCharacter(value1, value2)
    for i,char in pairs(chars) do
        if value1 == char.name then
            local copy = char
            extraChars.removeCharacter(char.name, true)
            extraChars.makeCharacter(char.name, value2, copy.noteType, copy.playable, copy.bothSided, copy.stageOffset, copy.altSuffix)
            break
        end
    end
end


function onCountdownTick(counter)
    if #chars == 0 then return end
    for i,char in pairs(chars) do
        if counter % 2 == 0 then
            playAnim(char.name, 'idle'..char.idleSuffix)
        end 
    end
end
    
function onSongStart()
    if #chars == 0 then return end
    for i,char in pairs(chars) do
		playAnim(char.name, 'idle'..char.idleSuffix)
    end
end

function onUpdate()
	if #chars == 0 then return end
    for i,char in pairs(chars) do
		if getProperty(char.name..".animation.curAnim.finished") and animationExists(char.name, getProperty(char.name..".animation.curAnim.name")..char.idleSuffix.."-loop") then
			playAnim(char.name, getProperty(char.name..".animation.curAnim.name")..char.idleSuffix.."-loop")
		end
	end
end

function onBeatHit()
    if #chars == 0 then return end
    for i,char in pairs(chars) do
        if not char.idleLoop then
            if curBeat % 2 == 0 and char.doIdle and not char.specialAnim and getProperty(char.name..'animation.curAnim.name') ~= "idle"..char.idleSuffix then
                playAnim(char.name, 'idle'..char.idleSuffix)
				if getVar("charSinging") == char.name then
					setVar("charSinging", "")
				end
            end
            char.doIdle = true
        else
            if curBeat % 2 == 0 and char.doIdle and not char.specialAnim and getProperty(char.name..'animation.curAnim.name') ~= "idle"..char.idleSuffix then
                playAnim(char.name, 'idle'..char.idleSuffix)
				if getVar("charSinging") == char.name then
					setVar("charSinging", "")
				end
            end
            char.doIdle = true
        end
    end
end

function getCharSinging(char)
	local names = getVar("exCharNamesOnCamera") -- From Camera Movement! Check if the character DOES have cam shits
	for i = 1, #names do
		if names[i] == char.name then
			setVar("charSinging", char.name)
		end
	end
end

function singStuff(membersIndex, noteData, noteType, char)
	for note = 1, #(char.noteTypes) do
		if noteType == char.noteTypes[note] or (noteType == "" and string.lower(char.noteTypes[note]) == "normal") then
			char.doIdle = false
			playAnim(char.name, anims[(noteData % 4) + 1], true)
			if noteType ~= "" then
				getCharSinging(char)
			end
		elseif noteType == char.noteTypes[note]..char.altSuffix then
			char.doIdle = false
			playAnim(char.name, anims[(noteData % 4) + 1]..char.altSuffix, true)
			getCharSinging(char)
		end
	end
end

function missStuff(noteData, noteType, char)
	for note = 1, #(char.noteTypes) do
		if noteType == char.noteTypes[note] or (noteType == "" and string.lower(char.noteTypes[note]) == "normal") then
			playAnim(char.name, anims[(noteData % 4) + 1].."miss", true)
			char.doIdle = false
		end
	end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if #chars == 0 then return end
    for i,char in pairs(chars) do
        if char.playable or char.bothSided then
            singStuff(membersIndex, noteData, noteType, char)
        end
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if #chars == 0 then return end
    for i,char in pairs(chars) do
        if not char.playable or char.bothSided then
            singStuff(membersIndex, noteData, noteType, char)
        end
    end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    if #chars == 0 then return end
    for i,char in pairs(chars) do
        if char.playable or char.bothSided then
            missStuff(noteData, noteType, char)
        end
    end
end

function onEvent(eventName, value1, value2)
    if #chars == 0 then return end
        if eventName == 'Play Animation' then
            for i,char in pairs(chars) do
                if value2 == char.name then
                    char.specialAnim = true
                    playAnim(char.name, value1)
                    break
                end
            end
        end
    if eventName == 'Alt Idle Animation' then
        for i,char in pairs(chars) do
            if value2 == char.name then
                char.idleSuffix = value2
                playAnim(char.name, 'idle'..char.idleSuffix)
                break
            end
        end
    end
    if eventName == "Change Extra Character" then
        extraChars.changeCharacter(value1, value2)
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

return extraChars