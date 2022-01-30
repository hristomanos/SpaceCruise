local StartMenu = {}

function StartMenu:load()
  
  self.background = love.graphics.newImage("assets/UISprites/staryBackground.png")
  self.image = love.graphics.newImage("assets/UISprites/title.png")
  
  self.startGameButton = {x = Width / 2 - 50, y = 300, w = 100, h = 40, text = "Start Game"}
  self.exitGameButton  = {x = Width / 2 - 50, y = 400, w = 100, h = 40, text = "Exit Game"}
  
  self.startGame = false
  
end

function StartMenu:update(dt)
  
end

function StartMenu:draw()
  
  love.graphics.draw(self.background, 0, 0, 0)
  love.graphics.draw(self.image, 100, 100, 0)
  
  love.graphics.setColor(0, 200, 255)
  
  love.graphics.rectangle("fill", self.startGameButton.x, self.startGameButton.y, self.startGameButton.w , self.startGameButton.h)
  love.graphics.rectangle("fill", self.exitGameButton.x, self.exitGameButton.y, self.exitGameButton.w , self.exitGameButton.h)
  
  love.graphics.setColor(0, 0, 0)
  
  love.graphics.print(self.startGameButton.text, self.startGameButton.x + 15, self.startGameButton.y + 15)
  love.graphics.print(self.exitGameButton.text, self.exitGameButton.x + 20, self.exitGameButton.y + 15)
  
  love.graphics.setColor(255, 255, 255)
  
end

function StartMenu:checkCollision(x, y)
  
  if x >= self.startGameButton.x and x <= self.startGameButton.x + self.startGameButton.w and y >= self.startGameButton.y and y <= self.startGameButton.y + self.startGameButton.h then
    self.startGame = true
  end
  
  if x >= self.exitGameButton.x and x <= self.exitGameButton.x + self.exitGameButton.w and y >= self.exitGameButton.y and y <= self.exitGameButton.y + self.exitGameButton.h then
    love.event.quit()
  end
  
end

return StartMenu