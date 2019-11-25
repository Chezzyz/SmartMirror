-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

------------------
 --added GUI config
 ------------------
local backGroundGroup = display.newGroup()
local iconUIGroup     = display.newGroup()
local homeIconsGroup  = display.newGroup()
local blurGroup       = display.newGroup()
local blockGroup      = display.newGroup()

iconUIGroup.isVisible = false
homeIconsGroup.isVisible = false

local songFont        = native.newFont("HebarExtraLight",50)
local clockFont       = native.newFont("Futura (Light)",160)
local calendarNumFont = native.newFont("Futura (Light)", 85)
local blockTextFont   = native.newFont("Futura (Light)" , 45)
local notesFont       = native.newFont("Futura (Light)" , 65)

local backGround = display.newImageRect(backGroundGroup,"Images/backGround.jpg",1080,1920)
backGround.x = display.contentCenterX
backGround.y = display.contentCenterY

------------------
--added Clock
------------------
local clockSnapshot = display.newSnapshot( 500, 350 )
clockSnapshot.x,clockSnapshot.y = 860,200
local UIclock = display.newText( "",860,200,500,350,clockFont )
local UIclockGlow = display.newText( "",0,0,500,350,clockFont )

local function setTime()
  clockSnapshot:invalidate()
  local hours = os.date("%H")
  local minutes = os.date("%M")
  UIclock.text = (hours..':'..minutes)
  UIclockGlow.text = (hours..':'..minutes)
  clockSnapshot.group:insert(UIclockGlow)
  clockSnapshot.fill.effect = "filter.blurGaussian"
  clockSnapshot.fill.effect.horizontal.blurSize = 18
  clockSnapshot.fill.effect.vertical.blurSize = 10
end

setTime()

timer.performWithDelay( 10000, setTime, -1 )

------------------
--added Weather
------------------
local cloud = display.newImageRect("Images/Cloud.png",235,159)
cloud.x = 150
cloud.y = 225

local cloudGlow = display.newImage("Images/Cloud.png",235,159)
cloudGlow.x,cloudGlow.y = cloud.x,cloud.y
cloudGlow.fill.effect = "filter.blurGaussian"
cloudGlow.fill.effect.horizontal.blurSize = 18
cloudGlow.fill.effect.vertical.blurSize = 18

local sun = display.newImageRect("Images/Sun.png",166,154)
sun.x = 205
sun.y = 135

local sunGlow = display.newImage("Images/Sun.png",166,154)
sunGlow.x,sunGlow.y = sun.x,sun.y
sunGlow.fill.effect = "filter.blurGaussian"
sunGlow.fill.effect.horizontal.blurSize = 18
sunGlow.fill.effect.vertical.blurSize = 18

local weatherText = display.newImageRect("Images/WeatherText.png",145, 70 )
weatherText.x = 165
weatherText.y = 350

local function animateWeatherRight()
 transition.to(cloud,{time = 1200,transition = easing.outSine,x=170})
 transition.to(cloudGlow,{time = 1200,transition = easing.outSine,x=170})
 transition.to(sun,{time = 1200,transition = easing.outSine,x=225,delay = 120})
 transition.to(sunGlow,{time = 1200,transition = easing.outSine,x=225,delay = 120})
end

local function animateWeatherLeft()
  transition.to(cloud,{time = 1200,transition = easing.outSine,x=150})
  transition.to(cloudGlow,{time = 1200,transition = easing.outSine,x=150})
  transition.to(sun,{time = 1200,transition = easing.outSine,x=205,delay = 120})
  transition.to(sunGlow,{time = 1200,transition = easing.outSine,x=205,delay = 120})
end

timer.performWithDelay(1200,animateWeatherRight,-1)
timer.performWithDelay(1200,animateWeatherLeft,-1)

------------------
--added Block\Unblock mechanism
------------------
local blockBackGround = display.newImageRect(blockGroup,"Images/backGround.jpg",1080,1920)
blockBackGround.x = display.contentCenterX
blockBackGround.y = display.contentCenterY

local dayBlockText = display.newText(blockGroup,"",880,250,0,0,blockTextFont)
local dayBlockTextGlow = display.newText(blockGroup,"",0,0,0,0,blockTextFont)
local blockTextSnapshot = display.newSnapshot(blockGroup, 1000, 300 )
blockTextSnapshot.x,blockTextSnapshot.y = dayBlockText.x,dayBlockText.y

local blockButton = display.newImageRect(iconUIGroup,"Images/LockIconLocked.png",160,160)
blockButton.x = 960
blockButton.y = 1140

