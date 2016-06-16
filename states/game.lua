game = {}

-- Game TODO:
--      * Add identity and title to conf.lua

function game:enter()
    self.map = Map:new(29, 29)
    
    self.map:add(Spawner:new(15, 1, self.map))

    self.step = 0
end

function game:update(dt)

end

function game:keypressed(key, code)
	if key == "space" then
		self.step = self.step + 1
		self.map:action()
	end
end

function game:mousepressed(x, y, mbutton)
	self.map:addArrow(x, y, mbutton)
end

function game:draw()
    love.graphics.setColor(255, 255, 255)
    local text = "This is the game"
    love.graphics.setFont(font[48])
    local x = love.graphics.getWidth()/2 - love.graphics.getFont():getWidth(text)/2
    local y = love.graphics.getHeight()/2 - love.graphics.getFont():getHeight(text)/2
    
    self.map:draw()
end