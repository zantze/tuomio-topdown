scene = {}
scene.scenes = {}
scene.active = nil

function scene.add(name, s)
	scene.scenes[name] = s
	if scene.active == nil then
		scene.active = name
		scene.scenes[name]:load()
	end
end

function scene.change(s)
	scene.active = s;
	scene.scenes[s]:load()
	love.graphics.setColor(255, 255, 255, 255)
end

function scene:update(dt)
	scene.scenes[scene.active]:update(dt)
end

function scene:draw()
	scene.scenes[scene.active]:draw()
end