local AABB = require("UI/AABB")
local Text = require("UI/Text")

local Button = {}

function Button.create(x, y, width, height, label, callback)
    local self = {}

    self.aabb = AABB.create(x, y, width, height)
    self.label = Text.create(x, y, width, height, label)
    self.label.color = {0xff, 0xff, 0xff, 0xff}
    self.callback = callback

    self.hover = false

    self.colors = {}
    self.colors.hover = {}
    self.colors.hover.fill = {0x88, 0x88, 0x88, 0xff}
    self.colors.hover.stroke = {0xcc, 0xcc, 0xcc, 0xff}
    self.colors.normal = {}
    self.colors.normal.fill = {0x88, 0x88, 0x88, 0x88}
    self.colors.normal.stroke = {0xcc, 0xcc, 0xcc, 0xff}

    return setmetatable(self, {__index = Button})
end

function Button:mousepressed(x, y, button)
    if self.hover and button == 1 then
        --self.callback()
        return true
    end
end

function Button:update()
    self.hover = self.aabb:contains(love.mouse.getPosition())
end

function Button:draw()
    if self.hover then
        self.aabb:drawFilled(self.colors.hover.fill, self.colors.hover.stroke)
    else
        self.aabb:drawFilled(self.colors.normal.fill, self.colors.normal.stroke)
    end

    self.label:draw()
end

return Button