local state = require("state")
local entities = require("entities")

local press_functions = {
	left = function()
		state.left = true
	end,
	right = function()
		state.right = true
	end,
	a = function()
		state.left = true
	end,
	d = function()
		state.right = true
	end,
	escape = function()
		love.event.quit()
	end,
	space = function()
		if state.game_over or state.won then
			if state.game_over or state.won then
				state.lifes = 3
				state.stage = 1
				state.game_started = false
			end
			state.won = false
			state.game_over = false
			state.stage_cleared = false
			state.changed_entities = false
			state.life_lost = false
		elseif not state.game_started or state.life_lost or state.stage_cleared then
			state.stage_cleared = false
			state.game_started = true
			state.life_lost = false
			state.changed_entities = false
			if state.stage == 1 then
				for _, entity in ipairs(entities.entities) do
					if entity.type == "ball" then
						math.randomseed(os.time())
						local sign = math.random(-1, 1)
						if sign > 0 then
							entity.body:setLinearVelocity(math.random(400, 500), 500)
						else
							entity.body:setLinearVelocity(math.random(-400, -500), 500)
						end
					end
				end
			else
				for _, entity in ipairs(entities.entities) do
					if entity.type == "ball" then
						math.randomseed(os.time())
						local sign = math.random(-1, 1)
						if sign > 0 then
							entity.body:setLinearVelocity(math.random(500, 600), 600)
						else
							entity.body:setLinearVelocity(math.random(-500, -600), 600)
						end
					end
				end
			end
		else
			state.paused = not state.paused
		end
	end,
}
local release_functions = {
	left = function()
		state.left = false
	end,
	right = function()
		state.right = false
	end,
	a = function()
		state.left = false
	end,
	d = function()
		state.right = false
	end
}

return {
	press = function(pressed_key)
		if press_functions[pressed_key] then
			press_functions[pressed_key]()
		end
	end,
	release = function(released_key)
		if release_functions[released_key] then
			release_functions[released_key]()
		end
	end,
	toggle_focus = function(f)
		if not f and not state.game_over and state.game_started then
			state.paused = true
		end
	end
}
