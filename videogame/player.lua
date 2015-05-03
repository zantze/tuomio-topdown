player = {}

require 'mapper'
require 'bullet'

vector = require 'vector'

function player:load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	player.texture = love.graphics.newImage("png/player.png")
	player.map = mapper.load('maps/kerava.map')
    bullet:load()
end

player.pos = vector(128, 128)
player.rot = 0

function player:draw(i)
        
    love.graphics.setColor(255, 255, 255, 255)
	map:draw()
    bullet:draw()  
	love.graphics.draw(player.texture, player.pos.x, player.pos.y, math.rad(player.rot), 1, 1, player.texture:getWidth() / 2, player.texture:getHeight() / 2)
      
end

function player:update(dt)
    bullet:update(dt)
end

function player:translate(x, y)
	player.pos = player.pos + vector(x, y):rotated(math.rad(player.rot))
end

function player:rotate(angle)
	player.rot = math.deg(math.rad(player.rot + angle))
end

function player:shoot()
    bullet:spawn()
end
