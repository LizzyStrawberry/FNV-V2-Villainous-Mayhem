local options = {
    Particle = {
        imagePath = 'effects/particles',
        name = 'particles',
        startY = 1500,
        destinationY = -500,
        minimumX = -500,
        maximumX = 2500,
        speed = 4,
        overlapping = true,
        animated = false,
        commonity = 10,
        scaleX = 1.1,
        scaleY = 1.1,
        animationName = '',
        frameRate = 24
    },
    ParticleNum = 60,
    generateParticles = false
}

function onEvent(name)
	if shadersEnabled then
		if name == 'particles' then
			options.generateParticles = not options.generateParticles
		end
	end
end

function onUpdate()
	if curBeat == 64 or curBeat == 128 then
		options.generateParticles = true
	end
	if curBeat == 744 then
		options.generateParticles = false
	end
	if shadersEnabled then
		if options.generateParticles and getRandomInt(1, options.Particle.commonity) == 1 then
			options.ParticleNum = options.ParticleNum + 1
			(options.Particle.animated and makeAnimatedLuaSprite or makeLuaSprite)(options.Particle.name .. options.ParticleNum, options.Particle.imagePath, getRandomInt(options.Particle.minimumX, options.Particle.maximumX), options.Particle.startY)
			scaleObject(options.Particle.name .. options.ParticleNum, options.Particle.scaleX, options.Particle.scaleY)
			addLuaSprite(options.Particle.name .. options.ParticleNum, options.Particle.overlapping)
			doTweenY('particleweeee' .. options.ParticleNum, options.Particle.name .. options.ParticleNum, options.Particle.destinationY, options.Particle.speed, 'sineInOut')
			if options.Particle.animated then 
				addAnimationByPrefix(options.Particle.name .. options.ParticleNum, 'particleanim', options.Particle.animationName, options.Particle.frameRate, true)
			end
		end
	end
end