function onCreate()
	-- Health Bar Flip
	setProperty('healthBar.angle', tonumber(-90)) 
	setProperty('healthBar.x', screenWidth - 400)
	setProperty('healthBar.y', 355)
	setProperty('healthBar.flipX', true)
end