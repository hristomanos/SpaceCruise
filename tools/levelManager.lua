require "platformerLevel"
require "shipLevel"

local LevelManager = {}

local bulletHell = require "bulletHellLevel"
local platformer = nil
local shipLevel  = nil

function LevelManager:load()
  
  self.levelWon = false
  self.levelLost = false
  
  if currentLevel == "Level1" then
    
    sounds.currentMusic = sounds.platformerMusic
    platformer = PlatformerLevel.new("Level1", "TileSheetv4")
    
  elseif currentLevel == "Level3" then
    
    sounds.currentMusic = sounds.platformerMusic
    platformer = PlatformerLevel.new("Level3", "TileSheetv4")
    
  elseif currentLevel == "Level4" then
    
    sounds.currentMusic = sounds.platformerMusic
    platformer = PlatformerLevel.new("Level4", "TileSheetv4")
    
  elseif currentLevel == "Level2" then
    
    sounds.currentMusic = sounds.platformerMusic
    bulletHell:load()
    
  elseif currentLevel == "shipLevel" then
    
    sounds.currentMusic = sounds.shipMusic
    shipLevel = ShipLevel.new("shipTileMap", "TileSheetv4")
    
  end
  
end

function LevelManager:update(dt)
  
  if currentLevel == "Level1" or currentLevel == "Level3" or currentLevel == "Level4" then
    
    platformer:update(dt)
    self.levelWon = platformer.levelWon
    self.levelLost = platformer.levelLost
    
  elseif currentLevel == "Level2" then
    
    bulletHell:update(dt)
    self.levelWon = bulletHell.levelWon
    self.levelLost = bulletHell.levelLost
    
  elseif currentLevel == "shipLevel" then
    shipLevel:update(dt)
    self.levelWon = shipLevel.levelWon
    self.levelLost = shipLevel.levelLost
  end
  
end

function LevelManager:draw()
  
  if currentLevel == "Level1" or currentLevel == "Level3" or currentLevel == "Level4" then
    
    platformer:draw()
    
  elseif currentLevel == "Level2" then
    
    bulletHell:draw()
    
  elseif currentLevel == "shipLevel" then
    
    shipLevel:draw()
    
  end
  
end

function LevelManager:endLevel()
  
  if currentLevel == "Level1" or currentLevel == "Level3" or currentLevel == "Level4" then
    
    return platformer:endLevel()
    
  elseif currentLevel == "Level2" then
    
    return bulletHell:endLevel()
    
  elseif currentLevel == "shipLevel" then
    
    return shipLevel:endLevel()
    
  end
  
end

function LevelManager:mousePressed(x, y, button, istouch)
  
  if currentLevel == "shipLevel" then
    shipLevel:mousePressed(x, y, button, istouch)
  end
  
end

return LevelManager