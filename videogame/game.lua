game =  {}
require "scene"

require "player"
require "menu"
require "intro"

function game:load()
	--scene.add('intro', intro)
	scene.add('menu', menu)
	scene.add('player', player)
end

function game:draw()
	scene:draw()
end

function game:update(dt)
	scene:update(dt)
end