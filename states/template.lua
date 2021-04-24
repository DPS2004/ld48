local st = {}
function st.init()
  em.init("template",{x=4,y=4})
  st.guy2 = em.init("template",{x=128,y=128})
  st.guy2.i = 5
end

function st.enter(prev)

end


function st.leave()

end


function st.resume()

end


function st.update()
  if not paused then

    -- do things here
    flux.update(1)
    em.update(dt)
  end
end


function st.draw()
  --push:start()
  shuv.start()
  love.graphics.setColor(0.5,0.5,0.5)

  love.graphics.rectangle("fill",0,0,gameWidth,gameHeight)

  love.graphics.setColor(1,1,1)
  em.draw()

  shuv.finish()
end


return st