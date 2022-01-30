local vec2 = require "tools/vec2"

local shopBlock= {}

function shopBlock:create(x,y)
  
  table.insert(shopBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function shopBlock:getBlock(index)
  
  return shopBlock[index]
  
end

function shopBlock:getAllBlocks()
  
  return shopBlock
  
end

function shopBlock:deleteAllBlocks()
  
  for i, v in ipairs(shopBlock) do
    table.remove(shopBlock, i)
  end
  
end

return shopBlock