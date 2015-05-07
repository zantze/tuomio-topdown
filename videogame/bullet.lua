bullet = {}

vector = require 'vector'

bullets = {}

function bullet:load()
    entities:create('bullet', 4, 4, love.graphics.newImage('png/bullet.png'), 100, 'dynamic')    
end

function bullet:draw()
end

function bullet:update(dt)
  for i, o in ipairs(bullets) do
    
    o.bullet.move(0,-10)
  end
end

function bullet:spawn(x, y, r)
        for i = 1, 1 ,1 do
            table.insert(bullets, {
                bullet = entities:spawn('bullet', x, y, r, 1)
            })
        end
end
