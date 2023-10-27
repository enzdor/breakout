local state = require("state")

return function()
	local entity = {}

	entity.type = "high"

	entity.draw = function()
		if state.high_score then
			love.graphics.print("YOU SET A NEW HIGH SCORE = " .. state.score .. "!\nWRITE YOUR NAME: " .. state.name, 10, 400)
		end
	end

	return entity
end
