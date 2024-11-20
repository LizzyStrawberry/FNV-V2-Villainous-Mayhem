function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'forceAileenNoteSkin' then
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/AileenNOTE_assets');
			
				if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
					setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/AileenNOTE_assets');
				end
			end
		end
	end
end