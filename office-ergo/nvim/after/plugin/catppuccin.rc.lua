local status, cpc = pcall(require, "catppuccin")
if (not status) then return end

cpc.setup {
    flavour = "mocha" -- mocha, macchiato, frappe, latte
}
vim.api.nvim_command "colorscheme catppuccin"
