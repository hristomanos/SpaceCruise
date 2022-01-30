local vec2 = require "tools/vec2"

local treasureBlock= {}

function treasureBlock:create(x,y)
  
  table.insert(treasureBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0, open = false})
  
end

function treasureBlock:getBlock(index)
  
  return treasureBlock[index]
  
end

function treasureBlock:getAllBlocks()
  
  return treasureBlock
  
end

function treasureBlock:deleteAllBlocks()
  
  for i, v in ipairs(treasureBlock) do
    treasureBlock[i] = nil
  end
  
end

return treasureBlock