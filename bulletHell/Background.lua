local SpriteMaker = require 'tools/SpriteMaker'
require 'UI/GenratedMovement'

Background = {}

astroids = {field, location, number}
sprite = {}
planet = {sprite, location}

astroids.field = {}
astroids.location = {}
astroids.number = 0


function Background.init()
  
  sprite.astroid = love.graphics.newImage("assets/UISprites/astroid1 Sheet (18x18Pix).png")
  
  sprite.planet  = love.graphics.newImage("assets/UISprites/Planet2.png")

  sprite.background = love.graphics.newImage("assets/UISprites/staryBackground.png")
  
  backgroundMovement = GenratedMovement.SetMove(0, -1080, 0, 0)


for i = 0, astroids.number do
  
    astroids.field[i]     =  SpriteMaker.new(sprite.astroid, 18, 18, 1, 7)
    
    astroids.location[i]  =  GenratedMovement.SetMove(math.random(0 - (i*astroids.number)) , math.random(love.graphics.getHeight()) , love.graphics.getWidth() * 2, math.random(love.graphics.getHeight()) )
    
end

planet.sprite = SpriteMaker.new(sprite.planet, 320, 320, 1, 2)

planet.sprite:FrameSet(0)

planet.location = GenratedMovement.SetMove(love.graphics.getWidth()/2, -320, love.graphics.getWidth()/2, love.graphics.getHeight() + 320)


    
end


function Background.draw()
  


  love.graphics.draw(sprite.background, GenratedMovement.getX(backgroundMovement), GenratedMovement.getY(backgroundMovement))
  
  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill',0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(255,255,255, 255)
  
  
  planet.sprite:draw(GenratedMovement.getX(planet.location), GenratedMovement.getY(planet.location))
  
  love.graphics.setColor(0,0,0, 100)
  love.graphics.rectangle('fill',0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(255,255,255, 255)

    
  for i = 0, astroids.number do
    
    astroids.field[i]:draw(GenratedMovement.getX(astroids.location[i]) , GenratedMovement.getY(astroids.location[i]) )
  
  end

  love.graphics.setColor(0,0,0, 100)
  
  love.graphics.rectangle('fill',0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  
  love.graphics.setColor(255,255,255, 255)



end
function Background.update(dt)
  
  for i = 0, astroids.number do
  astroids.field[i]:update(dt, 10)
  astroids.location[i] = GenratedMovement.UpdateLocation(astroids.location[i], dt, 0.1)
  
  if GenratedMovement.getX(astroids.location[i]) > love.graphics.getWidth() then
    
    GenratedMovement.Teleport(astroids.location[i], math.random(0 - (i*astroids.number)) , math.random(love.graphics.getHeight()))
    
  end
  
  planet.location = GenratedMovement.UpdateLocation(planet.location, dt, 0.01)
  
  end
  if GenratedMovement.getY(planet.location) > love.graphics.getHeight()  then
    GenratedMovement.Teleport(planet.location, love.graphics.getWidth()/2, -320)
  end
  


  backgroundMovement = GenratedMovement.UpdateLocation(backgroundMovement, dt, 0.0001)
  
  
  
  
end
  
  
  
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end