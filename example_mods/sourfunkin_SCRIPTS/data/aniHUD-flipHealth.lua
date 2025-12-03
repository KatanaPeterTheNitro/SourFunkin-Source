--Script port Stick-EXT (el pendejo no sabe hacer codigos lua XD)

function onCreatePost()
setProperty('comboGroup.visible', false)
--setHealthBarColors('FF0000', '55FF00') --esto no funciona 
setProperty('healthBar.visible', false)
setProperty('scoreTxt.visible', false)

---Health
makeLuaSprite('hpOP', 'ui/healthBar/WHITEBAR', 0, 0);
addLuaSprite('hpOP', true)
setObjectCamera('hpOP', 'hud')
scaleObject('hpOP', 1, 1)
screenCenter('hpOP','x')

makeLuaSprite('hpBF', 'ui/healthBar/WHITEBAR', 0, 0);
addLuaSprite('hpBF', true)
setObjectCamera('hpBF', 'hud')
scaleObject('hpBF', 1, 1)
screenCenter('hpBF','x')
setProperty('hpBF.flipX', false)

makeLuaSprite('hpBG', 'ui/healthBar/HEALTHBAR', 0, 0);
addLuaSprite('hpBG', true)
setObjectCamera('hpBG', 'hud')
scaleObject('hpBG', 1, 1)
screenCenter('hpBG','x')

dadColor = getProperty("dad.healthColorArray")
father = rgbToHex(dadColor[1], dadColor[2], dadColor[3])

bfColor = getProperty("boyfriend.healthColorArray")
player = rgbToHex(bfColor[1], bfColor[2], bfColor[3])

setProperty('hpBF.color', getColorFromHex(player))
setProperty('hpOP.color', getColorFromHex(father))

if downscroll then
setProperty('hpOP.flipY',true)
setProperty('hpBF.flipY',true)
setProperty('hpBG.flipY',true)
 end
end

function onCountdownStarted()
    callMethod('noteGroup.remove', {instanceArg('notes'), true})
end

function onSpawnNote(_, _, _, s)
    if s then
        callMethod('noteGroup.insert', {0, instanceArg('notes.members[0]')})
    else
        callMethod('noteGroup.add', {instanceArg('notes.members[0]')})
    end
end

function onUpdatePost(e)
P1Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') *        getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)

P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)

setProperty('iconP1.x',P1Mult - 110)
setProperty('iconP1.origin.x',240)
setProperty('iconP1.flipX',true)
setProperty('iconP2.x',P2Mult + 110)
setProperty('iconP2.origin.x',-100)
setProperty('iconP2.flipX',true)

for i = 0, getProperty('grpNoteSplashes.length') - 1 do
setPropertyFromGroup('grpNoteSplashes', i, 'alpha', 0.9)
 end
end

function onUpdate(e)
setProperty('guitarHeroSustains', false)
setProperty('hpBG.y', getProperty('healthBar.y'))
if not downscroll then
setProperty('hpBF.y', getProperty('healthBar.y') + 5)
setProperty('hpOP.y', getProperty('healthBar.y') + 5)
else
setProperty('hpBF.y', getProperty('healthBar.y') + 10)
setProperty('hpOP.y', getProperty('healthBar.y') + 10)
end

healthBarOffset = 6
curHealth = (getProperty('health')/2)
setProperty('hpBF._frame.frame.width', math.lerp(getProperty('hpBF.graphic.width') - healthBarOffset, 0, 1 - curHealth))
end

function rgbToHex(r, g, b)
    --%02x: 0 means replace " "s with "0"s, 2 is width, x means hex
	return string.format("%02x%02x%02x", 
		math.floor(r),
		math.floor(g),
		math.floor(b))
end 

function mathlerp(from,to,i)
  return from+(to-from)*i
end

function math.lerp(a, b, t)
	return a + t * (b - a);
end