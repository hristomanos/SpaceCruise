local PauseMenu = {}

function PauseMenu:load()
  
  self.resumeButton = {x = Width / 2 - 50, y = 200, w = 100, h = 40, text = "Resume Game"}
  self.exitGameButton  = {x = Width / 2 - 50, y = 300, w = 100, h = 40, text = "Exit Game"}
  
  self.resumeGame = false
  
end

function PauseMenu:update(dt)
  
end

function PauseMenu:draw()
  
  love.graphics.setColor(0, 200, 255)
  
  love.graphics.rectangle("fill", self.resumeButton.x, self.resumeButton.y, self.resumeButton.w , self.resumeButton.h)
  love.graphics.rectangle("fill", self.exitGameButton.x, self.exitGameButton.y, self.exitGameButton.w , self.exitGameButton.h)
  
  love.graphics.setColor(0, 0, 0)
  
  love.graphics.print(self.resumeButton.text, self.resumeButton.x + 5, self.resumeButton.y + 15)
  love.graphics.print(self.exitGameButton.text, self.exitGameButton.x + 20, self.exitGameButton.y + 15)
  
  love.graphics.setColor(255, 255, 255)
  
end

function PauseMenu:checkCollision(x, y)
  
  if x >= self.resumeButton.x and x <= self.resumeButton.x + self.resumeButton.w and y >= self.resumeButton.y and y <= self.resumeButton.y + self.resumeButton.h then
    self.resumeGame = true
  end
  
  if x >= self.exitGameButton.x and x <= self.exitGameButton.x + self.exitGameButton.w and y >= self.exitGameButton.y and y <= self.exitGameButton.y + self.exitGameButton.h then
    love.event.quit()
  end
  
end

return PauseMenu