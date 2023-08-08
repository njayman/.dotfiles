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
end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local augroup_format_formatter = vim.api.nvim_create_augroup("FormatFormatter", { clear = true })

local enable_format_on_save = function(_, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })
end

local enable_formatter_format_on_save = function(_, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })
end

local trylint = function()
    require("lint").try_lint()
end

lspconfig.rust_analyzer.setup {
    on_attach = function(client, bufnr)
        on_attach()
        enable_format_on_save(client, bufnr)
    end
}

lspconfig.marksman.setup {
    on_attach = function(client, bufnr)
        on_attach()
        enable_format_on_save(client, bufnr)
    end
}

lspconfig.jsonls.setup {
    on_attach = function(client, bufnr)
        on_attach()
        enable_formatter_format_on_save(client, bufnr)
    end
}

lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
        on_attach()
        enable_formatter_format_on_save(client, bufnr)
        trylint()
    end
}

lspconfig.eslint.setup {}

lspconfig.emmet_language_server.setup {
    on_attach = function(client, bufnr)
        on_attach()
        enable_format_on_save(client, bufnr)
    end
}

lspconfig.lua_ls.setup {
    on_attach = function(client, bufnr)
        on_attach()
        enable_format_on_save(client, bufnr)
    end,
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
