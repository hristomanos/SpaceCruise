local Text   = require "UI/Button"

local Spawner = require "bulletHell/EnemySpawner"
local Player = require "bulletHell/Player"
require 'UI/UI_main'
require 'bulletHell/Background'

local BulletHellLevel = {}

function BulletHellLevel:load()
  
  UI.init(0, 0)
  
  Spawner = Spawner.new(500)
  player = Player.new()
  Time = 90
  
  Background.init()
  
  self.levelWon = false
  self.levelLost = false
  
end

function BulletHellLevel:update(dt)
  
--if love.keyboard.isDown("e") then
  Spawner:spawn(dt)
--end

  UI.update(dt)
  Spawner:update(dt)
  
  player:update(dt)
  
  Spawner:BulletCollisionCheck(player, self)
  
  UI.setHealth(player.health)
  
  Time = Time - dt
  
  UI.setCoins(coins)
  
  Background.update(dt)
  
  if Time <= 0 then
    self.levelWon = true
  end
  
end

function BulletHellLevel:draw()
  
  Background.draw()
  
  player:draw()

  UI.draw()

  Spawner:draw(true)
  
  love.graphics.print(math.ceil(Time), Width / 2, 0)
  
end

function BulletHellLevel:CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end


function BulletHellLevel:endLevel()
  
  player:Destructor()
  Spawner:Destructor()
  
  return "shipLevel"
  
end

return BulletHellLevel