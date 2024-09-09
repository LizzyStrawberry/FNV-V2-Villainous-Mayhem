---@diagnostic disable: undefined-global
---@version 1.0.1.1 -- dunno what this is but its cool

-- TRAMPOLINE SCRIPT!!!
-- by aflac
--
-- WARNING:
-- offsets will  not  properly work
-- as of this version, if the character  changes position, it will  not look  good.
--
-- https://discord.gg/aflac

-- config

local jumpBind = "space"
local gravity = 32 -- gravity [default: 32]
local jumpheight = 1100
local neckbreak = 20 -- range from 180 degrees he can be from  breaking his neck, -1 if you want to disable it, default: 20

local DEBUG_MODE = false -- display information

local allowStylePoints = true -- disable if you don't want points  to be  awarded on things like flips
local safetyMode = true -- combo cant be lost on mustHitSections if true
local autoStart = true -- start jumping on song start, otherwise start after space was pressed

local trampolineOffsets = { 0, 0 } -- offsets of  the trampoline sprite
-- { 0, 0 }     default
-- { 25, 75 }   car bf fix

-- do not touch from beyond here LOSER

--  TODOs:
--  score for doing flips
--  ability to jump higher
--  lots of style point system shits
--  idk make it so you can do the hey pose mid  air for points sometimes
--  i  also wanna make it so the gravity  can  sync the jump with  beats but idk

local bouncing = false
local jumping = false
local y = 0
local tilt = 0
local isPixelStaaagge = false
local lastBounceAng = 0
local styleRot = 0 -- rotation used  to tracking flips for style points
-- vv ok i  lied  you can  touch this one vv --
local points = {
    --  cool tricks,  reccomended t o keep low because combos multiply it
    -- format  is { enabled, score, text }
    lost      = { nil,  nil, "Combo lost!"}; -- isn't  a trick youcan do  its just f or  text
    backflip  = { true, 90, "Backflip!" };
    frontflip = { true, 90, "Frontflip!" }; -- just for funsies
    peak      = { true, 200, "!!!" };       -- pressing space at the peak of the bounce, why not? couldn't t hink  of a text
    highJump  = { true, 100, "!!" }; -- performing a "Very High" jump (timing down key press on land landing from a "high")
}
local combo = 0
local tricksLastBounce = 0
local lastJumpHeight = 0 -- -1 = mini jump, 0 = normal jump, 1 = big  jump
local isHeFuckingDead = false -- well, is he?
local songStarted = false -- prevent style point bullshit

local pressedSpaceOnBounce = false -- don't fuck this up
function centerOffsets(sprite, AdjustPosition)
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    local offset = { x = 0, y = 0 }
    offset.x = (getProperty(sprite .. '.frameWidth') - getProperty(sprite .. '.width')) * 0.5
    offset.y = (getProperty(sprite .. '.frameHeight') - getProperty(sprite .. '.height')) * 0.5

    setProperty(sprite .. '.offset.x', offset.x)
    setProperty(sprite .. '.offset.y', offset.y)

    if AdjustPosition then
        setProperty(sprite .. '.x', getProperty(sprite .. '.x') + offset.x)
        setProperty(sprite .. '.y', getProperty(sprite .. '.y') + offset.y)
    end
end
end

function centerOrigin(sprite)
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    setProperty(sprite .. '.origin.x', getProperty(sprite .. '.frameWidth') * 0.5)
    setProperty(sprite .. '.origin.y', getProperty(sprite .. '.frameHeight') * 0.5)
end
end

local function Lerp(a,b,x)
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    return a + ((b - a) * x)
end
end

function onTimerCompleted(tag, loops, loopsLeft)
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    if tag == "combo_timer" then
        setProperty("combo_label.velocity.y",getProperty('combo_label.velocity.y') + 40)
        setProperty("combo_counter.velocity.y",getProperty('combo_counter.velocity.y') + 40)
    end
    if tag == "combo_timer_fade" then
        doTweenAlpha("combo_timer_fade_label","combo_label",0,1,'quadIn')
        doTweenAlpha("combo_timer_fade_counter","combo_counter",0,1,'quadIn')
    end
end
end

