return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true })

		local telescope = require("telescope")

		telescope.setup({})
	end,
}