local function unblockButtonAction(event)
  if(event.phase == "ended") then
    iconUIGroup.isVisible = true
    transition.to(blockBackGround,{time = 350,alpha = 0})
  end
end

local function blockButtonAction(event)
  if(event.phase == "ended") then
    transition.to(blockBackGround,{time = 150,alpha = 1,onComplete =
  function()
   iconUIGroup.isVisible = false
   end})
  end
end

------------------
--added Icons
------------------
local camera = display.newImageRect(iconUIGroup,"Images/CameraIcon.png",155,155)
camera.x = 120
camera.y = 1140
local cameraIcon = display.newImageRect(iconUIGroup,"Images/CameraIcon.png",155,155)
cameraIcon.x = 120
cameraIcon.y = 1140
cameraIcon.isVisible = false

local notes = display.newImageRect(iconUIGroup,"Images/NotesIcon.png",155,155)
notes.x = 120
notes.y = 960
local notesIcon = display.newImageRect(iconUIGroup,"Images/NotesIcon.png",155,155)
notesIcon.x = 120
notesIcon.y = 960
notesIcon.isVisible = false

local calendar = display.newImageRect(iconUIGroup,"Images/CalendarIcon.png",155,155)
calendar.x = 960
calendar.y = 780
local calendarIcon = display.newImageRect(iconUIGroup,"Images/CalendarIcon.png",155,155)
calendarIcon.x = 960
calendarIcon.y = 780
calendarIcon.isVisible = false
local calendarImage = display.newImageRect(iconUIGroup,"Images/CalendarImage.png",590,500)
calendarImage.x = 540
calendarImage.y = 880
calendarImage.isVisible = false

local home = display.newImageRect(iconUIGroup,"Images/SmartHomeIcon.png",155,155)
home.x = 120
home.y = 780
local homeIcon = display.newImageRect(iconUIGroup,"Images/SmartHomeIcon.png",155,155)
homeIcon.x = 120
homeIcon.y = 780
homeIcon.isVisible = false

local teapotOffIcon = display.newImageRect(homeIconsGroup,"Images/TeapotOffIcon.png",155,155)
local teapotIcon = display.newImageRect(homeIconsGroup,"Images/TeapotIcon.png",155,155)
teapotIcon.x,teapotOffIcon.x = 690,690
teapotIcon.y,teapotOffIcon.y = 760,760
teapotIcon.isVisible = false

local washMachineOffIcon = display.newImageRect(homeIconsGroup,"Images/WashmachineOffIcon.png",155,155)
local washMachineIcon = display.newImageRect(homeIconsGroup,"Images/WashmachineIcon.png",155,155)
washMachineIcon.x,washMachineOffIcon.x = 380,380
washMachineIcon.y,washMachineOffIcon.y = 760,760
washMachineIcon.isVisible = false

local coffeeOffIcon = display.newImageRect(homeIconsGroup,"Images/CoffeeOffIcon.png",155,155)
local coffeeIcon = display.newImageRect(homeIconsGroup,"Images/CoffeeIcon.png",155,155)
coffeeIcon.x,coffeeOffIcon.x = 690,690
coffeeIcon.y,coffeeOffIcon.y = 1030,1030
coffeeIcon.isVisible = false

local lightOffIcon = display.newImageRect(homeIconsGroup,"Images/LightOffIcon.png",155,155)
local lightIcon = display.newImageRect(homeIconsGroup,"Images/LightIcon.png",155,155)
lightIcon.x,lightOffIcon.x = 380,380
lightIcon.y,lightOffIcon.y = 1030,1030
lightIcon.isVisible = false


------------------
--work with date
------------------
local function setDay()
   blockTextSnapshot:invalidate()
   dayBlockText.text = os.date("%d").." "..os.date("%b")..", "..os.date("%A")
   dayBlockTextGlow.text = os.date("%d").." "..os.date("%b")..", "..os.date("%A")
   blockTextSnapshot.group:insert(dayBlockTextGlow)
   blockTextSnapshot.fill.effect = "filter.blurGaussian"
   blockTextSnapshot.fill.effect.horizontal.blurSize = 12
   blockTextSnapshot.fill.effect.vertical.blurSize = 6
end

setDay()
timer.performWithDelay( 10000, setDay, -1 )
-------------------

local function touchEffect(event)
  local icon = event.target
  local phase = event.phase
  if(phase == "began") then
    display.getCurrentStage():setFocus( icon )
    icon.isFocus = true
    transition.to( icon, {time = 50, width = icon.width - 15, height = icon.height - 15} )
  elseif(phase == "ended") then
    transition.to( icon, {time = 50, width =155, height = 155} )
    display.getCurrentStage():setFocus( nil )
    icon.isFocus = false
  end
