local tm = require("njayman.core.terminal")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "[N]o highlight search" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "[E]xit terminal mode" })

vim.keymap.set("n", "<leader>tf", tm.toggle_float, { desc = "[F]loating terminal manager" })
vim.keymap.set("n", "<leader>tt", tm.toggle_tab, { desc = "[T]abbed terminal manager" })
vim.keymap.set("n", "<leader>tb", tm.toggle_bottom, { desc = "[B]ottom terminal manager" })
vim.keymap.set("n", "<leader>tn", tm.new, {
	desc = "[N]ew terminal",
})
vim.keymap.set("n", "<leader>tl", tm.next, {
	desc = "[N]ext terminal",
})
vim.keymap.set("n", "<leader>th", tm.prev, {
	desc = "[P]revious terminal",
})
vim.keymap.set("n", "<leader>tk", tm.kill_current, {
	desc = "[K]ill current terminal",
})
