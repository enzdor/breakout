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
		if state.game_over or state.stage_cleared then
			state.game_over = false
			state.stage_cleared = false
			state.game_started = false
		elseif not state.game_started then
			state.game_started = true
			for _, entity in ipairs(entities.entities) do
				if entity.type == "ball" then
					math.randomseed(os.time())
					entity.body:setLinearVelocity(math.random(450, 500), 500)
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
