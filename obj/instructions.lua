local obj = {
  layer = 100,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.title.instructions,
  i=0,
  txt = loc.get("introtext")
}


function obj.update(dt)

end


function obj.draw()
  love.graphics.printf(obj.txt,0,obj.y + 200,200,"center",0,2,2)
  
end


return obj