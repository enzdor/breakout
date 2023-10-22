local world = require("world")
local state = require("state")

return function(x_pos, y_pos)
	local entity = {}
	local entity_max_speed = 1200

	entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
	entity.shape = love.physics.newCircleShape(0, 0, 10)
	entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setRestitution(1)
	entity.fixture:setFriction(0)
	entity.fixture:setUserData(entity)

	entity.type = "ball"

	entity.draw = function(self)
		love.graphics.setColor(state.palette[5])
		local self_x, self_y = self.body:getWorldCenter()
		love.graphics.circle("fill", self_x, self_y, self.shape:getRadius())
	end

	entity.update = function (self)
		local vel_x, vel_y = self.body:getLinearVelocity()
		local speed = math.abs(vel_x) + math.abs(vel_y)

		local vel_x_is_critical = math.abs(vel_x) > entity_max_speed * 2
		local vel_y_is_critical = math.abs(vel_y) > entity_max_speed * 2
		if vel_x_is_critical or vel_y_is_critical then
			self.body:setLinearVelocity(vel_x * 0.75, vel_y * 0.75)
		end

		if speed > entity_max_speed then
			self.body:setLinearDamping(0.1)
		else
			self.body:setLinearDamping(0)
		end

		if vel_x == 0 then
			self.body:setLinearVelocity(300, vel_y)
		end
		if vel_y == 0 then
			self.body:setLinearVelocity(vel_x, 300)
		end
	end

	return entity
end
