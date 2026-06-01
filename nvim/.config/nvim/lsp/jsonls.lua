---@type vim.lsp.Config
return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_dir = function(bufnr)
		return vim.fs.root(bufnr, { ".git" }) or vim.fn.getcwd()
	end,
	init_options = { provideFormatter = true },
	single_file_support = true,
}
