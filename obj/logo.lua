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
    "haha drill go brrrrrr",
    "No, I don't have Gunboots. Stop asking.",
    "Drilling with Style",
    "Kid Tested. Mother Approved.",
    "Bedrock is just a suggestion",
    "All your drill are belong to us",
    "Apply directly to the forehead",
    "EIGHT-FOOT VERTICAL LEAP",
    "Who needs volcano insurance?",
    "Up isn't a real direction.",
    "Filled with essential minerals!",
    "Give me drills or give me death",
    "Featuring Drillmin from the Drillmin series",
    "The man who sleeps with a drill is a fool every night but one",
    "99.56% fun!"
  },
  cline = "error!!!!",
  init = false
}


function obj.update(dt)
  if not obj.init then
    obj.init = true
    obj.cline = obj.taglines[love.math.random(1,#obj.taglines)]
  end
end


function obj.draw()
  love.graphics.draw(obj.spr,obj.x,obj.y,0,2,2)
  --love.graphics.setColor(1,0,0)
  for i=-1,1 do
    for j=-1,1 do
      love.graphics.printf(obj.cline,104+i*2,obj.y + 124 + j*2,148,"center",0,2,2)
    end
  end
  love.graphics.setColor(0,0,0)
  love.graphics.printf(obj.cline,104,obj.y + 124,148,"center",0,2,2)
  
  
  
  love.graphics.setColor(1,1,1)

  
end


return obj