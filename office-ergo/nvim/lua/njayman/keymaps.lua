local map = vim.api.nvim_set_keymap

map('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
map('n', '<leader>tn', [[:tabnew | term<CR>]], { noremap = true })
-- map('n', 'th', [[tabfirst]], { noremap = true })
-- map('n', 'tk', [[tabnext<CR>]], { noremap = true })
-- map('n', 'tl', [[tabprev<CR>]], { noremap = true })
-- map('n', 'tt', [[tablast<CR>]], { noremap = true })
-- map('n', 'tn', [[tabedit<CR>]], { noremap = true })
-- map('n', 'tm', [[tabnext<CR>]], { noremap = true })
-- map('n', 'td', [[tabm<CR>]], { noremap = true })
-- map('n', 'td', [[tabclose<CR>]], { noremap = true })
-- nnoremap tk  :tabnext<CR>
-- nnoremap tj  :tabprev<CR>
-- nnoremap tl  :tablast<CR>
-- nnoremap tt  :tabedit<Space>
-- nnoremap tn  :tabnext<Space>
-- nnoremap tm  :tabm<Space>
-- nnoremap td  :tabclose<CR>

-- Trouble keybindings
--[[ vim.keymap.set("<leader>p", "\"_dP", {xnoremap = true}) ]]
