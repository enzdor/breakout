local state = require("state")


return function()
	local entity = {}

	entity.draw = function()
		if state.stage_cleared then
			love.graphics.print("STAGE CLEARED - PRESS SPACE TO PLAY AGAIN", 0, 0, 0, 2, 2)
		end
	end

	return entity
end
