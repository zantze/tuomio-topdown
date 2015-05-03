bullet = {}

vector = require 'vector'

bullets = {}

function bullet:load()

end

function bullet:draw()
  for i, o in ipairs(bullets) do
    love.graphics.draw(sprite, o.pos.x, o.pos.y, 0)
  end
end

function bullet:update(dt)
  for i, o in ipairs(bullets) do
    o.pos = o.pos + vector(0, -speed * dt):rotated(math.rad(o.rot))
  end
end

function bullet:spawn(x, y, r)
  table.insert(bullets, {
    pos = vector (x, y),
    rot = r,
    speed = 400
  })
end
