local Player = {}
Player.__index = Player

local SpriteMaker = require ("tools/SpriteMaker")
local Bullet      = require ("bulletHell/Bullet")

function Player.new()
  
  local o = setmetatable(o or {}, Player)
  o.x = love.graphics.getWidth()  / 2
  o.y = love.graphics.getHeight() / 2
  o.width = 23
  o.height = 32
  o.sprite = SpriteMaker.new(love.graphics.newImage("assets/UISprites/SpaceShip.png"), o.width, o.height, 1, 3)
  o.speed = 200 
  o.bulletDump = {}
  
  o.MaxBullets = 100
  o.shotCooldown = 5
  o.bulletShooter = 1
  
  o.maxHealth = BulletHellMaxHealth
  o.health = o.maxHealth
  o.score  = 0
  
  o.bulletDelay = 20
  
  for i = 0, o.MaxBullets do
    o.bulletDump[i] = Bullet.new(x, y, 5, 5, false)
  end
  
  
  return o
end

function Player:update(dt)
  
  if love.keyboard.isDown("up") then
    self.y = self.y - (self.speed * dt)
  elseif love.keyboard.isDown("down") then
    self.y = self.y + (self.speed * dt)
  end
  
  if love.keyboard.isDown("left") then
    self.x = self.x - (self.speed * dt)
    self.sprite:FrameSet(0)
  elseif love.keyboard.isDown("right") then
    self.x = self.x + (self.speed * dt)
    self.sprite:FrameSet(2)
  else
    self.sprite:FrameSet(1)
  end
  
  self.shotCooldown = self.shotCooldown - (dt * 10)
  
  if love.keyboard.isDown("x") then
    if self.shotCooldown < 0 then
      self:shoot()
      self.shotCooldown = 0
    end
  end
  
    
    for i, v in ipairs(self.bulletDump) do
      if v.y == nil then break end
      
      --v:update()
      v:move()
    end
  
  if self.health <= 0 then
    self.x = 9999
  end
  
  if self.x + self.width >= Width then
    self.x = Width - self.width
  elseif self.x <= 0 then
    self.x = 0
  end
  
  if self.y + self.height >= Height then
    self.y = Height - self.height
  elseif self.y <= 0 then
    self.y = 0
  end
  
  self.bulletDelay = self.bulletDelay - 1
  
end

function Player:draw()
  self.sprite:draw(self.x, self.y)
  
  for i = 0, self.MaxBullets do
    self.bulletDump[i]:draw()
  end
  
end


function Player:shoot()
  if self.bulletShooter >= self.MaxBullets then
    self.bulletShooter = 1
  
  elseif self.bulletDelay <= 0 then
    self.bulletDump[self.bulletShooter]:shoot(self.x + (self.width / 2), self.y)
    self.bulletShooter = self.bulletShooter + 1
    self.bulletDelay = 20
    sounds.platformerBulletFire:play()
  end
  
end



function Player:CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function Player:Destructor()
  
  for i, v in ipairs(self.bulletDump) do
    v = nil
    --self.sprite:Destructor()
  end
  
end


return Player