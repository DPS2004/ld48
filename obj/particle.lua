local obj = {
  layer = 1,
  uplayer = 2,
  x=0,
  y=0,
  dx=0,
  dy=0,
  r=0,
  hp=20,
  ptype = "rock",
  spr = ez.newanim(templates.particles.rock),
  i=0,
  myshake = 0,
  init = false
}


function obj.update(dt)
  if not obj.init then
    if obj.ptype == "rock" then
      ez.rframe(obj.spr)
      obj.r = math.random(0,3) * 90
    end
    
    if obj.angle then
      local res = helpers.rotate(-10,obj.angle,0,0)
      obj.dx = res[1]
      obj.dy = res[2]
    end
    obj.init = true
  end
  obj.x = obj.x + obj.dx
  obj.y = obj.y + obj.dy
  
  obj.myshake = 0

    

end

function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()
  local dx = obj.x+cs.cx+obj.getshake()
  local dy = obj.y+cs.cy+obj.getshake()
  if obj.ptype == "rock" then
    ez.draw(obj.spr, dx, dy, math.rad(obj.r),2,2,7,7)
  elseif obj.ptype == "warning" then
    love.graphics.draw(obj.spr, obj.x, obj.y, math.rad(obj.r),2,2,8,8)
    
  end
  if dx <= -100 or dx >= 500 or dy <= -100 or dy >= 500 then
    if obj.ptype ~= "warning" then
      obj.delete = true
      print("rock particle destroyed")
    end
  end
  
end


return obj