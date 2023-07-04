local map = vim.api.nvim_set_keymap

vim.g.vimspector_base_dir = "/home/najish/.local/share/nvim/site/pack/packer/start/vimspector"
vim.g.vimspector_enable_mappings = "HUMAN"

map("n", "<leader>dd", "<cmd>call vimspector#Launch()<CR>", { noremap = true })
map("n", "<leader>de", "<cmd>VimspectorReset<CR>", { noremap = true })
map("n", "<leader>cc", "<cmd>call vimspector#Continue()<CR>", { noremap = true })
map("n", "<leader>ds", "<cmd>call vimspector#Stop()<CR>", { noremap = true })
map("n", "<leader>dr", "<cmd>call vimspector#Restart()<CR>", { noremap = true })
map("n", "<leader>dp", "<cmd>call vimspector#Pause()<CR>", { noremap = true })
-- vimp.rbind('n', '<leader>db', '<Plug>VimspectorToggleBreakpoint')
-- vimp.rbind('n', '<leader>db', '<Plug>VimspectorToggleBreakpoint')
map("n", "<space>db", "<cmd>call vimspector#ToggleBreakpoint()<CR>", { noremap = true })
map("n", "<space>cb", "<cmd>call vimspector#ToggleConditionalBreakpoint()<CR>", { noremap = true })
map("n", "<space>cfb", "<cmd>call vimspector#AddFunctionBreakpoint()<CR>", { noremap = true })
map("n", "<leader>drc", "<cmd>call vimspector#RunToCursor()<CR>", { noremap = true })
map("n", "<leader>l", "<cmd>call vimspector#StepOver()<CR>", { noremap = true })
map("n", "<leader>j", "<cmd>call vimspector#StepInto()<CR>", { noremap = true })
map("n", "<leader>k", "<cmd>call vimspector#StepOout()<CR>", { noremap = true })
