function applyGravity(obj, dt)
  
  obj.vel.y = obj.vel.y + obj.gravity * dt
  obj.dir.y = 1
  
  if obj.vel.y > 10 then
		obj.cannotMoveLR = false
    obj.onGround = false
    obj.invincible = false
	end
  
end

function jump(obj)
  
	if obj.vel.y < 10 and obj.vel.y > -10 and obj.onGround then
		obj.vel.y = -obj.gravity * 0.5
		obj.onGround = false
	end
  
end

function wallCollision(level, obj, dt)
  
  local colBlocks = level.collidableBlock:getAllBlocks()
  
  for i, v in ipairs(colBlocks) do
    
    if v == nil then break end
      
    local collision = boxCollision(obj, v)
    
    if collision then
      
      if obj.pos.y + obj.size.y / 2 < v.pos.y + v.size.y / 2 then
        
        if obj.pos.y + obj.size.y < v.pos.y + 8 then
          obj.vel.y = 0
          obj.pos.y = v.pos.y - obj.size.y
          obj.onGround = true
          obj.invincible = false
          obj.cannotMoveLR = false
          
          if obj.id == "Enemy" then
            changeDirection(level, obj, v)
          elseif obj.id == "Bullet" then
            return true
          end
        end
        
      else
        
        if obj.pos.y > v.pos.y + v.size.y - 8 then
          obj.vel.y = 0
          obj.pos.y = v.pos.y + v.size.y + 1
          break
        end
        
      end
      
      if obj.pos.x + obj.size.x / 2 < v.pos.x + v.size.x / 2 then
        
        if obj.pos.y + obj.size.y > v.pos.y then
          obj.vel.x = 0
          obj.pos.x = v.pos.x - obj.size.x
          
          if obj.id == "Enemy" and obj.onGround then
            return "objRightCollision"
          elseif obj.id == "Bullet" then
            return true
          end
        end
        
      else
        
        if obj.pos.y + obj.size.y > v.pos.y then
          obj.vel.x = 0
          obj.pos.x = v.pos.x + v.size.x
          
          if obj.id == "Enemy" and obj.onGround then
            return "objLeftCollision"
          elseif obj.id == "Bullet" then
            return true
          end
        end
        
      end
      
    end
  end
  
end

function climbableCollision(level, obj)
  
  local climBlocks = level.climbableBlock:getAllBlocks()
  
  for i, v in ipairs(climBlocks) do
    
    if v == nil then
      break
    else
      if insideBoxCollision(obj, v) then
        return true
      end
    end
    
  end
  
  return false
  
end

function damageableCollision(level, obj, dt)
  
  local dmgBlocks = level.damageableBlock:getAllBlocks()
  
  for i, v in ipairs(dmgBlocks) do
    
    if v == nil then
      break
    else
      if boxCollision(obj, v) then
        
        obj.currentHealth = obj.currentHealth - 1
        obj.invincible    = true
        
        if obj.pos.y + obj.size.y / 2 < v.pos.y + v.size.y / 2 then
        
          if obj.pos.y + obj.size.y < v.pos.y + 8 then
            
            obj.vel.y = 0
            playerBottomDmgTopCollision(obj, dt)
            return true
            
          end
        
        else
        
          if obj.pos.y > v.pos.y + v.size.y - 8 then
            
            obj.vel.y = 0
            playerTopDmgBottomCollision(obj, dt)
            return true
            
          end
          
        end
        
        if obj.pos.x + obj.size.x / 2 < v.pos.x + v.size.x / 2 then
          
          if obj.pos.y + obj.size.y > v.pos.y then
            
            obj.vel.y = 0
            obj.vel.x = 0
            
            obj.cannotMoveLR = true
            playerRightDmgLeftCollision(obj, dt)
            return true
            
          end
          
        else
          
          if obj.pos.y + obj.size.y > v.pos.y then
            
            obj.vel.y = 0
            obj.vel.x = 0
            
            obj.cannotMoveLR = true
            playerLeftDmgRightCollision(obj, dt)
            return true
            
          end
        
        end
        
      end
    end
    
  end
  
  return false
  
end

function openTreasureChest(level, obj)
  
  for i, v in ipairs(level.treasureBlock:getAllBlocks()) do
    if boxCollision(obj, v) then
      if v.open == false then
        v.open = true
        table.insert(obj.openChestImg, v)
        platformerGems = platformerGems + 1
        coins = coins + 20
        sounds.platformerTreasure:play()
        return true
      end
    end
  end
  
  return false
  
end

