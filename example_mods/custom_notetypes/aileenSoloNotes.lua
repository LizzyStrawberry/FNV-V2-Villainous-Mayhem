function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'aileenSoloNotes' then
			if not getPropertyFromClass('ClientPrefs', 'optimizationMode') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/AileenNOTE_assets');
			end
			
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
			end
		end
	end
end