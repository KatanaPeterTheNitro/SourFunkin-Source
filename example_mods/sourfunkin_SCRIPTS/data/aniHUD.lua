--Script port Stick-EXT (el pendejo no sabe hacer codigos lua XD)
local Score = getProperty('songScore')
local ScoreD = getProperty('songScore')
local maxCombo = getProperty('combo')
local posBlot = 480
--
--Note Combo Code by stilic
local lastMustHit = false
local noteHits = 0
local seperatedHits = ''

function onCreatePost()
setProperty('comboGroup.visible', false)
--setHealthBarColors('FF0000', '55FF00') --esto no funciona 
setProperty('healthBar.visible', false)
setProperty('scoreTxt.visible', false)

--countdown
makeAnimatedLuaSprite('cd', 'ui/countdown/COUNTDOWN', 100, 0)
addLuaSprite('cd', true)
addAnimationByPrefix('cd', '3', 'count3', 24, false)
addAnimationByPrefix('cd', '2', 'count2', 24, false)
addAnimationByPrefix('cd', '1', 'count1', 24, false)
addAnimationByPrefix('cd', 'go', 'countgo', 24, false)
scaleObject('cd', 0.6, 0.6)
setObjectCamera('cd', 'other')
setProperty('cd.visible', false)
screenCenter('cd','y')
--

--Combo
makeAnimatedLuaSprite('blot', 'ui/ratings/GAMEPLAY_UI_ASSETS', 680, 520)
addLuaSprite('blot', true)
addAnimationByPrefix('blot', '2', 'blot 2', 24, false)
addAnimationByPrefix('blot', '1', 'blot0', 24, false)
scaleObject('blot', 0.8, 0.8)
setProperty('blot.alpha', 0)

makeAnimatedLuaSprite('rating', 'ui/ratings/GAMEPLAY_UI_ASSETS', 1080, 520)
addLuaSprite('rating', true)
addAnimationByPrefix('rating', 'good', 'good', 24, false)
addAnimationByPrefix('rating', 'bad', 'bad', 24, false)
addAnimationByPrefix('rating', 'shit', 'shit', 24, false)
addAnimationByPrefix('rating', 'sick', 'sick', 24, false)
scaleObject('rating', 0.6, 0.6)

makeAnimatedLuaSprite('combo', 'ui/ratings/GAMEPLAY_UI_ASSETS', 1080, 520)
addLuaSprite('combo', true)
addAnimationByPrefix('combo', 'combo', 'combo', 24, false)
scaleObject('combo', 0.6, 0.6)
setProperty('combo.visible', false)

for i = 1, 3 do
local max = 'Maxcom' .. i
makeAnimatedLuaSprite(max, 'ui/ratings/GAMEPLAY_UI_ASSETS', 990 + i *
32, 660 - i * 8)
scaleObject(max, 0.7, 0.7)
for m = 0, 9 do
addAnimationByPrefix(max, m .. 'numComb', m .. ' num', 24, false)
end
setProperty(max .. '.visible', false)
setProperty(max .. '.active', false)
setProperty(max .. '.alpha', 0)
addLuaSprite(max, true)
    end

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
setProperty('hpBF.flipX', true)

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
--
---Score
if not downscroll then
makeAnimatedLuaSprite('textScore', 'ui/ratings/GAMEPLAY_UI_ASSETS', 1080, 520)
addLuaSprite('textScore', true)
addAnimationByPrefix('textScore', 'i', 'score', 1, true)
setObjectCamera('textScore', 'hud') 
scaleObject('textScore', 0.6, 0.6)

for i = 1, 7 do
local Score = 'ScoreNum' .. i
makeAnimatedLuaSprite(Score, 'ui/ratings/GAMEPLAY_UI_ASSETS', 990 + i *
32, 660 - i * 8)
setObjectCamera(Score, 'hud')
scaleObject(Score, 0.8, 0.8)
for m = 0, 9 do
addAnimationByPrefix(Score, m .. 'num', m .. ' num', 24, false)
end
setProperty(Score .. '.visible', false)
setProperty(Score .. '.active', false)
addLuaSprite(Score, true)
    end
else 
makeAnimatedLuaSprite('textScore', 'ui/ratings/GAMEPLAY_UI_ASSETS', 1080, 100)
addLuaSprite('textScore', true)
addAnimationByPrefix('textScore', 'i', 'downscroll score', 1, true)
setObjectCamera('textScore', 'hud') 
scaleObject('textScore', 0.6, 0.6)

