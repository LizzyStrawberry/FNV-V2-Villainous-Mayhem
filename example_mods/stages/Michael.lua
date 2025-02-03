function onCreate()
	if not optimizationMode then
		setProperty('defaultCamZoom', 1.5)
	end
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
