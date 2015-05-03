require "vector"
require "game"

function love.load()
  game:load()
end

function love.draw()
  game:draw()
  love.graphics.setColor(255, 0, 255, 255)
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
  sprite = love.graphics.newImage("png/bullet.png")
end

function love.update(dt)
  game:update(dt)
end
