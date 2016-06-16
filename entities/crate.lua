Crate = class('Crate')

function Crate:initialize(x, y, map)
	self.x, self.y = x, y
	self.color = {0, 0, 255}
	self.map = map

	self.dx, self.dy = 0, 1
end

function Crate:action(step)
	self.map:queueMove(self, self.x+self.dx, self.y+self.dy)
end

function Crate:moveOver(obj)
	--self.dx, self.dy = obj.dx, obj.dy
end