local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end
-- Setup Telescope
local map = vim.api.nvim_set_keymap

telescope.setup {
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}

map('n', '<leader>fg', ":lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
map('n', '<leader>ff', ":lua require('telescope.builtin').find_files()<cr>", { noremap = true })
map('n', '<leader>gf', ":lua require('telescope.builtin').git_files()<cr>", { noremap = true })
map('n', '<leader>fb', ":lua require('telescope.builtin').buffers()<cr>", { noremap = true })
map('n', '<leader>fh', ":lua require('telescope.builtin').help_tags()<cr>", { noremap = true })

telescope.load_extension('fzf')