local function centerSprite(sprite, center, axis)
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    -- this function was written for thjis script, its very basic
    -- does not support  xy, it uses x  or y individually
    -- checks the actual properties

    local length = "width"
    if axis == "y" then
        length = "height"
    end

    setProperty(sprite .. "." .. axis,
        getProperty(center .. "." .. axis) + (getProperty(center .. "." .. length) / 2) -
        (getProperty(sprite .. "." .. length) / 2))
end
end

local function spawnComboThingy(thingy,points)
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
        cancelTimer("combo_timer")
        cancelTimer("combo_timer_fade")
        cancelTween("combo_timer_fade_label")
        cancelTween("combo_timer_fade_counter")

        setProperty('combo_label.x',screenWidth - screenWidth/2.5)
        setProperty('combo_counter.x',screenWidth - screenWidth/3)

        setProperty("combo_label.y",screenHeight/3)
        setProperty("combo_counter.y",screenHeight/3+ 38)

        setProperty('combo_label.alpha',1)
        setProperty('combo_counter.alpha',1)

        setTextString("combo_label",thingy)
        if points == 0  then
            points = ""
        else
            points = "(+"..points..")"
        end
        setTextString("combo_counter","x"..combo.." "..points)

        setProperty('combo_label.height',40)

        if not isPixelStaaagge then  -- make sure  it  isnt pixel stage because imo it looks bad with pixel font
            setTextSize("combo_label",40)
        setTextSize("combo_counter",25)
        end
        

        setProperty('combo_label.velocity.y',-100)
        setProperty('combo_counter.velocity.y',-100)

        runTimer('combo_timer',0.02,50)
        runTimer('combo_timer_fade',1)
end
end

function onCreatePost()
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    ---luaDebugMode = true
    
    addHaxeLibrary('PlayState')

    if getPropertyFromClass('PlayState', 'isPixelStage') then
        isPixelStaaagge = true
    end
    math.randomseed(os.time())


    setProperty('botplayTxt.text', "Bing Boing Bing Trampoline go brRRRRR")
    setProperty('boyfriend.y', getProperty('boyfriend.y') - 90)
    makeLuaSprite("trampoline", "trampoline",
        getProperty('boyfriend.x') + (getProperty('boyfriend.width') / 2) + trampolineOffsets[1],
        getProperty('boyfriend.y') + trampolineOffsets[2])
    if isPixelStaaagge then
        makeLuaSprite("trampoline", "pixel-trampoline",
            getProperty('boyfriend.x') + (getProperty('boyfriend.width') / 2) + trampolineOffsets[1],
            getProperty('boyfriend.y') + trampolineOffsets[2])
        scaleObject('trampoline', 6, 6)
        updateHitbox('trampoline')
    end

    makeLuaText("combo_label","Backflip!",400,0,0)
    addLuaText('combo_label')
    setObjectCamera("combo_label",'camHUD')
    setTextSize("combo_label",35)

    makeLuaText("combo_counter","x10",200,0,38)
    addLuaText('combo_counter')
    setObjectCamera("combo_counter",'camHUD')
    setTextSize("combo_counter",20)

    setProperty('combo_label.alpha',0)
    setProperty('combo_counter.alpha',0)

    setTextAlignment("combo_counter","left")

    addLuaSprite('trampoline', false)
    updateHitbox('trampoline')

    if isPixelStaaagge then
        setTextFont("combo_counter","pixel.otf")
        setTextFont("combo_label","pixel.otf")
    end

    centerSprite("trampoline", "boyfriend", "x")



    if isPixelStaaagge then
        setProperty('trampoline.x', getProperty('trampoline.x') - (getProperty('trampoline.width') / 2.5)) -- weird  bug
        setProperty('trampoline.antialiasing', false)
        setProperty('trampoline.y',
            getProperty('boyfriend.y') + (getProperty('boyfriend.height') / 1.75) -
            (getProperty('trampoline.height') / 2))
    else
        setProperty('trampoline.y',
            getProperty('boyfriend.y') + getProperty('boyfriend.height') - (getProperty('trampoline.height') / 2))
    end

    setProperty('trampoline.x', getProperty('trampoline.x') + trampolineOffsets[1])
    setProperty('trampoline.y', getProperty('trampoline.y') + trampolineOffsets[2])

    makeLuaText("debugTxt", "debug text  goes here", screenWidth / 3, 10, screenHeight / 3)
    setTextAlignment("debugTxt", "left")
    setObjectCamera('debugTxt', 'camOther')

    --setProperty('gf.visible', false) -- she gets in the way of  bfs epic trampolining  skills
    -- NEVERMIND  SHE IS  VERY GOOD  AT NOT GETTING IN HIS WAY  WHILE TRAMPOLINING!!!!!!
    --setProperty('botplayTxt.visible', true)
    setObjectOrder("trampoline", getObjectOrder('boyfriendGroup') - 1)

    if DEBUG_MODE then
        addLuaText("debugTxt")
    end

    if songName == "Senpai" then --  LORE
        if not jumping then
            y = getProperty('boyfriend.y') -- get the start point
            jumping = true
            bouncing = true
            setProperty('boyfriend.velocity.y', -jumpheight * 0.5) --  initial  jump is smaller  for  effect
        end
    end
