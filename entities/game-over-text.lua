local state = require("state")


return function()
	local entity = {}

	entity.type = "over"

	entity.draw = function()
		if state.game_over then
			love.graphics.print("GAME OVER - PRESS SPACE TO RESTART", 10, 10)
		end
	end

	return entity
end
