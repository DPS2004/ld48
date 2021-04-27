local obj = {
  layer = 100,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.title.instructions,
  i=0
}


function obj.update(dt)

end


function obj.draw()
  love.graphics.draw(obj.spr,obj.x,obj.y,0,2,2)
  
end


return obj