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
  rockshake = 0
}


function obj.update(dt)
  
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
  for i,v in ipairs(entities) do
    
    if v.name == "rock" then
      if helpers.collide({x=obj.x, y=obj.y, width=0, height=0},{x=v.x-16,y=v.y-16,width=32,height=32}) then
        obj.speed = 0.75
        obj.rockshake = obj.rockshake + 0.5
        foundrock = true
      end
    end
  end
  if not foundrock then
    obj.rockshake = obj.rockshake / 2
    if obj.rockshake <= 0.25 then
      obj.rockshake = 0
    end
  end
  cs.camera.shake = cs.camera.shake + obj.rockshake

  
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
  for k,v in pairs(obj.anims) do
    ez.update(v)
  end
end


function obj.draw()

  ez.draw(obj.anims[obj.canim], obj.x + cs.cx + cs.getshake(), obj.y + cs.cy + cs.getshake(),math.rad(obj.r),2,2,15.5,30)
  
end


return obj