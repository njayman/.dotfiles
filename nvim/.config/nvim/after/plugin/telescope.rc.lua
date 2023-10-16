local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>tf", builtin.find_files, { noremap = true })
vim.keymap.set("n", "<leader>tg", builtin.live_grep, { noremap = true })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { noremap = true })
vim.keymap.set("n", "<leader>tb", builtin.buffers, { noremap = true })
vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>", { noremap = true })
vim.keymap.set("n", "<leader>cb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })

local telescope = require("telescope")

telescope.setup({
	extensions = {
		file_browser = {
			hijack_netrw = true,
		},
	},
})

telescope.load_extension("file_browser")
