local state = require("state")


return function()
	local entity = {}

	entity.draw = function()
		if state.paused then
			love.graphics.print("PAUSED - PRESS SPACE TO RESUME", 10, 10)
		end
	end

	return entity
end
