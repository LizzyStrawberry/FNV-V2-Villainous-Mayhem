--[[
	MODULAR HEALTH DRAIN (By Lizzy Strawberry)
	------------------------------------------
	
	This script basically allows for health drain in your songs,
	with the exception that you can modify the drain rate, enable / disable draining,
	and even exclude noteTypes from draining health!
	
	By default, the values are as is:
	allowDrain = true
	drainRate = 0.012
	blockedNoteTypes = NULL
	
	To modify any of these global variables, use setGlobalFromScript("scripts/HealthDrainModule", ...)!
	
	To add any blocked noteTypes, use setGlobalFromScript("scripts/Health Drain", "ntToBlock", ...)!
	REMEMBER, the blocked noteTypes should be written in string form CASE SENSITIVE, seperated with a ,:
	"Pico Notes, Sus Note, Piss" -> CORRECT
	"PicoNote,Sus,LoveYouNote" -> CORRECT
]]

allowDrain = false
drainRate = 0.012 -- Default (if not set)

ntToBlock = ""
blockedNoteTypes = {}

local foundBlockedNT = true

function onCreatePost()
	if allowDrain then checkForNTypes() end
end

function onUpdate()
	if isMayhemMode then allowDrain = false end -- Disable drain for Mayhem Mode!
end

function opponentNoteHit(id, dir, NT, isSus)
	if allowDrain and not getPropertyFromClass('ClientPrefs', 'buff3Active') then
		if foundBlockedNT then
			for i = 1, #blockedNoteTypes do
				if NT == blockedNoteTypes[i] then return end
			end
		end
		
		local totalDrain = isSus and drainRate / 1.5 or drainRate
		if getHealth() > 0.25 then setHealth(getHealth() - totalDrain) end
	end
end

-- Events
function onEvent(name, v1, v2)
	if name == 'Set Health Drain' then
		if string.lower(v1) == "true" or string.lower(v1) == "1" then allowDrain = true else allowDrain = false end
	end
	if name == 'Set H.D Rate' then
		if string.lower(v1) ~= nil then drainRate = tonumber(v1) else drainRate = 0.012; end
	end
	if name == 'BlackList H.D NTypes' then
		if string.lower(v1) ~= "" or string.lower(v1) ~= nil then
			ntToBlock = v1
			checkForNTypes()
		end
	end
end

function checkForNTypes()
	if ntToBlock == "" then
		foundBlockedNT = false
	else
		local nTypes = tableSplit(ntToBlock, ',')
		blockedNoteTypes = {} -- Clear up before adding noteypes
		for i = 1, #nTypes do
			--debugPrint("Added NoteType "..nTypes[i].." to list!")
			table.insert(blockedNoteTypes, nTypes[i])
		end
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
