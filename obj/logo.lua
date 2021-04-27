local obj = {
  layer = 100,
  uplayer = 3,
  x=0,
  y=0,
  spr = sprites.title.logo,
  i=0,
  taglines = {
    "The Movie: The Video Game",
    "Drill Till U Drop",
    "Drillier than ever",
    "As seen on TV!",
    "oh no my flower",
    "moppin pls dont sue",
    "why is there so much lava?????",
    "Go down, I SAID DOWN!",
    "heck yeah",
    "insert tagline",
    "you know, it's probably a good thing magma doesn't exist",
    "Drills of Future Past",
    "Is your refrigerator running? Good.",
    "Now in cherry flavor",
    "More cowbell!",
    "oh wow haha awesome",
    "Love2d is cool!",
    "haha drill go brrrrrr"
  },
  cline = "error!!!!",
  init = false
}


function obj.update(dt)
  if not obj.init then
    obj.init = true
    obj.cline = obj.taglines[math.random(1,#obj.taglines)]
  end
end


function obj.draw()
  love.graphics.draw(obj.spr,obj.x,obj.y,0,2,2)
  love.graphics.printf(obj.cline,106,obj.y + 122,148,"center",0,2,2)
  love.graphics.printf(obj.cline,102,obj.y + 122,148,"center",0,2,2)
  love.graphics.printf(obj.cline,102,obj.y + 118,148,"center",0,2,2)
  love.graphics.printf(obj.cline,106,obj.y + 118,148,"center",0,2,2)
--  love.graphics.setColor(0,0,0)
--  love.graphics.printf(obj.cline,101,obj.y + 118,148,"center",0,2,2)
--  love.graphics.printf(obj.cline,102,obj.y + 122,148,"center",0,2,2)
--  love.graphics.printf(obj.cline,106,obj.y + 122,148,"center",0,2,2)
--  love.graphics.printf(obj.cline,106,obj.y + 118,148,"center",0,2,2)
  love.graphics.setColor(0,0,0)
  love.graphics.printf(obj.cline,104,obj.y + 120,148,"center",0,2,2)
  
  
  
  love.graphics.setColor(1,1,1)

  
end


return obj