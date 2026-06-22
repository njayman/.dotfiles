local function js_formatter(bufnr)
	local has_deno = #vim.fs.find({ "deno.json", "deno.jsonc" }, {
		upward = true,
		path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
	}) > 0
	if has_deno then
		return { "deno_fmt" }
	end
	if vim.fn.executable("biome") == 1 then
		return { "biome" }
	end
	return { "prettier" }
end

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
			python = { "ruff_format" },
			go = { "gofmt" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			javascript = js_formatter,
			javascriptreact = js_formatter,
			typescript = js_formatter,
			typescriptreact = js_formatter,
			json = js_formatter,
			jsonc = js_formatter,
			css = js_formatter,
			html = { "prettier" },
			rust = { "rustfmt", lsp_format = "fallback" },
			c = { "clang-format" },
			cpp = { "clang-format" },
		},
	},
}
