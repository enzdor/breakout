local state = require("state")

local parseSaveFile = function(s)
	local sep1 = ","
	local t = {}
	for str in string.gmatch(s, "([^" .. sep1 .. "]+)") do
		table.insert(t, str)
	end

	local t2 = {}
	for _, value in ipairs(t) do
		local sep2 = ";"
		local score = 0
		local name = "NAME"
		local j = 1
		for str in string.gmatch(value, "([^" .. sep2 .. "]+)") do
			if j == 1 then
				score = tonumber(str)
			else
				name = str
			end
			j = j + 1
		end
		table.insert(t2, {
			score = score,
			name = name
		})
	end
	table.remove(t2, #t2)
	return t2
end

local createSaveString = function(high_scores)
	local string = ""
	for _, scores in ipairs(high_scores) do
		string = string .. tostring(scores.score) .. ";"
		string = string .. scores.name .. ","
	end
	return string
end

local save_load = {
	save = function(high_scores)
		local s = createSaveString(high_scores)
		local f, e = io.open("save.txt", "w")
		if f then
			f:write(s)
			f:close()
		else
			print(e)
		end
	end,
	load = function(self)
		local f, e = io.open("save.txt", "r")
		if f then
			local contents = f:read("*a")
			state.high_scores = parseSaveFile(contents)
			f:close()
		else
			print(e)
		end
	end
}

return save_load
