return {
	left = false,
	right = false,
	game_over = false,
	game_started = false,
	paused = false,
	loading = true,
	stage_cleared = false,
	life_lost = false,
	changed_entities = false,
	stage = 1,
	lifes = 3,
	palette = {
		{ 1,   0,    0,   1 },
		{ 1,   0.65, 0,   1 },
		{ 0,   1, 0,   1 },
		{ 0.9, 1,    0.2, 1 },
		{ 0.2, 0.6,  1,   1 },
		{ 1,   1,    1,   1 },
	},
	screen = {
		width = 800,
		height = 900,
		ratio = 800 / 900
	}
}
