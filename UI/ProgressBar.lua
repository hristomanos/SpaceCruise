local ProgressBar  = {}
ProgressBar.__index = ProgressBar

function ProgressBar.new(posX, posY, width, height, maxUpgrade, upgradeBy, id)
  local o = setmetatable(o or {}, ProgressBar)
  o.id = id
  o.x = x
  o.y = y
  o.width = width
  o.height = height
  o.maxUpgrade = maxUpgrade
  o.upgradeRate = upgradeBy
  o.currentUpgrade = 0
  o.progressRec = {x = posX, y = posY, w = 0, h = height}
  o.defaultRec = {x = posX, y = posY, w = width, h = height}
  return o
end

function ProgressBar:update()
  if self.progressRec.w < self.width then
  self.progressRec.w = (self.currentUpgrade / self.maxUpgrade) * self.width
  end
end

function ProgressBar:getMaxUpgrade()
    return self.maxUpgrade
end

function ProgressBar:getCurrentUpgrade()
    return self.currentUpgrade
end

function ProgressBar:draw()
  love.graphics.rectangle("line", self.defaultRec.x, self.defaultRec.y, self.defaultRec.w, self.defaultRec.h)
  love.graphics.push("all")
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", self.progressRec.x, self.progressRec.y, self.progressRec.w, self.progressRec.h)
  love.graphics.pop()
end

function ProgressBar:AddUpgrade()
  
  if self.id == "PlatformerHealth" then
    PlatformerMaxHealth = PlatformerMaxHealth + self.upgradeRate
  elseif self.id == "ShipHealth" then
    BulletHellMaxHealth = BulletHellMaxHealth + self.upgradeRate
  end
  
  self.currentUpgrade = self.currentUpgrade + self.upgradeRate
end


return ProgressBar
