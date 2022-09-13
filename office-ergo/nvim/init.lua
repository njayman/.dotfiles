require("options")
require("settings")
require("plugins")
require("config")
require("keymaps")
require("lsp")

-- vim.g.tokyonight_style = "storm"
-- vim.cmd [[colorscheme github_dark]]

vim.g.node_host_prog = vim.fn.expand("/home/najish/.nvm/versions/node/v16.17.0/bin/neovim-node-host")
vim.g.python3_host_prog = "/usr/bin/python3"

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}