end

camera:addEventListener("touch",touchEffect)
notes:addEventListener("touch",touchEffect)
home:addEventListener("touch",touchEffect)
calendar:addEventListener("touch",touchEffect)
blockBackGround:addEventListener("touch",unblockButtonAction)
blockButton:addEventListener("touch",blockButtonAction)
blockButton:addEventListener("touch",touchEffect)

------------------
--added Functional
------------------
local cameraBorder = display.newImageRect(iconUIGroup,"Images/MainBorder.png",700,950)
cameraBorder.x = 540
cameraBorder.y = 840
cameraBorder.alpha = 0
cameraBorder.isVisible = false

local cameraOff = display.newImageRect(iconUIGroup,"Images/CameraIcon.png",155,155)
cameraOff.x = 120
cameraOff.y = 1140
cameraOff.isVisible = false

local homeOff = display.newImageRect(iconUIGroup,"Images/SmartHomeIcon.png",155,155)
homeOff.x = 120
homeOff.y = 780
homeOff.isVisible = false

local calendarOff = display.newImageRect(iconUIGroup,"Images/CalendarIcon.png",155,155)
calendarOff.x = 960
calendarOff.y = 780
calendarOff.isVisible = false

local notesOff = display.newImageRect(iconUIGroup,"Images/NotesIcon.png",155,155)
notesOff.x = 120
notesOff.y = 960
notesOff.isVisible = false

local inputField = native.newTextField( 540, 1250, 600, 100 )
--inputField:setTextColor(1,1,1)
inputField.isVisible = false
inputField.font = notesFont
inputField.hasBackground = false
local note1 = display.newText( iconUIGroup,"1. Clean Room",250,440,0,0,notesFont)
local note2 = display.newText( iconUIGroup,"2. Call to mom",250,520,0,0,notesFont)
local note3 = display.newText( iconUIGroup,"",280,600,700,0,notesFont)
local textBox = {note1,note2,note3}

buttons = {camera,calendar,notes,home}
icons = {cameraIcon,calendarIcon,notesIcon,homeIcon}

local function blurImage(item,IconItem)
  for i,v in ipairs(buttons) do
    if(v ~= item) then
      v.isVisible = false
    end
  end
  for i,v in ipairs(icons) do
    if(v ~= IconItem) then
    v.isVisible = true
    v.fill.effect = "filter.blurGaussian"
    v.fill.effect.horizontal.blurSize = 15
    v.fill.effect.vertical.blurSize = 15
    end
  end
end

local function disBlurImage()
  for i,v in ipairs(buttons) do
    v.isVisible = true
  end
  for i,v in ipairs(icons) do
    v.fill.effect = nil
    v.isVisible   = nil
  end
end

local function cameraFunctionOn(event)
  if(event.phase == "ended") then
    cameraBorder.isVisible = true
    camera.isVisible = false
    cameraOff.isVisible = true
    transition.to(cameraBorder,{time = 150,alpha = 1})
    blurImage(camera,cameraIcon)
    note1.isVisible = false
    note2.isVisible = false
    note3.isVisible = false
    end
end

local function cameraFunctionOff(event)
  if(event.phase == "ended") then
    transition.to( cameraBorder, {time = 150,alpha = 0,onComplete =
    function()
      cameraBorder.isVisible = false
    end } )
    cameraOff.isVisible = false
    camera.isVisible = true
    disBlurImage()
    note1.isVisible = true
    note2.isVisible = true
    note3.isVisible = true
  end
end

homeIcons = {coffeeIcon,washMachineIcon,lightIcon,teapotIcon,coffeeOffIcon,washMachineOffIcon,lightOffIcon,teapotOffIcon}

local function homeIconsEffect(event)
  if(event.phase == "ended") then
    if(event.target == lightOffIcon) then
      lightIcon.isVisible = true
      lightOffIcon.isVisible = false
    end
    if(event.target == lightIcon) then
      lightIcon.isVisible = false
      lightOffIcon.isVisible = true
    end
    if(event.target == coffeeOffIcon) then
      coffeeIcon.isVisible = true
      coffeeOffIcon.isVisible = false
    end
    if(event.target == coffeeIcon) then
      coffeeIcon.isVisible = false
      coffeeOffIcon.isVisible = true
    end
    if(event.target == washMachineOffIcon) then
      washMachineIcon.isVisible = true
      washMachineOffIcon.isVisible = false
    end
    if(event.target == washMachineIcon) then
      washMachineIcon.isVisible = false
      washMachineOffIcon.isVisible = true
    end
    if(event.target == teapotOffIcon) then
      teapotIcon.isVisible = true
      teapotOffIcon.isVisible = false
    end
    if(event.target == teapotIcon) then
      teapotIcon.isVisible = false
      teapotOffIcon.isVisible = true
    end
  end
