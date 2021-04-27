
local obj = {
  layer = 13,
  uplayer = 2,
  x=0,
  y=0,
  r=90,
  hp=40,
  length = 3,
  spr = ez.newanim(templates.worm),
  i=0,
  init= false,
  left = true,
  hit = false,
  speed = 3,
  myshake = 0
  
}




function obj.update(dt)
  --print("wow upworm!")
  if not obj.init then
    obj.init = true
  end
  obj.myshake = 0
  obj.i = obj.i + dt
  obj.hit = false

  if helpers.collide({x=cs.player.x, y=cs.player.y, width=0, height=0},{x=obj.x-20,y=obj.y-20,width=40,height=60*(obj.length+1)}) then
    obj.hp = obj.hp - 1*dt
    obj.hit = true
    obj.spr.f = 2
  end

    
  if not obj.hit then
    obj.y = obj.y - obj.speed*dt
    obj.spr.f = 1
  end
  if obj.hp <= 0 then
    cs.score = cs.score + 500
    cs.scoreflash = true
    obj.delete =true
    te.play("assets/sounds/destroy.ogg","static")
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
  ez.draw(obj.spr, obj.x+cs.cx+obj.getshake() , obj.y+cs.cy+obj.getshake(), math.rad(obj.r),xscale,2,16,16)
  for i=1,obj.length do
    obj.spr.f = 3

    local oy = obj.y+(60*i)
    ez.draw(obj.spr, obj.x + cs.cx+obj.getshake() , oy+ cs.cy+obj.getshake(), math.rad(obj.r),xscale,2,16,16)

  end
  obj.spr.f = 4

  local oy= obj.y+(60*(obj.length+1))
  ez.draw(obj.spr, obj.x + cs.cx+obj.getshake() , oy + cs.cy+obj.getshake(), math.rad(obj.r),xscale,2,16,16)
  --love.graphics.rectangle("line",obj.x-20+ cs.cx,obj.y-20+ cs.cy,40,60*(obj.length+1))
end


return obj