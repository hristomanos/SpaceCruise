local vec2 = require "tools/vec2"

local enemySpawnBlock= {}

function enemySpawnBlock:create(x,y)
  
  table.insert(enemySpawnBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function enemySpawnBlock:getBlock(index)
  
  return enemySpawnBlock[index]
  
end

function enemySpawnBlock:getAllBlocks()
  
  return enemySpawnBlock
  
end

function enemySpawnBlock:deleteAllBlocks()
  
  for i, v in ipairs(enemySpawnBlock) do
    enemySpawnBlock[i] = nil
  end
  
end

return enemySpawnBlock