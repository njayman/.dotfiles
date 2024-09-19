return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		color_overrides = {
			mocha = {
				base = "#000000",
				mantle = "#010101",
				crust = "#020202",
			},
			flavour = "mocha",
			transparent_background = true,
		},
	},
}
