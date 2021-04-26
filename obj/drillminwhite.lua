local obj = {
  layer = 13, --fix maybe?
  uplayer = 99,
  x=0,
  y=0,
  r=0,
  speed=4,
  anims = {down = ez.newanim(templates.drillminwhite.down), left =  ez.newanim(templates.drillminwhite.left), right =  ez.newanim(templates.drillminwhite.right)},
  canim = "down",
  i=0,
  rockshake = 0,
  myshake = 0
}


function obj.update(dt)
  
end


function obj.draw()
  
  obj.canim = obj.dc
  obj.anims[obj.canim].f = obj.da.f
  ez.draw(obj.anims[obj.canim], obj.dx, obj.dy , obj.dr,2,2,15.5,30)
  
end


return obj