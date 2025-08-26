function onCreatePost()
    setProperty('healthBar.flipX', true)
    setProperty('iconP1.flipX', true)
    setProperty('iconP2.flipX', true)
    setProperty('iconGF.flipX', true)
end

function onUpdatePost()
	-- Note Flip
	setPropertyFromGroup('playerStrums', 0, 'x', 92)
	setPropertyFromGroup('playerStrums', 1, 'x', 204)
	setPropertyFromGroup('playerStrums', 2, 'x', 316)
	setPropertyFromGroup('playerStrums', 3, 'x', 428)
	
	setPropertyFromGroup('opponentStrums', 0, 'x', 732)
	setPropertyFromGroup('opponentStrums', 1, 'x', 844)
	setPropertyFromGroup('opponentStrums', 2, 'x', 956)
	setPropertyFromGroup('opponentStrums', 3, 'x', 1068)
end