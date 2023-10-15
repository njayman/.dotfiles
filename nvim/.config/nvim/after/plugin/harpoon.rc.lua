local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>h", mark.add_file, { desc = "Mark files for harpoon" })
vim.keymap.set("n", "<C-h>", ui.toggle_quick_menu, { desc = "Toggle harpoon ui" })
