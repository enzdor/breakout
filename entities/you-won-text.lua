local state = require("state")


return function()
	local entity = {}

	entity.type = "won"

	entity.draw = function()
		if state.won then
			love.graphics.print("YOU WON", 10, 10)
		end
	end

	return entity
end
