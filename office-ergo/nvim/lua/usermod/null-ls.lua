local nls = require "null-ls"
local b = nls.builtins

local sources = {
    -- formatting
    -- b.formatting.prettierd,
    -- b.formatting.shfmt,
    -- b.formatting.fixjson,
    -- b.formatting.black.with { extra_args = { "--fast" } },
    -- b.formatting.isort,
    -- b.formatting.stylua, "stylua.toml",

    -- diagnostics
    b.diagnostics.markdownlint,
    b.diagnostics.eslint_d,
    b.diagnostics.tsc,

    -- code actions
    b.code_actions.gitsigns,
    b.code_actions.gitrebase,

    -- hover
    b.hover.dictionary,
}

nls.setup {
    sources = sources,
    save_after_format = false
}
