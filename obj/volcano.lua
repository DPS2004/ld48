local obj = {
  layer = 10,
  uplayer = 3,
  x=0,
  y=0,
  r=0,
  speed=4,
  anims = {idle = ez.newanim(templates.volcano.idle), erupt =  ez.newanim(templates.volcano.erupt)},
  canim = "idle",
  i=0,
  rockshake = 0,
  myshake = 0
}


function obj.update(dt)
  obj.myshake = 0
  
  

  

  
  
  ez.update(obj.anims[obj.canim])
end
function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()

  ez.draw(obj.anims[obj.canim], obj.x + cs.cx + obj.getshake(), obj.y + cs.cy + obj.getshake(),math.rad(obj.r),2,2)
  
end


return obj