local st = {}
function st.init()
  entities = {}
  te.stop("bgm")
  te.stop("all")
  te.play("assets/sounds/gameover.ogg","stream","bgm",1,1,function(a) te.playLooping("assets/sounds/gameover_loop.ogg","stream","bgm") print("done") end)
  st.savescore = 69
  st.name = "gyrodebug"
end




function st.leave()

end


function st.resume()

end


function st.update()
  if maininput:pressed("accept") or (ismobile and maininput:pressed("touch"))then
    cs = bs.load("title")
    cs.init()
    cs.bg.y=240
    cs.border.y=240
    
    
  end
  st.joycount = love.joystick.getJoystickCount()
  if st.joycount ~= 0 then
    st.joysticks = love.joystick.getJoysticks()
    st.joystick = st.joysticks[1]
    st.numaxis = st.joystick:getAxisCount()
    st.axes = {}
    for i = 1, st.numaxis do
      st.axes[i] = st.joystick:getAxis(i)
    end
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
  love.graphics.printf("gyro debug screen!!!!!!",0,0,400,"center",0,1,1)
  love.graphics.printf("Joysticks connected: "..st.joycount,0,10,400,"center",0,1,1)
  if st.joycount == 0 then
    love.graphics.printf("no gyro for you :(",0,20,400,"center",0,1,1)
  else
    love.graphics.printf(st.numaxis .. " axes found :)",0,20,400,"center",0,1,1)
    for i,v in ipairs(st.axes) do
      love.graphics.printf("Axis " .. i .. ": " .. v,0,20+i*10,400,"left",0,1,1)
      love.graphics.draw(sprites.arrow,200,20+64*i,math.rad(v*90),1,1,32,32)
    end
  end

  shuv.finish()

end


return st