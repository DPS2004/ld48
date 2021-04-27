local st = {}
function st.init()
  print("mainstate init")
  st.player = em.init("drillmin",{x=200,y=0})
  st.pwhite = em.init("drillminwhite",{x=200,y=0})
  st.border = em.init("border",{x=0,y=0})
  st.bg = em.init("bg",{x=0,y=0})
  st.lava = em.init("lava",{x=0,y=-200})
  st.score = 0
  st.scoreflash = false
  --spawn some obstacles
  em.init("rock",{x=32,y=300})
  em.init("rock",{x=32+42*1,y=300})
  em.init("rock",{x=32+42*2,y=300})
  em.init("rock",{x=32+42*3,y=300})
  em.init("rock",{x=32+42*4,y=300})
  em.init("rock",{x=32+42*5,y=300})
  em.init("rock",{x=32+42*6,y=300})
  em.init("rock",{x=32+42*7,y=300})
  em.init("rock",{x=32+42*8,y=300})
  --em.init("rock",{x=32+42*9,y=300})


  
  st.camera = {x=0,y=cameraheight,shake=0}
  st.cx = 0
  st.cy = cameraheight
  
  te.playLooping("assets/sounds/ld48.ogg","stream","bgm")
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
    
    flux.update(dt)
    --print("mainstate update")
    em.update(dt)
    
    st.camera.y = cameraheight-st.player.y
    st.cx = st.camera.x
    st.cy = st.camera.y -- TODO: camera shake
    st.border.update(dt)
    st.bg.update(dt)  -- cringe and hacky workaround :)
    
    if st.lose then
      entities = {}
      local savescore = cs.score
      cs = bs.load("gameover")
      cs.init()
      cs.savescore = savescore
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
  love.graphics.setColor(1,1,1)

  love.graphics.rectangle("fill",0,0,gameWidth,gameHeight)

  love.graphics.setColor(1,1,1)
  
  em.draw()
  love.graphics.setColor(0,0,0)
  
  love.graphics.print(st.score,0,2-10,0,2,2)
  love.graphics.print(st.score,4,2-10,0,2,2)
  love.graphics.print(st.score,2,0-10,0,2,2)
  love.graphics.print(st.score,2,4-10,0,2,2)
  if st.scoreflash then
    love.graphics.setColor(1,0,77/255)
    st.scoreflash = false
  else
    love.graphics.setColor(1,1,1)
  end
  love.graphics.print(st.score,2,2-10,0,2,2)

  love.graphics.setColor(1,1,1)
  shuv.finish()

end


return st