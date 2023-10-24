local state = require("state")
local paddle = require("entities/paddle")
local ball = require("entities/ball")
local boundary_bottom = require("entities/boundary-bottom")
local boundary_top = require("entities/boundary-top")
local boundary_vertical = require("entities/boundary-vertical")
local brick = require("entities/brick")
local pause_text = require("entities/pause-text")
local game_over_text = require("entities/game-over-text")
local stage_cleared_text = require("entities/stage-cleared-text")
local start_game_text = require("entities/start-game-text")
local lifes_text = require("entities/lifes-text")
local score_text = require("entities/score-text")
local you_won_text = require("entities/you-won-text")
local high_score_text = require("entities/high-score-text")

return {
	newEntities = function()
		math.randomseed(os.time())
		local entities = {
			boundary_bottom(400, 900),
			boundary_vertical(0, 450),
			boundary_vertical(800, 450),
			boundary_top(400, 0),
			pause_text(),
			game_over_text(),
			start_game_text(),
			stage_cleared_text(),
			lifes_text(),
			score_text(),
			you_won_text(),
			high_score_text(),
			paddle(300, 800),
			ball(math.random(100, 700), 300),
		}

		local row_width = state.screen.width - 20
		for number = 0, 51 do -- 51
			local brick_x = ((number * 60) % row_width) + 40
			local brick_y = (math.floor(number * 60 / row_width) * 40) + 80
			entities[#entities + 1] = brick(brick_x, brick_y, math.floor(number * 60 / row_width) + 1)
		end
		return entities
	end,
	entities = {}
}
