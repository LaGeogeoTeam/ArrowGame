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
	if self.r == math.rad(-90) then -- droite
		self.x = self.x + self.speed * dt
	elseif self.r == math.rad(90) then -- gauche
		self.x = self.x - self.speed * dt
	elseif self.r == math.rad(0) then -- bas
		self.y = self.y + self.speed * dt
	elseif self.r == math.rad(180) then -- haut
		self.y = self.y - self.speed * dt
	end
end

function Arrow:draw()
	love.graphics.draw(self.img, self.x, self.y, self.r)
end