game =  {}
require "scene"

require "player"
require "intro"

function game:load()
	--scene.add('intro', intro)
	scene.add('player', player)
end

function game:draw()
	scene:draw()
end

function game:update(dt)
	scene:update(dt)
end