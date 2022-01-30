local vec2 = require "tools/vec2"

local backgroundBlock = {}

function backgroundBlock:create(x,y)
  
  table.insert(backgroundBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function backgroundBlock:getBlock(index)
  
  return backgroundBlock[index]
  
end

function backgroundBlock:getAllBlocks()
  
  return backgroundBlock
  
end

function backgroundBlock:deleteAllBlocks()
  
  for i, v in ipairs(backgroundBlock) do
    backgroundBlock[i] = nil
    
  end
  
end

return backgroundBlock