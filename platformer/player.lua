require "tools/camera"
require "tools/worldPhysics"

require "platformer/bullet"
local vec2   = require "tools/vec2"

Player = {}

local quad  = love.graphics.newQuad
local key   = love.keyboard.isDown

Player.new = function(x, y, w, h)
  
  local p = {}
  
  p.id             = "Player"
  p.pos            = vec2:new(x, y)
  p.size           = vec2:new(w, h)
  p.vel            = vec2:new(0, 0)
  p.dir            = vec2:new(1, 0)
  p.onGround       = false
  p.gravity        = 550
  p.maxHealth      = PlatformerMaxHealth
  p.currentHealth  = p.maxHealth
  p.invincible     = false
  p.cannotMoveLR   = false
  p.shooting       = false
  p.shootAnimTime  = 0.4
  p.bullets        = {}
  p.openChestImg   = {}
  p.tileSheet      = love.graphics.newImage("assets/tileSheets/TileSheet.png")
  p.image          = love.graphics.newImage("assets/tileSheets/TheDudeMan2.png")
  p.animData      = {quad(0,0,32,32,128,192), quad(33,0,32,32,128,192), quad(65,0,32,32,128,192), quad(97,0,32,32,128,192),
                        quad(0,32,32,32,128,192), quad(33,32,32,32,128,192),
                        quad(0,64,32,32,128,192), quad(33,64,32,32,128,192), quad(65,64,32,32,128,192), quad(97,64,32,32,128,192),
                        quad(0,96,32,32,128,192), quad(33,96,32,32,128,192), quad(65,96,32,32,128,192), quad(97,64,32,32,128,192),
                        quad(0,128,32,32,128,192), quad(33,128,32,32,128,192), quad(65,128,32,32,128,192), quad(97,128,32,32,128,192),
                        quad(0,160,32,32,128,192)}
  
  p.image:setFilter("nearest", "nearest")
  
  p.animation = require("tools/animation"):new(
				p.image,
				{
					{ -- idle
						p.animData[5],
            p.animData[6]
					},
					{ -- walk
            p.animData[1],
						p.animData[2],
						p.animData[3],
						p.animData[4]
					},
          {
            -- jump up
            p.animData[8]
          },
          {
            -- fall down
            p.animData[10]
          },
          {
            -- shooty gun gun
            p.animData[11],
            p.animData[12],
            p.animData[13],
            p.animData[14]
          },
          {
            -- climb idle
            p.animData[15]
          },
          {
            -- climb anim
            p.animData[15],
            p.animData[16],
            p.animData[17],
            p.animData[18]
          },
          {
            -- damage
            p.animData[19]
          }
				},
				0.125
			)
  
  p.animation:play()
  
  setmetatable(p, {__index = Player})
  return p
  
end

function Player:update(level, dt)

  level.camera:goto_point(self.pos)
  
  self.animation:set_animation(1, 0.5)
  
  if not self.cannotMoveLR then
    
    if key("x") and self.onGround == true then
      
      if openTreasureChest(level, self) == false then
        if endLevel(level, self) == true then 
          level.levelWon = true 
        end
      
        if self.shooting == false then
          self.shooting = true
          
          local bullet = Bullet.new(self.pos.x + (self.size.x / 2 * self.dir.x), self.pos.y + (self.size.y / 2), 4, 4, self.dir.x, 250)
          table.insert(self.bullets, bullet)
          
          if (sounds.platformerBulletFire:play()) then
            sounds.platformerBulletFire:stop()
            sounds.platformerBulletFire:play()
          else
            sounds.platformerBulletFire:play()
          end
        end
      end
        
    end
    
    if key("left") and self.shooting == false then
    
      self.animation:set_animation(2, 0.125)
      self.dir.x = -1
      self.vel.x = 200
      
    end
    
    if key("right") and self.shooting == false then
      
      self.animation:set_animation(2, 0.125)
      self.dir.x = 1
      self.vel.x = 200
      
    end
    
    if self.shooting == true then
      self.animation:set_animation(5, 0.1)
      self.shootAnimTime = self.shootAnimTime - dt
      
      if self.shootAnimTime <= 0 then
        self.shooting = false
        self.shootAnimTime = 0.4
      end
    end
    
    if self.onGround == false and self.vel.y < 0 then
      self.animation:set_animation(4)
    elseif self.onGround == false and self.vel.y >= 0 then
      self.animation:set_animation(3)
    end
    
    if self.invincible == true then
      self.animation:set_animation(8)
    end
    
  else
    self.animation:set_animation(8)
  end
    
  self.pos.x = self.pos.x + (self.vel.x * dt) * self.dir.x
  self.pos.y = self.pos.y + (self.vel.y * dt) * self.dir.y
  self.vel.x = self.vel.x * (1-dt*12)
  
  for i,v in ipairs(self.bullets) do
    v:update(dt)
    
    if v.deathTime <= 0 or wallCollision(level, v, dt) == true then
      table.remove(self.bullets, i)
    end
  end
  
  openShop(level, self)
  openLevelSelect(level, self)
  
  wallCollision(level, self, dt)
  
  if damageableCollision(level, self, dt) or enemyDamagePlayer(level, self, dt) then
    
    sounds.platformerDamaged:play()
    
  end
    
  if climbableCollision(level, self) then
    self.animation:set_animation(6)
    
    if key("up") then
        
      self.animation:set_animation(7, 0.125)
      self.dir.y = -1
      self.vel.y = 200
        
    end
    
    if key("down") then
        
      self.animation:set_animation(7, 0.125)
      self.dir.y = 1
      self.vel.y = 200
        
    end
    
    self.vel.y = self.vel.y * (1-dt*12)
    
  else
    
    applyGravity(self, dt)
    
  end
  
  if key("z") then
    
    if self.onGround == true then
      if (sounds.platformerJump:play()) then
        sounds.platformerJump:stop()
        sounds.platformerJump:play()
      else
        sounds.platformerJump:play()
      end
    end
    
    jump(self)

  end
  
  self.animation:update(dt)
  
end

function Player:draw()
  
  for i, v in ipairs(self.openChestImg) do
    love.graphics.draw(self.tileSheet, quad(33, 64, 32, 32, 128, 224), v.pos.x - 16, v.pos.y)
  end

  self.animation:draw({self.pos.x, self.pos.y, self.dir.x})
  
  for i,v in ipairs(self.bullets) do
    v:draw()
  end
  
end

return Player