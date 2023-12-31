local world = require("world")
local state = require("state")

return function(x_pos, y_pos)
	local entity = {}
	entity.body = love.physics.newBody(world, x_pos, y_pos, "static")
	entity.shape = love.physics.newRectangleShape(10, 900)
	entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)

	entity.type = "boundary v"

	entity.draw = function(self)
		love.graphics.setColor(state.palette[6])
		love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
	end

	return entity
end
