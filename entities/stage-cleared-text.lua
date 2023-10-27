local state = require("state")

return function()
	local entity = {}

	entity.type = "cleared"

	entity.draw = function()
		if state.stage_cleared and not state.won then
			love.graphics.print("STAGE CLEARED - PRESS SPACE", 10, 10)
		end
	end

	return entity
end
