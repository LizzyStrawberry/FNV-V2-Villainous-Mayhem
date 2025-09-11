local alphaRemoval = {'healthBar', 'iconP1', 'iconP2'}
function onCreate()
	makeLuaSprite('blackBG', '', -300, -300)
	makeGraphic('blackBG', 2000, 2000, '000000')
	setScrollFactor('blackBG', 0, 0)
	setObjectCamera('blackBG', 'game')
	setProperty('blackBG.alpha', 1)
	addLuaSprite('blackBG', true)
	
	makeLuaSprite('WhiteBG', '', -300, -300)
	makeGraphic('WhiteBG', 2000, 2000, 'FFFFFF')
	setScrollFactor('WhiteBG', 0, 0)
	setObjectCamera('WhiteBG', 'game')
	setProperty('WhiteBG.alpha', 0)
	addLuaSprite('WhiteBG', false)
	
	setProperty('gf.x', getProperty('gf.x') - 550)
	setProperty('gf.y', getProperty('gf.y') + 250)
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if difficulty == 2 and getPropertyFromClass('ClientPrefs', 'buff3Active') == false then
		setProperty('health', 0)
	end
end

local flashStyle = {'boyfriend', 'dad', 'gf', 'trampoline'}
function onUpdate()
	if curBeat == 8 then
		doTweenAlpha('blackBGFadeOut', 'blackBG', 0, 4.5 / playbackRate, 'cubeInOut')
	end
	if curBeat == 16 then
		setProperty('defaultCamZoom', 0.9)
	end
	if curBeat == 255 then
		doTweenAlpha('BGMagic', 'WhiteBG', 1, 0.8 / playbackRate, 'cubeInOut')
		for i = 1, #(flashStyle) do
			doTweenColor('sillouetteColor'..i, flashStyle[i], '000000', 0.8 / playbackRate, 'cubeInOut')
		end
		for j = 1, #(alphaRemoval) do
			doTweenAlpha('hudAlpha'..j, alphaRemoval[j], 0, 0.8 / playbackRate, 'cubeInOut')
		end
	end
	if curBeat == 288 then
		doTweenAlpha('BGMagic', 'WhiteBG', 0, 0.8 / playbackRate, 'cubeOut')
		for i = 1, #(flashStyle) do
			doTweenColor('sillouetteColor'..i, flashStyle[i], 'FFFFFF', 0.8 / playbackRate, 'cubeOut')
		end
		for j = 1, #(alphaRemoval) do
			doTweenAlpha('hudAlpha'..j, alphaRemoval[j], 1, 0.8 / playbackRate, 'cubeInOut')
		end
	end
end