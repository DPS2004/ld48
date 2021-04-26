local obj = {
  layer = 12,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.lava,
  i=0,
  
  myshake = 0,
  timer = 0,
  timers = {randomrock=0, randomhardrock = 100, rockcluster = 200,tunnel = 300}
}


function obj.update(dt)
  if not nostress then
    obj.y = obj.y + dt*3
    for k,v in pairs(obj.timers) do
      
      obj.timers[k] = obj.timers[k] - 1 --????
    end
    obj.timer = obj.timer - 1
    
    
  end
  if cs.player.y -250 >= obj.y then
    obj.y = cs.player.y - 250
    if nostress then
      for k,v in pairs(obj.timers) do
        obj.timers[k] = obj.timers[k] - 1 
      end
    end
  end
  --catch up with player
  if obj.timer <= 0 then
    for k,v in pairs(obj.timers) do
      if v <= 0 then
        if k == "randomrock" then
          em.init("rock",{x=math.random(32,370),y=obj.y+600})
          obj.timers[k] = math.random(200,300) 
          print("rock spawn")
          break
        end
        if k == "randomhardrock" then
          em.init("hardrock",{x=math.random(32,370),y=obj.y+600})
          obj.timers[k] = math.random(300,400) 
          print("hardrock spawn")
          break
        end
        if k == "rockcluster" then
          local xpos = math.random(32+42,370-42)
          em.init("rock",{x=xpos,y=obj.y+600})
          em.init("hardrock",{x=xpos,y=obj.y+642})
          em.init("rock",{x=xpos-42,y=obj.y+642})
          em.init("rock",{x=xpos+42,y=obj.y+642})
          em.init("rock",{x=xpos,y=obj.y+684})
          obj.timers[k] = math.random(200,400) 
          print("cluster spawn")
          break
        end
        if k == "tunnel" then
          
          local skip = math.random(1,7)
          local skip2 = math.random(1,7)
          for i=0,8 do
            if i ~= skip and i ~= skip2 then
              em.init("rock",{x=32+42*i,y=obj.y+600})
              em.init("hardrock",{x=32+42*i,y=obj.y+642})
            end
          end
          obj.timers[k] = math.random(500,600) 
          print("tunnel spawn")
          break
        end
        
      end
    end
  obj.timer = math.random(50,100)
  end
  
end


function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()
  love.graphics.setColor(1,0,77/255)
  love.graphics.rectangle("fill",obj.x,obj.y-400+ cs.cy,400,440)
  love.graphics.setColor(1,1,1)
  love.graphics.draw(obj.spr,obj.x+ cs.cx + obj.getshake(),obj.y+ cs.cy + obj.getshake(),0,2,2)
  
end


return obj