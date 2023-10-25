local world = require("world")
local state = require("state")

return function(x_pos, y_pos, color, id)
	local entity = {}

	local i = 0
	while i < 10 do
		math.randomseed(os.time())
		local particle = {}

		particle.body = love.physics.newBody(world, x_pos, y_pos, "dynamic")
		particle.shape = love.physics.newRectangleShape(2, 2)
		particle.fixture = love.physics.newFixture(particle.body, particle.shape)
		particle.body:setLinearVelocity(math.random(-200, 200), math.random(-200, 200))
		particle.fixture:setUserData(particle)
		table.insert(entity, particle)
		i = i + 1
	end
	entity.id = id

	entity.draw = function(self)
		for _, particle in ipairs(self) do
			love.graphics.setColor(state.palette[color])
			love.graphics.polygon("fill", particle.body:getWorldPoints(particle.shape:getPoints()))
		end
	end

	return entity
end
