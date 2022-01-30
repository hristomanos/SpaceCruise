
GenratedMovement = {currentPosX, currentPosY, endPosX, endPosY}



function GenratedMovement.SetMove(StartPosX, StartPosY , EndPosX, EndPosY)
  
  Movement = setmetatable({}, GenratedMovement)
  
  Movement.currentPosX = StartPosX
  Movement.currentPosY = StartPosY
  
  Movement.endPosX = EndPosX
  Movement.endPosY = EndPosY
  
  return Movement
  
end


function  GenratedMovement.UpdateLocation(self, dt, MoveSpeed)
  
  directionX = (self.endPosX - self.currentPosX)
  directionY = (self.endPosY - self.currentPosY)
  
  magnatude = GetMagnatude(directionX, directionY)
  
  
  
  self.currentPosX = self.currentPosX + (directionX * MoveSpeed * dt)
  self.currentPosY = self.currentPosY + (directionY * MoveSpeed * dt)
  
  
  return self
  
end

function GenratedMovement.ChangeEndPos(self, EndPosX, EndPosY)
  
  self.endPosX = EndPosX
  self.endPosY = EndPosY
  
  return self
  
end

function GenratedMovement.Teleport(self, NewPosX, NewPosY)
  
  self.currentPosX = NewPosX
  self.currentPosY = NewPosY
  
  return self
  
end


function GenratedMovement.getX(self)
  
  return self.currentPosX
  
end

function GenratedMovement.getY(self)
  
  return self.currentPosY
  
end


 function GetMagnatude(x, y)
  
  return math.sqrt((x*x) + (y*y))
  
  end