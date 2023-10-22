local state = require("state")


return function()
	local entity = {}

	entity.draw = function()
		if not state.game_started then
			love.graphics.print("START GAME - PRESS SPACE TO START", 0, 0, 0, 2, 2)
		end
	end

	return entity
end
