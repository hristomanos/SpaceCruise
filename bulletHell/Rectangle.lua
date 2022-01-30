local ShapeClass = require "Shape"

local Rectangle = setmetatable({}, ShapeClass)
Rectangle.__index = Rectangle

function Rectangle.new(x, y, width, height)
local o = setmetatable(o or ShapeClass.new(x*2, y*2, width*2, height*2), Rectangle)

return o
end

function Rectangle:draw()
   love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

return Rectangle