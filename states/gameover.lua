local st = {}
function st.init()
  entities = {}
  te.stop("bgm")
  te.stop("all")
  te.play("assets/sounds/gameover.ogg","static","bgm",1,1,function(a) te.playLooping("assets/sounds/gameover_loop.ogg","static","bgm") print("done") end)
end




function st.leave()

end


function st.resume()

end


function st.update()
  if maininput:down("accept") then
    cs = bs.load("title")
    cs.init()
    cs.bg.y=240
    cs.border.y=240
    
    
  end
end

function st.getshake()
  local shake = ((0 - st.camera.shake) + (math.random() * (st.camera.shake * 2)))
  return shake
end


function st.draw()

  --push:start()
  shuv.start()
  love.graphics.setColor(0,0,0)

  love.graphics.rectangle("fill",0,0,gameWidth,gameHeight)

  love.graphics.setColor(1,1,1)
  
  em.draw()
  love.graphics.print("game over")

  shuv.finish()

end


return st