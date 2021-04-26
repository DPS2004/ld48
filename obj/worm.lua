
local obj = {
  layer = 13,
  uplayer = 2,
  x=0,
  y=0,
  r=0,
  hp=40,
  length = 2,
  spr = ez.newanim(templates.worm),
  i=0,
  init= false,
  left = true,
  hit = false,
  speed = 3,
  myshake = 0
}




function obj.update(dt)
  
  if not obj.init then
    obj.init = true
  end
  obj.myshake = 0
  obj.i = obj.i + dt
  obj.hit = false
  if helpers.collide({x=cs.player.x, y=cs.player.y, width=0, height=0},{x=obj.x-20,y=obj.y-20,width=60*(obj.length+1),height=40}) then
    obj.hp = obj.hp - 1
    obj.hit = true
    obj.spr.f = 2
  end
  if not obj.hit then
    if obj.left then
      obj.x = obj.x - obj.speed
    else
      obj.x = obj.x + obj.speed
    end
    obj.spr.f = 1
  end
  if obj.hp <= 0 then
    cs.score = cs.score + 5
    cs.scoreflash = true
    obj.delete =true
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
  ez.draw(obj.spr, obj.x+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake()+math.sin(obj.x/10)*5, math.rad(obj.r),2,2,16,16)
  for i=1,obj.length do
    obj.spr.f = 3
    local ox= obj.x+(60*i)
    ez.draw(obj.spr, ox+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake()+math.sin(ox/10)*(5+(i*2)), math.rad(obj.r),2,2,16,16)
  end
  obj.spr.f = 4
  local ox= obj.x+(60*(obj.length+1))
  ez.draw(obj.spr, ox+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake()+math.sin(ox/10)*(5+((obj.length+1)*2)), math.rad(obj.r),2,2,16,16)
end


return obj