function onCreatePost()
	if getPropertyFromClass("ClientPrefs", "noteTailLayer") == "Behind" then
		setObjectOrder('notes', getObjectOrder('timeTxt'))--Change all notes behind the strumline layer (timeTxt does the trick)
	end
end

function onSpawnNote(id, direction, noteType, isSustainNote)
	if getPropertyFromClass("ClientPrefs", "noteTailLayer") == "Behind" then
		if not isSustainNote then
			setObjectOrder('notes.members['..id..']', getObjectOrder('healthBarBG') - 1)
			setObjectCamera('notes.members['..id..']', 'hud')
		end
	end
end