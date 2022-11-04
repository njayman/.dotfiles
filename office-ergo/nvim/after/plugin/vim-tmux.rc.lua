local status, vtn = pcall(require, "vim-tmux-navigation")
if (not status) then return end

vtn.setup {
    disable_when_zoomed = true
}

vim.keymap.set('n', "<C-h>", vtn.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", vtn.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", vtn.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", vtn.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-\\>", vtn.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-Space>", vtn.NvimTmuxNavigateNext)

