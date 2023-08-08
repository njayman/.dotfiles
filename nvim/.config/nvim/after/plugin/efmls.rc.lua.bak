local efmls = require "efmls-configs"
local eslint = require "efmls-configs.linters.eslint"
local prettier = require "efmls-configs.formatters.prettier"

local jsconf = {
    linter = eslint,
    formatter = prettier
}

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

efmls.init {
    init_options = {
        documentFormatting = true
    },
    on_attach = function(client, bufnr)
        on_attach()
        enable_format_on_save(client, bufnr)
    end
}

efmls.setup {
    javascript = jsconf,
    typescript = jsconf,
    javascriptreact = jsconf,
    typescriptreact = jsconf
}
