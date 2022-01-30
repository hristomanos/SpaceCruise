local vec2 = require "tools/vec2"

local playerSpawnBlock= {}

function playerSpawnBlock:create(x,y)
  
  table.insert(playerSpawnBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function playerSpawnBlock:getBlock(index)
  
  return playerSpawnBlock[index]
  
end

function playerSpawnBlock:getAllBlocks()
  
  return playerSpawnBlock
  
end

function playerSpawnBlock:deleteAllBlocks()
  
  for i, v in ipairs(playerSpawnBlock) do
    playerSpawnBlock[i] = nil
  end
  
end

return playerSpawnBlock