end
end

-- makes sure bf  fdidnt break  his neck  in  a jump
-- if  he did  ooff ouchie ouuwwwww  my  neckk  aououuoutuutuuuuu it hurty!!
local function checkIfBrokeNeck()
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    local angle = getProperty('boyfriend.angle') % 360

    if not (safetyMode and mustHitSection) then
        if tricksLastBounce == 0 then
            if not (combo == 0) then
                combo = 0
            spawnComboThingy(points.lost[3],0)
            else
                combo = 0
            end
        end
    end
    tricksLastBounce = 0

    lastBounceAng = angle
    styleRot = 0 -- because style is only gained during air time


    if neckbreak > -1 then -- make suyre breaking your neck  isnt disabled
        if angle < 180 + neckbreak and angle > 180 - neckbreak then
            if lastJumpHeight > -1 then -- smaller jumps wont kill you
                bouncing = false
                jumping = false
                setProperty('boyfriend.velocity.y', 0)
                setProperty('health', 0)
                isHeFuckingDead = true
            else if lastJumpHeight == -1 then
                    setProperty('health', getProperty("health") - 0.25)
                else
                    setProperty('health', getProperty("health") - 0.05)
                end
            end
        end
    end
end
end

function onSongStart()
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    --debugPrint(getProperty('isPixelStage'))
    songStarted = true -- HI
    if autoStart then
        if not jumping then
            y = getProperty('boyfriend.y') -- get the start point
            jumping = true
            bouncing = true
            setProperty('boyfriend.velocity.y', -jumpheight * 0.5) --  initial  jump is smaller  for  effect
        end
    end
end
end

function onUpdate(elapsed)
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    -- elapsed gets used a lot here to make sure that if a mod
    -- has a faster update speed or smth or the player has a
    -- shitty pc, the trampoline will still behave corrcetly
    -- and not lag behind or be super slow. haven't tested it
    -- but this computer im using is 7 years oldS

    --runHaxeCode([[boyfriend.centerOrigins();]]) -- does not work, reminder to try to fix
    -- FUCK Y OU I  FIXED  IT!!! (kinda)
    centerOrigin("boyfriend")

    --setProperty("combo_label.height",Lerp(getProperty('combo_label.height'),35,0.2)  * elapsed)
setTextSize("combo_label",Lerp(getTextSize("combo_label"),35,0.2 * (elapsed * 0.2)))
setTextSize("combo_counter",Lerp(getTextSize("combo_counter"),20,0.2 * (elapsed * 0.2)))
    --setProperty('combo_label.y',getProperty('combo_label.y') + getProperty('combo_label.velocity.y')  * elapsed)
    --setProperty('combo_counter.y',getProperty('combo_counter.y') + getProperty('combo_counter.velocity.y')  * elapsed)
