return {

	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters.clangtidy = {
			name = "clangtidy",
			cmd = "clang-tidy",
			args = { "--quiet" },
			stdin = false,
			stream = "stdout",
			ignore_exitcode = true,
			parser = require("lint.parser").from_pattern(
				"([^:]+):(%d+):(%d+): (%w+): (.+)",
				{ "file", "lnum", "col", "severity", "message" },
				{
					source = "clang-tidy",
					severity = vim.diagnostic.severity.WARN,
				}
			),
		}
		lint.linters_by_ft = {
			markdown = { "markdownlint" },
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			c = { "clangtidy" },
			cpp = { "clangtidy" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				local bufname = vim.api.nvim_buf_get_name(0)
				local has_biome = #vim.fs.find({ "biome.json", "biome.jsonc" }, {
					upward = true,
					path = vim.fs.dirname(bufname),
				}) > 0
				local ft = vim.bo.filetype
				local js_fts = { javascript = true, javascriptreact = true, typescript = true, typescriptreact = true }
				if has_biome and js_fts[ft] then
					return
				end
				lint.try_lint()
			end,
		})
	end,
}
