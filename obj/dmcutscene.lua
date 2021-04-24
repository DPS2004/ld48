local obj = {
  layer = 10,
  uplayer = 3,
  x=0,
  y=0,
  r=0,
  speed=4,
  anims = {wateringcan = ez.newanim(templates.drillmin.wateringcan), grabdrill =  ez.newanim(templates.drillmin.grabdrill)},
  canim = "wateringcan",
  i=0,
  rockshake = 0,
  myshake = 0,
  spawned = false
}


function obj.update(dt)
  obj.myshake = 0
  
  

  

  
  
  ez.update(obj.anims[obj.canim])
  if obj.anims.grabdrill.f == 20 and not obj.spawned then
    obj.spawned = true
    local new = em.init("dmjump",{x=obj.x+90,y=obj.y+40,r=-90})
    flux.to(new,5,{r=-180,x=new.x-40, y= new.y-40}):ease("linear"):oncomplete(function()
      new.canim = "left"
      flux.to(new,30,{r=-360}):ease("linear")
      
      flux.to(new,30,{x=200}):ease("inoutSine")
      flux.to(cs,30,{cy=cameraheight}):ease("linear")
      
      flux.to(new,15,{y=new.y-40}):ease("outSine"):oncomplete(function() 
        flux.to(new,15,{y=0}):ease("inSine"):oncomplete(function()
          cs.finished = true
          new.delete = true
          print("set cs finished")
          --states.mainstate.init()
        end)
      end)
    end)
  end
end
function obj.getshake()
  return ((0 - (obj.myshake + cs.camera.shake)) + (math.random() * ((obj.myshake + cs.camera.shake) * 2)))
end

function obj.draw()

  ez.draw(obj.anims[obj.canim], obj.x + cs.cx + obj.getshake(), obj.y + cs.cy + obj.getshake(),math.rad(obj.r),2,2)
  
end


return obj