require "vector"
require "game"

function love.load()
  game:load()
end

function love.draw()
  game:draw()
  love.graphics.setColor(255, 0, 255, 255)
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

function love.update(dt)
  speed = 100
  rotspeed = 500
  if love.keyboard.isDown('w') then
      player:translate(0, -speed * dt)
  elseif love.keyboard.isDown('s') then
      player:translate(0, speed * dt)
  end
  if love.keyboard.isDown('d') then
      player:rotate(rotspeed * dt)
  elseif love.keyboard.isDown('a') then
      player:rotate(-rotspeed * dt)
  end
  
  game:update(dt)
end

function love.keypressed(key)
  
end