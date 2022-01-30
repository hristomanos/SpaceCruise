local Bullet  = {}
Bullet.__index = Bullet

function Bullet.new(x, y, width, height, isEnemy)
  local o = setmetatable(o or {}, Bullet)
  o.x = x
  o.y = y
  o.width = width
  o.height = height
  o.counter = 1
  o.direction = {}
  o.direction.x = 0
  o.direction.y = 0
  
  o.onScreen = false
  o.isEnemy = isEnemy
  return o
end

function Bullet:update()
  
  if self.onScreen == true then
    local lastX = self.x
    local lastY = self.y
    self.x =  self.x + math.sqrt(self.counter) * math.sin((1 * math.pi) * math.sqrt(self.counter)) 
    self.y =  self.y + math.sqrt(self.counter) * math.cos((1 * math.pi) * math.sqrt(self.counter))

    self.counter = self.counter + 0.1
    
    self.direction.x = self.x - lastX
    self.direction.y = self.y - lastY
    
    if self.counter > 660 then
      self.x = 0
      self.y = 0
    end
    
    --if self.isEnemy == true then
      --self.x = self.x + 0.02
    --else
      --self.y = self.y - 2
    --end
    
    if self.isEnemy == true then
    
      if self.y > love.graphics.getHeight() then
        self.onScreen = false
      elseif self.y < 0 then
        self.onScreen = false
      end
    
  end
end

  
end


function Bullet:draw()
  if self.onScreen == true then
    love.graphics.push()

    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(math.atan2(self.direction.y, self.direction.x))
    love.graphics.rectangle("fill", -self.width/2, -self.height, self.width, self.height)

    love.graphics.pop()
  end
end

function Bullet:move()
  
  self.y =  self.y - 10
  
end


function Bullet:shoot(x,y)
  
  self.x = x
  self.y = y
  
  self.direction.x = 0
  self.direction.y = 0
  
  self.counter = 1
  
  self.onScreen = true
  
end

return Bullet