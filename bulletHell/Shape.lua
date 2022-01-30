local ShapeClass  = {}
ShapeClass.__index = ShapeClass

function ShapeClass.new(x, y, width, height)
  local o = setmetatable(o or {}, ShapeClass)
  o.x = x
  o.y = y
  o.width = width
  o.height = height
  return o
end

function ShapeClass:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end


return ShapeClass


--local ParentClass = {}
--ParentClass.__index = ParentClass

--function ParentClass.new(o)
--  local o = setmetatable(o or {}, ParentClass)

--  return o
--end