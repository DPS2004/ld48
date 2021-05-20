local st = {}
function st.init()
  st.border = em.init("border",{x=0,y=0})
  st.name = "title"
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
    loc.get("gameplay"),
    loc.get("audio"),
    loc.get("credits"),
  }
  st.optionsindex = 1
  st.optionsmenu = 0
  st.on = loc.get("on")
  st.off = loc.get("off")
  st.warning = loc.get("warning")
  st.camera = {x=0,y=240,shake=0}
  st.cx = 0
  st.cy = 240
  st.creditsplaying = false
  st.cursorspr = ez.newanim(templates.cursor)
  st.credits = love.filesystem.read("credits.txt")
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
    if (maininput:pressed("accept") or (ismobile and (lt.x <= 266 and maininput:pressed("touch")))) and st.status == "calm" then
      st.status="eruptstart"
      st.volcano.canim = "erupt"
      st.dmcutscene.canim = "grabdrill"
      te.stop("bgm")
      te.play("assets/sounds/erupt.ogg","static","sfx")
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
      if maininput:pressed("down") and not st.creditsplaying then
        st.optionsindex = st.optionsindex + 1
      end
      if maininput:pressed("up") and not st.creditsplaying then
        st.optionsindex = st.optionsindex - 1
      end
      
      if maininput:pressed("accept") or maininput:pressed("left") or maininput:pressed("right") then
        if st.optionsmenu == 0 then
          if st.optionsindex == 1 then
            if maininput:pressed("accept") then
              st.status = "calm"
              flux.to(st.logo,60,{y=0}):ease("outQuint"):oncomplete(function() end)
              flux.to(st.instructions,60,{y=0}):ease("outQuint"):oncomplete(function() end)
              flux.to(st,120,{cy=240}):ease("outQuint"):oncomplete(function()  end)
            end
          elseif st.optionsindex == 2 then
            if maininput:pressed("accept") then
              st.optionsmenu = 1
              st.optionsindex = 1
              st.optionstxt = {
                loc.get("back"),
                loc.get("invertedcontrols"),
                loc.get("staticdeltatime"),
              }
            end
          elseif st.optionsindex == 3 then
            if maininput:pressed("accept") then
              st.optionsmenu = 2
              st.optionsindex = 1
              st.optionstxt = {
                loc.get("back"),
                loc.get("musicvolume"),
                loc.get("sfxvolume"),
              }
            end
          elseif st.optionsindex == 4 then
            if maininput:pressed("accept") then
              if not st.creditsplaying then
                st.creditsplaying = true
                flux.to(st,1400,{cy=-1400}):ease("linear"):oncomplete(function() st.cy = 0 st.creditsplaying = false end)
              else
                st.creditsplaying = false
                flux.to(st,0,{cy=0}):ease("linear"):oncomplete(function()  end)
              end
            end
          end
          
        elseif st.optionsmenu == 1 then
          if st.optionsindex == 1 then
            if maininput:pressed("accept") then
              st.optionsmenu = 0
              st.optionsindex = 1
              st.optionstxt = {
                loc.get("back"),
                loc.get("gameplay"),
                loc.get("audio"),
                loc.get("credits"),
              }
            end
          elseif st.optionsindex == 2 then
            if maininput:pressed("accept") then
              options.invertedcontrols = not options.invertedcontrols
            end
          elseif st.optionsindex == 3 then
            if maininput:pressed("accept") then
              acdelt = not acdelt
            end
          end
        elseif st.optionsmenu == 2 then
          if st.optionsindex == 1 then
            if maininput:pressed("accept") then
              st.optionsmenu = 0
              st.optionsindex = 1
              st.optionstxt = {
                loc.get("back"),
                loc.get("gameplay"),
                loc.get("audio"),
                loc.get("credits"),
              }
            end
          elseif st.optionsindex == 2 then
            if maininput:pressed("left") then
              options.volume.bgm = (options.volume.bgm - 0.1) % 1.1
            elseif maininput:pressed("right") then
              options.volume.bgm = (options.volume.bgm + 0.1) % 1.1
            end
            if options.volume.bgm < 0.1 or options.volume.bgm > 1 then
              options.volume.bgm = 0
            end
            if options.volume.bgm < 0 then
              options.volume.bgm = 1
            end
            te.volume("bgm", options.volume.bgm)
          elseif st.optionsindex == 3 then
            if maininput:pressed("left") then
              options.volume.sfx = (options.volume.sfx - 0.1) 
            elseif maininput:pressed("right") then
              options.volume.sfx = (options.volume.sfx + 0.1) 
            end
            if options.volume.sfx < 0.1 or options.volume.sfx > 1 then
              options.volume.sfx = 0
            end
            if options.volume.sfx < 0 then
              options.volume.sfx = 1
            end
            te.volume("sfx", options.volume.sfx)
            
          end
        end
      end
      
      if st.optionsindex == 0 then
        st.optionsindex = 1
        st.optionsmenu = 0
        st.status = "calm"
        st.optionstxt = {
          loc.get("back"),
          loc.get("gameplay"),
          loc.get("audio"),
          loc.get("credits"),
        }
        flux.to(st.logo,60,{y=0}):ease("outQuint"):oncomplete(function() end)
        flux.to(st.instructions,60,{y=0}):ease("outQuint"):oncomplete(function() end)
        flux.to(st,120,{cy=240}):ease("outQuint"):oncomplete(function()  end)
      end

      st.optionsindex = ((st.optionsindex - 1) % #st.optionstxt) +1
    end
    
    
    
    if (maininput:pressed("down") or (ismobile and (lt.x > 266 and maininput:pressed("touch")))) and st.status == "calm" then
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
      for h=-1,1 do
        for j=-1,1 do
          love.graphics.printf(v,44+h*2,j*2+st.cy+ i*20,148,"left",0,2,2)
        end
      end
      love.graphics.setColor(1,1,1)
      love.graphics.printf(v,44,0+st.cy+ i*20,148,"left",0,2,2)
      
      
    end
    
    ez.draw(st.cursorspr,28,st.optionsindex*20+st.cy+2,0,2,2)
    
    if st.optionsmenu == 1 then
      if st.optionsindex == 2 then
        
        local txt = st.off
        if options.invertedcontrols then
          txt = st.on
        end
        love.graphics.setColor(0,0,0)
        for i=-1,1 do
          for j=-1,1 do
            love.graphics.printf(txt,44+i*2,j*2+st.cy+ st.optionsindex*20,148,"right",0,2,2)
          end
        end
        love.graphics.setColor(1,1,1)
        love.graphics.printf(txt,44,0+st.cy+ st.optionsindex*20,148,"right",0,2,2)
        
      elseif st.optionsindex == 3 then

        local txt = st.off
        if acdelt then
          txt = st.on
        end
        love.graphics.setColor(0,0,0)
        for i=-1,1 do
          for j=-1,1 do
            love.graphics.printf(txt,44+i*2,j*2+st.cy+ st.optionsindex*20,148,"right",0,2,2)
            love.graphics.printf(st.warning,i*2,196+j*2,200,"center",0,2,2)
          end
        end
        
        love.graphics.setColor(1,1,1)
        
        love.graphics.printf(txt,44,0+st.cy+ st.optionsindex*20,148,"right",0,2,2)
        love.graphics.printf(st.warning,0,196,200,"center",0,2,2)

      end
    elseif st.optionsmenu == 2 then
      if st.optionsindex == 1 then
        
      elseif st.optionsindex == 2 then
        txt = tostring(options.volume.bgm * 100) .. "%"
        love.graphics.setColor(0,0,0)
        for i=-1,1 do
          for j=-1,1 do
            love.graphics.printf(txt,44+i*2,j*2+st.cy+ st.optionsindex*20,148,"right",0,2,2)
          end
        end
        love.graphics.setColor(1,1,1)
        love.graphics.printf(txt,44,0+st.cy+ st.optionsindex*20,148,"right",0,2,2)
      
        
      elseif st.optionsindex == 3 then
        txt = tostring(options.volume.sfx * 100) .. "%"
        love.graphics.setColor(0,0,0)
        for i=-1,1 do
          for j=-1,1 do
            love.graphics.printf(txt,44+i*2,j*2+st.cy+ st.optionsindex*20,148,"right",0,2,2)
          end
        end
        love.graphics.setColor(1,1,1)
        love.graphics.printf(txt,44,0+st.cy+ st.optionsindex*20,148,"right",0,2,2)
      end
    end
    love.graphics.setColor(0,0,0)
    for i=-1,1 do
      for j=-1,1 do
        love.graphics.printf(st.credits,i*2,240+st.cy+j*2,200,"center",0,2,2)
      end
    end
    love.graphics.setColor(1,1,1)
    love.graphics.printf(st.credits,0,240+st.cy,200,"center",0,2,2)
    if ismobile then
      if not st.creditsplaying then
        love.graphics.draw(sprites.controls,0,st.cy,0,2,2)
      end
      
      
    end
  end


  shuv.finish()

end


return st