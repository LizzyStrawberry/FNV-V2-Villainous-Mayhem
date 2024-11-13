function onCreate()
	if mechanics then		
		precacheSound('gunshot')
		precacheSound('gunjam')
		precacheSound('reload')
		precacheSound('CrystalAlarm')
		--Iterate over all notes
		for i = 0, getProperty('unspawnNotes.length')-1 do
			--Check if the note is a Bullet Note
			if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bullet Notes' then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/BULLET'); --Change texture
				if botPlay then
					setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
				else
					setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
				end
				setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true);
			end
		end
	end
end