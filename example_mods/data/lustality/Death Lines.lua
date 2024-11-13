local playedOnce = false
local funninumber = 0

function onCreate()
	funninumber = getRandomInt(1, 3)
end

function onGameOver()
		if not playedOnce then
				playSound("Kiana's Lines/She killed you " ..funninumber, 1, 'funnivoice')
				playedOnce = true
			end
	return Function_Continue;
end

function onGameOverConfirm(retry)
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESC') or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.BACKSPACE') then
		stopSound('funnivoice')
	end
end