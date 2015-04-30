require "scene"

intro = {}

function intro:load()
	intro.logo = love.graphics.newImage('png/tuomio.png')
end

local logoscale = 0.5
local angle = math.rad(330)
local tuomas = 255
local bgcolor = {r=255,g=255,b=255} 


function intro:draw()

	width = love.graphics.getWidth()
	height = love.graphics.getHeight()

	love.graphics.setBackgroundColor( bgcolor.r, bgcolor.g, bgcolor.b )
	love.graphics.setColor( 255, 255, 255, tuomas )
    love.graphics.draw(intro.logo, width / 2 , height / 2 ,angle,logoscale,logoscale, intro.logo:getWidth() / 2, intro.logo:getHeight() /2 )
end

function intro:update(dt)

	logoscale = logoscale + ( dt * 0.01)
	angle = math.rad(math.deg(angle)+ 5 * dt) 
	if math.deg(angle) > 359 then

    	if tuomas > 1 then
    	tuomas = tuomas - 80 * dt
		end
	end 

    if tuomas <= 1 then
        print('change')
        scene.change('player')
    end 
end