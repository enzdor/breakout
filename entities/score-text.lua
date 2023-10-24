local state = require("state")

return function()
	local entity = {}

	entity.type = "score"

	entity.draw = function()
		if not state.paused and not state.game_over and not state.stage_cleared and state.game_started then
			love.graphics.print("STAGE = " .. state.score, 300, 10)
		end
	end

	return entity
end
