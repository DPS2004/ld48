function love.conf(t)
  release = false
  t.externalstorage = true
  gameWidth, gameHeight = 352,198 
  windowWidth, windowHeight = 352, 198
  t.window.usedpiscale = false
  if not release then
    t.console = true
  end
  t.window.width = 352
  t.window.height = 198 
end
