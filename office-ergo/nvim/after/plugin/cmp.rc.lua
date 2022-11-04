local status, cmp = pcall(require, "cmp")
if not status and cmp == nil then
	return
end

local ls_status, luasnip = pcall(require, "luasnip")
if not ls_status then
	return
end

local lsvc_status, luasnipvc = pcall(require, "luasnip/loaders/from_vscode")
if not lsvc_status then
	return
end

local lspk_status, lspk = pcall(require, "lspkind")
if not lspk_status then
	return
end

luasnipvc.lazy_load()

if cmp ~= nil then
	-- local select_opts = { behavior = cmp.SelectBehavior.Select }
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
		-- mapping = cmp.mapping.preset.insert({
		-- 	["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		-- 	["<Down>"] = cmp.mapping.select_next_item(select_opts),
		--
		-- 	["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		-- 	["<C-n>"] = cmp.mapping.select_next_item(select_opts),
		-- 	["<C-d>"] = cmp.mapping.scroll_docs(-4),
		-- 	["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- 	["<C-Space>"] = cmp.mapping.complete(),
		-- 	["<CR>"] = cmp.mapping.confirm({
		-- 		behavior = cmp.ConfirmBehavior.Replace,
		-- 		select = true,
		-- 	}),
		-- 	["<Tab>"] = cmp.mapping(function(fallback)
		-- 		if cmp.visible() then
		-- 			cmp.select_next_item()
		-- 		elseif luasnip.expand_or_jumpable() then
		-- 			luasnip.expand_or_jump()
		-- 		else
		-- 			fallback()
		-- 		end
		-- 	end, { "i", "s" }),
		-- 	["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 		if cmp.visible() then
		-- 			cmp.select_prev_item()
		-- 		elseif luasnip.jumpable(-1) then
		-- 			luasnip.jump(-1)
		-- 		else
		-- 			fallback()
		-- 		end
		-- 	end, { "i", "s" }),
		-- }),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "cmp_tabnine" },
		}),
		formatting = {
			format = lspk.cmp_format({
				mode = "text_symbol",
				maxwidth = 50,
				before = function(_, vim_item)
					return vim_item
				end,
			}),
		},
	})

	-- cmp.setup.filetype("gitcommit", {
	-- 	sources = cmp.config.sources({
	-- 		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	-- 	}, {
	-- 		{ name = "buffer" },
	-- 	}),
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

	--     vim.cmd [[
	--   set completeopt=menuone,noinsert,noselect
	--   highlight! default link CmpItemKind CmpItemMenuDefault
	-- ]]
end
