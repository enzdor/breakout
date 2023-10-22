local world = require("world")
local state = require("state")

return function(x_pos, y_pos)
	local widnow_width = state.screen.width
	local entity = {}
	local entity_width = 120
	local entity_height = 20
	local entity_speed = 600

	local left_boundary = (entity_width / 2) - 2
	local right_boundary = widnow_width - (entity_width / 2) - 2

	entity.body = love.physics.newBody(world, x_pos, y_pos, "kinematic")
	entity.shape = love.physics.newRectangleShape(entity_width, entity_height)
	entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)

	entity.draw = function(self)
		love.graphics.setColor(state.palette[3])
		love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	end

	entity.update = function(self)
		if (state.left and state.right) then
			return
		end

		local self_x = self.body:getX()
		if state.left and self_x > left_boundary then
			self.body:setLinearVelocity(-entity_speed, 0)
		elseif state.right and self_x < right_boundary then
			self.body:setLinearVelocity(entity_speed, 0)
		else
			self.body:setLinearVelocity(0, 0)
		end
	end

	return entity
end
