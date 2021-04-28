local st = {}
function st.init()
  st.border = em.init("border",{x=0,y=0})
  st.bg = em.init("bg",{x=0,y=0})
  st.dmcutscene = em.init("dmcutscene",{x=230,y=-100})
  st.volcano = em.init("volcano",{x=180,y=-366})
  st.status = "calm"
  te.stop("bgm")
  te.play("assets/sounds/intro.ogg","stream","bgm",1,1,function(a) te.playLooping("assets/sounds/intro_loop.ogg","stream","bgm") print("done") end)
  st.logo = em.init("logo",{})
  st.instructions = em.init("instructions",{})
  st.optionstxt = {
    loc.get("back"),
    loc.get("invertedcontrols"),
    loc.get("staticdeltatime")
  }
  st.optionsindex = 1
  st.camera = {x=0,y=240,shake=0}
  st.cx = 0
  st.cy = 240
  st.cursorspr = ez.newanim(templates.cursor)
end

function st.enter(prev)

end


function st.leave()

end


function st.resume()

end


function st.update()

  --st.camera.shake = 0
  if not paused then
    if maininput:pressed("accept") and st.status == "calm" then
      st.status="eruptstart"
      st.volcano.canim = "erupt"
      st.dmcutscene.canim = "grabdrill"
      te.stop("bgm")
      te.play("assets/sounds/erupt.ogg","static")
      flux.to(st.logo,60,{y=-240}):ease("inQuint"):oncomplete(function() st.logo.delete = true end)
      flux.to(st.instructions,60,{y=40}):ease("inQuint"):oncomplete(function() st.instructions.delete = true end)
      
    end
    if st.status == "eruptstart" then
      st.camera.shake = st.camera.shake + 0.025*dt
    end
    
    if st.status == "options" then
      if maininput:pressed("back") then
        st.status = "calm"
        flux.to(st.logo,60,{y=0}):ease("outQuint"):oncomplete(function() end)
        flux.to(st.instructions,60,{y=0}):ease("outQuint"):oncomplete(function() end)
        flux.to(st,120,{cy=240}):ease("outQuint"):oncomplete(function()  end)
      end
      if maininput:pressed("down") then
        st.optionsindex = st.optionsindex + 1
      end
      if maininput:pressed("up") then
        st.optionsindex = st.optionsindex - 1
      end

      st.optionsindex = ((st.optionsindex - 1) % #st.optionstxt) +1
    end
    
    
    
    if maininput:pressed("down") and st.status == "calm" then
      st.status="options"



      flux.to(st.logo,60,{y=-240}):ease("outQuint"):oncomplete(function() end)
      flux.to(st.instructions,60,{y=40}):ease("outQuint"):oncomplete(function() end)
      flux.to(st,120,{cy=0}):ease("outQuint"):oncomplete(function()  end)
      
    end
    
    
    
    flux.update(dt)
    em.update(dt)
    ez.update(st.cursorspr)
    
    st.border.update(dt)
    st.bg.update(dt)  -- cringe and hacky workaround :)
    
    if st.finished then
      local retainshake = cs.camera.shake
            cs.border.delete =true
      cs.bg.delete = true
      
      cs = bs.load("mainstate")
      cs.cy = cameraheight
      --cs.bg.y = 64
      
      
      

      
      cs.init()
      st.bg.update(dt)
      cs.bg.y = cameraheight
      cs.border.y = cameraheight
      cs.camera.shake = retainshake
      flux.to(cs.camera,60,{shake=0}):ease("linear")
      print("switching")
      st.finished = false
    end
  end
end

function st.getshake()
  local shake = ((0 - st.camera.shake) + (love.math.random() * (st.camera.shake * 2)))
  return shake
end


function st.draw()

  --push:start()
  shuv.start()
  love.graphics.setColor(1,1,1)

  love.graphics.rectangle("fill",0,0,gameWidth,gameHeight)

  love.graphics.setColor(1,1,1)
  
  em.draw()
  if st.status ~= "eruptstart" then
    for i,v in ipairs(st.optionstxt) do
      love.graphics.setColor(0,0,0)
      love.graphics.printf(v,44,2+st.cy+ i*20,148,"left",0,2,2)
      love.graphics.printf(v,44,-2+st.cy+ i*20,148,"left",0,2,2)
      love.graphics.printf(v,42,0+st.cy+ i*20,148,"left",0,2,2)
      love.graphics.printf(v,46,0+st.cy+ i*20,148,"left",0,2,2)
      love.graphics.setColor(1,1,1)
      love.graphics.printf(v,44,0+st.cy+ i*20,148,"left",0,2,2)
      
      ez.draw(st.cursorspr,28,st.optionsindex*20+st.cy+2,0,2,2)
    end
  end


  shuv.finish()

end


return st