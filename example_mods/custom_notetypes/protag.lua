function onCreate()

	for i = 0, getProperty('unspawnNotes.length')-1 do

		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'protag' then 
			if getPropertyFromClass('ClientPrefs', 'optimizationMode') == false then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/LilyNOTE_assets');
			end
			setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then

				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end
