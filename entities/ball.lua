local world = require("world")
local state = require("state")

return function(x_pos, y_pos)
	local entity = {}
	local entity_max_speed = 1200

	entity.body = love.physics.newBody(world, x_pos, y_pos, 'dynamic')
	entity.body:setFixedRotation(true)
	entity.shape = love.physics.newRectangleShape(0, 0, 20, 20)
	entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setRestitution(1)
	entity.fixture:setFriction(0)
	entity.fixture:setUserData(entity)

	entity.type = "ball"

	entity.draw = function(self)
		love.graphics.setColor(state.palette[6])
		love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
	end

	entity.update = function(self)
		local self_x = self.body:getX()
		if self_x > state.screen.width or self_x < 0 then
			state.sounds.plop:play()
			state.combo = 0
			state.lifes = state.lifes - 1
			state.life_lost = true
			if state.lifes <= 0 then
				state.game_over = true
				state.life_lost = false
				state.lifes = 3
			end
		end

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
			self.body:setLinearVelocity(450, vel_y)
		end
		if vel_y == 0 then
			self.body:setLinearVelocity(vel_x, 450)
		end
	end

	return entity
end
