require("options")
require("settings")
require("plugins")
require("config")
require("keymaps")
require("lsp")

vim.g.tokyonight_style = "storm"
vim.cmd [[colorscheme tokyonight]]

vim.g.node_host_prog = io.popen 'which node':read '*a'
vim.g.python3_host_prog = "python3"

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}
