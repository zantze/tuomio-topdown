player = {}

require 'mapper'
require 'entities'
require 'bullet'

vector = require 'vector'

shootTimer = 100

function player:load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	entities:create('barrel', 10, 16, love.graphics.newImage('png/berrel.png'), 10, 'dynamic')
	entities:create('player', 18, 18, love.graphics.newImage('png/player.png'), 100, 'dynamic')

	player.texture = love.graphics.newImage("png/player.png")
	player.map = mapper.load('maps/kerava.map')
  
    bullet:load()

	player.player = entities:spawn('player', 100, 100, 0, 1)

	entities:spawn('barrel', 200, 200, 0, 2)
	entities:spawn('barrel', 300, 200, 0, 2)
	entities:spawn('barrel', 250, 300, 0, 2)
	entities:spawn('barrel', 400, 250, 0, 2)
end

function player:draw()
  love.graphics.setColor(255, 255, 255, 255)
	map:draw()
	entities:draw()
  bullet:draw()
end

function player:update(dt)
  bullet:update(dt)
shootTimer = shootTimer + 1
	entities:update(dt)

	speed = 100
  rotspeed = 500
	if love.keyboard.isDown('w') then
		player.player.move(0, -speed * dt)
	elseif love.keyboard.isDown('s') then
		player.player.move(0, speed * dt)
	end

	if love.keyboard.isDown('d') then
		player.player.rotate(rotspeed * dt)
	elseif love.keyboard.isDown('a') then
		player.player.rotate(-rotspeed * dt)
	end

	if love.keyboard.isDown('x') then
        if shootTimer > 10 then
		    bullet:spawn(player.player.pos.x, player.player.pos.y, player.player.rot)
            shootTimer = 0
            end
	end
end
