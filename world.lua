local state = require("state")
local particles = require("entities/particles")

local world = love.physics.newWorld(0, 0)

local end_contact_callback = function(fixture_a, fixture_b)
	local entity_a = fixture_a:getUserData()
	local entity_b = fixture_b:getUserData()

	if (entity_a.type == "ball" and not (entity_b.type == "boundary b")) or (entity_b.type == "ball" and not (entity_a.type == "boundary b")) then
		state.sounds.beep:play()
	end

	if (entity_a.type == "ball" and entity_b.type == "paddle") or (entity_a.type == "paddle" and entity_b.type == "ball") then
		state.score = state.score + state.combo_score * state.combo
		state.combo_score = 0
		state.combo = 0
		if entity_a.type == "ball" then
			local vel_x, vel_y = entity_a.body:getLinearVelocity()
			if (state.right == true and vel_x < 0) or (state.left == true and vel_x > 0) then
				entity_a.body:setLinearVelocity(vel_x * -1, vel_y)
			end
		else
			local vel_x, vel_y = entity_b.body:getLinearVelocity()
			if (state.right == true and vel_x < 0) or (state.left == true and vel_x > 0) then
				entity_b.body:setLinearVelocity(vel_x * -1, vel_y)
			end
		end
	end

	if (entity_a.type == "ball" and entity_b.type == "brick") or (entity_a.type == "brick" and entity_b.type == "ball") then
		if entity_a.type == "ball" then
			local x, y = entity_b.body:getWorldPoints(entity_b.shape:getPoints())
			local p = particles.createParticles(x, y, entity_b.color)
			table.insert(particles.particles, p)
		elseif entity_b.type == "ball" then
			local x, y = entity_a.body:getWorldPoints(entity_a.shape:getPoints())
			local p = particles.createParticles(x, y, entity_a.color)
			table.insert(particles.particles, p)
		end
		state.combo = state.combo + 1
	end
	if entity_a.end_contact then
		entity_a:end_contact()
	end
	if entity_b.end_contact then
		entity_b:end_contact()
	end
end

world:setCallbacks(
	nil,
	end_contact_callback,
	nil,
	nil
)

return world
