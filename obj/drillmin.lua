local obj = {
  layer = 1,
  uplayer = 3,
  x=0,
  y=0,
  r=0,
  anim = ez.newanim(templates.drillmin),
  i=0
}


function obj.update(dt)
  ez.update(obj.anim)
  obj.r = obj.r + dt
end


function obj.draw()
  ez.draw(obj.anim,obj.x,obj.y,math.rad(obj.r),2,2,15.5,42)
  
end


return obj