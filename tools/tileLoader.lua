TileLoader = {}

TileLoader.new = function()
  
  local t = {}
  
  t.tilesetImage     = nil
  t.tilesetQuads     = {}
  t.tilesetPositionX = {}
  t.tilesetPositionY = {}
  t.mapfunction  = nil
  t.mapdatatable = nil
  
  setmetatable(t, {__index = TileLoader})
  return t
  
end

function TileLoader:loadMap(level, mapName, imagePath)
  
  self.tilesetImage = love.graphics.newImage("assets/tileSheets/" .. imagePath .. ".png")

  self.mapfunction = love.filesystem.load("assets/tileMaps/" .. mapName .. ".lua")
  self.mapdatatable = self.mapfunction()
  self.maptilesetdata = {}
  
  for i = 1, math.floor(self.tilesetImage:getHeight()/32) do
		for j = 1, math.floor(self.tilesetImage:getWidth()/32) do
        table.insert(self.tilesetQuads, love.graphics.newQuad(32*j-32,32*i-32,32,32,self.tilesetImage:getWidth(),self.tilesetImage:getHeight()))
    end
  end
  
  self.tilesetImage:setFilter("nearest", "nearest")
  
  for x = 1, self.mapdatatable.width do
    self.tilesetPositionX[x] = (x-1)*32
     
    for y = 1, self.mapdatatable.height do
      self.tilesetPositionY[y] = (y-1)*32
    end
  end
  
  for layer = 1, #self.mapdatatable.layers do
    self.maptilesetdata[layer] = {}
    
    for x = 1, self.mapdatatable.width do
      self.maptilesetdata[layer][x] = {}
    end
  end
  
  for layer = 1, #self.mapdatatable.layers do 
    local data = self.mapdatatable.layers[layer].data -- this containts the x any y of the tile
    
    for x = 1, self.mapdatatable.width do --width 64
      for y = 1, self.mapdatatable.height do -- height 64
        local index = (y*self.mapdatatable.height +(x-1)-self.mapdatatable.width)+1 -- creating an index so it converts 1d to 2d
        
        if data[index] ~= 0 then -- checks if the indexed value is not zero
          self.maptilesetdata[layer][x][y] = self.mapdatatable.layers[layer].data[(y-1)*self.mapdatatable.layers[layer].width+x] -- this gets the right tile to display from the quad data     
         
          if self.maptilesetdata[11][x][y] ~= nil then
            if self.maptilesetdata[11][x][y] ~= 0 then
              level.cockpitBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[10][x][y] ~= nil then
            if self.maptilesetdata[10][x][y] ~= 0 then
              level.exitBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[9][x][y] ~= nil then
            if self.maptilesetdata[9][x][y] ~= 0 then
              level.shopBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[8][x][y] ~= nil then
            if self.maptilesetdata[8][x][y] ~= 0 then
             level.endLevelBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[7][x][y] ~= nil then
            if self.maptilesetdata[7][x][y] ~= 0 then
             level.treasureBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[6][x][y] ~= nil then
            if self.maptilesetdata[6][x][y] ~= 0 then
             level.enemySpawnBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[5][x][y] ~= nil then
            if self.maptilesetdata[5][x][y] ~= 0 then
             level.playerSpawnBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[4][x][y] ~= nil then
            if self.maptilesetdata[4][x][y] ~= 0 then
             level.damageableBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[3][x][y] ~= nil then
            if self.maptilesetdata[3][x][y] ~= 0 then
             level.climbableBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[2][x][y] ~= nil then
            if self.maptilesetdata[2][x][y] ~= 0 then
             level.collidableBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
          if self.maptilesetdata[1][x][y] ~= nil then
            if self.maptilesetdata[1][x][y] ~= 0 then
             level.backgroundBlock:create((x-1)*32, (y-1)*32)
            end
          end
          
      end  
     end
    end
  end
  
end

function TileLoader:drawMap()
  
  for layer = 1, #self.maptilesetdata do
    for x = 1, self.mapdatatable.width do
      for y = 1 , self.mapdatatable.height do
        if self.maptilesetdata[layer][x][y] ~= nil then
          love.graphics.draw(self.tilesetImage, self.tilesetQuads[self.maptilesetdata[layer][x][y]], self.tilesetPositionX[x] - 16, self.tilesetPositionY[y])
        end
      end
    end
  end
  
end

return TileLoader