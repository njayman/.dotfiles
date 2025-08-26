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
				lint.try_lint()
			end,
		})
	end,
}
