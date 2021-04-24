local st = {}
function st.init()
  st.player = em.init("drillmin",{x=100,y=100})
  st.border = em.init("border",{x=0,y=0})
  st.bg = em.init("bg",{x=0,y=0})
  
  
  st.rock = em.init("rock",{x=100,y=400})
  
  st.camera = {x=0,y=0,shake=0}
  st.cx = 0
  st.cy = 0
end

function st.enter(prev)

end


function st.leave()

end


function st.resume()

end


function st.update()

  st.camera.shake = 0
  if not paused then
    
    flux.update(1)
    em.update(dt)
    
    st.camera.y = 64-st.player.y
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