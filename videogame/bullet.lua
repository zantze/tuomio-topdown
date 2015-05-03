bullet = {}

vector = require 'vector'

bullets = {}

function bullet:load()
    sprite = love.graphics.newImage("png/bullet.png"
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

function bullet:spawn()

    table.insert(bullets,{
            pos = vector (player.pos.x,player.pos.y),
            rot = player.rot,
            speed = 200
        })
    end 

