local world = require("world")
local state = require("state")

return function(x_pos, y_pos)
	local entity = {}
	entity.body = love.physics.newBody(world, x_pos, y_pos, "static")
	entity.shape = love.physics.newRectangleShape(800, 10)
	entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)

	entity.type = "boundary b"

	entity.end_contact = function()
		state.lifes = state.lifes - 1
		state.life_lost = true
		if state.lifes <= 0 then
			state.game_over = true
			state.life_lost = false
			state.lifes = 3
		end
	end

	entity.draw = function(self)
		love.graphics.setColor(state.palette[6])
		love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
	end

	return entity
end
