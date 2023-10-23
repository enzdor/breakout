local state = require("state")

local world = love.physics.newWorld(0, 0)

local end_contact_callback = function(fixture_a, fixture_b, contact)
	local entity_a = fixture_a:getUserData()
	local entity_b = fixture_b:getUserData()
	if (entity_a.type == "ball" and entity_b.type == "paddle") or (entity_a.type == "paddle" and entity_b.type == "ball") then
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
