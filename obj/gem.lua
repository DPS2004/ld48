
local obj = {
  layer = -1,
  uplayer = 2,
  x=0,
  y=0,
  r=0,
  hp=40,
  spr = sprites.gem,
  i=0,
  init= false,
  myshake = 0
}




function obj.update(dt)
  
  if not obj.init then
    
    obj.init = true
  end
  obj.myshake = 0
  obj.i = obj.i + dt
  
  if helpers.collide({x=cs.player.x, y=cs.player.y, width=0, height=0},{x=obj.x-20,y=obj.y-15,width=40,height=30}) then
    --print("hit!")
    obj.hp = obj.hp - 1*dt
  end
  if obj.hp <= 0 then
    obj.delete = true
    te.play("assets/sounds/destroy.ogg","static","sfx")
    cs.score = cs.score + 1000
    cs.scoreflash = true
    em.init("particle",{x=obj.x-9,y=obj.y-9,angle=helpers.anglepoints(obj.x-9,obj.y-9,cs.player.x,cs.player.y)})
    em.init("particle",{x=obj.x-9,y=obj.y+9,angle=helpers.anglepoints(obj.x-9,obj.y+9,cs.player.x,cs.player.y)})
    em.init("particle",{x=obj.x+9,y=obj.y-9,angle=helpers.anglepoints(obj.x+9,obj.y+9,cs.player.x,cs.player.y)})
    em.init("particle",{x=obj.x+9,y=obj.y+9,angle=helpers.anglepoints(obj.x+9,obj.y-9,cs.player.x,cs.player.y)})

  end

end

function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()
  love.graphics.draw(obj.spr, obj.x+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake(), math.rad(obj.r+math.sin(obj.i/5)*2+obj.getshake()),2,2,12.5,12)
  
end


return obj