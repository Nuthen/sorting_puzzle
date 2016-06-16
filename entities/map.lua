Map = class('Map')

function Map:initialize(c, r)
	self.columns, self.rows = c, r
	self.tileWidth, self.tileHeight = 64, 64
	self.width, self.height = c * self.tileWidth, r*self.tileHeight

	self.map = {}
	for iy = 1, r do
		self.map[iy] = {}
		for ix = 1, c do
			self.map[iy][ix] = 0
		end
	end

	self.moveQueue = {}
	self.moveQueueQueue = {}
end

function Map:draw()
	local w, h = self.tileWidth, self.tileHeight

	for iy = 1, self.rows do
		for ix = 1, self.columns do
			local x, y = (ix-1) * w, (iy-1) * h

			local isObj = false
			local obj = self.map[iy][ix]

			if obj == 0 then
				love.graphics.setColor(255, 255, 255)
			else
				isObj = true
				love.graphics.setColor(obj.color)
			end

			love.graphics.rectangle('fill', x, y, w, h)
			love.graphics.setColor(0, 0, 0)
			love.graphics.rectangle('line', x, y, w, h)

			if isObj and obj.draw then
				obj:draw()
			end
		end
	end
end

function Map:action()
	for iy = 1, self.rows do
		for ix = 1, self.columns do
			if self.map[iy][ix] == 0 then
			else
				local obj = self.map[iy][ix]
				obj:action()
			end
		end
	end

	self:moveAll()
end

function Map:add(obj)
	self.map[obj.y][obj.x] = obj
end

function Map:remove(obj)
	self.map[obj.y][obj.x] = 0
end

function Map:queueMove(obj, x, y)
	table.insert(self.moveQueue, {obj = obj, x = x, y = y})
end

function Map:queueMoveQueue(obj, x, y)
	table.insert(self.moveQueueQueue, {obj = obj, x = x, y = y})
end

function Map:moveAll()
	for i, move in ipairs(self.moveQueue) do
		local obj = move.obj
		local toX = move.x
		local toY = move.y
		local fromX = obj.x
		local fromY = obj.y

		if toX > 0 and toY > 0 and toX <= self.columns and toY <= self.rows then
			local obj2 = self.map[toY][toX]
			if obj2 == 0 then
				self:remove(obj)
				obj.x = toX
				obj.y = toY
				self:add(obj)
			elseif obj2.moveOver then
				obj2:moveOver(obj)
			end
		end
	end

	self.moveQueue = {}
	for i, move in ipairs(self.moveQueueQueue) do
		table.insert(self.moveQueue, move)
	end
	self.moveQueueQueue = {}
end

function Map:addArrow(xPos, yPos, mbutton)
	local x, y = math.floor(xPos / self.tileWidth) + 1, math.floor(yPos / self.tileHeight) + 1

	if x > 0 and y > 0 and x <= self.columns and y <= self.rows then
		if mbutton == 1 then
			self:add(Arrow:new(x, y, self))
		elseif mbutton == 2 then
			local obj = self.map[y][x]
			if obj ~= 0 then
				if obj.clicked then
					obj:clicked()
				end
			end
		end
	end
end