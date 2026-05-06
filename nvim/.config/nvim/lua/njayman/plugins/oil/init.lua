return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = {
		{ "nvim-mini/mini.icons", opts = {} },
		"malewicz1337/oil-git.nvim",
		"JezerM/oil-lsp-diagnostics.nvim",
	},
	config = function()
		require("oil").setup({
			delete_to_trash = true,
			win_options = {
				signcolumn = "yes:2",
			},
		})

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

		require("oil-git").setup({
			debounce_ms = 50,
			show_file_highlights = true,
			show_directory_highlights = true,
			show_file_symbols = true,
			show_directory_symbols = true,
			show_ignored_files = false,
			show_ignored_directories = false,
			symbol_position = "eol",
			can_use_signcolumn = nil,
			ignore_gitsigns_update = false,
			debug = false,

			symbols = {
				file = {
					added = "+",
					modified = "~",
					renamed = "->",
					deleted = "D",
					copied = "C",
					conflict = "!",
					untracked = "?",
					ignored = "o",
				},
				directory = {
					added = "*",
					modified = "*",
					renamed = "*",
					deleted = "*",
					copied = "*",
					conflict = "!",
					untracked = "*",
					ignored = "o",
				},
			},

			highlights = {
				OilGitAdded = { fg = "#a6e3a1" },
				OilGitModifiedStaged = { fg = "#f9e2af" },
				OilGitModifiedUnstaged = { fg = "#e5c890" },
				OilGitRenamed = { fg = "#cba6f7" },
				OilGitDeleted = { fg = "#f38ba8" },
				OilGitCopied = { fg = "#cba6f7" },
				OilGitConflict = { fg = "#fab387" },
				OilGitUntracked = { fg = "#89b4fa" },
				OilGitIgnored = { fg = "#6c7086" },
			},
		})

		require("oil-lsp-diagnostics").setup({
			per_column = true,
			symbols = {
				error = "E",
				warn = "W",
				info = "I",
				hint = "H",
			},
			-- diagnostics_get = vim.diagnostic.get,
			-- update_event = "DiagnosticChanged",
			-- throttle_ms = 60,
			-- debug = false,
		})
	end,
}
