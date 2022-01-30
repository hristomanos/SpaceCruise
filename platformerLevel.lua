require "platformer/player"
require "platformer/enemy"
require "UI/UI_main"
require "tools/tileLoader"

PlatformerLevel = {}

PlatformerLevel.new = function(levelName, levelSheet)
  
  local p = {}
  
  p.camera           = require "tools/camera"
  p.player           = nil
  p.enemies          = {}
  p.tileLoader       = nil
  
  p.backgroundBlock  = require "tools/blocks/backgroundBlock"
  p.climbableBlock   = require "tools/blocks/climbableBlock"
  p.collidableBlock  = require "tools/blocks/collidableBlock"
  p.damageableBlock  = require "tools/blocks/damageableBlock"
  p.playerSpawnBlock = require "tools/blocks/playerSpawnBlock"
  p.enemySpawnBlock  = require "tools/blocks/enemySpawnBlock"
  p.treasureBlock    = require "tools/blocks/treasureBlock"
  p.endLevelBlock    = require "tools/blocks/endLevelBlock"
  
  p.cockpitBlock     = require "tools/blocks/uniqueShipBlocks/cockpitBlock"
  p.exitBlock        = require "tools/blocks/uniqueShipBlocks/exitBlock"
  p.shopBlock        = require "tools/blocks/uniqueShipBlocks/shopBlock"
  
  p.levelWon         = false
  p.levelLost        = false
  
  p.tileLoader = TileLoader.new()
  p.tileLoader:loadMap(p, levelName, levelSheet)
  
  for i, v in ipairs(p.playerSpawnBlock:getAllBlocks()) do
    if v == nil then break end
    p.player = Player.new(v.pos.x, v.pos.y, 32, 32)
  end
  
  for i, v in ipairs(p.enemySpawnBlock:getAllBlocks()) do
    if v == nil then break end
    
    local enemy = Enemy.new(v.pos.x, v.pos.y, v.size.x, v.size.y)
    table.insert(p.enemies, enemy)
    
  end
  
  UI.init(0, 0)
  UI.setHealth(p.player.currentHealth)
  UI.setCoins(coins)
  UI.setGem1(platformerGems)
  
  p.camera.scale.x = 0.75
  p.camera.scale.y = 0.75
  
  setmetatable(p, {__index = PlatformerLevel})
  return p
  
end

function PlatformerLevel:update(dt)
  
  self.player:update(self, dt)
  
  if self.player.currentHealth <= 0 then
    self.levelLost = true
  end
  
  for i, v in ipairs(self.enemies) do
    v:update(self, dt)
    
    if v.currentHealth <= 0 then
      table.remove(self.enemies, i)
      coins = coins + 10
      sounds.platformerEnemyKilled:play()
    end
  end
  
  UI.update(dt)
  UI.setHealth(self.player.currentHealth)
  UI.setCoins(coins)
  UI.setGem1(platformerGems)
  
end

function PlatformerLevel:draw()
  
  self.camera:set()
  self.tileLoader:drawMap()
  
  for i, v in ipairs(self.enemies) do
    v:draw()
  end
  --print(#self.enemies)
  
  self.player:draw()
  self.camera:unset()
  
  UI.draw()
  
end

function PlatformerLevel:endLevel()
  
  self.climbableBlock:deleteAllBlocks()
  self.collidableBlock:deleteAllBlocks()
  self.damageableBlock:deleteAllBlocks()
  self.playerSpawnBlock:deleteAllBlocks()
  self.enemySpawnBlock:deleteAllBlocks()
  print(#self.enemySpawnBlock:getAllBlocks())
  self.treasureBlock:deleteAllBlocks()
  self.endLevelBlock:deleteAllBlocks()
  self.cockpitBlock:deleteAllBlocks()
  self.exitBlock:deleteAllBlocks()
  self.shopBlock:deleteAllBlocks()
  
  for i, v in ipairs(self.enemies) do
    table.remove(self.enemies, i)
  end
  
  return "shipLevel"
  
end

return PlatformerLevel