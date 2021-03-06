
local obj = {
  layer = -9,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.bg,
  spr2 = sprites.title.base,
  spr3 = sprites.title.blades,
  spr4 = sprites.title.ground,
  i=0,
  myshake = 0
}


function obj.update(dt)
  obj.i = obj.i + dt
  if cs.cy <= 0 then
    obj.y = cs.cy % -960
  else
    obj.y = cs.cy
  end
end

function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end


function obj.draw()

  love.graphics.draw(obj.spr,obj.x+ obj.getshake(),obj.y+ obj.getshake(),0,2,2)
  if obj.y >= 0 then
    love.graphics.draw(obj.spr4,obj.x,obj.y-234,0,2,2)
    love.graphics.draw(obj.spr2,obj.x+ obj.getshake(),obj.y-240+obj.getshake(),0,2,2)
    love.graphics.draw(obj.spr3,obj.x+84+ obj.getshake(),obj.y-240+56+ obj.getshake(),math.rad(obj.i/8+ obj.getshake()),2,2,50,50)
  end
end


return obj