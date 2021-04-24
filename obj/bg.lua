
local obj = {
  layer = -9,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.bg,
  i=0
}


function obj.update(dt)
  obj.i = obj.i + dt
  obj.y = cs.cy % -960
end


function obj.draw()
  love.graphics.draw(obj.spr,obj.x,obj.y,0,2,2)
  
end


return obj