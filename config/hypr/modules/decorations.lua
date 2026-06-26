local colors = require("ui.colors")

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 5,
		border_size = 2,
		col = {
			active_border = colors.primary,
			inactive_border = colors.on_primary,
		},
		resize_on_border = false,
		allow_tearing = false,
	},

	decoration = {
		rounding = 5,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			-- range = 4,
			render_power = 3,
			-- color = "rgba(1a1a1aee)",
			range = 8,
			color = 0xee121212,
		},

		blur = {
			enabled = true,
			size = 7,
			passes = 3,
			ignore_opacity = true,
			contrast = 1.5,
			xray = false,
			new_optimizations = true,
			-- size = 3,
			-- passes = 1,
			-- vibrancy = 0.1696,
		},
	},
})
