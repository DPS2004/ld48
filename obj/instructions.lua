local obj = {
  layer = 100,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.title.instructions,
  i=0,
  txt = loc.get("introtext"),
  play = loc.get("play"),
  options = loc.get("options")
}


function obj.update(dt)

end


function obj.draw()
  if not ismobile then
    love.graphics.printf(obj.txt,0,obj.y + 200,200,"center",0,2,2)
  else
    love.graphics.printf(obj.options,133,obj.y + 202,200,"center",0,2,2)
    love.graphics.setLineWidth(2)
    love.graphics.line(267,obj.y+204,obj.y+267,242)
    love.graphics.printf(obj.play,0,obj.y + 202,133,"center",0,2,2)
  end
  
end


return obj