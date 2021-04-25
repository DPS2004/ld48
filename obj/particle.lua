local obj = {
  layer = 1,
  uplayer = 2,
  x=0,
  y=0,
  dx=0,
  dy=0,
  r=0,
  hp=20,
  spr = ez.newanim(templates.particles.rock),
  i=0,
  myshake = 0,
  init = false
}


function obj.update(dt)
  if not obj.init then
    ez.rframe(obj.spr)
    obj.r = math.random(0,3) * 90
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
  ez.draw(obj.spr, dx, dy, math.rad(obj.r),2,2,7,7)
  if dx <= -100 or dx >= 500 or dy <= -100 or dy >= 500 then
    obj.delete = true
  end
  
end


return obj