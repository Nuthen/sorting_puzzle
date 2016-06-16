Arrow = class('Arrow')

function Arrow:initialize(x, y, map)
	self.x, self.y = x, y
	self.color = {0, 255, 155}
	self.map = map

	self.img = love.graphics.newImage('assets/img/arrow.png')

	self.lastStep = 0

	self.angle = 0
	self.dir = 'S'
end

function Arrow:action()

end

function Arrow:clicked()
	if     self.dir == 'S' then self.dir = 'W' self.angle = 90
	elseif self.dir == 'W' then self.dir = 'N' self.angle = 180
	elseif self.dir == 'N' then self.dir = 'E' self.angle = 270
	elseif self.dir == 'E' then self.dir = 'S' self.angle = 0
	end
end

function Arrow:moveOver(obj)
	local dx, dy = 0, 0
	if self.dir == 'S' then dy =  1 end
	if self.dir == 'W' then dx = -1 end
	if self.dir == 'N' then dy = -1 end
	if self.dir == 'E' then dx =  1 end

	--self.map:queueMoveQueue(obj, self.x + dx, self.y + dy)
	obj.dx, obj.dy = dx, dy
end

function Arrow:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.img, (self.x-1) * self.map.tileWidth + self.map.tileWidth/2, (self.y-1) * self.map.tileHeight + self.map.tileHeight/2, math.rad(self.angle), 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end