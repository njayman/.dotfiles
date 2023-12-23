return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			run = ":MasonUpdate",
		},
		"williamboman/mason-lspconfig.nvim",
		{
			"SmiteshP/nvim-navbuddy",
			dependencies = {
				"SmiteshP/nvim-navic",
				"MunifTanjim/nui.nvim",
			},
			opts = { lsp = { auto_attach = true } },
		},
		"hrsh7th/cmp-nvim-lua",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"dockerls",
				"docker_compose_language_service",
				"efm",
				"emmet_language_server",
				"eslint",
				"tsserver",
				"jsonls",
				"lua_ls",
				"marksman",
				"rust_analyzer",
				"yamlls",
			},
		})

		local lspconfig = require("lspconfig")
		local navbuddy = require("nvim-navbuddy")

		local on_attach = function(client, bufnr)
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
			navbuddy.attach(client, bufnr)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		lspconfig.rust_analyzer.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig.gopls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig.marksman.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		lspconfig.jsonls.setup({
			on_attach = on_attach,
		})

		lspconfig.tsserver.setup({
			on_attach = on_attach,
			cmd = { "typescript-language-server", "--stdio" },
			capabilities = capabilities,
		})

		lspconfig.emmet_language_server.setup({
			on_attach = on_attach,
		})

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim", "love" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = { "${3rd}/love2d/library" },
						checkThirdParty = false,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}
