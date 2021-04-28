local obj = {
  layer = 12,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.lava,
  i=0,
  
  myshake = 0,
  timer = 0,
  timers = {randomrock=0,upworm = 400, randomhardrock = 100,gem=100, rockcluster = 200,tunnel = 300,funnel=400,worm=100,wormsmall = 100,}
}


function obj.update(dt)
  obj.i = obj.i + dt
  if not nostress then
    obj.y = obj.y + dt*3
    for k,v in pairs(obj.timers) do
      
      obj.timers[k] = obj.timers[k] - dt --????
    end
    obj.timer = obj.timer - dt
    
    
  end
  if cs.player.y -250 >= obj.y then
    obj.y = cs.player.y - 250
    if nostress then
      for k,v in pairs(obj.timers) do
        obj.timers[k] = obj.timers[k] - dt
        obj.timer = obj.timer - dt
      end
    end
  end
  --catch up with player
  if obj.timer <= 0 then
    for k,v in pairs(obj.timers) do
      if v <= 0 then
        if k == "randomrock" then
          em.init("rock",{x=love.math.random(32,370),y=obj.y+800})
          obj.timers[k] = love.math.random(200,300) 
          print("rock spawn")
          break
        end
        if k == "randomhardrock" then
          em.init("hardrock",{x=math.random(32,370),y=obj.y+800})
          obj.timers[k] =love.math.random(300,400) 
          print("hardrock spawn")
          break
        end
        if k == "gem" then
          em.init("gem",{x=math.random(32,370),y=obj.y+800})
          obj.timers[k] =love.math.random(300,400) 
          print("gem spawn")
          break
        end
        if k == "rockcluster" then
          local xpos =love.math.random(32+42,370-42)
          em.init("rock",{x=xpos,y=obj.y+800})
          em.init("hardrock",{x=xpos,y=obj.y+842})
          em.init("rock",{x=xpos-42,y=obj.y+842})
          em.init("rock",{x=xpos+42,y=obj.y+842})
          em.init("rock",{x=xpos,y=obj.y+884})
          obj.timers[k] =love.math.random(200,400) 
          print("cluster spawn")
          break
        end
        if k == "tunnel" then
          
          local skip =love.math.random(1,7)
          local skip2 =love.math.random(1,7)
          for i=0,8 do
            if i ~= skip and i ~= skip2 then
              em.init("rock",{x=32+42*i,y=obj.y+800})
              em.init("hardrock",{x=32+42*i,y=obj.y+842})
              if not tatemode then
                local newpart = em.init("particle",{x=32+42*i,y=260,spr=sprites.warning,dx=0,dy=0,ptype="warning"})
                flux.to(newpart,30,{y=140}):ease("outExpo"):oncomplete(function() 
                  flux.to(newpart,30,{y=-16}):ease("inExpo"):oncomplete(function()
                    newpart.delete = true 
                  end)
                end)
              end
            end
          end
          obj.timers[k] =love.math.random(500,600) 
          print("tunnel spawn")
          break
        end
        if k == "funnel" then
          local xpos =love.math.random(32+42,370-42)
          em.init("rock",{x=32+42*0,y=obj.y+800})
          em.init("rock",{x=32+42*8,y=obj.y+800})
          
          em.init("hardrock",{x=32+42*0,y=obj.y+800+42*1})
          em.init("rock",    {x=32+42*1,y=obj.y+800+42*1})
          em.init("rock",    {x=32+42*7,y=obj.y+800+42*1})
          em.init("hardrock",{x=32+42*8,y=obj.y+800+42*1})

          em.init("hardrock",{x=32+42*0,y=obj.y+800+42*2})
          em.init("hardrock",{x=32+42*1,y=obj.y+800+42*2})
          em.init("rock",    {x=32+42*2,y=obj.y+800+42*2})
          em.init("rock",    {x=32+42*6,y=obj.y+800+42*2})
          em.init("hardrock",{x=32+42*7,y=obj.y+800+42*2})
          em.init("hardrock",{x=32+42*8,y=obj.y+800+42*2})
          
          em.init("hardrock",{x=32+42*0,y=obj.y+800+42*3})
          em.init("hardrock",{x=32+42*1,y=obj.y+800+42*3})
          em.init("hardrock",{x=32+42*2,y=obj.y+800+42*3})
          em.init("rock",    {x=32+42*3,y=obj.y+800+42*3})
          em.init("rock",    {x=32+42*5,y=obj.y+800+42*3})
          em.init("hardrock",{x=32+42*6,y=obj.y+800+42*3})
          em.init("hardrock",{x=32+42*7,y=obj.y+800+42*3})
          em.init("hardrock",{x=32+42*8,y=obj.y+800+42*3})
          
          obj.timers[k] =love.math.random(1000,1200) 
          print("funnel spawn")
          break
        end
        if k == "worm" then
          if love.math.random(0,1) == 1 then
            em.init("worm",{x=math.random(400,460),y=obj.y+math.random(400,800)})
          else
            em.init("worm",{x=math.random(-60,0),y=obj.y+math.random(400,800),left = false})
          end
          obj.timers[k] =love.math.random(800,900) 
          print("worm spawn")
          break
        end
        if k == "wormsmall" then
          if love.math.random(0,1) == 1 then
            em.init("wormsmall",{x=math.random(400,430),y=obj.y+math.random(400,800)})
          else
            em.init("wormsmall",{x=math.random(-30,0),y=obj.y+math.random(400,800),left = false})
          end
          obj.timers[k] =love.math.random(400,500) 
          print("wormsmall spawn")
          break
        end
        if k == "upworm" then
          local spawnx = math.random(32,370)
          if not tatemode then
            local newpart = em.init("particle",{x=spawnx,y=260,spr=sprites.warning,dx=0,dy=0,ptype="warning"})
            flux.to(newpart,30,{y=140}):ease("outExpo"):oncomplete(function() 
              flux.to(newpart,30,{y=-16}):ease("inExpo"):oncomplete(function()
                newpart.delete = true 
              end)
            end)
          end
          em.init("upworm",{x=spawnx,y=obj.y+800})
          obj.timers[k] =love.math.random(1200,1300) 
          print("upworm spawn") --whats upworm? nothing much how about you LMAOOOOOOOOOOOOOOOOOOOOO
          break
        end
        
        
      end
    end
  obj.timer =love.math.random(50,100)
  end
--  if maininput:pressed("k3") then
--    em.init("upworm",{x=math.random(32,370),y=obj.y+800})
--    print("upworm spawn") --whats upworm? nothing much how about you LMAOOOOOOOOOOOOOOOOOOOOO
--  end
end


function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()
  love.graphics.setColor(1,0,77/255)
  love.graphics.rectangle("fill",obj.x,obj.y-400+ cs.cy,400,440)
  love.graphics.setColor(1,1,1)
  love.graphics.draw(obj.spr,(obj.x+ cs.cx + obj.getshake()-math.sin(obj.i/100)*600+obj.i*0.5)%-800,obj.y+ cs.cy + obj.getshake()-20,0,2,2)
  
end


return obj