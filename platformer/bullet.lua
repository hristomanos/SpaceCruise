local vec2 = require "tools/vec2"

Bullet = {}

Bullet.new = function(x,y,w,h,dir,speed)
  
  local pos = vec2:new(x, y)
  local size = vec2:new(w, h)
  local vel  = vec2:new(0, 0)
  
  local b = { pos = pos, size = size, dir = dir, speed = speed, deathTime = 0.5, vel = vel, id = "Bullet"}

  setmetatable(b, {__index = Bullet}) -- use all of the functionality from Bullet
  return b -- let's return the newly created table
  
end

function Bullet:update(dt)
   -- go ahead, you can now use "self."
   
   self.pos.x = self.pos.x + (self.dir * self.speed * dt)
   self.deathTime = self.deathTime - dt
   
end

function Bullet:draw()
  love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.x, self.size.y)
end

return Bullet