return {
	"j-hui/fidget.nvim",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("fidget").setup({})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("njayman-lsp-attach", { clear = true }),
			callback = function(event)
				local nmap = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				nmap("<leader>ca", function()
					vim.lsp.buf.code_action({
						context = {
							only = { "quickfix", "refactor", "source" },
							diagnostics = vim.diagnostic.get(0),
						},
					})
				end, "[C]ode [A]ction")
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("<leader>df", vim.diagnostic.open_float, "[D]iagnostic [F]loat")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("njayman-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					if not vim.g.vscode then
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("njayman-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "njayman-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					nmap("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities(),
			{ workspace = { workspaceEdit = { documentChanges = true } } }
		)

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "✗",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰌶",
				},
			},
			virtual_text = { prefix = "●" },
			float = { border = "rounded", source = true },
			severity_sort = true,
			underline = true,
			update_in_insert = false,
		})

		vim.o.winborder = "rounded"

		vim.lsp.config("*", { capabilities = capabilities })

		vim.lsp.enable({
			"ts_ls",
			"lua_ls",
			"jsonls",
			"ty",
			"ruff",
			"marksman",
			"bashls",
			"gopls",
			"biome",
			"denols",
			"rust_analyzer",
			"clangd",
			"glsl_analyzer",
			"cmake",
			"dockerls",
			"cssls",
			"html",
		})

		if vim.fn.executable("hyprls") == 1 then
			vim.api.nvim_create_autocmd("BufReadPre", {
				pattern = { "*.hl", "hypr*.conf" },
				callback = function()
					vim.lsp.start({
						name = "hyprlang",
						cmd = { "hyprls" },
						root_dir = vim.fn.getcwd(),
						capabilities = capabilities,
					})
				end,
			})
		end

		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LSP
				"typescript-language-server",
				"lua-language-server",
				"json-lsp",
				"ruff",
				"marksman",
				"bash-language-server",
				"gopls",
				"biome",
				"deno",
				"rust-analyzer",
				"clangd",
				"cmake-language-server",
				"dockerfile-language-server",
				"css-lsp",
				"html-lsp",
				-- Formatters
				"stylua",
				"prettier",
				"clang-format",
				"shfmt",
				-- Linters
				"eslint_d",
				"markdownlint",
				"selene",
				"shellcheck",
				"hadolint",
				"staticcheck",
				"ty",
				-- DAP
				"debugpy",
				"delve",
				"codelldb",
			},
			automatic_installation = true,
		})
	end,
}
