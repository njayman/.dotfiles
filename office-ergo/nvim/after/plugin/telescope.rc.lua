local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

-- Setup Telescope
local builtin = require("telescope.builtin")
local map = vim.keymap.set

telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"build",
			"dist",
			"node_modules",
		},
	},
	extensions = {
		file_browser = {
			hijack_netrw = true,
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

map("n", "<leader>fg", function()
	builtin.live_grep()
end, { noremap = true })

map("n", "<leader>ff", function()
	builtin.find_files()
end, { noremap = true })

map("n", "<leader>gf", function()
	builtin.git_files()
end, { noremap = true })

map("n", "<leader>fb", function()
	builtin.buffers()
end, { noremap = true })

map("n", "<leader>fh", function()
	builtin.help_tags()
end, { noremap = true })

map("n", "<leader>bf", ":Telescope file_browser<CR>", { noremap = true })

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
