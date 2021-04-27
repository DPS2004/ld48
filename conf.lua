function love.conf(t)
  release = false
  t.externalstorage = true
  gameWidth, gameHeight = 400,240 
  windowWidth, windowHeight = 800, 480
  t.window.usedpiscale = false
  if not release then
    t.console = true
  end
  t.window.width = 400
  t.window.height = 240
end
