local obj = {
  layer = 0,
  uplayer = 3,
  x=0,
  y=0,
  r=0,
  speed=4,
  anims = {down = ez.newanim(templates.drillmin.down), left =  ez.newanim(templates.drillmin.left), right =  ez.newanim(templates.drillmin.right)},
  canim = "down",
  i=0,
  rockshake = 0,
  myshake = 0
}


function obj.update(dt)
  obj.myshake = 0
  obj.canim = "down"
  
  if maininput:down("left") then
    obj.r = obj.r - 2
    obj.canim = "left"
  end
  if maininput:down("right") then
    obj.r = obj.r + 2
    obj.canim = "right"
  end
  
  obj.speed = 4
  local foundrock = false
  local hitrock = nil
  for i,v in ipairs(entities) do
    
    if v.name == "rock" then
      if helpers.collide({x=obj.x, y=obj.y, width=0, height=0},{x=v.x-19,y=v.y-19,width=38,height=38}) then
        obj.speed = 0.75
        obj.rockshake = obj.rockshake + 0.5
        foundrock = true
        hitrock = v
      end
      
    elseif v.name == "hardrock" then
      if helpers.collide({x=obj.x, y=obj.y, width=0, height=0},{x=v.x-19,y=v.y-19,width=38,height=38}) then
        obj.speed = 0.4
        obj.rockshake = obj.rockshake + 0.2
        foundrock = true
        hitrock = v
      end
    elseif v.name == "gem" then
      if helpers.collide({x=obj.x, y=obj.y, width=0, height=0},{x=v.x-19,y=v.y-19,width=38,height=38}) then
        obj.speed = 0.4
        obj.rockshake = obj.rockshake + 0.2
        foundrock = true
        hitrock = v
      end
    elseif v.name == "worm" then
      if helpers.collide({x=obj.x, y=obj.y, width=0, height=0},{x=v.x-19,y=v.y-19,width=60*(v.length+1),height=40}) then
        obj.speed = 0.4
        obj.rockshake = obj.rockshake + 0.2
        foundrock = true
        hitrock = v
      end
    end
  end
  if foundrock then
    hitrock.myshake = obj.myshake + obj.rockshake
  else
    obj.rockshake = obj.rockshake / 2
    if obj.rockshake <= 0.25 then
      obj.rockshake = 0
    end
  end
  obj.myshake = obj.myshake + obj.rockshake

  
  local rret = helpers.rotate(obj.speed*dt*-1,obj.r,obj.x,obj.y)
  obj.x = rret[1]
  obj.y = rret[2]
  
  if obj.x < 20 then
    obj.x = 20
    obj.r = obj.r * -1
  end
  if obj.x > 380 then
    obj.x = 380
    obj.r = obj.r * -1
  end
  
  if cs.lava.y - 20 >= obj.y then
    cs.lose = true
    
  end
  
  
  for k,v in pairs(obj.anims) do
    ez.update(v)
  end
end
function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()
  local dc = obj.canim
  local da = obj.anims[obj.canim]
  local dx = obj.x + cs.cx + obj.getshake()
  local dy = obj.y + cs.cy + obj.getshake()
  local dr = math.rad(obj.r)
  
  
  ez.draw(da, dx, dy,dr,2,2,15.5,30)
  
  cs.pwhite.dc = dc
  cs.pwhite.da = da
  cs.pwhite.dx = dx
  cs.pwhite.dy = dy
  cs.pwhite.dr = dr
  
  
end


return obj