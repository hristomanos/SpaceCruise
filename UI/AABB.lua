local AABB = {}

local function fixXY(x, y)
    if x < 0 then
        x = love.graphics.getWidth() + x
    end

    if y < 0 then
        y = love.graphics.getHeight() + y
    end

    return x, y
end

function AABB.create(x, y, width, height)
    local self = {}

    self.x, self.y = fixXY(x, y)
    self.width = width
    self.height = height

    return setmetatable(self, {__index = AABB})
end

function AABB:contains(x, y)
    x, y = fixXY(x, y)
    x = x - self.x
    y = y - self.y

    return x > 0 and x < self.width and y > 0 and y < self.height
end

function AABB:drawFilled(fill, stroke)
    love.graphics.setColor(fill)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(stroke)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

return AABB