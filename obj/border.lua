local obj = {
  layer = 1,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.border,
  i=0
}


function obj.update(dt)
  obj.i = obj.i + dt
  if cs.cy <= 0 then
    obj.y = cs.cy % -240
  else
    obj.y = cs.cy
  end
end


function obj.draw()
  love.graphics.draw(obj.spr,obj.x,obj.y,0,2,2)
  if tatemode then
    love.graphics.draw(obj.spr,obj.x,obj.y+480,0,2,2)
  end
  
end


return obj