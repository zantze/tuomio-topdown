entities = {}
entities.loaded = {}
entities.list = {}

vector = require 'vector'
entities.world = love.physics.newWorld(0, 0, true)

function entities:create(name, w, h, texture, health, type)
  health = health or 10
  type = type or 'static'
  entities.loaded[name] = {
    name = name,
    w = w,
    h = h,
    texture = texture,
    health = health,
    type = type
  }
end

function entities:spawn(name, x, y, r, s)
  local entity = {}
  entity.pos = vector(x, y)
  entity.rot = r
  entity.scale = s
  entity.w = entities.loaded[name].w
  entity.h = entities.loaded[name].h
  entity.texture = entities.loaded[name].texture
  entity.health = entities.loaded[name].health
  entity.body = love.physics.newBody(entities.world, x, y, entities.loaded[name].type)
  entity.body:setLinearDamping(10)
  entity.shape = love.physics.newRectangleShape(entities.loaded[name].w * s, entities.loaded[name].h * s)
  entity.fixture = love.physics.newFixture(entity.body, entity.shape, 10)

  entity.move = function (x, y)
    --entity.pos = entity.pos + vector(x, y):rotated(math.rad(entity.rot))
    --entity.body:setPosition(entity.pos.x, entity.pos.y)
    vel = vector(x, y):rotated(math.rad(entity.rot))
    entity.body:setLinearVelocity(vel.x * 40, vel.y * 40)
  end

  entity.rotate = function (r)
    entity.rot = math.deg(math.rad(entity.rot + r))
  end

  entity.destroy = function ()
    table.remove(entities.list, entity)
  end

  id = #entities.list + 1
  entities.list[id] = entity
  return entities.list[id]
end

function entities:update(dt)
  entities.world:update(dt)

  for entity in pairs(entities.list) do
    entity = entities.list[entity]
    entity.pos.x = entity.body:getX()
    entity.pos.y = entity.body:getY()
  end
end

function entities:draw()
  love.graphics.setColor(255, 255, 255, 255)
  for entity in pairs(entities.list) do
    entity = entities.list[entity]
    s = entity.scale
    --love.graphics.rectangle('fill', entity.body:getX() - (entity.w / (2 / entity.scale)), entity.body:getY() - (entity.h / (2 / entity.scale)), entity.w * s, entity.h * s)
    love.graphics.draw(entity.texture, entity.pos.x, entity.pos.y, math.rad(entity.rot), s, s, entity.texture:getWidth() / 2, entity.texture:getHeight() / 2)
  end
end
