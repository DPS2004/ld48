function love.load()
  dt = 1

  gamename = "ld48"
  
  pressed = 0
  mx,my = 0,0
  ispush = false
  screencenter = {x = gameWidth/2, y = gameHeight/2}
  
  -- font is https://tepokato.itch.io/axolotl-font
  -- https://www.dafont.com/digital-disco.font
  
  font = love.graphics.newFont("assets/Axolotl.ttf", 16)
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
  if (not release) or ismobile then 
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
  
  
  cameraheight = 94
  
  frameadvance = false
  
  nostress = false

  --load sprites
  sprites = {
    templateguy = love.graphics.newImage("assets/templateguy.png"),
    border = love.graphics.newImage("assets/border.png"),
    rock = love.graphics.newImage("assets/rock.png"),
    warning = love.graphics.newImage("assets/warning.png"),
    gem = love.graphics.newImage("assets/gem.png"),
    hardrock = love.graphics.newImage("assets/hardrock.png"),
    lava = love.graphics.newImage("assets/lava.png"),
    bg = love.graphics.newImage("assets/bg.png"),
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
      rock = ez.newtemplate("particles/rock.png",14,0,false)
    },
    worm = ez.newtemplate("worm.png",32,0,false),
    wormsmall = ez.newtemplate("wormsmall.png",16,0,false)
  }

  --setup input
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