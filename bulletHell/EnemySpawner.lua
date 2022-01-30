local EnemySpawner = {}
EnemySpawner.__index = EnemySpawner

local Enemy = require "bulletHell/Enemy"

local EnemySprite1 = love.graphics.newImage("assets/UISprites/EnemyShip(23x15pix).png")

function EnemySpawner.new(EnemyNumber)
  
  local o = setmetatable(o or {}, EnemySpawner)
  
  o.x = 100
  o.y = -50
  o.speed = 0.1
  o.enemyNumber = EnemyNumber
  o.currentSpawn = 0
  o.spawnRate = 10
  o.moveRight = true
  o.enemys = {}
  
  for i = 0, EnemyNumber do
    o.enemys[i] = Enemy.new(love.graphics.getWidth() + 100, love.graphics.getHeight() + 100, 200, EnemySprite1)
  end
  
  return o
end

function EnemySpawner:update(dt)
  
  self:Move(dt)
  
  for i = 0, self.enemyNumber do
    self.enemys[i]:update(dt)
  end

end

function EnemySpawner:draw(debugOn)
  
  if debugOn == true then
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", self.x, self.y, 5, 5)
     love.graphics.setColor(255, 255, 255)
  end
  
  
  for i = 0, self.enemyNumber do
    self.enemys[i]:draw()
  end
  
end

function EnemySpawner:spawn(dt)
  
  if self.spawnRate < 0 then
    if self.currentSpawn > self.enemyNumber then
      self.currentSpawn = 0
    end
    
    self.enemys[self.currentSpawn].x = self.x
    self.enemys[self.currentSpawn].y = self.y
    self.enemys[self.currentSpawn].onScreen = true
    
    
    self.currentSpawn = self.currentSpawn + 1
  
    self.spawnRate = math.ceil(math.random(2, 4))
  else
    self.spawnRate = self.spawnRate - (dt* 10)
  end
end

function EnemySpawner:Move(dt)
  
    if self.x > love.graphics.getWidth() then
      self.moveRight = false
    elseif self.x < 0 then
      self.moveRight = true
    end
    
    if self.moveRight == true then
      self.x = self.x + (math.ceil(math.random(50, 1000)) * dt)
    else
      self.x = self.x - (math.ceil(math.random(50, 1000)) * dt)
    end

end

function EnemySpawner:BulletCollisionCheck(Player, level)
  for i = 0, self.enemyNumber do
    
    for j = 0, self.enemys[i].MaxBullets do
      
    if self:CheckCollision(self.enemys[i].bulletDump[j].x, self.enemys[i].bulletDump[j].y,self.enemys[i].bulletDump[j].width, self.enemys[i].bulletDump[j].height, Player.x, Player.y, Player.width, Player.height) then
      Player.health = Player.health - 1
      self.enemys[i].bulletDump[j].onScreen = false
      self.enemys[i].bulletDump[j].x = 9999
      
      if Player.health <= 0 then
        level.levelLost = true
      else
        sounds.platformerDamaged:play()
      end
    end
    end
  end
  
    for i,v in ipairs(self.enemys) do
    
    for j, w in ipairs(Player.bulletDump) do
      if w.y == nil then break end
      if CheckCollision(v.x, v.y, v.width, v.height, w.x, w.y, w.width,w.height) then
        v.onScreen = false
        v.x = 99999
        sounds.platformerEnemyKilled:play()
        coins = coins + 1
      end

    end
  end
  
  
end


function EnemySpawner:CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function EnemySpawner:Destructor()
  
  for i, v in ipairs (self.enemys) do
    v:Destructor()
    v = nil
  end
end

return EnemySpawner
