vim.diagnostic.config()
vim.g.mapleader = " "
vim.go.t_Co = "256"
vim.g.node_host_prog = vim.fn.expand("/home/najish/.nvm/versions/node/v16.17.0/bin/neovim-node-host")
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.markdown_fenced_languages = {
    "ts=typescript"
}
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)]]