end

for i,v in ipairs( homeIcons ) do
  v:addEventListener("touch",homeIconsEffect)
  v:addEventListener("touch",touchEffect)
end

local function homeFunctionOn(event)
  if(event.phase == "ended") then
    home.isVisible = false
    homeOff.isVisible = true
    blurImage(home,homeIcon)
    homeIconsGroup.alpha = 0
    homeIconsGroup.isVisible = true
    transition.to(homeIconsGroup,{time = 200,alpha=1})
  end
end

local function homeFunctionOff(event)
  if(event.phase == "ended") then
    homeOff.isVisible = false
    home.isVisible = true
    transition.to(homeIconsGroup,{time = 200,alpha=0,onComplete =
    function()
     homeIconsGroup.isVisible = false
    end})
    disBlurImage()
  end
end

local function calendarFunctionOn(event)
  if(event.phase == "ended") then
    calendar.isVisible = false
    calendarOff.isVisible = true
    blurImage(calendar,calendarIcon)
    calendarImage.alpha = 0
    calendarImage.isVisible = true
    transition.to(calendarImage,{time = 200,alpha = 1})
  end
end

local function calendarFunctionOff(event)
  if(event.phase == "ended") then
    calendarOff.isVisible = false
    calendar.isVisible = true
    transition.to(calendarImage,{time = 200,alpha = 0,onComplete =
    function()
     calendarImage.isVisible = false
    end})
    disBlurImage()
  end
end

local function notesFunctionOn(event)
  if(event.phase == "ended") then
   notes.isVisible = false
   notesOff.isVisible = true
   blurImage(notes,notesIcon)

   transition.to(note1,{time = 700,transition = easing.outQuad,x = 540,y = 900})
   transition.to(note2,{time = 700,transition = easing.outQuad,x = 540,y = 980,onComplete =
    function()
     inputField.isVisible = true
    end})
    transition.to(note3,{time = 700,transition = easing.outQuad,x = 680,y = 1060})
  end
end

local function notesFunctionOff(event)
  if(event.phase == "ended") then
    notesOff.isVisible = false
    notes.isVisible = true
    inputField.isVisible = false
    transition.to(note1,{time = 700,transition = easing.outQuad,x = 250,y = 440})
    transition.to(note2,{time = 700,transition = easing.outQuad,x = 250,y = 520,onComplete =
     function()
      inputField.isVisible = false
     end})
     if(inputField.text ~= "") then
      note3.text = "3. "..inputField.text
     end
     transition.to(note3,{time = 700,transition = easing.outQuad,x = 390,y = 600})
    disBlurImage()
  end
end

home:addEventListener("touch",homeFunctionOn)
homeOff:addEventListener("touch",homeFunctionOff)
homeOff:addEventListener("touch",touchEffect)
camera:addEventListener("touch",cameraFunctionOn)
cameraOff:addEventListener("touch",cameraFunctionOff)
cameraOff:addEventListener("touch",touchEffect)
calendar:addEventListener("touch",calendarFunctionOn)
calendarOff:addEventListener("touch",calendarFunctionOff)
calendarOff:addEventListener("touch",touchEffect)
notes:addEventListener("touch",notesFunctionOn)
notesOff:addEventListener("touch",notesFunctionOff)
notesOff:addEventListener("touch",touchEffect)

------------------
--added audioPlayer
------------------

local playButton = display.newImageRect( iconUIGroup, "Images/PlayButton.png", 85, 90 )
playButton.x = 540
playButton.y = 1460

local pauseButton = display.newImageRect( iconUIGroup, "Images/PauseButton.png", 85, 90 )
pauseButton.x = 540
pauseButton.y = 1460
pauseButton.isVisible = false

local prevButton = display.newImageRect( iconUIGroup, "Images/PrevButton.png", 50, 50 )
prevButton.x = 405
prevButton.y = 1460

local nextButton = display.newImageRect( iconUIGroup, "Images/NextButton.png", 50, 50 )
nextButton.x = 660
nextButton.y = 1460

local songLine = display.newLine(iconUIGroup,320,1560,760,1560)
songLine:setStrokeColor(1,1,1)
songLine.strokeWidth = 5

local volumeLine = display.newLine(iconUIGroup,790,1540,790,1410)
volumeLine:setStrokeColor(1,1,1)
volumeLine.strokeWidth = 5

