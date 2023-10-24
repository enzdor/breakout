local world = require("world")
local entities = require("entities")
local input = require("input")
local state = require("state")
local ball = require("entities/ball")

love.load = function()
	local myFont = love.graphics.setNewFont("resources/roboto-regular.ttf", 32)
	myFont:setFilter("nearest", "nearest")
	entities.entities = entities.newEntities()
	state.loading = false
end

love.draw = function()
	local window_width, window_height = love.window.getMode()
	if window_width / window_height > state.screen.ratio then
		local change_rate = window_height / state.screen.height
		love.graphics.translate((window_width - change_rate * state.screen.width) / 2, 0)
		love.graphics.scale(change_rate, change_rate)
	else
		love.graphics.scale(window_width / state.screen.width, window_height / state.screen.height)
	end
	if not state.loading then
		for _, entity in ipairs(entities.entities) do
			if entity.draw then
				entity:draw()
			end
		end
	end
end

love.focus = function(f)
	input.toggle_focus(f)
end

love.keypressed = function(pressed_key)
	input.press(pressed_key)
end

love.keyreleased = function(released_key)
	input.release(released_key)
end


love.update = function(dt)
	if (state.game_over and not state.changed_entities) or (state.stage_cleared and not state.changed_entities) then
		if state.stage_cleared then
			state.stage = state.stage + 1
			if state.stage > 2 then
				state.won = true
			end
		end
		while 1 <= #entities.entities do
			if entities.entities[1].fixture then
				entities.entities[1].fixture:destroy()
			end
			table.remove(entities.entities, 1)
		end
		entities.entities = entities.newEntities()
		state.changed_entities = true
	end

	if (state.life_lost and not state.changed_entities) then
		local i = 1
		while i <= #entities.entities do
			if entities.entities[i].type == "ball" then
				math.randomseed(os.time())
				entities.entities[i].fixture:destroy()
				table.remove(entities.entities, i)
				entities.entities[#entities.entities + 1] = ball(math.random(100, 700), 300)
				state.changed_entities = true
			end
			i = i + 1
		end
	end

	if state.game_over or state.paused then
		return
	elseif state.stage_cleared or not state.game_started or state.life_lost then
		for _, entity in ipairs(entities.entities) do
			if entity.type == "paddle" then
				entity:update(dt)
				world:update(dt)
				return
			end
		end
	end


	local have_bricks = false

	local i = 1
	while i <= #entities.entities do
		local entity = entities.entities[i]
		if entity.type == "brick" then
			have_bricks = true
		end
		if entity.update then
			entity:update(dt)
		end
		if entity.health == 0 then
			table.remove(entities.entities, i)
			entity.fixture:destroy()
			state.combo_score = state.combo_score + 10
		else
			i = i + 1
		end
	end

	state.stage_cleared = not have_bricks
	if state.stage_cleared == true then
		state.score = state.score + state.combo_score * state.combo
	end
	world:update(dt)
end