setProperty('trampoline.alpha', getProperty('boyfriend.alpha'))
setProperty('trampoline.visible', getProperty('boyfriend.visible'))
    if not jumping then
        if keyPressed(jumpBind) then
            y = getProperty('boyfriend.y') -- get the start point
            setProperty('boyfriend.velocity.y', -jumpheight * 0.5)
            jumping = true
            bouncing = true

        end
    else
        -- for  if jumping, handle the jump height n shits
        if keyJustPressed("space") then
            if not pressedSpaceOnBounce then
                if points.peak[1] then
                    if getProperty('boyfriend.velocity.y') > -300 and getProperty('boyfriend.velocity.y') < 300 then
                        triggerEvent("Hey!", "", "")
                        addScore(points.peak[2])
                        combo =  combo + 1
                        tricksLastBounce  = tricksLastBounce + 1 -- SAFE
                        spawnComboThingy(points.peak[3],points.peak[2])
                        
                    end
                end
            end
            pressedSpaceOnBounce = true
        end

        if getProperty('boyfriend.y') >= y then
            checkIfBrokeNeck()
            if bouncing then
                setProperty('boyfriend.y', y)
                jumping = true
                pressedSpaceOnBounce = false -- a new bounce
                local lastlastjumpheight = lastJumpHeight

                lastJumpHeight = 0
                if lastlastjumpheight == 2 then
                    lastJumpHeight = 1
                end

                local additional = 0
                if keyPressed("up") then
                    additional = jumpheight * 0.25
                    lastJumpHeight = 1


                end
                if keyPressed("down") then
                    if lastlastjumpheight == 1 then
                        additional = jumpheight * 0.5
                        lastJumpHeight = 2
                        lastlastjumpheight = 2 -- prevent conflict
                        if points.highJump[1] then
                            addScore(points.highJump[2])
                            -- spawnComboThingy(points.highJump[3])
                            --combo =  combo + 1 -- should not  count towards combo
                        end
                    elseif lastlastjumpheight == -1 or lastlastjumpheight == -2 then
                        additional = jumpheight * -0.2
                        lastJumpHeight = -2
                    else


                        additional = jumpheight * -0.05
                        lastJumpHeight = -1
                    end

                end

                if lastlastjumpheight == 1 then
                    additional = jumpheight * 0.25
                end

                playSound('boing')
                setProperty('boyfriend.velocity.y', -jumpheight + math.random(-50, 50) - additional)
            end
        else
            -- setProperty("boyfriend.velocity.x",getProperty('boyfriend.velocity.x')+50) -- https://twitter.com/aflaccck/status/1595932461082763264
            if keyPressed('left') then
                tilt = tilt - 0.5
            end
            if keyPressed('right') then
                tilt = tilt + 0.5
            end

            local additional = 0

            if keyPressed("down") then
                additional = 30
            end
            setProperty('boyfriend.velocity.y',
                getProperty('boyfriend.velocity.y') + (gravity + additional) * (elapsed * 40))
        end

    end

    -- flips system
    if allowStylePoints and songStarted then  -- disregard everything i said
        if styleRot >= 360 and points.backflip[1] then
            -- FUCCIN BACKFLIP
            combo            = combo + 1
            tricksLastBounce = tricksLastBounce + 1
            styleRot         = styleRot - 360
            addScore(points.backflip[2] * (combo * 1.1))
            triggerEvent("Hey!", "", "")
            spawnComboThingy(points.backflip[3],points.backflip[2] * (combo * 1.1))
        end
        if styleRot <= -360 and points.frontflip[1] then
            -- FUCCIN FRONTFLIP
            combo            = combo + 1
            styleRot         = styleRot + 360
            tricksLastBounce = tricksLastBounce + 1
            addScore(points.frontflip[2] * (combo * 1.1))
            triggerEvent("Hey!", "", "")
            spawnComboThingy(points.frontflip[3],points.frontflip[2] * (combo * 1.1))
        end
    end

    setProperty('boyfriend.angle', getProperty('boyfriend.angle') + tilt * (elapsed * 40))
    styleRot = styleRot + tilt * (elapsed * 40)

    tilt = tilt * 0.95

    local temptilt = math.abs(getProperty('boyfriend.angle')) % 360
    if getProperty('boyfriend.angle') < 0 then
        setProperty('boyfriend.angle', temptilt * -1)
    else
        setProperty('boyfriend.angle', temptilt)
    end

    if DEBUG_MODE then

        local SILLIES = "Normal"

        if lastJumpHeight == -2 then
            SILLIES = "Very low"
        elseif lastJumpHeight == -1 then
            SILLIES = "Low"
        elseif lastJumpHeight == 1 then
            SILLIES = "High"
        elseif lastJumpHeight == 2 then
            SILLIES = "Very high"
        end

        local join = "angle: " ..
            getProperty('boyfriend.angle') ..
            "\nlastBounceAng: " ..
            lastBounceAng ..
            "\nstyleRot: " ..
            styleRot ..
            "\ncombo: " ..
            combo .. "\nlastJumpHeight: " .. SILLIES .. "\nboyfriend.velocity.y: " .. getProperty('boyfriend.velocity.y')
        setTextString("debugTxt", join)
    end

