Shop  = {}
Shop.__index = Shop

local SpriteMaker = require "tools/SpriteMaker"

function Shop.new()
  local o = setmetatable(o or {}, Shop)
  o.width = love.graphics.getWidth()
  o.height = love.graphics.getHeight()
  o.isVisible = true
  o.Tabs = {}
  o.temp = {}
  o.CurrentState = "None"
  o.PlayerUpgrades = {}
  o.ShipUpgrades = {}
  o.image = love.graphics.newImage("assets/UISprites/ShopMonitor.png")
  o.image:setFilter("nearest", "nearest")
  return o
end

function Shop:load()
  local ProgressBar = require "UI/ProgressBar"
  local BuyButton = require "UI/BuyButton"
  local TabButton = require "UI/TabButton"
  --HealthRec was 190
  local rectangle = {x = 190, y = 130, w = 40, h = 40}
  WeaponBar = ProgressBar.new(rectangle.x + 50, rectangle.y, 100, 40, 100, 10, "ShipHealth")
  WeaponBuy = BuyButton.new(rectangle.x + 160, rectangle.y, 80, 40, "Weapon Upgrade", 10)
  
  local healthRec  = {x = 190, y = 130, w = 40, h = 40}
  HealthBar = ProgressBar.new(healthRec.x + 50, healthRec.y, 100, 40, 100, 20, "PlatformerHealth")
  HealthBuy = BuyButton.new(healthRec.x + 160, healthRec.y, 80, 40, "Health Upgrade", 20)
  
  
  PlayerTabButton = TabButton.new(80, 120, 40, 40, love.graphics.newImage("assets/UISprites/Healthy.png"))
  ShipTabButton = TabButton.new(80, 180, 40, 40, love.graphics.newImage("assets/UISprites/SpaceShip.png"))
  
  local PlayerTab = {tab = PlayerTabButton, state = "player"}
  local ShipTab = {tab = ShipTabButton, state = "ship"}
  
  local weaponArray = {item = SpriteMaker.new(love.graphics.newImage("assets/UISprites/bulletRevised.png"), 32, 32, 1, 1), bar = WeaponBar, buy = WeaponBuy}
  local healthArray = {item = SpriteMaker.new(love.graphics.newImage("assets/UISprites/Healthy.png"), 32, 32, 1, 1), bar = HealthBar, buy = HealthBuy}
  
  table.insert(self.Tabs, PlayerTab)
  table.insert(self.Tabs, ShipTab)

  table.insert(self.PlayerUpgrades, healthArray)
  table.insert(self.ShipUpgrades, weaponArray)

end

function Shop:update()
  if self.isVisible == true then
 if self.CurrentState == "player" then
   self.temp = self.PlayerUpgrades
 end
 if self.CurrentState == "ship" then
   self.temp = self.ShipUpgrades
  end
  
  for i,v in ipairs(self.Tabs) do 
    if self.CurrentState == v.state then
      v.tab.state = true
    else
      v.tab.state = false
    end
  end
 end
 
 for i,v in ipairs(self.temp) do
  v.bar:update()
 end
end


function Shop:draw()
  if self.isVisible == true then
      love.graphics.setColor(255, 255, 255, 200)
    love.graphics.draw(self.image, 0, 0, 0, Width/self.image:getWidth(), Height/self.image:getHeight())
    love.graphics.setColor(255, 255, 255, 255)
  for i,v in ipairs(self.Tabs) do 
    v.tab:draw()
  end
  
  for i,v in ipairs(self.temp) do
    v.item:draw(190, 130)
    v.bar:draw()
    v.buy:draw()
    end    
  end
end

  
function Shop:StateCheck(x, y)
 if self.isVisible == true then
  for i,v in ipairs(self.Tabs) do
    if v.tab:collision(x, y) then
      self.CurrentState = v.state
      end
    end
  end
end

function Shop:Collision(x,y)
 if self.isVisible == true then
 for i,v in ipairs(self.temp) do
   if v.buy:CollisionCheck(x,y) then
     if v.buy.cost <= coins then
     if v.bar:getMaxUpgrade() == v.bar:getCurrentUpgrade() then
       v.buy.image:FrameSet(3)
          return
        end
      coins = coins - v.buy.cost
      v.bar:AddUpgrade()
      end

      end
    end
  end
end

return Shop