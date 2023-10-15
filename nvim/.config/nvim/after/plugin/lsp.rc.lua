local lspconfig = require "lspconfig"

local on_attach = function()
    local opts = { noremap = true, silent = true, buffer = 0 }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)

    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    vim.keymap.set("n", "<leader>df", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)

    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            require("conform").format({ bufnr = args.buf })
        end,
    })
end

local trylint = function()
    require("lint").try_lint()
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.marksman.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.jsonls.setup {
    on_attach = function(client, bufnr)
        on_attach()
    end
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = capabilities
}

lspconfig.eslint.setup {
    settings = {
        codeActionsOnSave = {
            enabled = true,
            mode = "all",
        },
        run = "onSave"
    }
}

lspconfig.emmet_language_server.setup {
    on_attach = on_attach,
}

lspconfig.lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim', "love" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = { "${3rd}/love2d/library" },
                checkThirdParty = false
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
