
local SpriteMaker = {}
SpriteMaker.__index = SpriteMaker

--SpriteMaker = {storage, spriteSheet, arraySize, dt, anim}


function SpriteMaker.new(spriteSheet, width, height, numOfCollumns, numOfRows)
  
  local o = setmetatable(o or {}, SpriteMaker)
  
  o.dt = 0
  o.anim = 0
  
  o.storage = {}
  
  o.spriteSheet = spriteSheet
  
  o._counter = 0
  
  o.arraySize = numOfCollumns*numOfRows
  
  for i = 0, numOfCollumns do
    
    for j = 0, numOfRows do
      
      o.storage[o._counter] = love.graphics.newQuad(width*j, height*i, width, height, o.spriteSheet:getDimensions())
      
      o._counter = o._counter + 1
      
    end
    
  end
  
      return o
  
end




function SpriteMaker:draw(x, y)
  
  love.graphics.draw(self.spriteSheet, self.storage[self.anim], x,y)
  
end


function SpriteMaker:update(dt, animSpeed)
  
  self.dt = self.dt + (dt *animSpeed)
  
  if self.dt >= self.arraySize then
    self.dt = 0 
  end
  
  self.anim = math.floor(self.dt)
  

end


function SpriteMaker:FrameSet(setFrame)
  
  if setFrame >= self.arraySize then
    
    self.anim = self.arraySize
    
  else
    
    self.anim = setFrame
  
  end
  
  
end

return SpriteMaker