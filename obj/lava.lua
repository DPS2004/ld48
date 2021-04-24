local obj = {
  layer = 1,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.lava,
  i=0,
  myshake = 0
}


function obj.update(dt)
  obj.y = obj.y + dt
end


function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()
  love.graphics.setColor(1,0,77/255)
  love.graphics.rectangle("fill",obj.x,obj.y-400+ cs.cy,400,440)
  love.graphics.setColor(1,1,1)
  love.graphics.draw(obj.spr,obj.x+ cs.cx + obj.getshake(),obj.y+ cs.cy + obj.getshake(),0,2,2)
  
end


return obj