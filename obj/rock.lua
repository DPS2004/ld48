local obj = {
  layer = -1,
  uplayer = 2,
  x=0,
  y=0,
  r=0,
  hp=20,
  spr = sprites.rock,
  i=0,
  myshake = 0
}


function obj.update(dt)
  obj.myshake = 0
  obj.i = obj.i + dt
  
  if helpers.collide({x=cs.player.x, y=cs.player.y, width=0, height=0},{x=obj.x-20,y=obj.y-20,width=40,height=40}) then
    obj.hp = obj.hp - 1
  end
  if obj.hp <= 0 then
    obj.delete =true
    
  end

end

function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()
  love.graphics.draw(obj.spr, obj.x+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake(), math.rad(obj.r),2,2,12,12)
  
end


return obj