local state = require("state")


return function()
	local entity = {}

	entity.type = "start game"

	entity.draw = function()
		if not state.game_started then
			love.graphics.print("START GAME - PRESS SPACE TO START", 10, 10)
		end
	end

	return entity
end
