function love.load()
  dt = 1

  gamename = "Drillmin"
  
  pressed = 0
  mx,my = 0,0
  
  ispush = false
  screencenter = {x = gameWidth/2, y = gameHeight/2}
  
  -- font is https://tepokato.itch.io/axolotl-font
  -- https://www.dafont.com/digital-disco.font
  
  font = love.graphics.newFont("assets/Axmolotl.ttf", 16)
  font:setFilter("nearest", "nearest",0)

love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setFont(font)
  -- accurate deltatime
  acdelt = true

  -- import libraries
  
  
  -- json handler
  json = require "lib.json"
  
  -- quickly load json files
  dpf = require "lib.dpf"
  
  -- localization
  loc = require "lib.loc"
  loc.load("assets/localization.json")

  -- custom functions, snippets, etc
  helpers = require "lib.helpers"

  -- gamestate, manages gamestates
  gs = require "lib.gamestatestripped"
  
  -- how dare i want a simple library
  bs = require "lib.basestate"

  -- baton, manages input handling
  baton = require "lib.baton"

  -- lovebpm, syncs stuff to music
  lovebpm = require "lib.lovebpm"

  shuv = require "lib.shuv"
  shuv.init()
  
  -- what it says on the tin
  utf8 = require("utf8")
  -- push, graphics helper, makes screen resolution stuff easy (doesnt work so im not using it actually lol)
  if ispush then
    push = require "lib.push"
  else
    push = require "lib.pushstripped"
  end

  -- deeper, modification of deep, queue functions, now with even more queue
  deeper = require "lib.deeper"

  -- tesound, sound playback
  te = require"lib.tesound"



  -- lovebird,debugging console
  if (not release)  then 
    lovebird = require "lib.lovebird"
  else
    lovebird = require "lib.lovebirdstripped"
  end

  -- entity manager
  em = require "lib.entityman"

  -- spritesheet manager
  ez = require "lib.ezanim"

  -- tween manager
  flux = require "lib.flux"
  

  
  -- set rescaling filter
  love.graphics.setDefaultFilter("nearest", "nearest")
  
  -- set line style
  love.graphics.setLineStyle("rough")
  love.graphics.setLineJoin("miter")
  
  -- send these arguments to push (or dont cause push is kinda strange sometimes)
  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
    fullscreen = release,
    resizable = false,
    pixelperfect = true
    })
  push:setBorderColor{0,0,0}
  love.window.setTitle(gamename)
  paused = false
  
  if not tatemode then
    cameraheight = 94
  else
    cameraheight = 300
  end
  frameadvance = false
  
  nostress = false

  --load sprites
  sprites = {
    templateguy = love.graphics.newImage("assets/templateguy.png"),
    border = love.graphics.newImage("assets/levelobjects/border.png"),
    rock = love.graphics.newImage("assets/levelobjects/rock.png"),
    booster = love.graphics.newImage("assets/levelobjects/booster.png"),
    warning = love.graphics.newImage("assets/particles/warning.png"),
    boostwarning = love.graphics.newImage("assets/particles/boostwarning.png"),
    gem = love.graphics.newImage("assets/levelobjects/gem.png"),
    hardrock = love.graphics.newImage("assets/levelobjects/hardrock.png"),
    softrock = love.graphics.newImage("assets/levelobjects/softrock.png"),
    gradient = love.graphics.newImage("assets/gradient.png"),
    lava = love.graphics.newImage("assets/levelobjects/lava.png"),
    controls = love.graphics.newImage("assets/ui/controls.png"),
    bg = love.graphics.newImage("assets/levelobjects/bg.png"),
    title = {
      base = love.graphics.newImage("assets/title/base.png"),
      blades = love.graphics.newImage("assets/title/blades.png"),
      logo = love.graphics.newImage("assets/title/logo.png"),
      instructions = love.graphics.newImage("assets/title/instructions.png"),
      ground = love.graphics.newImage("assets/title/ground.png")
    }
    
  }
  
  -- make templates
  templates = {
    drillmin = {
      down = ez.newtemplate("player/down.png",31,2,true),
      left = ez.newtemplate("player/left.png",31,2,true),
      right = ez.newtemplate("player/right.png",31,2,true),
      wateringcan = ez.newtemplate("player/wateringcan.png",64,2,true),
      grabdrill = ez.newtemplate("player/grabdrill.png",64,8,false),
    },
    
    drillminwhite = {
      down = ez.newtemplate("player_white/down.png",31,0,false), -- i know i should be using a shader of some sort to do this but, ludum dare!!!
      left = ez.newtemplate("player_white/left.png",31,0,false), 
      right = ez.newtemplate("player_white/right.png",31,0,false),
      wateringcan = ez.newtemplate("player_white/wateringcan.png",64,0,false),
      grabdrill = ez.newtemplate("player_white/grabdrill.png",64,0,false),
    },

    volcano = {
      idle = ez.newtemplate("title/idle.png", 32, 4, false),
      erupt = ez.newtemplate("title/erupt.png", 32, 8, false),
    },
    particles = {
      rock = ez.newtemplate("particles/rock.png",14,0,false),
      worm = ez.newtemplate("particles/worm.png",14,0,false)
    },
    worm = ez.newtemplate("levelobjects/worm.png",32,0,false),
    wormsmall = ez.newtemplate("levelobjects/wormsmall.png",16,0,false),
    cursor = ez.newtemplate("ui/cursor.png",8,3,true)
  }
  
  
  options = {
    invertedcontrols = false,
    volume = {
      bgm = 1,
      sfx = 1
    }
  }

  --setup input
  
  lt={x=0,y=0}
  
  if not ismobile then
    ctrls = {
          left = {"key:left",  "axis:rightx-", "button:dpleft"},
          right = {"key:right",  "axis:rightx+", "button:dpright"},
          up = {"key:up", "key:w", "axis:righty-", "button:dpup"},
          down = {"key:down", "key:s", "axis:righty+", "button:dpdown"},
          accept = {"key:space", "key:return", "button:a"},
          back = {"key:escape", "button:b"},
          f5 = {"key:f5"},
          k1 = {"key:1"},
          k2 = {"key:2"},
          k3 = {"key:3"},
          
          
          mouse1 = {"mouse:1"},
          mouse2 = {"mouse:2"},
          mouse3 = {"mouse:3"}
        }
        

        
    maininput = baton.new {
      controls = ctrls,
      pairs = {
        lr = {"left", "right", "up", "down"}
      },
        joystick = love.joystick.getJoysticks()[1],
    }
  else
    maininput = {
      controls = {left = {false,0},right = {false,0}, down = {false,0}, up = {false,0}, accept = {false,0}, touch = {false,0},back = {false,0}},
      press = function(ctrl)
        maininput.controls[ctrl][1] = true
        maininput.controls[ctrl][2] = maininput.controls[ctrl][2] + 1
    
        
        
      end,
      checkforpresses = function(x,y)
        if cs.name == "mainstate" then
          if x <= (gameWidth*shuv.scale / 2) + shuv.xoffset then 
            maininput.press("left")
          end
          if x >= (gameWidth*shuv.scale / 2) + shuv.xoffset then 
            maininput.press("right")
          end
        elseif cs.name == "title" then
          if cs.status == "options" and cs.cy <= 10 then
            
            if helpers.inrect(40, 70,134,170,lt.x,lt.y) then
              maininput.press("up")
            end
            if helpers.inrect(40, 70,200,236,lt.x,lt.y) then
              maininput.press("down")
            end
            if helpers.inrect(4, 40,170,200,lt.x,lt.y) then
              maininput.press("left")
            end
            if helpers.inrect(70, 106,170,200,lt.x,lt.y) then
              maininput.press("right")
            end
            if helpers.inrect(350, 392,146,188,lt.x,lt.y) then
              maininput.press("accept")
            end
            if helpers.inrect(306, 348,186,228,lt.x,lt.y) then
              maininput.press("back")
            end
          end
        end
      end,
      update = function() 
        
        for k,v in pairs(maininput.controls) do
          v[1] = false
        end
        
        local touches = love.touch.getTouches()
        
        for i, id in ipairs(touches) do
          local x, y = love.touch.getPosition(id)
          
          maininput.press("touch")
          
          lt.x = (x- shuv.xoffset)/shuv.scale
          lt.y = (y-shuv.yoffset)/shuv.scale
          
          maininput.checkforpresses(x,y)

        end
        
        
        if love.keyboard.isDown("space") then
          local x, y = love.mouse.getPosition()
          
          maininput.press("touch")
          
          lt.x = (x- shuv.xoffset)/shuv.scale
          lt.y = (y-shuv.yoffset)/shuv.scale
          
          maininput.checkforpresses(x,y)
          
        end
        
        
        
        for k,v in pairs(maininput.controls) do
          if v[2] == -1 then
            v[2] = 0
          end
        end
        for k,v in pairs(maininput.controls) do
          if not v[1] then
            v[2] = -1
          end
        end
      end,
      pressed = function(self,ctrl)
        
        return maininput.controls[ctrl][2] == 1
        
      end,
      down = function(self,ctrl) 
        return maininput.controls[ctrl][1]
      end
     
    }
  end
  local seed = 0
  for i=0,math.abs(love.mouse.getX()) do
    seed = seed + love.math.random(0,100)
  end
  love.math.setRandomSeed(seed)
  print(seed)
    
    
  entities = {}
  -- init states
  toswap = nil
  newswap = false
  bs.new("template")
  bs.new("mainstate")
  bs.new("title")
  bs.new("gameover")
  cs = bs.load("title")
  cs.init()
  
end

function love.textinput(t)
  tinput = t
end

function love.update(d)
  maininput:update()
  lovebird.update()
  if frameadvance == false or maininput:pressed("k1") or maininput:down("k2") then
    
    mouseX, mouseY = love.mouse.getPosition()
    mouseX = mouseX / 2
    mouseY = mouseY / 2

    shuv.check()
    if not acdelt then
      dt = 1
    else
      dt = d * 60
    end
    if dt >=6 then
      dt = 6
    end
    cs.update(dt)
    te.cleanup()
    --print(tinput)
  end
end

function love.draw()
  cs.draw()
end


function love.resize(w, h)
  push:resize(w, h)
end