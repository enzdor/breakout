local state = require("state")


return function()
	local entity = {}

	entity.draw = function()
		if state.game_over then
			love.graphics.print("GAME OVER - PRESS SPACE TO RESTART", 0, 0, 0, 2, 2)
		end
	end

	return entity
end