local songCircle = display.newRoundedRect( iconUIGroup,320, 1560, 15, 15, 13 )
local volumeCircle = display.newRoundedRect( iconUIGroup,790, 1540, 15, 15, 13 )

local song = display.newText(iconUIGroup,"",630,1400,750,150,songFont)
local song1 = "Victor Tsoy - Vosmiklassnitsa"
local song2 = " Egor Letov - Moya Oborona"
local song3 = "  Artur Pirozhkov - Zacepila"
songList = {[1] = song1,[2] = song2,[3] = song3}
song.text = song1
local songNum = 1;

local function prevButtonFunction(event)
  local icon = event.target
  local phase = event.phase
  if(phase == "began") then
    display.getCurrentStage():setFocus( icon )
    icon.isFocus = true
    transition.to( icon, {time = 50, width = icon.width - 5, height = icon.height - 5} )
  elseif(phase == "ended") then
    transition.to( icon, {time = 50, width =50, height = 50} )
    display.getCurrentStage():setFocus( nil )
    icon.isFocus = false
    if(songNum ~= 1) then
     songNum = songNum - 1
    else
      songNum = 3
    end
    song.text = songList[songNum]
    songCircle.x = 320
    transition.to(songCircle,{iterations = -1,time = 30000,x = 760,onRepeat =
    function()
      if(songNum ~= 3) then
       songNum = songNum + 1
      else
        songNum = 1
      end
      song.text = songList[songNum]
      songCircle.x = 320
    end})
  end
end

local function nextButtonFunction(event)
  local icon = event.target
  local phase = event.phase
  if(phase == "began") then
    display.getCurrentStage():setFocus( icon )
    icon.isFocus = true
    transition.to( icon, {time = 50, width = icon.width - 5, height = icon.height - 5} )
  elseif(phase == "ended") then
    transition.to( icon, {time = 50, width =50, height = 50} )
    display.getCurrentStage():setFocus( nil )
    icon.isFocus = false
    if(songNum ~= 3) then
     songNum = songNum + 1
    else
      songNum = 1
    end
    song.text = songList[songNum]
    songCircle.x = 320
    transition.to(songCircle,{iterations = -1,time = 30000,x = 760,onRepeat =
    function()
      if(songNum ~= 3) then
       songNum = songNum + 1
      else
        songNum = 1
      end
      song.text = songList[songNum]
      songCircle.x = 320
    end})
  end
end

local function playButtonFunction(event)
  local icon = event.target
  local phase = event.phase
  if(phase == "began") then
    display.getCurrentStage():setFocus( icon )
    icon.isFocus = true
    transition.to( icon, {time = 50, width = icon.width - 8, height = icon.height - 8} )
  elseif(phase == "ended") then
    transition.to( icon, {time = 50, width =85, height = 90} )
    display.getCurrentStage():setFocus( nil )
    icon.isFocus = false
    playButton.isVisible = false
    pauseButton.isVisible = true
    transition.to(songCircle,{iterations = -1,time = 30000,x = 760,onRepeat =
    function()
      if(songNum ~= 3) then
       songNum = songNum + 1
      else
        songNum = 1
      end
      song.text = songList[songNum]
      songCircle.x = 320
    end})
  end
end

local function pauseButtonFunction(event)
  local icon = event.target
  local phase = event.phase
  if(phase == "began") then
    display.getCurrentStage():setFocus( icon )
    icon.isFocus = true
    transition.to( icon, {time = 50, width = icon.width - 8, height = icon.height - 8} )
  elseif(phase == "ended") then
    transition.to( icon, {time = 50, width =85, height = 90} )
    display.getCurrentStage():setFocus( nil )
    icon.isFocus = false
    playButton.isVisible = true
    pauseButton.isVisible = false
    transition.pause(songCircle)
  end
end

local function volumeChange(event)
  local icon = event.target
  local phase = event.phase
  if(phase == "began") then
    display.getCurrentStage():setFocus( icon )
    icon.isFocus = true
  elseif(phase == "moved") then
    if(event.y > 1540) then icon.y = 1540
    elseif(event.y<1410) then icon.y = 1410
    else
    icon.y = event.y
    end
  elseif(phase == "ended") then
    display.getCurrentStage():setFocus( nil )
    icon.isFocus = false
  end
end

volumeCircle:addEventListener("touch",volumeChange)
playButton:addEventListener("touch",playButtonFunction)
pauseButton:addEventListener("touch",pauseButtonFunction)
prevButton:addEventListener("touch",prevButtonFunction)
nextButton:addEventListener("touch",nextButtonFunction)
