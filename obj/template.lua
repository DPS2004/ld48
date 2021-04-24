local obj = {
  layer = 1,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.templateguy,
  i=0
}


function obj.update(dt)
  obj.i = obj.i + dt
  obj.x = obj.x + math.sin(obj.i/10)
  obj.y = obj.y + math.cos(obj.i/10)
end


function obj.draw()
  love.graphics.draw(obj.spr,obj.x-16,obj.y-16)
  
end


return obj