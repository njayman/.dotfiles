return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			local disable_filetypes = { c = true, cpp = true }
			return {
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = function(bufnr)
				if #vim.fs.find({ "biome.json", "biome.jsonc" }, { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) }) > 0 then
					return { "biome" }
				end
				return { "prettier" }
			end,
			javascriptreact = function(bufnr)
				if #vim.fs.find({ "biome.json", "biome.jsonc" }, { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) }) > 0 then
					return { "biome" }
				end
				return { "prettier" }
			end,
			typescript = function(bufnr)
				if #vim.fs.find({ "biome.json", "biome.jsonc" }, { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) }) > 0 then
					return { "biome" }
				end
				return { "prettier" }
			end,
			typescriptreact = function(bufnr)
				if #vim.fs.find({ "biome.json", "biome.jsonc" }, { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) }) > 0 then
					return { "biome" }
				end
				return { "prettier" }
			end,
			json = function(bufnr)
				if #vim.fs.find({ "biome.json", "biome.jsonc" }, { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) }) > 0 then
					return { "biome" }
				end
				return { "prettier" }
			end,
			css = function(bufnr)
				if #vim.fs.find({ "biome.json", "biome.jsonc" }, { upward = true, path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)) }) > 0 then
					return { "biome" }
				end
				return { "prettier" }
			end,
			html = { "prettier" },
			rust = { "rustfmt", lsp_format = "fallback" },
			c = { "clang-format" },
			cpp = { "clang-format" },
		},
	},
}
