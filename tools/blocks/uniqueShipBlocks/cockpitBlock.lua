local vec2 = require "tools/vec2"

local cockpitBlock= {}

function cockpitBlock:create(x,y)
  
  table.insert(cockpitBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function cockpitBlock:getBlock(index)
  
  return cockpitBlock[index]
  
end

function cockpitBlock:getAllBlocks()
  
  return cockpitBlock
  
end

function cockpitBlock:deleteAllBlocks()
  
  for i, v in ipairs(cockpitBlock) do
    table.remove(cockpitBlock, i)
  end
  
end

return cockpitBlock