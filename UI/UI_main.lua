local UI_fragment = require "UI/UI_fragment"

UI     = {x, y, health, ammo, gem1, gem2, coins}
--Timers = {health, ammo, gem1, gem2, coins}

--Timers.health = 10
--Timers.ammo = 10
--Timers.gem1 = 10
--Timers.gem2 = 10
--Timers.coins = 10


function UI.init(x, y)
  
  UI.x = x
  UI.y = y
  
  healthSprite = love.graphics.newImage("assets/UISprites/Healthy.png")
  ammoSprite   = love.graphics.newImage("assets/UISprites/bulletRevised.png")
  gemSprite = love.graphics.newImage("assets/UISprites/gemRevised.png")
  coinSprite = love.graphics.newImage("assets/UISprites/coinRevised.png")
  
  
  UI.health = UI_fragment.new(x, y, healthSprite , 32, 32, 1, 14)
  UI.ammo   = UI_fragment.new(x + 64 , y, ammoSprite , 32, 32, 1, 8)
  UI.gem1   = UI_fragment.new(x + 128, y, gemSprite , 32, 32, 1, 7)
  UI.gem2   = UI_fragment.new(x + 192, y, gemSprite , 32, 32, 1, 7)
  UI.coins  = UI_fragment.new(x + 256, y, coinSprite , 32, 32, 1, 7)
  
end

function UI.setHealth(value)
  
  UI.health:setValue(value)
  --Timers.health = 10.0
  
end

function UI.setAmmo(value)
  
  UI.ammo:setValue(value)

  --Timers.ammo = 10.0
  
end


function UI.setGem1(value)
  
  UI.gem1:setValue(value)

  --Timers.gem1 = 10.0
  
end

function UI.setGem2(value)
  

  UI.gem2:setValue(value)

  --Timers.gem2 = 10.0
  
end


function UI.setCoins(value)
  
  UI.coins:setValue(value)
  
  --Timers.coins = 10.0
  
end


function UI.draw()
  
  love.graphics.setColor(255,255,255, 255)
  
  UI.health:draw(10)
  UI.ammo:draw(10)
  UI.coins:draw(7)
  
  love.graphics.setColor(0,0,255, 255)
  UI.gem1:draw(10)
  
  love.graphics.setColor(255,0,255, 255)
  UI.gem2:draw(5)
  
  love.graphics.setColor(255,255,255, 255)
end

function UI.update(dt)
  
  --if Timers.health > 0 then
  --  Timers.health = Timers.health - dt
  --else
  --  UI.health:moveOffandOnScreen(UI.health)
  --end
  
  --if Timers.ammo > 0 then
  --  Timers.ammo = Timers.ammo - dt
  --else
  --  UI.ammo:moveOffandOnScreen(UI.ammo)
  --end

  --if Timers.gem1 > 0 then
  --  Timers.gem1 = Timers.gem1 - dt
  --else
  --  UI.gem1:moveOffandOnScreen(UI.gem1)
  --end
  
  --if Timers.gem2 > 0 then
  --  Timers.gem2 = Timers.gem1 - dt
  --else
  --  UI.gem2:moveOffandOnScreen(UI.gem2)
  --end
  
  --if Timers.coins > 0 then
  --  Timers.coins = Timers.coins - dt
  --else
  --  UI.coins:moveOffandOnScreen(UI.coins)
  --end
  
end