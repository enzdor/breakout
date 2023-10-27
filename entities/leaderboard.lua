local state = require("state")
local save_load = require("save-load")

return function()
	save_load.load()
	local entity = {}
	local hs_text = ""

	for _, hs in ipairs(state.high_scores) do
		hs_text = hs_text .. hs.name .. " - " .. tostring(hs.score) .. "\n"
	end

	entity.type = "high"

	entity.draw = function()
		if not state.game_started then
			love.graphics.print("LEADERBOARD\n" .. hs_text, 10, 400)
		end
	end

	return entity
end
