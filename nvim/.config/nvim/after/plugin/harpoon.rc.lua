local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>hh", mark.add_file, { desc = "Harpoon: Mark files" })
vim.keymap.set("n", "<leader>hu", ui.toggle_quick_menu, { desc = "Harpoon: Toggle ui" })
vim.keymap.set("n", ",", ui.nav_prev, { desc = "Harpoon: Go to previous mark" })
vim.keymap.set("n", ".", ui.nav_next, { desc = "Harpoon: Go to next mark" })
