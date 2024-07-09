Arrow = Object:extend()

function Arrow:new(x, y, r)
	self.img = love.graphics.newImage("assets/images/arrow.png")
	self.x = x
	self.y = y
	self.r = r
	self.speed = 400
	self.w = self.img:getWidth()
	self.h = self.img:getHeight()
end

function Arrow:update(dt)
	self.x = self.x + self.speed * math.cos(self.r) * dt
    self.y = self.y + self.speed * math.sin(self.r) * dt
end

function Arrow:draw()
	love.graphics.draw(self.img, self.x, self.y, self.r + math.pi * 1.5, 1, 1, self.w / 2, self.h / 2)
end