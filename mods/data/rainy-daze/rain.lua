-- yoooo
-- here comes the most epic particle script you have ever seen in your fucking life
-- yoooo
imgpath = 'effects/raindrop' -- path your image is in
name = 'rainDrop' -- put something here
spawnY = -1000 -- on what height particles have to spawn
destinantionY = 1300 -- where particles have to go
spawnX = -3000 -- from what width particles have to spawn
spawnX2 = 3000 -- on what width particles stop generating
speed = 0.7 -- time that particles reach their destination in
overlapping = true -- false for below characters, true for above characters
animated = false -- false for static particles, true for animated
commonity = 3 -- 1 - very common, 10 - less common
scaleX = 1 -- x scale of the particle
scaleY = 1 -- y scale of the particle
-- if animated: ( if not leave it be)
animname = '' -- animation name on the .xml file
fps = 24 -- fps the animation is played in

-- do not touch anything after this point
-- use event named "particles" to start generation











partnum = 150
generateParticles = true
partchance = 0

function onEvent(name)
	if name == 'particles' then
		if generateParticles == false then
			generateParticles = true
		end
		if generateParticles == true then
			generateParticles = false
		end
	end
end

function onUpdate()
	partchance = getRandomInt(1, commonity)
	if generateParticles == true then
		if partchance == 1 then
			particle()
		end
	end
end

function particle()
	if animated == false then
		partnum = partnum + 1
		makeLuaSprite(name .. partnum, imgpath, getRandomInt(spawnX, spawnX2), spawnY)
		scaleObject(name .. partnum, scaleX, scaleY)
		addLuaSprite(name .. partnum, overlapping)
		doTweenY('particleweeee' .. partnum,name .. partnum,destinantionY,speed,'circOut')
	end
	if animated == true then
		partnum = partnum + 1
		makeAnimatedLuaSprite(name .. partnum, imgpath, getRandomInt(spawnX, spawnX2), spawnY)
		addAnimationByPrefix(name .. partnum, 'particleanim', animname, fps, true)
		scaleObject(name .. partnum, scaleX, scaleY)
		addLuaSprite(name .. partnum, overlapping)
		doTweenY('particleweeee' .. partnum,name .. partnum,destinantionY,speed,'circOut')
	end
end