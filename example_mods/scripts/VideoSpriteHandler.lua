--[[
    Made By BBPanzu
    Improved By Cherry
    Fixed By Laztrix

    How To Use:
        Put this script in scripts folder
        if you want to use it on a certain script do this
            callScript('scripts/VideoSpriteHandler', 'makeVideoSprite', {'videotag', 'videoname', X, Y, 'camera', hasVolume})
       
        for the camera you can put
            -camHUD
            -camGame
            -camOther
        for hasVolume you can set it to true or false
        
    this have unfunny callback you can use when the video are finished by the tag.
    example:

        function onVideoFinished(name)
            if name == 'videotag' then
                --code here lma
            end
        end
]]--

local videoCache = {}
--[[
    put your videoname here to cache it
    example: {'videoname','videoname2'}
    or leave it like that if you do not want to cache it.

    do note!
        IF YOU DONT CACHE THE VIDEO YOU WILL RECEIVE A MASSIVE LAG SPIKE FOR A MOMENT
                ]]

-- [[the stuff ]] --
function onCreate()
	if not optimizationMode then
		if songName == "Get Villain'd (Old)" then
			videoCache = {'morky farded'}
		elseif songName == "Get Villain'd" then
			videoCache = {'theBilly', 'flames'}
		elseif songName == "Shucks V2" then
			videoCache = {'Shucks Cutscene'}
		end
		
		addHaxeLibrary('VideoHandler', 'hxcodec')
		addHaxeLibrary('Event', 'openfl.events')
		cacheFuck()
	end
end

local videoSprites = {}
function makeVideoSprite(tag, videoPath, x, y, camera, hasVolume)
	if not optimizationMode then
		runHaxeCode([[
			]]..tag..[[ = new VideoHandler();
			]]..tag..[[.playVideo(Paths.video("]]..videoPath..[["));
			]]..tag..[[.visible = false;
			]]..tag..[[.rate = ]]..playbackRate..[[;
			]]..tag..[[.volume = ]]..(hasVolume and 1 or 0)..[[;
			setVar("]]..tag..[[hasVolume", ]]..(hasVolume and 1 or 0)..[[);

			]]..tag..[[.finishCallback = function()
			{ 
				game.remove(game.getLuaObject("]]..tag..[[")); 
				game.callOnLuas("onVideoFinished",["]]..tag..[["]);
				return;
			}
			FlxG.stage.removeEventListener("enterFrame", ]]..tag..[[.update);
		]])
		makeLuaSprite(tag, nil, x, y)
		setObjectCamera(tag, camera)
		addLuaSprite(tag, false)
		table.insert(videoSprites, tag)
	end
end
---// i dont know the other way to cache this :sob: \\ --
function cacheFuck()
    if #videoCache == 0 then

    else
        for i = 1,#videoCache do
            local tag = videoCache[i]..'c'
            runHaxeCode([[
            ]]..tag..[[ = new VideoHandler();
            ]]..tag..[[.playVideo(Paths.video("]]..videoCache[i]..[["));
            ]]..tag..[[.onVLCEndReached();
            ]])
        end
        --debugPrint('bro the video has been cached!')
    end
end
function onUpdatePost()
	if not optimizationMode then
		for _, __ in pairs(videoSprites) do
			runHaxeCode([[
				if (game.getLuaObject("]]..__..[[") != null)
				{
					game.getLuaObject("]]..__..[[").loadGraphic(]]..__..[[.bitmapData);
					if (getVar("]]..__..[[hasVolume"))
						]]..__..[[.volume = 1;
				}
			]])
		end
	end
end
function onPause()
	if not optimizationMode then
		for _, __ in pairs(videoSprites) do
			runHaxeCode([[
				]]..__..[[.pause();
			]])
		end
	end
end
function onResume()
	if not optimizationMode then
		for _, __ in pairs(videoSprites) do
			runHaxeCode([[
				]]..__..[[.resume();
			]])
		end
	end
end