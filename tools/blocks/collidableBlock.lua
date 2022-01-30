local vec2 = require "tools/vec2"

local collidableBlock = {}

function collidableBlock:create(x,y)
  
  table.insert(collidableBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function collidableBlock:getBlock(index)
  
  return collidableBlock[index]
  
end

function collidableBlock:getAllBlocks()
  
  return collidableBlock
  
end

function collidableBlock:deleteAllBlocks()
  
  for i, v in ipairs(collidableBlock) do
    collidableBlock[i] = nil
  end
  
end

return collidableBlock