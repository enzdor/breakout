local state = require("state")

return {
	createParticles = function(x_pos, y_pos, color)
		local entity = {}
		local img = love.graphics.newImage('resources/particle.png')
		local rgba = state.palette[color]

		local particle_system = love.graphics.newParticleSystem(img, 32)
		particle_system:setParticleLifetime(1, 1)
		particle_system:setEmissionRate(100)
		particle_system:setEmitterLifetime(0.1)
		particle_system:setSizeVariation(1)
		particle_system:setLinearAcceleration(-200, -200, 200, 200) -- Random movement in all directions.
		particle_system:setColors(rgba[1], rgba[2], rgba[3], rgba[4], rgba[1], rgba[2], rgba[3], 0) -- Fade to transparency.

		entity.particle_system = particle_system
		entity.x_pos = x_pos + 25
		entity.y_pos = y_pos + 10

		return entity
	end,
	particles = {}
}
