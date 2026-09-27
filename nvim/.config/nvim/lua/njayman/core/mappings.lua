local tm = require("njayman.core.terminal")
local cm = require("njayman.core.cmake")
local sp = require("njayman.core.scratchpad")

vim.keymap.set("n", "<leader>.", sp.toggle, { desc = "Toggle scratchpad" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "[N]o highlight search" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "[E]xit terminal mode" })

for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
	vim.keymap.set({ "n", "v", "i" }, key, "<Nop>", { desc = "Disabled, use hjkl" })
end

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

vim.keymap.set("n", "<leader>lr", function()
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		vim.lsp.stop_client(client.id)
	end
	vim.defer_fn(function() vim.cmd("edit") end, 500)
end, { desc = "[L]SP [R]estart" })

vim.keymap.set("n", "<leader>cb", cm.build, { desc = "[B]uild cmake project" })
vim.keymap.set("n", "<leader>cc", cm.configure, { desc = "[C]onfigure cmake project" })
vim.keymap.set("n", "<leader>cR", cm.rebuild, { desc = "[R]ebuild cmake project (clean + reconfigure)" })
vim.keymap.set("n", "<leader>cx", cm.clean, { desc = "Clean cmake build" })
