return {

	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			modules = {},
			ignore_install = {},
			auto_install = true,
			ensure_installed = {
				"c",
				"css",
				"html",
				"javascript",
				"bash",
				"comment",
				"cpp",
				"dockerfile",
				"diff",
				"go",
				"java",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"php",
				"prisma",
				"python",
				"query",
				"regex",
				"rust",
				"scss",
				"sql",
				"svelte",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
			},
			sync_install = false,
			autotag = {
				enable = true,
			},
			highlight = {
				enabled = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
