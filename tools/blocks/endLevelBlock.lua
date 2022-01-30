local vec2 = require "tools/vec2"

local endLevelBlock= {}

function endLevelBlock:create(x,y)
  
  table.insert(endLevelBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function endLevelBlock:getBlock(index)
  
  return endLevelBlock[index]
  
end

function endLevelBlock:getAllBlocks()
  
  return endLevelBlock
  
end

function endLevelBlock:deleteAllBlocks()
  
  for i, v in ipairs(endLevelBlock) do
    endLevelBlock[i] = nil
  end
  
end

return endLevelBlock