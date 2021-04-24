local obj = {
  layer = 0,
  uplayer = 3,
  x=0,
  y=0,
  r=0,
  speed=4,
  anims = {down = ez.newanim(templates.drillmin.down), left =  ez.newanim(templates.drillmin.left), right =  ez.newanim(templates.drillmin.right)},
  canim = "right",
  i=0,
  rockshake = 0,
  myshake = 0
}


function obj.update(dt)
  obj.myshake = 0
  
  
  
  if obj.x < 20 then
    obj.x = 20
    obj.r = obj.r * -1
  end
  if obj.x > 380 then
    obj.x = 380
    obj.r = obj.r * -1
  end
  for k,v in pairs(obj.anims) do
    ez.update(v)
  end
end
function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()

  ez.draw(obj.anims[obj.canim], obj.x + cs.cx + obj.getshake(), obj.y + cs.cy + obj.getshake(),math.rad(obj.r),2,2,15.5,30)
  
end


return obj