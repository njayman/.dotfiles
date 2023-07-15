local cmp = require "cmp"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local luasnip = require 'luasnip'

require "luasnip/loaders/from_vscode".lazy_load()

if cmp ~= nil then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete({}),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            -- { name = 'vsnip' }, -- For vsnip users.
            { name = "luasnip" }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        }, {
            { name = "buffer" },
        })
    })

    -- cmp.setup.filetype("gitcommit", {
    --     sources = cmp.config.sources({
    --         { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
    --     }, {
    --         { name = "buffer" },
    --     }),
    -- })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
end
