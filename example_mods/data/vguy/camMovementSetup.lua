local xx = 520;
local yy = 330;
local xx2 = 980;
local yy2 = 460;
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;

local camVariables = {
	camOffsets = "980, 460, 520, 330",
	ofs = 35,
	noMove = "700, 350",
	camZooms = nil
}

function onCreate()
	setGlobalFromScript("scripts/Camera Movement", 'flipOppMovement', true)
	callScript("scripts/Camera Movement", "setCameraMovement", {camVariables.camOffsets, camVariables.ofs, camVariables.noMove, camVariables.camZooms})
	setGlobalFromScript("scripts/Camera Movement", "allowGF", false)
end

function onUpdate()
	if curBeat == 64 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "980, 480"})
	end
	if curBeat == 67 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "520, 390"})
	end
	if curBeat == 68 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"bfCamera", "980, 460"})
	end
	if curBeat == 76 then
		callScript("scripts/Camera Movement", "setCameraProperty", {"dadCamera", "520, 330"})
	end
	if curStep == 1776 then
		setGlobalFromScript("scripts/Camera Movement", 'followChars', false)
	end
end