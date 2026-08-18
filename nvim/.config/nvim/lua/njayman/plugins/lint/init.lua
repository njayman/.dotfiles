return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- ponytail: c/cpp linting comes from clangd's --clang-tidy flag over LSP,
		-- not nvim-lint, to avoid running clang-tidy twice per save.
		lint.linters_by_ft = {
			lua = { "selene" },
			markdown = { "markdownlint" },
			go = { "staticcheck" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			dockerfile = { "hadolint" },
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
