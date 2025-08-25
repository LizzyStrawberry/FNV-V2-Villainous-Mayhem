function onCreatePost()
    setProperty('healthBar.flipX', true)
    setProperty('iconP1.flipX', true)
    setProperty('iconP2.flipX', true)
end

function onUpdatePost()
	-- Note Flip
	if curBeat <= 190 then
		-- HealthBar Flip
		x1 = getProperty('iconP1.x')
		x2 = getProperty('iconP2.x')
		setProperty('iconP1.x', x2)
		setProperty('iconP2.x', x1)
		setProperty('coloredPlayerCircle.x', x2)
		setProperty('coloredOpponentCircle.x', x1)
		setProperty('iconPlayer.x', x2)
		setProperty('iconOpponent.x', x1)
	end
	if curBeat > 190 then
		setProperty('healthBar.flipX', false)
		setProperty('iconP1.flipX', false)
		setProperty('iconP2.flipX', false)
		setProperty('iconPlayer.x', x1)
		setProperty('iconOpponent.x', x2)
		setProperty('coloredOpponentCircle.x', x2)
		setProperty('coloredPlayerCircle.x', x1)
	end
end