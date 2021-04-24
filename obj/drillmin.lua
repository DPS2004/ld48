local obj = {
  layer = 0,
  uplayer = 3,
  x=0,
  y=0,
  r=0,
  anim = ez.newanim(templates.drillmin),
  i=0
}


function obj.update(dt)
  
  
  if maininput:down("left") then
    obj.r = obj.r - 2
  end
  if maininput:down("right") then
    obj.r = obj.r + 2
  end
  local rret = helpers.rotate(-4*dt,obj.r,obj.x,obj.y)
  obj.x = rret[1]
  obj.y = rret[2]
  
  if obj.x < 20 then
    obj.x = 20
    obj.r = obj.r * -1
  end
  if obj.x > 380 then
    obj.x = 380
    obj.r = obj.r * -1
  end
  
  ez.update(obj.anim)
end


function obj.draw()
  ez.draw(obj.anim,obj.x+cs.cx,obj.y+cs.cy,math.rad(obj.r),2,2,15.5,30)
  
end


return obj