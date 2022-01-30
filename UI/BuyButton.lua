local BuyButton  = {}
BuyButton.__index = BuyButton
local SpriteMaker = require "tools/SpriteMaker"

function BuyButton.new(x, y, width, height, text, cost)
  local o = setmetatable(o or {}, BuyButton)
  o.x = x
  o.y = y
  o.width = width
  o.height = height
  o.text = text
  o.color = {255, 0, 0}
  o.image = SpriteMaker.new(love.graphics.newImage("assets/UISprites/FancyButtons.png"), o.width, o.height, 1, 5)
  o.cost = cost
  return o
end

function BuyButton:update()
  
end

function BuyButton:draw()
  love.graphics.push("all")
  --love.graphics.setColor(self.color)
  --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  self.image:draw(self.x, self.y)
  
  love.graphics.pop()
  --love.graphics.printf(self.text, self.x + 5, self.y + 10, 200, "left", 0)
end

function BuyButton:CollisionCheck(x,y)
  if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
    return true
  end
  return false
end

return BuyButton