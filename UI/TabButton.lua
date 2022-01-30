local TabButton  = {}
TabButton.__index = TabButton
local SpriteMaker = require "tools/SpriteMaker"

function TabButton.new(x, y, width, height, image)
  local o = setmetatable(o or {}, TabButton)
  o.x = x
  o.y = y
  o.width = width
  o.height = height
  o.color = {255, 0, 0}
  o.state = false
  o.image = SpriteMaker.new(image, 32, 32, 1, 1)
  o.border = SpriteMaker.new(love.graphics.newImage("assets/UISprites/ShopBorder.png"), width, height, 1, 1)
  return o
end

function TabButton:draw()
  
  if self.state == true then
    love.graphics.push("all")
    love.graphics.setColor(0, 255, 0)
    self.border:draw(self.x, self.y)
    love.graphics.pop()
  else
    love.graphics.push("all")
    love.graphics.setColor(255, 0, 0)
    self.border:draw(self.x, self.y)
    love.graphics.pop()  
  end
  
    self.image:draw(self.x + 4, self.y + 4)
end

function TabButton:collision(x, y)
   if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
    return true
  end
  return false
end



return TabButton