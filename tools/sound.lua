function soundLoad()
  
  --[[Music]]--
  sounds.platformerMusic = love.audio.newSource("assets/audio/platformerMusic.mp3", "stream")
  sounds.shipMusic       = love.audio.newSource("assets/audio/shipMusic.mp3", "stream")
  
  sounds.currentMusic = sounds.shipMusic
  
  --[[Global Sound Effects]]--
  sounds.gameOver = love.audio.newSource("assets/audio/gameOver.wav", "static")
  sounds.winLevel = love.audio.newSource("assets/audio/winLevel.wav", "static")
  
  --[[Platformer Sound Effects]]--
  sounds.platformerBulletFire    = love.audio.newSource("assets/audio/platformerBulletFire.wav", "static")
  sounds.platformerDamaged       = love.audio.newSource("assets/audio/platformerDamaged.wav", "static")
  sounds.platformerEnemyHit      = love.audio.newSource("assets/audio/platformerEnemyHit.wav", "static")
  sounds.platformerEnemyJump     = love.audio.newSource("assets/audio/platformerEnemyJump.wav", "static")
  sounds.platformerEnemyKilled   = love.audio.newSource("assets/audio/platformerEnemyKilled.wav", "static")
  sounds.platformerJump          = love.audio.newSource("assets/audio/platformerJump.wav", "static")
  sounds.platformerTreasure      = love.audio.newSource("assets/audio/platformerTreasure.wav", "static")
  
end

function soundUpdate()
  
  sounds.currentMusic:isLooping(true)
  sounds.currentMusic:setVolume(0.5)
  
end


-- soundEffect = love.audio.newSource("assets/audio/soundeffect.wav")