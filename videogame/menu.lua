require 'scene'

menu = {}

function menu:load()
    require 'modules/luafft'

	love.graphics.setDefaultFilter('nearest', 'nearest')
	font_title = love.graphics.newFont('fonts/kenpixel.ttf', 22)
    font_text = love.graphics.newFont('fonts/kenpixel.ttf', 12)

    sound = love.sound.newSoundData('music/test.mp3')
    rate = sound:getSampleRate()
    channels = sound:getChannels()
    samples = sound:getSampleCount()

    music = love.audio.newSource(sound)
    music:setLooping(true)
    music:play()

    spectrum = {}

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

    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.setFont(font_text)
    love.graphics.print(text, x - (font_text:getWidth(text) / 2), y + 2)

    love.graphics.pop()
end

function menu:draw()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()

    love.graphics.push()
    local bgscale = width / 800
	love.graphics.setColor(255, 255, 255, 128)
	love.graphics.draw(menu.girls[menu.back], width / 2 , (height / 2) + (spectrum[2]:abs() * 100), 0, bgscale, bgscale, menu.girls[menu.back]:getWidth() / 2, menu.girls[menu.back]:getHeight() / 2)
    love.graphics.pop()

	menu.button(width / 2, (height / 2) - 50, 'Play Game', 100, 20)

    menu.button(width / 2, (height / 2) - 10, 'Intro', 100, 20)

    love.graphics.translate(width / 2, (height / 2) - 150)
    love.graphics.rotate(0 + math.sin(love.timer.getTime() * 2) / 32)
    love.graphics.translate(-width / 2, -height / 2)
    love.graphics.push()

    color = {}
    color.r = 0
    color.g = 148
    color.b = 255

    local division = 10
    local sd = (#spectrum/division);
    for i = 1, #spectrum/division do
        local width = width / 2
        local dist = width / sd
        local v = spectrum[i]
        local n = height * 2 * v:abs(),0
        
        love.graphics.setColor(color.r, (color.g * (i / sd)) * (spectrum[2]:abs() * 10), color.b, (sd - (i / sd)) * 255)

        love.graphics.rectangle(
            'fill',
            width + ((i - 1) * dist), height / 2 - n / 2,
            10, n
        )

        love.graphics.rectangle(
            'fill',
            width - ((i - 1) * dist), height / 2 - n / 2,
            10, n
        )
    end

    for i = 0, 30 do
        love.graphics.setColor(color.r, (color.g * (i / 30)) * (spectrum[2]:abs() * 10), color.b, (i / 30) * 255)
        if(i == 30) then
        	love.graphics.setColor(255, 255, 255)
        end
        love.graphics.translate(width / 2, height / 2)
        scale = 1 + (math.sin(love.timer.getTime() * 2) / 100)
        love.graphics.scale(1.03 * scale, 1.03 * scale)
        love.graphics.rotate(-0.025 * (math.sin(love.timer.getTime() * 2) / 2))
        love.graphics.translate(-width / 2, -height / 2)
        love.graphics.setFont(font_title)
        text = 'mango hunter'
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

    -- Get the music data
    -- TODO: Calculation breaks near the end
    local curSample = music:tell('samples')
    local wave = {}
    local size = next_possible_size(2048)
    if channels == 2 and curSample + rate < samples then
        for i = curSample, (curSample + (size - 1) / 2) do
            local sample = (sound:getSample(i * 2) + sound:getSample(i * 2 + 1)) * 0.5
            table.insert(wave,complex.new(sample, 0))
        end
    else
        for i = curSample, curSample + (size - 1) do
            table.insert(wave,complex.new(sound:getSample(i), 0))
        end
    end
    
    local spec = fft(wave, false)
    function divide(list, factor)
        for i,v in ipairs(list) do
            list[i] = list[i] / factor
        end
    end

    divide(spec, size / 2)
    spectrum = spec
end

