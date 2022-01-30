require "platformer/player"
require "platformer/enemy"
require "UI/UI_main"
require "UI/UI_shop"
require "UI/UI_levelSelector"
require "tools/tileLoader"

ShipLevel = {}

ShipLevel.new = function(levelName, levelSheet)
  
  local s = {}
  
  s.camera          = require "tools/camera"
  s.player          = nil
  s.enemies         = {}
  s.tileLoader      = nil
  s.shopMenu        = nil
  s.levelSelector   = nil
  s.selectedLevel   = nil
  
  s.backgroundBlock  = require "tools/blocks/backgroundBlock"
  s.climbableBlock   = require "tools/blocks/climbableBlock"
  s.collidableBlock  = require "tools/blocks/collidableBlock"
  s.damageableBlock  = require "tools/blocks/damageableBlock"
  s.playerSpawnBlock = require "tools/blocks/playerSpawnBlock"
  s.enemySpawnBlock  = require "tools/blocks/enemySpawnBlock"
  s.treasureBlock    = require "tools/blocks/treasureBlock"
  s.endLevelBlock    = require "tools/blocks/endLevelBlock"
  
  s.cockpitBlock     = require "tools/blocks/uniqueShipBlocks/cockpitBlock"
  s.exitBlock        = require "tools/blocks/uniqueShipBlocks/exitBlock"
  s.shopBlock        = require "tools/blocks/uniqueShipBlocks/shopBlock"
  
  s.levelWon         = false
  s.levelLost        = false
  s.shopActivated    = false
  s.cockpitActivated = false
  
  s.tileLoader = TileLoader.new()
  s.tileLoader:loadMap(s, levelName, levelSheet)
  
  for i, v in ipairs(s.playerSpawnBlock:getAllBlocks()) do
    if v == nil then break end
    s.player = Player.new(v.pos.x, v.pos.y, 32, 32)
  end
  
  for i, v in ipairs(s.enemySpawnBlock:getAllBlocks()) do
    if v == nil then break end
    
    local enemy = Enemy.new(v.pos.x, v.pos.y, v.size.x, v.size.y)
    table.insert(s.enemies, enemy)
    
  end
  
  UI.init(0, 0)
  UI.setHealth(s.player.currentHealth)
  UI.setCoins(coins)
  UI.setGem1(platformerGems)
  
  s.shopMenu = Shop.new()
  s.shopMenu:load()
  
  s.levelSelector = LevelSelector.new()
  s.levelSelector:load()
  
  s.camera.scale.x = 0.75
  s.camera.scale.y = 0.75
  
  setmetatable(s, {__index = ShipLevel})
  return s
  
end

function ShipLevel:update(dt)
  
  self.player:update(self, dt)
  
  if self.player.currentHealth <= 0 then
    self.levelLost = true
  end
  
  for i, v in ipairs(self.enemies) do
    v:update(self, dt)
    
    if v.currentHealth <= 0 then
      table.remove(self.enemies, i)
      coins = coins + 10
    end
  end
  
  UI.update(dt)
  UI.setHealth(self.player.currentHealth)
  UI.setCoins(coins)
  UI.setGem1(platformerGems)
  
  if self.shopActivated == true then
    self.shopMenu:update()
  end
  
  if self.cockpitActivated == true then
    self.levelSelector:update()
  end
  
end

function ShipLevel:draw()
  
  self.camera:set()
  self.tileLoader:drawMap()
  
  for i, v in ipairs(self.enemies) do
    v:draw()
  end
  
  self.player:draw()
  self.camera:unset()
  
  UI.draw()
  
  if self.shopActivated == true then
    self.shopMenu:draw()
  end
  
  if self.cockpitActivated == true then
    self.levelSelector:draw()
  end
  
end

function ShipLevel:endLevel()
  
  self.backgroundBlock:deleteAllBlocks()
  self.climbableBlock:deleteAllBlocks()
  self.collidableBlock:deleteAllBlocks()
  self.damageableBlock:deleteAllBlocks()
  self.playerSpawnBlock:deleteAllBlocks()
  self.enemySpawnBlock:deleteAllBlocks()
  self.treasureBlock:deleteAllBlocks()
  self.endLevelBlock:deleteAllBlocks()
  self.cockpitBlock:deleteAllBlocks()
  self.exitBlock:deleteAllBlocks()
  self.shopBlock:deleteAllBlocks()
  
  for i, v in ipairs(self.enemies) do
    table.remove(self.enemies, i)
  end
  
  return self.selectedLevel
  
end

function ShipLevel:mousePressed(x, y, button, istouch)
  
  self.shopMenu:StateCheck(x, y)
  self.shopMenu:Collision(x, y)
  self.levelSelector:CheckCollision(x, y, self)
  
end

return ShipLevel