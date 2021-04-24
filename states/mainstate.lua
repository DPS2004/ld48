local st = {}
function st.init()
  st.player = em.init("drillmin",{x=100,y=100})
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
  if not paused then
    st.cx = st.camera.x
    st.cy = st.camera.y -- TODO: camera shake
    flux.update(1)
    em.update(dt)
  end
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