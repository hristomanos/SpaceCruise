LevelSelector  = {}
LevelSelector.__index = LevelSelector

function LevelSelector.new()
  local o = setmetatable(o or {}, LevelSelector)
  o.levels = {}
  o.rectangles = {}
  o.leftArrow = {x = 250, y = 400, w = 80, h = 40}
  o.rightArrow = {x = 450, y = 400, w = 80, h =40}
  o.Arrows = {r = o.rightArrow, l = o.leftArrow}
  o.loopIndex = 1
  o.image = love.graphics.newImage("assets/UISprites/CockpitMonitor.png")
  o.image:setFilter("nearest", "nearest")
  return o
end

function LevelSelector:createRectangle(width, height, text)
  local rectangle = {x = 0, y = 200, w = 80, h = 80, text = text, state = false, levelLoad = nil}
  table.insert(self.rectangles, rectangle)
end


function LevelSelector:load()
  self:createRectangle(80, 80, "Level 1")
  self:createRectangle(80, 80, "Level 2")
  self:createRectangle(80, 80, "Level 3")
  self:createRectangle(80, 80, "Level 4")
  self:createRectangle(80, 80, "Level 5")
  self:createRectangle(80, 80, "Level 6")
  self:createRectangle(80, 80, "Level 7")
  self:createRectangle(80, 80, "Level 8")
  self:createRectangle(80, 80, "Level 9")
  self:createRectangle(80, 80, "Level 10")
  self:createRectangle(80, 80, "Level 11")
  self:createRectangle(80, 80, "Level 12")

end


function LevelSelector:update()
  for i = 1, 12 do
  self.rectangles[i].x = 0
  self.rectangles[i].state = false
  end
  
  self.rectangles[self.loopIndex].x = 250
  self.rectangles[self.loopIndex+1].x = 350
  self.rectangles[self.loopIndex+2].x = 450
  
  self.rectangles[self.loopIndex].state = true
  self.rectangles[self.loopIndex+1].state = true
  self.rectangles[self.loopIndex+2].state = true
  
end

function LevelSelector:draw()
  
  love.graphics.setColor(255, 255, 255, 200)
  love.graphics.draw(self.image, 0, 0, 0, Width/self.image:getWidth(), Height/self.image:getHeight())
  love.graphics.setColor(255, 255, 255, 255)
  
  love.graphics.rectangle("line", self.Arrows.l.x, self.Arrows.l.y, self.Arrows.l.w, self.Arrows.l.h)
  love.graphics.print("<<", self.Arrows.l.x, self.Arrows.l.y)
  love.graphics.rectangle("line", self.Arrows.r.x, self.Arrows.r.y, self.Arrows.r.w, self.Arrows.r.h)
  love.graphics.print(">>", self.Arrows.r.x, self.Arrows.r.y)
  
  love.graphics.print(self.loopIndex, 200, 0)
  for i =self.loopIndex, self.loopIndex+2, 3 do 
    --self.rectangles[i].x   =  250
    --self.rectangles[i+1].x =  350
    --self.rectangles[i+2].x =  450

    love.graphics.rectangle("fill", self.rectangles[i].x, self.rectangles[i].y, self.rectangles[i].w ,self.rectangles[i].h)
    love.graphics.rectangle("fill", self.rectangles[i+1].x, self.rectangles[i+1].y, self.rectangles[i+1].w ,self.rectangles[i+1].h)
    love.graphics.rectangle("fill", self.rectangles[i+2].x, self.rectangles[i+2].y, self.rectangles[i+2].w ,self.rectangles[i+2].h)
    love.graphics.push("all")
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.rectangles[i].text, self.rectangles[i].x, self.rectangles[i].y)
    love.graphics.print(self.rectangles[i+1].text, self.rectangles[i+1].x, self.rectangles[i+1].y)
    love.graphics.print(self.rectangles[i+2].text, self.rectangles[i+2].x, self.rectangles[i+2].y)

    love.graphics.pop()
    end

end

function LevelSelector:LeftArrowCollision(x, y)
 if self.loopIndex > 1 then
 if x >= self.Arrows.l.x and x <= self.Arrows.l.x + self.Arrows.l.w and y >= self.Arrows.l.y and y <= self.Arrows.l.y + self.Arrows.l.h then
   self.loopIndex = self.loopIndex - 1
   return true
  end
 end
 return false
end


function LevelSelector:RightArrowCollision(x, y)
   if self.loopIndex < 10 then
  if x >= self.Arrows.r.x and x <= self.Arrows.r.x + self.Arrows.r.w and y >= self.Arrows.r.y and y <= self.Arrows.r.y + self.Arrows.r.h then
   self.loopIndex = self.loopIndex + 1
   return true
  end
 end
 return false
end


function LevelSelector:CheckCollision(x, y, level)
  self:LeftArrowCollision(x, y)
  self:RightArrowCollision(x, y)
  
    for i,v in ipairs(self.rectangles) do
      if v.state == true then
      if x >= v.x and x <= v.x + v.w and y >= v.y and y <= v.y + v.h then
        level.selectedLevel = ("Level" .. i)
        level.levelWon = true
      end
    end
  end
end


return LevelSelector