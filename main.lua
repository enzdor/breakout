local utf8 = require("utf8")
local world = require("world")
local entities = require("entities")
local input = require("input")
local state = require("state")
local particles = require("entities/particles")
local ball = require("entities/ball")

love.load = function()
	-- local myFont = love.graphics.setNewFont("resources/Roboto-Bold.ttf", 32)
	-- local myFont = love.graphics.setNewFont("resources/Roboto-Regular.ttf", 32)
	local myFont = love.graphics.setNewFont("resources/VT323-Regular.ttf", 52)
	myFont:setFilter("nearest", "nearest")
	entities.entities = entities.newEntities()
	state.loading = false
	love.keyboard.setTextInput(false)
	love.keyboard.setKeyRepeat(true)
	local beep = love.audio.newSource("resources/ping_pong_8bit_beeep.ogg", "static")
	local plop = love.audio.newSource("resources/ping_pong_8bit_plop.ogg", "static")
	love.audio.setVolume(0.25)
	state.sounds = {
		beep = beep,
		plop = plop
	}
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
		for _, particle in ipairs(particles.particles) do
			love.graphics.draw(particle.particle_system, particle.x_pos,
				particle.y_pos)
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
	if released_key == "backspace" then
		-- get the byte offset to the last UTF-8 character in the string.
		local byteoffset = utf8.offset(state.name, -1)

		if byteoffset then
			-- remove the last UTF-8 character.
			-- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
			state.name = string.sub(state.name, 1, byteoffset - 1)
		end
	end
	input.release(released_key)
end

love.textinput = function(t)
	if string.len(state.name) < 4 then
		if not t:match("%W") then
			state.name = state.name .. string.upper(t)
		end
	end
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
		while 1 <= #particles.particles do
			table.remove(particles.particles, 1)
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
		if state.won and not state.checked_high_score then
			for _, score in ipairs(state.high_scores) do
				local found = false
				if score.score < state.score and not found then
					found = true
					state.high_score = true
					love.keyboard.setTextInput(true)
					love.keyboard.setKeyRepeat(true)
					state.checked_high_score = true
					return
				end
			end
			state.checked_high_score = true
		end
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

			-- local x_pos, y_pos = entity.body:getWorldPoints(entity.shape:getPoints())
			-- table.insert(entities.entities, particles(x_pos, y_pos, entity.color, os.time()))
		else
			i = i + 1
		end
	end

	state.stage_cleared = not have_bricks
	if state.stage_cleared == true then
		state.score = state.score + state.combo_score * state.combo
		state.combo_score = 0
		state.combo = 0
	end

	for _, particle in ipairs(particles.particles) do
		particle.particle_system:update(dt)
	end
	world:update(dt)
end
