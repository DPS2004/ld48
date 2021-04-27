
local obj = {
  layer = 13,
  uplayer = 2,
  x=0,
  y=0,
  r=0,
  hp=20,
  length = 3,
  spr = ez.newanim(templates.wormsmall),
  i=0,
  init= false,
  left = true,
  hit = false,
  speed = 2,
  myshake = 0
}




function obj.update(dt)
  
  if not obj.init then
    obj.init = true
  end
  obj.myshake = 0
  obj.i = obj.i + dt
  obj.hit = false
  if obj.left then
    if helpers.collide({x=cs.player.x, y=cs.player.y, width=0, height=0},{x=obj.x-16,y=obj.y-16,width=30*(obj.length+1),height=30}) then
      obj.hp = obj.hp - 1
      obj.hit = true
      obj.spr.f = 2
    end
  else
    if helpers.collide({x=cs.player.x, y=cs.player.y, width=0, height=0},{x=obj.x-(30*(obj.length+1)),y=obj.y-16,width=30*(obj.length+1),height=30}) then
      obj.hp = obj.hp - 1
      obj.hit = true
      obj.spr.f = 2
    end
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
    te.play("assets/sounds/destroy.ogg","static")
    cs.score = cs.score + 500
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
  local xscale = 2
  if not obj.left then
    xscale = -2
  end
  ez.draw(obj.spr, obj.x+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake()+math.sin(obj.x/10)*3, math.rad(obj.r),xscale,2,8,8)
  for i=1,obj.length do
    obj.spr.f = 3
    if obj.left then
      local ox= obj.x+(30*i)
      ez.draw(obj.spr, ox+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake()+math.sin(ox/10)*(3+(i*2)), math.rad(obj.r),xscale,2,8,8)
    else
      local ox= obj.x-(30*i)
      ez.draw(obj.spr, ox+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake()+math.sin(ox/10)*(3+(i*2)), math.rad(obj.r),xscale,2,8,8)
    end
  end
  obj.spr.f = 4
  if obj.left then
    local ox= obj.x+(30*(obj.length+1))
    ez.draw(obj.spr, ox+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake()+math.sin(ox/10)*(3+((obj.length+1)*2)), math.rad(obj.r),xscale,2,8,8)
  else
    local ox= obj.x-(30*(obj.length+1))
    ez.draw(obj.spr, ox+cs.cx+obj.getshake(), obj.y+cs.cy+obj.getshake()+math.sin(ox/10)*(3+((obj.length+1)*2)), math.rad(obj.r),xscale,2,8,8)
  end
end


return obj