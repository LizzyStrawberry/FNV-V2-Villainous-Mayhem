function onCreate()
	if shadersEnabled then
		addVCREffect('game', 0.022, true, true, true)
		addVCREffect('hud', 0.047, true, true, false)
		addVCREffect('other', 0.022, true, false, false)
		addScanlineEffect('game', false)
		addScanlineEffect('hud', true)
		addBloomEffect('game', 0.55, 1.3)
		addBloomEffect('hud', 0.55, 1.3)
	end
end