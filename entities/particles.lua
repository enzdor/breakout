local state = require("state")

	-- local img = love.graphics.newImage('logo.png')
	-- local canvas = love.graphics.newCanvas(10, 10)
	-- love.graphics.setCanvas(canvas)
	-- love.graphics.clear(0, 0, 0, 0)
	-- love.graphics.setBlendMode("alpha")
	-- love.graphics.setColor(1, 0, 0, .5)
	-- love.graphics.rectangle("fill", 0, 0, 100, 100)
	-- love.graphics.setCanvas()

	-- psystem = love.graphics.newParticleSystem(canvas, 32)
	-- psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	-- psystem:setEmissionRate(5)
	-- psystem:setSizeVariation(1)
	-- psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	-- psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

return {
	createParticles = function(x_pos, y_pos, color)
		local entity = {}
		local canvas = love.graphics.newCanvas(10, 10)
		love.graphics.setCanvas(canvas)
		love.graphics.clear(0, 0, 0, 0)
		love.graphics.setBlendMode("alpha")
		love.graphics.setColor(state.palette[color])
		love.graphics.rectangle("fill", 0, 0, 100, 100)
		love.graphics.setCanvas()

		local particle_system = love.graphics.newParticleSystem(canvas, 32)
		particle_system:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
		particle_system:setEmissionRate(5)
		particle_system:setEmitterLifetime(0.5)
		particle_system:setSizeVariation(1)
		particle_system:setLinearAcceleration(-200, -200, 200, 200) -- Random movement in all directions.
		particle_system:setColors(1, 1, 1, 1, 1, 1, 1, 0) -- Fade to transparency.

		entity.particle_system = particle_system
		entity.x_pos = x_pos
		entity.y_pos = y_pos

		return entity
	end,
	particles = {}
}
