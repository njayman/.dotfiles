-- Python
require 'lspconfig'.pyright.setup {}
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Lua
require 'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
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
    on_attach = on_attach,
    capabilities = capabilities
}

-- HTML
require 'lspconfig'.html.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- CSS
-- require 'lspconfig'.cssmodules_ls.setup { capabilities = capabilities }

-- Tailwind
-- require 'lspconfig'.tailwindcss.setup { capabilities = capabilities }

-- JavaScript & TypeScript
require 'lspconfig'.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- Deno
-- require 'lspconfig'.denols.setup { capabilities = capabilities }

-- Svelte
require 'lspconfig'.svelte.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- Prisma
require 'lspconfig'.prismals.setup { capabilities = capabilities }

-- Docker
require 'lspconfig'.dockerls.setup { capabilities = capabilities }

-- GraphQL
-- require 'lspconfig'.graphql.setup { capabilities = capabilities }

require 'lspconfig'.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- Autoformat every file
vim.cmd [[autocmd BufWritePre *.html lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.scss lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil,100)]]
vim.cmd [[autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)]]
vim.cmd [[autocmd BufWritePre *.mjs lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.json lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.md lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.svelte lua vim.lsp.buf.formatting_sync()]]
vim.cmd [[autocmd BufWritePre *.prisma lua vim.lsp.buf.formatting_sync()]]
