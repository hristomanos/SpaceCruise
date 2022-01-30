require "tools/worldPhysics"

local vec2 = require "tools/vec2"

Enemy = {}

local quad  = love.graphics.newQuad

Enemy.new = function(x, y, w, h)
  
  local e = {}
  
  e.id                 = "Enemy"
  e.pos                = vec2:new(x, y)
  e.size               = vec2:new(w, h)
  e.vel                = vec2:new(0, 0)
  e.dir                = vec2:new(love.math.random(-2, 1), 0)
  e.chasePlayerBoxPos  = vec2:new(e.pos.x - (e.size.x * 4), e.pos.y)
  e.chasePlayerBoxSize = vec2:new(e.size.x * 8, e.size.y)
  e.gravity            = 500
  e.onGround           = false
  e.cannotMoveLR       = false
  e.maxHealth          = 2
  e.currentHealth      = e.maxHealth
  e.death              = false
  e.image              = love.graphics.newImage("assets/tileSheets/TheStretchyBoi.png")
  e.animData           = {quad(0,0,32,32,128,32), quad(33,0,32,32,128,32), quad(65,0,32,32,128,32), quad(97,0,32,32,128,32)}
  
  e.image:setFilter("nearest", "nearest")
  
  while e.dir.x == 0 do
    e.dir.x = 1
  end
  
  while e.dir.x == -2 do
    e.dir.x = -1
  end
  
  e.animation = require("tools/animation"):new(
				e.image,
				{
					{ -- idle
						e.animData[1]
					},
					{ -- walk right
            e.animData[1],
						e.animData[2],
						e.animData[3],
						e.animData[4]
					},
				},
				0.125
			)
  
  e.animation:play()
  
  setmetatable(e, {__index = Enemy}) -- use all of the functionality from Bullet
  return e
  
end

function Enemy:update(level, dt)
  
  applyGravity(self,dt)
  
  if not self.cannotMoveLR then
    
    local collideWithWall = wallCollision(level, self, dt)
    
    if collideWithWall == "objRightCollision" then
      self.dir.x = -1
    elseif collideWithWall == "objLeftCollision" then
      self.dir.x = 1
    end
    
    if damageableCollision(level, self, dt) == true then
      if self.currentHealth > 0 then
        sounds.platformerEnemyHit:play()
      else
        sounds.platformerEnemyKilled:play()
      end
    end
    
    playerDamageEnemy(level, self, dt)
    
    if noticePlayer(level, self) then
      
      if self.pos.x < level.player.pos.x then
          self.vel.x = 150
          self.dir.x = 1
        else
          self.vel.x = 150
          self.dir.x = -1
      end
        
      if math.random(1,10) == 1 then
        jump(self)
        
        if self.onGround == false then
          sounds.platformerEnemyJump:play()
        end
      end
      
    elseif self.onGround then
      
      self.vel.x = 50
      
    end
    
  end
  
  

  self.animation:set_animation(2)
  
  --self.pos.x = self.pos.x + self.vel.x * dt
  --self.pos.y = self.pos.y + self.vel.y * dt
  
  self.pos.x = self.pos.x + (self.vel.x * dt) * self.dir.x
  self.pos.y = self.pos.y + (self.vel.y * dt) * self.dir.y
    
  self.chasePlayerBoxPos.y = self.pos.y
  self.chasePlayerBoxPos.x = self.pos.x - (self.size.x * 4)
  
  self.animation:update(dt)
  
end

function Enemy:draw()
  
  self.animation:draw({self.pos.x, self.pos.y, self.dir.x})
  --love.graphics.rectangle( "line", self.chasePlayerBoxPos.x, self.chasePlayerBoxPos.y, self.chasePlayerBoxSize.x, self.chasePlayerBoxSize.y )
  
end

return Enemy