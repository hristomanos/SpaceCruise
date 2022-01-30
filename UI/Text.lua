local AABB = require("UI/AABB")

local Text = {}

function Text.create(x, y, width, height, text)
    local self = {}

    self.aabb = AABB.create(x, y, width, height)
    self.text = text

    self.color = {0xff, 0xff, 0xff, 0xff}
    self.font = love.graphics.newFont(12)

    return setmetatable(self, {__index = Text})
end

function Text:assign(newText)
    self.text = newText
end

function Text:draw()
    local textWidth = self.font:getWidth(self.text)
    local textHeight = self.font:getHeight()

    local x = self.aabb.x + (self.aabb.width - textWidth) / 2
    local y = self.aabb.y + (self.aabb.height - textHeight) / 2

    love.graphics.setColor(self.color)
    love.graphics.setFont(self.font)
    love.graphics.print(self.text, x, y)
end

return Text