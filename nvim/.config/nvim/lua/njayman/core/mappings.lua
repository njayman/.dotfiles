local tm = require("njayman.core.terminal")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "[N]o highlight search" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "[E]xit terminal mode" })

vim.keymap.set("n", "<leader>tf", tm.toggle_float)
vim.keymap.set("n", "<leader>tt", tm.toggle_tab)
vim.keymap.set("n", "<leader>tb", tm.toggle_bottom)

vim.keymap.set({ "n", "t" }, "<Esc>", function()
	if tm.state.view then
		tm.close_view()
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	end
end, { silent = true })
