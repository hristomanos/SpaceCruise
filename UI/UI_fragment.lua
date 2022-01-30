local SpriteMaker = require "tools/SpriteMaker"


local UI_fragment = {}
UI_fragment.__index = UI_fragment

function UI_fragment.new(x, y, sprite, width, height, numOfCollumns, numOfRows)
  
  local fragment = setmetatable(fragment or {}, UI_fragment)
  
  fragment.x = x
  fragment.y = y
  fragment.sprite = SpriteMaker.new(sprite, width, height, numOfCollumns, numOfRows)
  fragment.value = 0
  fragment.onScreen = true
  
  return fragment
end


function UI_fragment:draw(animSpeed)
 
 self.sprite:draw(self.x ,self.y)
 
 self.sprite:update(0.01667, animSpeed)
  love.graphics.setColor(255,255,255, 255)
 
 
 if self.value > 9 then
   if self.value > 99 then
      love.graphics.print(self.value, self.x + 18, self.y + 23)
    else
love.graphics.print(self.value, self.x + 20, self.y + 23)
end
else
 love.graphics.print(self.value, self.x + 27, self.y + 23)
 end

 
end


function UI_fragment:setValue(newValue)
  
  self.value = newValue
  
end

function UI_fragment:moveOffandOnScreen(self)
  
  if self.onScreen == true then
    self.y = 0
    self.onScreen = false
  
  else
    self.y = -100
    self.onScreen = false
  
  end
  
end

return UI_fragment