local state = require("state")


return function()
	local entity = {}

	entity.type = "stage cleared"

	entity.draw = function()
		if state.stage_cleared then
			love.graphics.print("STAGE CLEARED - PRESS SPACE TO PLAY AGAIN", 10, 10)
		end
	end

	return entity
end