function endLevel(level, obj)
  
  for i, v in ipairs(level.endLevelBlock:getAllBlocks()) do
    if boxCollision(obj, v) then
      coins = coins + 100
      return true
    end
  end
  
end

function openShop(level, obj)
  
  for i, v in ipairs(level.shopBlock:getAllBlocks()) do
    if boxCollision(obj, v) then
      level.shopActivated = true
      return true
    end
  end
  
  level.shopActivated = false
  
end

function openLevelSelect(level, obj)
  
  for i, v in ipairs(level.cockpitBlock:getAllBlocks()) do
    if boxCollision(obj, v) then
      level.cockpitActivated = true
      return true
    end
  end
  
  level.cockpitActivated = false
  
end

function changeDirection(level, obj, currentCol)
  
  local colBlocks      = level.collidableBlock:getAllBlocks()
  local dmgBlocks      = level.damageableBlock:getAllBlocks()
  local collidingRight = false
  local collidingLeft  = false
  
  for i, v in ipairs(dmgBlocks) do
    if v.pos.x == currentCol.pos.x + currentCol.size.x and v.pos.y == currentCol.pos.y then
      
      collidingRight = true
      
    elseif v.pos.x + v.size.x == currentCol.pos.x and v.pos.y == currentCol.pos.y then
      
      collidingLeft = true
      
    end
  end
  
  for i, v in ipairs(colBlocks) do 
    if v.pos.x == currentCol.pos.x + currentCol.size.x and v.pos.y == currentCol.pos.y then
     
      collidingRight = true
     
    elseif v.pos.x + v.size.x == currentCol.pos.x and v.pos.y == currentCol.pos.y then
      
      collidingLeft = true
      
    end
  end
  
  if collidingRight == false or collidingLeft == false then
    
    obj.dir.x = obj.dir.x * -1
    
  end
  
end

function noticePlayer(level, obj)
  
  local v = level.player
  
  if obj.chasePlayerBoxPos.x <= v.pos.x                             and
     obj.chasePlayerBoxPos.x + obj.chasePlayerBoxSize.x >= v.pos.x  and
     obj.chasePlayerBoxPos.y == v.pos.y                             then
       
       return true
       
  else
       
       return false
  
  end
     
  
end

function enemyDamagePlayer(level, obj, dt)
  
  for i, v in ipairs(level.enemies) do
    if boxCollision(obj, v) then
      if obj.invincible == false then
        obj.currentHealth = obj.currentHealth - 1
        obj.invincible = true
        playerLeftDmgRightCollision(obj, dt)
        return true
      end
    end
  end
  
end

function playerDamageEnemy(level, obj, dt)
  
  for i, v in ipairs(level.player.bullets) do
    if boxCollision(obj, v) then
      
      table.remove(level.player.bullets, i)
      obj.currentHealth = obj.currentHealth - 1
      
      if obj.currentHealth > 0 then
        sounds.platformerEnemyHit:play()
      end
    
    end
  end
  
end

function boxCollision(box1, box2)
  
  return box1.pos.x < box2.pos.x + box2.size.x and
         box2.pos.x < box1.pos.x + box1.size.x and
         box1.pos.y < box2.pos.y + box2.size.y and
         box2.pos.y < box1.pos.y + box1.size.y
  
end

function insideBoxCollision(box1, box2)
  
  return box1.pos.x < box2.pos.x + box2.size.x / 2 and
         box2.pos.x < box1.pos.x + box1.size.x / 2 and
         box1.pos.y < box2.pos.y + box2.size.y     and
         box2.pos.y < box1.pos.y + box1.size.y
  
end

function playerBottomDmgTopCollision(obj, dt)
  
  if obj.vel.y < 10 and obj.vel.y > -10 then
		obj.vel.y = -obj.gravity * 0.5
		obj.onGround = false
	end
  
end

function playerTopDmgBottomCollision(obj, dt)
  
  if obj.vel.y < 10 and obj.vel.y > -10 then
		obj.vel.y = obj.gravity * 0.5
		obj.onGround = false
	end
  
end

function playerRightDmgLeftCollision(obj, dt)
  
  if obj.vel.y < 10 and obj.vel.y > -10 then
		obj.vel.y = -obj.gravity * 0.3
    obj.vel.x = obj.gravity * 1
		obj.onGround = false
	end
  
end

function playerLeftDmgRightCollision(obj, dt)
  
  if obj.vel.y < 10 and obj.vel.y > -10 then
		obj.vel.y = -obj.gravity * 0.3
    obj.vel.x = -obj.gravity * 1
		obj.onGround = false
	end
  
end