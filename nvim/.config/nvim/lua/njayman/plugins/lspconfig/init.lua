return {
	"j-hui/fidget.nvim",
	dependencies = {
		-- provides default configs under lsp/*.lua; we never call require("lspconfig")
		"neovim/nvim-lspconfig",
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

				if client and client:supports_method(vim.lsp.protocol.Methods.callHierarchy_incomingCalls) then
					nmap("<leader>ci", vim.lsp.buf.incoming_calls, "[C]alls [I]ncoming")
					nmap("<leader>co", vim.lsp.buf.outgoing_calls, "[C]alls [O]utgoing")
				end

				if client and client.name == "clangd" then
					nmap("<leader>ch", function()
						client:request(
							"textDocument/switchSourceHeader",
							vim.lsp.util.make_text_document_params(event.buf),
							function(err, result)
								if not err and result then
									vim.cmd.edit(vim.uri_to_fname(result))
									return
								end

								-- clangd doesn't pair source/header across directories
								-- (e.g. src/ vs include/), so fall back to a stem search.
								local bufname = vim.api.nvim_buf_get_name(event.buf)
								local stem = vim.fn.fnamemodify(bufname, ":t:r")
								local is_header = bufname:match("%.h[pxc]*$") ~= nil
								local exts = is_header and { "c", "cc", "cpp", "cxx" } or { "h", "hh", "hpp", "hxx" }

								local matches = vim.fs.find(function(name)
									local ext = name:match("%.([^.]+)$")
									return name:match("^" .. vim.pesc(stem) .. "%.") ~= nil
										and vim.tbl_contains(exts, ext)
								end, { path = vim.fn.getcwd(), limit = 1, type = "file" })

								if matches[1] then
									vim.cmd.edit(matches[1])
								end
							end,
							event.buf
						)
					end, "[C]langd Switch [H]eader/Source")

					if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					end
				end
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

		vim.keymap.set("x", "<leader>yd", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local start_line = math.min(vim.fn.line("v"), vim.fn.line(".")) - 1
			local end_line = math.max(vim.fn.line("v"), vim.fn.line(".")) - 1

			local code = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line + 1, false)

			local diagnostics = vim.diagnostic.get(bufnr, { lnum = nil })
			local diag_lines = {}
			for _, d in ipairs(diagnostics) do
				if d.lnum >= start_line and d.lnum <= end_line then
					table.insert(
						diag_lines,
						string.format(
							"line %d: %s%s: %s",
							d.lnum + 1,
							vim.diagnostic.severity[d.severity],
							d.source and (" (" .. d.source .. ")") or "",
							d.message:gsub("\n", " ")
						)
					)
				end
			end

			local out = vim.list_extend({}, code)
			if #diag_lines > 0 then
				table.insert(out, "")
				table.insert(out, "-- Diagnostics --")
				vim.list_extend(out, diag_lines)
			end

			local text = table.concat(out, "\n")
			vim.fn.setreg('"', text, "l")
			vim.fn.setreg("+", text, "l")
			vim.cmd("normal! \27")
		end, { desc = "[Y]ank selection with [D]iagnostics" })

		vim.lsp.config("*", { capabilities = capabilities })

		-- deliberate deltas on top of nvim-lspconfig's lsp/*.lua defaults
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					diagnostics = { globals = { "vim" } },
				},
			},
		})
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--all-scopes-completion",
				"--pch-storage=memory",
				"--offset-encoding=utf-16",
			},
		})
		-- conform already formats html via prettier; don't let the LSP double up
		vim.lsp.config("html", { init_options = { provideFormatter = false } })
		-- upstream's tsgo is a deprecated alias to tsc; define it standalone to skip the nag
		vim.lsp.config("tsgo", {
			cmd = { "tsgo", "--lsp", "--stdio" },
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			root_dir = function(bufnr, on_dir)
				local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
				root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
					or vim.list_extend(root_markers, { ".git" })

				local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
				local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
				local project_root = vim.fs.root(bufnr, root_markers)
				if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
					return
				end
				if deno_root and (not project_root or #deno_root >= #project_root) then
					return
				end
				on_dir(project_root or vim.fn.getcwd())
			end,
			settings = {
				["js/ts"] = {
					inlayHints = {
						parameterNames = { enabled = "literals", suppressWhenArgumentMatchesName = true },
						parameterTypes = { enabled = true },
						variableTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						enumMemberValues = { enabled = true },
					},
					referencesCodeLens = { enabled = true, showOnAllFunctions = true },
					implementationsCodeLens = {
						enabled = true,
						showOnInterfaceMethods = true,
						showOnAllClassMethods = true,
					},
				},
			},
			on_init = function() end,
		})

		vim.lsp.enable({
			"tsgo",
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
