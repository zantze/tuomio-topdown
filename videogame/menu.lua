require "scene"

menu = {}

function menu:load()
	love.graphics.setDefaultFilter('nearest', 'nearest')
	font_title = love.graphics.newFont('fonts/kenpixel.ttf', 22)
	menu.start = love.graphics.newImage('png/start.png')
	menu.options = love.graphics.newImage('png/options.png')
	menu.exit = love.graphics.newImage('png/exit.png')

	menu.girls = {}
	menu.girls[0] = love.graphics.newImage('anime/0.jpg')
	menu.girls[1] = love.graphics.newImage('anime/1.jpg')
	menu.girls[2] = love.graphics.newImage('anime/2.jpg')
	menu.girls[3] = love.graphics.newImage('anime/3.jpg')
	menu.back = 0
	menu.timer = 5

	menu.scale = 2;
end

function menu.button(x, y, text, w, h)
	--love.graphics.translate(x + w, y + h)
    --love.graphics.rotate(0 + math.sin(love.timer.getTime() * 2) / 32)
    --love.graphics.translate(x - w, y - h)
    love.graphics.push()
    for i = 0, 30 do
        color = {}
        color.r = 0
        color.g = 148
        color.b = 255
        love.graphics.setColor(color.r, (color.g * (i / 30)) * math.sin(love.timer.getTime() * 5), color.b, (i / 30) * 255)
        if(i == 30) then
        	love.graphics.setColor(255, 255, 255)
        end
        scale = 1 + (math.sin(love.timer.getTime() * 2) / 200)
        love.graphics.translate(0, math.sin(love.timer.getTime() * 2) / 5)
        love.graphics.rotate(-0.002 * (math.sin(love.timer.getTime() * 2) / 2))
        love.graphics.rectangle('fill', x - (w / 2), y, w, h);
    end
    love.graphics.pop()
end

function menu:draw()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()

	love.graphics.setColor(255, 255, 255, 128)
	love.graphics.draw(menu.girls[menu.back], width / 2 , height / 2, 0, 1, 1, menu.girls[menu.back]:getWidth() / 2, menu.girls[menu.back]:getHeight() /2)

	menu.button(width / 2, (height / 2) - 50, 'Play Game', 100, 20)

    love.graphics.translate(width / 2, (height / 2) - 150)
    love.graphics.rotate(0 + math.sin(love.timer.getTime() * 2) / 32)
    love.graphics.translate(-width / 2, -height / 2)
    love.graphics.push()
    for i = 0, 30 do
        color = {}
        color.r = 0
        color.g = 148
        color.b = 255
        love.graphics.setColor(color.r, (color.g * (i / 30)) * math.sin(love.timer.getTime() * 5), color.b, (i / 30) * 255)
        if(i == 30) then
        	love.graphics.setColor(255, 255, 255)
        end
        love.graphics.translate(width / 2, height / 2)
        scale = 1 + (math.sin(love.timer.getTime() * 2) / 100)
        love.graphics.scale(1.03 * scale, 1.03 * scale)
        love.graphics.rotate(-0.025 * (math.sin(love.timer.getTime() * 2) / 2))
        love.graphics.translate(-width / 2, -height / 2)
        love.graphics.setFont(font_title)
        text = 'tuom.io'
        love.graphics.print(text, (width / 2) - (font_title:getWidth(text) / 2), (height / 2) - (font_title:getHeight(text) / 2))
    end
    love.graphics.pop()
end

function menu:update(dt)
	menu.timer = menu.timer - dt
	if menu.timer <= 0 then
		menu.timer = 5
		menu.back = menu.back + 1
		if menu.back > #menu.girls then
			menu.back = 0
		end
	end
end