function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'managerSoloNotes' then 
			if not getPropertyFromClass('ClientPrefs', 'optimizationMode') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/LilyNOTE_assets');
			end
			
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
			setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true)
			
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false)
			end
		end
	end
end
