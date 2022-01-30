--require('mobdebug').start()
require "tools/sound"

Width  = love.graphics.getWidth()
Height = love.graphics.getHeight()

coins = 0
platformerGems = 0

PlatformerMaxHealth = 50
BulletHellMaxHealth = 50

sounds = {}

currentLevel = "shipLevel"

gameState = {"MainMenu", "PauseMenu", "PlayLevel", "WinLevel", "GameOver"}

local startMenu    = require "UI/UI_StartMenu"
local pauseMenu    = require "UI/UI_PauseMenu"
local levelManager = require "tools/levelManager"

function love.load()
  
  soundLoad()
  
  gameState = "MainMenu"
  startMenu:load()
  pauseMenu:load()
  
end

function love.update(dt)
  
  soundUpdate()
  
  if gameState == "MainMenu" then
    
    if startMenu.startGame == true then
      levelManager:load()
      gameState = "PlayLevel"
      startMenu.startGame = false
    end
    
  elseif gameState == "PauseMenu" then
    
    sounds.currentMusic:pause()
    
    if pauseMenu.resumeGame == true then
      gameState = "PlayLevel"
      pauseMenu.resumeGame = false
    end
    
  elseif gameState == "PlayLevel" then
    
     levelManager:update(dt)
     
     sounds.currentMusic:play()
     
     if levelManager.levelWon == true then
       gameState = "WinLevel"
     end
     
     if levelManager.levelLost == true then
       gameState = "GameOver"
     end
    
  elseif gameState == "WinLevel" then
    
    sounds.currentMusic:stop()
    sounds.winLevel:play()
    
    currentLevel = levelManager:endLevel()
    levelManager:load(currentLevel)
    gameState = "PlayLevel"
    
  elseif gameState == "GameOver" then
    
    sounds.currentMusic:stop()
    sounds.gameOver:play()
    
    levelManager:endLevel()
    levelManager:load(currentLevel)
    gameState = "PlayLevel"
    
  end
  
end

function love.draw()
  
  if gameState == "MainMenu" then
    
    startMenu:draw()
    
  elseif gameState == "PauseMenu" then
    
    levelManager:draw()
    pauseMenu:draw()
    
  elseif gameState == "PlayLevel" then
    
    levelManager:draw()
    
  elseif gameState == "WinLevel" then
    
  elseif gameState == "GameOver" then
    
  end
  
end

function love.keypressed(key)
  
  if key == "escape" then
    
    if gameState == "PauseMenu" then
      gameState = "PlayLevel"
    elseif gameState == "PlayLevel" then
      gameState = "PauseMenu"
    end
    
  end
  
end

function love.mousepressed(x, y, button, istouch)
  
  if gameState == "MainMenu" then
    startMenu:checkCollision(x, y)
  elseif gameState == "PauseMenu" then
    pauseMenu:checkCollision(x, y)
  else
    levelManager:mousePressed(x, y, button, istouch)
  end
  
end