end
end

function onUpdatePost()
if not isStoryMode and getPropertyFromClass('ClientPrefs', 'trampolineMode') == true then
    if isHeFuckingDead then
        setProperty('health', 0)
        -- NEVER ESCAPE.
    end
end
end

--[[
????????????YPP5YYY??JJJJJJJJJJY555YYYYYJYYY5YJ7!!7JYYJJJJ???JJJJJJJJ?777?J
????????????YPP5Y5YYYYY5YJ?7!!~~~~~~~~~~~~~~~77??JYYYYYJJ?777?JJJJJJ??7777?
????????????YPPPPPJ7!~~^::.::...................:^~!?JJJJJJ?7!7?JYJ?777!7??
????????????YPP?^^::::........:::.................:...::^!5PP5YJJJYJ?7!!77J
??????JJJYY5PG5^..:::::::::::::::::::.:::::..............:^7P#G5YJJ??JYY555
YYYYYYYYY5GB5!~::::::::::::..:::::........................:^!JGB5??JJJ?????
?77777777?5BY^:::....::::..................................::!G#5777777!!7?
777??????JP#5~:::........:::::::::::::::::::::.::::::::....:^?B#P????JJJJJJ
?????????JP#5~^::.:..:~?5GBY!::::::::::::::::^~?PBG57:..:..:~?B&PJJJJJJJJJJ
?????JJJJJG&P!~^:::::~J#&&&P!::::::::::::::.^Y#@@@@B?^::::~!7YB&PJ?JJJJJJJJ
JJJJJJJJJYG&&BG5J?~:^~7JYYY?~^::::::........^?Y5YYJ7!~~!?Y5GB#&&PJ?JJJJJJJJ
JJJJJY5555JJ???77!~:::...::::::::::::::...............:^!77777?J?JJJJJJJJJJ
JJJJJ5#B?::::::::::::::::::::::^^:::::::::::::::................^5BPYJJJJJJ
JJJJJ5#B!..::::::::::::::::::::^!7~:...:~!^:::::................^5#G5JJJJJJ
JJJJJY#B!..::::::::::::::::::::^YGG5YYY5GP7^::::::..............^5&GYJJJJJJ
JJJJJY5P5Y?~^::..::::::::::^~7J5PPPPPPGP5555?^:::.........:::^~~!YP5YJJJJJJ
JJJJJJJJY5PGPP5?!!!!!!!!!!!JG#BGPYJJJYYJJJ5##P?!~~!!!!~~~!?Y5PPP5J?JJJJJJJJ
JJJJJJJJJJJJJJYPGGGGGGGBB##BGP55PPPPPPPPP555PBB###BGGPPPPPPPYJJJJJJJJJJJJJJ
JJJJJJJJJJJJJJJJJJJJJJ5BBG5J????JYY5PP5YYJJ???YPB#BG5JJJJJJJJJJJJJJJJJJJJJJ
JJJJJJJJJJJJJJJJJJJY5PB#B5J??JJJYY5PGGG5YJJJ??JY5GBBG5JJJJJJJJJJJJJJJJJJJJJ
JJJJJJJJJJJJJJJJJJJYPB##P???JJJJJYYPBGPYJ???????J5B##5JJ???JJJJJJJJJJJJJJJJ
JJJJJJJJJJJJJJY5PPPGB###G5YJ?????JJY55J??????JYPPG#&#GPP555YJ????JJJJJJJJJJ
JJJJJJY5PPGGGP5JJJJJJJJJJJJYPPYJJJJ5BG5J??J5P55YJJJJJJJJJJJ5PPPPP5JJ??JJJJJ
JJJJ?JJ?7!777!~:.:::::.....^!?YPGB####BBGG5J7~^^::.........:~7!!7?Y555YJJJJ
JYPG5~...:^~~::^^^^::::::::::^~!7JP####BY7!~^::::::::::::::::......:~JBGYJJ
??J55?!!7JY5YYJJJJJJJJJJJJJJJJYYYY5PPPPPYJYYJJJJJJJJJJJJJJ???77!~~^^~?PPJ?J
]]
