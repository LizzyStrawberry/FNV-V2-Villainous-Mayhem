function onCreatePost()
    setProperty('healthBar.flipX', true)
    setProperty('iconP1.flipX', true)
    setProperty('iconP2.flipX', true)
end

function onUpdatePost()
	-- Note Flip
	if curBeat <= 190 then
		setPropertyFromGroup('playerStrums', 0, 'x', 92)
		setPropertyFromGroup('playerStrums', 1, 'x', 204)
		setPropertyFromGroup('playerStrums', 2, 'x', 316)
		setPropertyFromGroup('playerStrums', 3, 'x', 428)
	
		setPropertyFromGroup('opponentStrums', 0, 'x', 732)
		setPropertyFromGroup('opponentStrums', 1, 'x', 844)
		setPropertyFromGroup('opponentStrums', 2, 'x', 956)
		setPropertyFromGroup('opponentStrums', 3, 'x', 1068)
	
		-- HealthBar Flip
		x1 = getProperty('iconP1.x')
		x2 = getProperty('iconP2.x')
		setProperty('iconP1.x', x2)
		setProperty('iconP2.x', x1)
		setProperty('coloredPlayerCircle.x', x2- 45)
		setProperty('coloredOpponentCircle.x', x1- 45)
		setProperty('iconPlayer.x', x2- 45)
		setProperty('iconOpponent.x', x1- 45)
	end
	if curBeat > 190 then
		setPropertyFromGroup('opponentStrums', 0, 'x', 92)
		setPropertyFromGroup('opponentStrums', 1, 'x', 204)
		setPropertyFromGroup('opponentStrums', 2, 'x', 316)
		setPropertyFromGroup('opponentStrums', 3, 'x', 428)
	
		setPropertyFromGroup('playerStrums', 0, 'x', 732)
		setPropertyFromGroup('playerStrums', 1, 'x', 844)
		setPropertyFromGroup('playerStrums', 2, 'x', 956)
		setPropertyFromGroup('playerStrums', 3, 'x', 1068)
	
		setProperty('healthBar.flipX', false)
		setProperty('iconP1.flipX', false)
		setProperty('iconP2.flipX', false)
		setProperty('iconPlayer.x', x1- 45)
		setProperty('iconOpponent.x', x2- 45)
		setProperty('coloredOpponentCircle.x', x2- 45)
		setProperty('coloredPlayerCircle.x', x1- 45)
	end
end