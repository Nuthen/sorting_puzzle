Spawner = class('Spawner')

function Spawner:initialize(x, y, map)
	self.x, self.y = x, y
	self.color = {124, 0, 255}
	self.map = map
end

function Spawner:action(step)
	self.map:add(Crate:new(self.x, self.y+1, self.map))
end