for i = 1, 7 do
local ScoreD = 'ScoreNumD' .. i
makeAnimatedLuaSprite(ScoreD, 'ui/ratings/GAMEPLAY_UI_ASSETS', 990 + i *
34, 10 - i * -5)
setObjectCamera(ScoreD, 'hud')
scaleObject(ScoreD, 0.8, 0.8)
for m = 0, 9 do
addAnimationByPrefix(ScoreD, m .. 'num', m .. ' d num', 24, false)
end
setProperty(ScoreD .. '.visible', false)
setProperty(ScoreD .. '.active', false)
addLuaSprite(ScoreD, true)
 end
end
--Note Combo
lastMustHit = mustHitSection
precacheSound('noteComboSound')

local x = defaultBoyfriendX / 10 + getProperty('boyfriend.x') / 4
local y = defaultBoyfriendY / 10 + getProperty('boyfriend.y') / 6 + 300
 if getPropertyFromClass('PlayState', 'isPixelStage') or
    getProperty('camGame.zoom') > 1 then
    x = x - 180
    y = y / 1.3
 end
 makeAnimatedLuaSprite('noteCombo', 'ui/combo/amt/noteCombo', x, y)
 setScrollFactor('noteCombo', 0.5, 0.5)
 addAnimationByPrefix('noteCombo', 'appear', 'NOTE COMBO animation', 24, false)
 setProperty('noteCombo.visible', false)
 setProperty('noteCombo.active', false)
 setProperty('noteCombo.antialiasing',
                getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
 addLuaSprite('noteCombo', true)

 --this is repeated like 4 times in the code lmao
   for i = 1, 3 do
   local tag = 'noteComboN' .. i
   makeAnimatedLuaSprite(tag, 'ui/combo/amt/noteComboNumbers', x - 30 + i * 100, y - 0 - i * 50)
   setScrollFactor(tag, 0.5, 0.5)
   scaleObject(tag, 0.99, 0.99)
  for m = 0, 9 do
    addAnimationByPrefix(tag, m .. 'a', m .. ' light', 24, false)
  end
    setProperty(tag .. '.visible', falde)
    setProperty(tag .. '.active', false)
    addLuaSprite(tag, true)
end
--

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

setProperty('rating.y', getProperty('blot.y') + 85)
setProperty('rating.x', getProperty('blot.x') - 5)
setProperty('combo.y', getProperty('blot.y') + 175)
setProperty('combo.x', getProperty('blot.x') - 35)

setProperty('rating.alpha', getProperty('blot.alpha'))
setProperty('combo.alpha', getProperty('blot.alpha'))

healthBarOffset = 6
curHealth = (getProperty('health')/2)
setProperty('hpBF._frame.frame.width', math.lerp(getProperty('hpBF.graphic.width') - healthBarOffset, 0, 1 - curHealth))

-----Score
seperatedHits = ''
local Score = getProperty('songScore')
for i = 1, 7 do
local score = string.sub(Score, i, i)
if score ~= '' then
seperatedHits = seperatedHits .. Score
else
seperatedHits = ' ' .. seperatedHits
end
end
for i = 1, 7 do
local Score = 'ScoreNum' .. i
local score = string.sub(seperatedHits, i, i)
if score ~= '' and score ~= ' ' then
objectPlayAnimation(Score, score .. 'num')
setProperty(Score .. '.visible', true)
setProperty(Score .. '.active', true)
end
for i = 1, 6 do
local Score = 'ScoreNum' .. i
scaleObject(Score, 0.75, 0.75)
end
for i = 1, 5 do
local Score = 'ScoreNum' .. i
scaleObject(Score, 0.7, 0.7)
end
for i = 1, 4 do
local Score = 'ScoreNum' .. i
scaleObject(Score, 0.65, 0.65)
end
for i = 1, 3 do
local Score = 'ScoreNum' .. i
scaleObject(Score, 0.6, 0.6)
end
for i = 1, 2 do
local Score = 'ScoreNum' .. i
scaleObject(Score, 0.55, 0.55)
end
for i = 1, 1 do
local Score = 'ScoreNum' .. i
scaleObject(Score, 0.5, 0.5)
end
end
--
-----Score Downscroll
seperatedHits = ''
local ScoreD = getProperty('songScore')
for i = 1, 7 do
local scoreD = string.sub(ScoreD, i, i)
if scoreD ~= '' then
seperatedHits = seperatedHits .. ScoreD
else
seperatedHits = ' ' .. seperatedHits
end
end
for i = 1, 7 do
local ScoreD = 'ScoreNumD' .. i
local scoreD = string.sub(seperatedHits, i, i)
if scoreD ~= '' and scoreD ~= ' ' then
objectPlayAnimation(ScoreD, scoreD .. 'num')
setProperty(ScoreD .. '.visible', true)
setProperty(ScoreD .. '.active', true)
end
for i = 1, 6 do
local ScoreD = 'ScoreNumD' .. i
scaleObject(ScoreD, 0.75, 0.75)
end
for i = 1, 5 do
local ScoreD = 'ScoreNumD' .. i
scaleObject(ScoreD, 0.7, 0.7)
end
for i = 1, 4 do
local ScoreD = 'ScoreNumD' .. i
scaleObject(ScoreD, 0.65, 0.65)
end
for i = 1, 3 do
local ScoreD = 'ScoreNumD' .. i
scaleObject(ScoreD, 0.6, 0.6)
end
for i = 1, 2 do
local ScoreD = 'ScoreNumD' .. i
scaleObject(ScoreD, 0.55, 0.55)
end
for i = 1, 1 do
local ScoreD = 'ScoreNumD' .. i
scaleObject(ScoreD, 0.5, 0.5)
end
end
--
--MaxCombo
seperatedHits = ''
local maxCombo = getProperty('combo')
for i = 1, 3 do
local nigno1 = string.sub(maxCombo, i, i)
if nigno1 ~= '' then
seperatedHits = seperatedHits .. nigno1
else
seperatedHits = ' ' .. seperatedHits
end
end
for i = 1, 3 do
local max = 'Maxcom' .. i
local ningo1 = string.sub(seperatedHits, i, i)
if ningo1 ~= '' and ningo1 ~= ' ' then
objectPlayAnimation(max, ningo1 .. 'numComb')

setProperty(max..'.x',getProperty('blot.x') + 225)
setProperty(max..'.y', getProperty('blot.y') + 170)
setProperty(max .. '.visible', true)
setProperty(max .. '.active', true)
end
for i = 1, 2 do
local max = 'Maxcom' .. i
scaleObject(max, 0.6, 0.6)
setProperty(max..'.x',getProperty('blot.x') + 195)
setProperty(max..'.y', getProperty('blot.y') + 190)
end
for i = 1, 1 do
local max = 'Maxcom' .. i
setProperty(max..'.x',getProperty('blot.x') + 165)
setProperty(max..'.y', getProperty('blot.y') + 205)
scaleObject(max, 0.55, 0.55)
end
end 
--
---Note Combo
if lastMustHit ~= mustHitSection then
        lastMustHit = mustHitSection
        if not lastMustHit and noteHits > 12 and
            (curBeat % 4 == 0 or curBeat % 6 == 0) then
            playSound('noteComboSound')

            setProperty('noteCombo.visible', true)
            setProperty('noteCombo.active', true)
            animBullshit('appear', true)
            objectPlayAnimation('noteCombo', 'appear')

            seperatedHits = ''
            local wtf = tostring(noteHits)
            for i = 1, 3 do
                local num = string.sub(wtf, i, i)
                if num ~= '' then
                    seperatedHits = seperatedHits .. num
                else
                    seperatedHits = ' ' .. seperatedHits
                end
            end

            for i = 1, 3 do
                local tag = 'noteComboN' .. i
                local num = string.sub(seperatedHits, i, i)
                if num ~= '' and num ~= ' ' then
                    setProperty(tag .. '.visible', true)
                    setProperty(tag .. '.active', true)
                    objectPlayAnimation(tag, num .. 'a')
                else
                    setProperty(tag .. '.visible', false)
                    setProperty(tag .. '.active', false)
                end
            end

            noteHits = 0
        end
    end

    if getProperty('noteCombo.animation.finished') then
        local ateUrFrame = getProperty('noteCombo.animation.curAnim.name')
        if ateUrFrame == 'appear' then
            animBullshit('disappear')
            setProperty('noteCombo.visible', false)
            setProperty('noteCombo.active', false)
            -- not the same frames length, but shut the fuck up
            for i = 1, 3 do
                local tag = 'noteComboN' .. i
                local num = string.sub(seperatedHits, i, i)
                if num ~= '' and num ~= ' ' then
                    setProperty(tag .. '.visible', false)
                    setProperty(tag .. '.active', false)
                end
            end
        end
    end
---
end 

function animBullshit(anim, force)
    if force == nil then force = false end
    playAnim('noteCombo', anim, force)

    local ox, oy = 100, 150
    if anim == 'disappear' then ox = -150 end

    setProperty('noteCombo.offset.x', ox)
    setProperty('noteCombo.offset.y', oy)
end

function goodNoteHit(id, direction, noteType, isSustainNote)
 if not isSustainNote then
 for i = 1, 3 do
 local max = 'Maxcom' .. i
 cancelTween(max)
 end
 cancelTimer('BROHIDEFUCK')
 cancelTimer('byeRating')
 cancelTween('d')
 cancelTween('alpha')
 runTimer('byeRating',0.5)
 noteHits = noteHits + 1
 setProperty('rating.angle', getRandomInt(-3, 3))
 setProperty('combo.angle', getRandomInt(-3, 3))
 objectPlayAnimation('blot', getRandomInt(1,2))
 objectPlayAnimation('combo', 'combo')
 setProperty('blot.alpha', 1)
 setProperty('blot.y', posBlot)
 doTweenY('uppp', 'blot', getProperty('blot.y') - 55, 0.5, 'quadOut')
 end
if getProperty('notes.members['..id..'].rating') == 'sick' then
 objectPlayAnimation('rating', 'sick')
 end 
 if getProperty('notes.members['..id..'].rating') == 'good' then
 objectPlayAnimation('rating', 'good')
 end
 if getProperty('notes.members['..id..'].rating') == 'bad' then
 objectPlayAnimation('rating', 'bad')
 end
 if getProperty('notes.members['..id..'].rating') == 'shit' then
 objectPlayAnimation('rating', 'shit')
 end
if getProperty('combo') >= 15 then
for i = 1, 3 do
 local max = 'Maxcom' .. i
 setProperty(max..'.alpha', 1)
 end
end
if getProperty('combo') >= 20 then
 setProperty('combo.visible', true)
  end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
noteHits = 0
for i = 1, 3 do
local max = 'Maxcom' .. i
setProperty(max .. '.visible', false)
setProperty(max .. '.alpha', 0)
 end
if not isSustainNote then
setProperty('combo.visible', false)
 end
end

function noteMissPress() noteHits = 0 end

function onTweenCompleted(tag)
if tag == ('uppp') then
doTweenY('d', 'blot', getProperty('blot.y') + 95, 0.4, 'quadIn')
doTweenAlpha('alpha', 'blot', 0, 0.3)
for i = 1, 3 do
local max = 'Maxcom' .. i
doTweenAlpha(max, max, 0, 0.1)
  end
end
if tag == ('jc') then
startTween('tweenCD','cd.scale',{x = 0.55,y = 0.55},0.2 ,{ease = 'sineInOut'})
doTweenAngle('jc1', 'cd', 10, 0.2, 'sineInOut')
doTweenAlpha('bye', 'cd', 0, 0.15, 'sineInOut')
 end
if tag == ('d') then
runTimer('BROHIDEFUCK',0.1, 999999999)
for i = 1, 3 do
local max = 'Maxcom' .. i
setProperty(max .. '.alpha', 0)
  end
 end
end

function onCountdownTick(c)
    if c == 0 then
    setProperty('cd.visible', true)
    objectPlayAnimation('cd', '3')
    elseif c == 1 then
    objectPlayAnimation('cd', '2')
    elseif c == 2 then
    objectPlayAnimation('cd', '1')
    elseif c == 3 then
    objectPlayAnimation('cd', 'go')
    runTimer('byeCount',0.4)
    end
end

function onTimerCompleted(t,l,ll)
if t == 'BROHIDEFUCK' then
for i = 1, 3 do
 local max = 'Maxcom' .. i
 setProperty(max..'.alpha', 0)
 end
end
if t == 'byeCount' then
startTween('tweenCD1','cd.scale',{x = 0.65,y = 0.65},0.1 ,{ease = 'sineInOut'})
doTweenAngle('jc', 'cd', -5, 0.1, 'sineInOut')
 end
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