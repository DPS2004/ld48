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
  acdelt = false

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
  gs = require "lib.gamestate"

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


  --load sprites
  sprites = {
    templateguy = love.graphics.newImage("assets/templateguy.png")
    
  }
  
  -- make templates
  templates = {
    drillmin = ez.newtemplate("player/drillmin.png",31,2,true)
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
    
    
    
  entities = {}
  -- init states
  toswap = nil
  newswap = false
  states = {
    template = require "states.template",
    mainstate = require "states.mainstate",
  }

  gs.registerEvents()
  gs.switch(states.mainstate)
end

function love.textinput(t)
  tinput = t
end

function love.update(d)
  maininput:update()
  lovebird.update()
  mouseX, mouseY = love.mouse.getPosition()
  mouseX = mouseX / 2
  mouseY = mouseY / 2
  cs = gs.current()
  shuv.check()
  if not acdelt then
    dt = 1
  else
    dt = d * 60
  end
  if dt >=2 then
    dt = 2
  end
  if paused then
    if cs.source then
      cs.source:update()
    end
    em.update(dt) -- for text boxes
  end
  --print(tinput)
  
end




function love.resize(w, h)
  push:resize(w, h)
end