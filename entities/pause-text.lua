local state = require("state")


return function()
	local entity = {}

	entity.draw = function()
		if state.paused then
			love.graphics.print("PAUSED - PRESS SPACE TO RESUME", 0, 0, 0, 2, 2)
		end
	end

	return entity
end
