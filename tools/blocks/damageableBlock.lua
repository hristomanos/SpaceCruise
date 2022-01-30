local vec2 = require "tools/vec2"

local damageableBlock= {}

function damageableBlock:create(x,y)
  
  table.insert(damageableBlock, {pos = vec2:new(x, y), size = vec2:new(32, 32), xSpeed = 0, ySpeed = 0})
  
end

function damageableBlock:getBlock(index)
  
  return damageableBlock[index]
  
end

function damageableBlock:getAllBlocks()
  
  return damageableBlock
  
end

function damageableBlock:deleteAllBlocks()
  
  for i, v in ipairs(damageableBlock) do
    damageableBlock[i] = nil
  end
  
end

return damageableBlock