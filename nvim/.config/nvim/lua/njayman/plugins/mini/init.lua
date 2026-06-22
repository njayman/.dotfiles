return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.icons").mock_nvim_web_devicons()

	local statusline = require("mini.statusline")

		statusline.setup({ use_icons = true })

		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- Registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},
			clues = {
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),

				-- Leader group labels
				{ mode = "n", keys = "<Leader>f", desc = "+find" },
				{ mode = "n", keys = "<Leader>t", desc = "+terminal" },
				{ mode = "n", keys = "<Leader>T", desc = "+test" },
				{ mode = "n", keys = "<Leader>d", desc = "+debug/diagnostics" },
				{ mode = "n", keys = "<Leader>w", desc = "+workspace" },
				{ mode = "n", keys = "<Leader>s", desc = "+session" },
				{ mode = "n", keys = "<Leader>c", desc = "+cmake" },
				{ mode = "n", keys = "<Leader>r", desc = "+rename" },
			},
		})
	end,
}
