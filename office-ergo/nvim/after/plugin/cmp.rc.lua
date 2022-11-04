local status, cmp = pcall(require, "cmp")
if (not status and cmp == nil) then return end

local ls_status, luasnip = pcall(require, "luasnip")
if (not ls_status) then return end

local lsvc_status, luasnipvc = pcall(require, "luasnip/loaders/from_vscode")
if (not lsvc_status) then return end
luasnipvc.lazy_load()

if cmp ~= nil then
    local select_opts = { behavior = cmp.SelectBehavior.Select }
    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert({
            ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
            ['<Down>'] = cmp.mapping.select_next_item(select_opts),

            ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
            ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
            { name = 'buffer', priority = 4 },
            { name = 'luasnip', priority = 3 },
            { name = 'cmp_tabnine', priority = 2 },
            { name = 'path', priority = 5 },
            { name = 'nvim_lsp', priority = 1 },
        }),
        -- formatting = {
        --     format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
        -- }
    }

    --     vim.cmd [[
    --   set completeopt=menuone,noinsert,noselect
    --   highlight! default link CmpItemKind CmpItemMenuDefault
    -- ]]
end
