local st = {}
function st.init()
  print("mainstate init")
  st.player = em.init("drillmin",{x=200,y=0})
  st.border = em.init("border",{x=0,y=0})
  st.bg = em.init("bg",{x=0,y=0})
  st.lava = em.init("lava",{x=0,y=-200})
  
  
  st.rock = em.init("rock",{x=100,y=400})
  st.rock2 = em.init("rock",{x=100,y=440})
  st.rock3 = em.init("rock",{x=140,y=440})
  
  st.camera = {x=0,y=cameraheight,shake=0}
  st.cx = 0
  st.cy = cameraheight
end




function st.leave()

end


function st.resume()

end


function st.update()
  if not st.player then
    print("could not find player")
    st.enter()
  end

  --st.camera.shake = 0
  if not paused then
    
    flux.update(1)
    --print("mainstate update")
    em.update(dt)
    
    st.camera.y = cameraheight-st.player.y
    st.cx = st.camera.x
    st.cy = st.camera.y -- TODO: camera shake
    st.border.update(1)
    st.bg.update(1)  -- cringe and hacky workaround :)
  end
end

function st.getshake()
  local shake = ((0 - st.camera.shake) + (math.random() * (st.camera.shake * 2)))
  return shake
end


function st.draw()

  --push:start()
  shuv.start()
  love.graphics.setColor(1,1,1)

  love.graphics.rectangle("fill",0,0,gameWidth,gameHeight)

  love.graphics.setColor(1,1,1)
  
  em.draw()


  shuv.finish()

end


return st