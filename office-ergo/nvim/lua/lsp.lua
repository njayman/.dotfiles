-- Python
require 'lspconfig'.pyright.setup {}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua
require 'lspconfig'.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },

    capabilities = capabilities
}

-- Markdown
require 'lspconfig'.marksman.setup {

    capabilities = capabilities
}

-- HTML
require 'lspconfig'.html.setup { capabilities = capabilities }

-- CSS
require 'lspconfig'.cssmodules_ls.setup { capabilities = capabilities }

-- Tailwind
require 'lspconfig'.tailwindcss.setup { capabilities = capabilities }

-- JavaScript & TypeScript
require 'lspconfig'.tsserver.setup { capabilities = capabilities }

-- Deno
require 'lspconfig'.denols.setup { capabilities = capabilities }

-- Svelte
require 'lspconfig'.svelte.setup { capabilities = capabilities }

-- Prisma
require 'lspconfig'.prismals.setup { capabilities = capabilities }

-- Docker
require 'lspconfig'.dockerls.setup { capabilities = capabilities }

-- GraphQL
require 'lspconfig'.graphql.setup { capabilities = capabilities }

-- Autoformat every file
vim.cmd [[autocmd BufWritePre *.html lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.scss lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.mjs lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.json lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.md lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.svelte lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.prisma lua vim.lsp.buf.formatting_sync()]]
