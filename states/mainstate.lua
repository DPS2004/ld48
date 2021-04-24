local st = {}
function st.init()
--  em.init("template",{x=200,y=100})
--  st.guy2 = em.init("template",{x=100,y=100})
--  st.guy2.i = 5
  st.otto = em.init("otto",{x=gameWidth/4, y=gameHeight/4})
  st.canvas = love.graphics.newCanvas(gameWidth/2, gameHeight/2)
  st.ian = em.init("iandialog",{x=0,y=0,text={"boo hahaha","ok sorry i'll go now..."}})
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
  love.graphics.setColor(0.2,0.2,0.2)

  love.graphics.rectangle("fill",0,0,gameWidth,gameHeight)

  love.graphics.setColor(1,1,1)
  
  
  love.graphics.setCanvas(st.canvas)
  love.graphics.clear()
  
  em.draw()
  love.graphics.draw(sprites.mouse,math.floor(mouseX/2),math.floor(mouseY/2))
  
  
  
  love.graphics.setCanvas(shuv.canvas)
  
  
  
  love.graphics.draw(st.canvas,0,0,0,2,2)
  
  st.ian.draw()
  
  love.graphics.draw(sprites.computer.layer1)
  love.graphics.draw(sprites.computer.layer2)

  shuv.finish()
end


return st