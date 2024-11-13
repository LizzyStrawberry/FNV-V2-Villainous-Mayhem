function onGameOverStart()
	if not isMayhemMode then
		setPropertyFromClass("openfl.Lib", "application.window.title", "An unexpected problem occured, and your game needs to restart. Please close the app now.");
	end
end