local lsp = require('lsp-zero')
-- local lspconfig = require('lspconfig')
-- local eslint_config = require('lspconfig.server_configurations.eslint')

-- lspconfig.eslint.setup {
--     opt.cmd = { "yarn", "exec", unpack(eslint_config.default_config.cmd) }
-- }

lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = true,
    call_servers = 'local',
    sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = ''
    }
})
lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

-- vim.cmd [[autocmd BufWritePre *.js silent! !npx prettier %]]
--
-- vim.cmd [[autocmd BufWritePre *.jsx silent! !npx prettier %]]
--
-- vim.cmd [[autocmd BufWritePre *.ts silent! !npx prettier %]]
--
-- vim.cmd [[autocmd BufWritePre *.tsx lua silent! !npx prettier %]]

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)]]
