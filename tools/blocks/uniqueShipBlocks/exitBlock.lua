local vec2 = require "tools/vec2"

local exitBlock= {}

function exitBlock:create(x,y)
  
  table.insert(exitBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function exitBlock:getBlock(index)
  
  return exitBlock[index]
  
end

function exitBlock:getAllBlocks()
  
  return exitBlock
  
end

function exitBlock:deleteAllBlocks()
  
  for i, v in ipairs(exitBlock) do
    table.remove(exitBlock, i)
  end
  
end

return exitBlock