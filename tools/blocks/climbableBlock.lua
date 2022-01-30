local vec2 = require "tools/vec2"

local climbableBlock = {}

function climbableBlock:create(x,y)
  
  table.insert(climbableBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function climbableBlock:getBlock(index)
  
  return climbableBlock[index]
  
end

function climbableBlock:getAllBlocks()
  
  return climbableBlock
  
end

function climbableBlock:deleteAllBlocks()
  
  for i, v in ipairs(climbableBlock) do
    climbableBlock[i] = nil
  end
  
end

return climbableBlock