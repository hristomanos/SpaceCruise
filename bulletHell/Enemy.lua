
local SpriteMaker = require ("tools/SpriteMaker")
local Bullet      = require ("bulletHell/Bullet")

local Enemy = {}
Enemy.__index = Enemy


function Enemy.new(x, y, speed, sprite)
  
  local o = setmetatable(o or {}, Enemy)
  
  o.x = x
  o.y = y
  o.width = 23
  o.height = 15
  o.speed  = speed
  o.sprite =  SpriteMaker.new(sprite, o.width, o.height, 1, 3)
  o.onScreen = true
  o.bulletDump = {}
  o.MaxBullets = 20
  o.shotCooldown = 0
  
  for i = 0, o.MaxBullets do
    o.bulletDump[i] = Bullet.new(x, y, 5, 5, true)
  end
  

  o.bulletShooter = 5
  
  return o
  
end

function Enemy:update(dt)
  if self.onScreen == true then
    self:moveDown(dt)
    if self.y > love.graphics.getHeight() then
      self.onScreen = false
    end
    
    if self.shotCooldown > 0 then
      self.shotCooldown = self.shotCooldown - (dt * 10)
    else
      self:shoot()
      self.shotCooldown = math.ceil(10)
    end
    
    for i = 0, self.MaxBullets do
      self.bulletDump[i]:update()
    end
    
    
    
  end
  
  if self.bulletShooter > 0 then
      for i = 0, self.MaxBullets do
        self.bulletDump[i]:update()
      end
  end
end

function Enemy:draw()
if self.onScreen == true then
  self.sprite:draw(self.x, self.y)
end

  if self.MaxBullets > 0 then
    love.graphics.setColor(255, 0, 0)
      for i = 0, self.MaxBullets do
        self.bulletDump[i]:draw()
      end
    love.graphics.setColor(255, 255, 255)
  end
end

function Enemy:moveDown(dt)
  
  self.y = self.y + (self.speed * dt)
  
end

function Enemy:shoot()
  if self.bulletShooter > self.MaxBullets then
    self.bulletShooter = 0
  end
  
  if self.bulletDump[self.bulletShooter].onScreen == false then
    self.bulletDump[self.bulletShooter]:shoot(self.x + (self.width / 2), self.y)
    self.bulletShooter = self.bulletShooter + 1
  end
  
end


function Enemy:Destructor()
  
  for i, v in ipairs (self.bulletDump) do
    v = nil
  end
  
  
end


return Enemy